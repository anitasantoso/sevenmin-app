//
//  MainViewController.m
//  sevenmin-app
//
//  Created by Anita Santoso on 19/05/13.
//  Copyright (c) 2013 as. All rights reserved.
//

#import "MainViewController.h"
#import "RepPickerView.h"
#import "PauseOverlayView.h"
#import "TimerMgr.h"
#import "WorkoutView.h"
#import "StartOverlayView.h"

@interface MainViewController()

@property (nonatomic, strong) NSNumberFormatter *formatter;
@property (nonatomic, strong) UIView *breakOverlayView;
@property (nonatomic, strong) UIView *completedOverlayView;
@property (nonatomic, strong) StartOverlayView *startOverlayView;
@property (nonatomic, strong) WorkoutView *workoutView;
@property BOOL buttonStateStart;
@end


@implementation MainViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [TimerMgr sharedInstance].workoutTimerCompleted = ^{
        [self updateTimerLabel];
    };
    [TimerMgr sharedInstance].breakTimerCompleted = ^{
        [self updateTimerLabel];        
    };
    [TimerMgr sharedInstance].timerDidFire = ^{
        [self setTimerLabel];
    };

    // scroll view
    self.workoutView = [[[NSBundle mainBundle]loadNibNamed:@"WorkoutView" owner:nil options:nil]objectAtIndex:0];
    [self.workoutContentView addSubview:self.workoutView];
    
    self.breakOverlayView = [[[NSBundle mainBundle]loadNibNamed:@"OverlayView" owner:nil options:nil]objectAtIndex:0];
    self.completedOverlayView = [[[NSBundle mainBundle]loadNibNamed:@"OverlayView" owner:nil options:nil]objectAtIndex:1];
    
    UITapGestureRecognizer *tapGest = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(doneOverlayTapped:)];
    [self.completedOverlayView addGestureRecognizer:tapGest];
    
    self.formatter = [[NSNumberFormatter alloc]init];
    [self.formatter setMinimumIntegerDigits:2];
    
    // initial state
    [self resetApp];
    [self resetButtonState];
    [self setTimerLabel];
}

- (void)setTimerLabel {
    NSNumber *remaining = [NSNumber numberWithInt:[[TimerMgr sharedInstance]secondsRemaining]];
    self.timerLabel.text = [NSString stringWithFormat:@"00:%@", [self.formatter stringFromNumber:remaining]];
}

- (void)doneOverlayTapped:(id)sender {
    [self.completedOverlayView removeFromSuperview];
}

- (void)resetApp {
    self.timerLabel.text = @"00:00";
    [self.breakOverlayView removeFromSuperview];
    
    // reset timer
    [[TimerMgr sharedInstance] reset];
    
    // reset scroll view
    [self.workoutView reset];
}

- (void)resetButtonState {
    self.buttonStateStart = YES;
    [self setButtonState];
}

- (void)setButtonState {
    if(self.buttonStateStart) {
        [self.startButton setTitle:@"Start" forState:UIControlStateNormal];
        [self.startButton setBackgroundImage:[UIImage imageNamed:@"start_button"] forState:UIControlStateNormal];

    } else {
        [self.startButton setTitle:@"Pause" forState:UIControlStateNormal];
        [self.startButton setBackgroundImage:[UIImage imageNamed:@"stop_button"] forState:UIControlStateNormal];
    }
}

- (BOOL)isStartButton {
    NSString *title = self.startButton.titleLabel.text;
    return [title isEqualToString:@"Start"];
}

- (IBAction)startButtonPressed:(id)sender {
    
    if(self.buttonStateStart) {
        // start button pressed
        __block MainViewController *bself = self;
        self.startOverlayView = [[[NSBundle mainBundle]loadNibNamed:@"OverlayView" owner:nil options:nil]objectAtIndex:2];
        
        self.startOverlayView.completionBlock = ^{
            [[TimerMgr sharedInstance] startWorkoutTimer];
            
            bself.buttonStateStart = !bself.buttonStateStart;
            [bself setButtonState];
        };
        [self.view addSubview:self.startOverlayView];
        [self.startOverlayView startCounter];
    }
    // stop button pressed
    else {
        [[TimerMgr sharedInstance]stopCurrentTimer];
       
        // show pause overlay
        PauseOverlayView *pauseView = [[[NSBundle mainBundle]loadNibNamed:@"OverlayView" owner:nil options:nil]objectAtIndex:3];
        pauseView.doneBlock = ^{
            // done with workout
            [self.workoutView resetRepIndex];
            [self resetButtonState];
            [self resetApp];
        };
        pauseView.resumeBlock = ^{
            [[TimerMgr sharedInstance]restartCurrentTimer];
        };
        [self.view addSubview:pauseView];
    }
}

- (void)updateTimerLabel {
    
    // if workout timer is running
    if([[TimerMgr sharedInstance]currentTimer] == TimerTypeWorkout) {
            
        self.workoutView.workoutIndex++;

        // stop timer if last workout
        if([self.workoutView lastWorkout]) {
            
            // last workout
            // reset all counter except repIndex
            [self resetApp];
            
            // stop app
            if([self.workoutView lastRep]) {
                [self.workoutView resetRepIndex];
                [self.startButton setTitle:@"Start" forState:UIControlStateNormal];
                
                // show done
                [self.view addSubview:self.completedOverlayView];
                return;
            }
            
            // go to next rep
            else {
                [self.workoutView nextRep];
            }
        } else {
            // next workout
            [self.workoutView showNextWorkout];
            
            // stop workout timer
            [[TimerMgr sharedInstance] stopWorkoutTimer];
        }
        
        // start break
        [[TimerMgr sharedInstance] startBreakTimer];
        [self.workoutView.mainContentView addSubview:self.breakOverlayView];
    }
    
    // if break timer is running
    else {
        // end of break
        [[TimerMgr sharedInstance] stopBreakTimer];
        
        // remove break overlay and start timer
        [self.breakOverlayView removeFromSuperview];
        [[TimerMgr sharedInstance] startWorkoutTimer];
    }

    // update timer label
    if([[TimerMgr sharedInstance]secondsRemaining] >= 0) {
        self.timerLabel.text = [NSString stringWithFormat:@"00:%@", [self.formatter stringFromNumber:[NSNumber numberWithInt:[[TimerMgr sharedInstance]secondsRemaining]]]];
    }
}

- (IBAction)menuButtonPressed:(id)sender {
    RepPickerView *pickerView = [[[NSBundle mainBundle]loadNibNamed:@"RepPickerView" owner:nil options:nil]objectAtIndex:0];
    pickerView.currentValue = self.workoutView.numOfReps;
    pickerView.completionBlock = ^(NSInteger selectedValue) {
        self.workoutView.numOfReps = selectedValue;
        self.workoutView.repIndex = 0;
        [[NSUserDefaults standardUserDefaults]setObject:[NSNumber numberWithInt:selectedValue] forKey:@"7MIN_NUM_OF_REPS"];
        [[NSUserDefaults standardUserDefaults]synchronize];
        
    };
    __block CGRect pickerFrame = pickerView.frame;
    pickerFrame.origin = CGPointMake(0, 320);
    pickerView.frame = pickerFrame;
    [self.view addSubview:pickerView];
    
    [UIView animateWithDuration:0.5f animations:^{
        pickerFrame.origin = CGPointMake(0, self.view.frame.size.height-pickerView.frame.size.height);
        pickerView.frame = pickerFrame;
    }];
}

@end
