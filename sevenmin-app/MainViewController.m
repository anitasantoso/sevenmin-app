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
#import <QuartzCore/QuartzCore.h>
#import "UIViewUtil.h"

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
 
    [self.completedOverlayView addGestureRecognizer:[UIViewUtil tapToDismissGestureWithTarget:self selector:@selector(doneOverlayTapped:)]];
    
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
    UIView *view = [[self.view subviews]lastObject];
    [UIViewUtil removeView:view fromSuperview:self.view];
}

- (void)resetApp {
    self.timerLabel.text = @"00:00";
    [self.breakOverlayView removeFromSuperview];
    self.timerLabel.textColor = [UIViewUtil tealColor];
    
    // reset timer
    [[TimerMgr sharedInstance] reset];
    
    // reset scroll view
    [self.workoutView reset];
    [self.workoutView enableSwipe:YES];
}

- (void)resetButtonState {
    self.buttonStateStart = YES;
    [self setButtonState];
}

- (void)setButtonState {
    if(self.buttonStateStart) {
        [self.startButton setTitle:@"Start" forState:UIControlStateNormal];
        [self.startButton setBackgroundImage:[UIImage imageNamed:@"start_button"] forState:UIControlStateNormal];
        self.menuButton.hidden = NO;
        self.infoButton.hidden = NO;
    } else {
        [self.startButton setTitle:@"Pause" forState:UIControlStateNormal];
        [self.startButton setBackgroundImage:[UIImage imageNamed:@"stop_button"] forState:UIControlStateNormal];

        self.menuButton.hidden = YES;
        self.infoButton.hidden = YES;
    }
}

- (BOOL)isStartButton {
    NSString *title = self.startButton.titleLabel.text;
    return [title isEqualToString:@"Start"];
}

- (IBAction)startButtonPressed:(id)sender {

    // start button pressed
    if(self.buttonStateStart) {
        
        // reset page control position etc
        [self.workoutView reset];
        
        __block MainViewController *bself = self;
        self.startOverlayView = [[[NSBundle mainBundle]loadNibNamed:@"OverlayView" owner:nil options:nil]objectAtIndex:2];
        
        self.startOverlayView.completionBlock = ^{
            [[TimerMgr sharedInstance] start];
            [bself.workoutView enableSwipe:NO];
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
        
        // gray color
        self.timerLabel.textColor = [UIColor colorWithRed:130.0/255.0 green:130.0/255.0 blue:130.0/255.0 alpha:1.0f];
        self.workoutView.workoutIndex++;

        // stop timer if last workout
        if([self.workoutView lastWorkout]) {
            
            // last workout
            // reset all counter except repIndex
            [self resetApp];
            
            // stop app
            if([self.workoutView lastRep]) {
                
                [self.workoutView resetRepIndex];
                [self resetButtonState];
                
                [[TimerMgr sharedInstance]finish];
                ((UILabel*)[self.completedOverlayView viewWithTag:99]).text = [NSString stringWithFormat:@"%d seconds", [TimerMgr sharedInstance].totalDuration];
                
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
        self.timerLabel.textColor = [UIViewUtil tealColor];
        
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
        
        // store in user defaults
        [[NSUserDefaults standardUserDefaults]setObject:[NSNumber numberWithInt:selectedValue] forKey:kNumOfRepsKey];
        [[NSUserDefaults standardUserDefaults]synchronize];
    };
    __block CGRect pickerFrame = pickerView.frame;
    pickerFrame.origin = CGPointMake(0, [UIViewUtil screenSize].width);
    pickerView.frame = pickerFrame;
    [self.view addSubview:pickerView];
    
    [UIView animateWithDuration:0.2f animations:^{
        pickerFrame.origin = CGPointMake(0, self.view.frame.size.height-pickerView.frame.size.height);
        pickerView.frame = pickerFrame;
    }];
}

- (IBAction)infoButtonPressed:(id)sender {
    UIView *helpView = [[[NSBundle mainBundle]loadNibNamed:@"OverlayView" owner:nil options:nil]objectAtIndex:4];
    UIView *contentView = [helpView viewWithTag:20];
    contentView.layer.cornerRadius = 7.0f;
    
    [helpView addGestureRecognizer:[UIViewUtil tapToDismissGestureWithTarget:self selector:@selector(doneOverlayTapped:)]];
    [UIViewUtil addView:helpView toSuperview:self.view];
}

@end
