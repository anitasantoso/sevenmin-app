//
//  MainViewController.m
//  sevenmin-app
//
//  Created by Anita Santoso on 19/05/13.
//  Copyright (c) 2013 as. All rights reserved.
//

#import "MainViewController.h"
#import "PickerView.h"
#import "PauseOverlayView.h"
#import "TimerMgr.h"
#import "WorkoutView.h"
#import "StartOverlayView.h"
#import "UIViewUtil.h"
#import "SoundMgr.h"
#import "SettingsUtil.h"
#import "UIViewController+MenuContainer.h"

@interface MainViewController()

@property (nonatomic, strong) UIView *breakOverlayView;
@property (nonatomic, strong) UIView *completedOverlayView;
@property (nonatomic, strong) StartOverlayView *startOverlayView;
@property (nonatomic, strong) WorkoutView *workoutView;
@property BOOL buttonStateStart;
@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [TimerMgr sharedInstance].workoutTimerCompleted = ^{
        [self updateTimerLabel];
    };
    [TimerMgr sharedInstance].breakTimerCompleted = ^{
        [self updateTimerLabel];        
    };

    [self loadOverlayViews];
    [self setInitialState];
}

- (void)loadOverlayViews {
    self.workoutView = [[[NSBundle mainBundle]loadNibNamed:@"WorkoutView" owner:nil options:nil]objectAtIndex:0];
    self.workoutView.numOfReps = [SettingsUtil sharedInstance].numberOfReps;
    [self.workoutContentView addSubview:self.workoutView];
    
    self.breakOverlayView = [[[NSBundle mainBundle]loadNibNamed:@"OverlayView" owner:nil options:nil]objectAtIndex:0];
    self.breakOverlayView.frame = [UIViewUtil screenFrame];
    
    self.completedOverlayView = [[[NSBundle mainBundle]loadNibNamed:@"OverlayView" owner:nil options:nil]objectAtIndex:1];
    self.completedOverlayView.frame = [UIViewUtil screenFrame];
    
    [self.completedOverlayView addGestureRecognizer:[UIViewUtil tapToDismissGestureWithTarget:self selector:@selector(overlayTapped:)]];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    // update with current config values
    void(^playWhistleSound)(void) = ^{
        // if sound is enabled
        BOOL whistleSoundEnabled = [SettingsUtil sharedInstance].whistleSoundEnabled;
        if(whistleSoundEnabled) {
            [[SoundMgr sharedInstance]playWhistleSound];
        }
    };
    [TimerMgr sharedInstance].workoutTimerDidStart = ^{
        playWhistleSound();
    };
    [TimerMgr sharedInstance].workoutTimerDidStop = ^{
        playWhistleSound();
    };
    [TimerMgr sharedInstance].timerDidFire = ^() {
        BOOL tickSoundEnabled = [SettingsUtil sharedInstance].clockSoundEnabled;
        if(tickSoundEnabled) {
            [[SoundMgr sharedInstance]playTickingSound];
        }
        [self setTimerLabel];
    };
    
    // update this if viewcontroller is re-used
    self.workoutView.numOfReps = [SettingsUtil sharedInstance].numberOfReps;
}

- (void)setInitialState {
    // initial state
    [self resetIteration];
    [self resetButtonState];
    [self setTimerLabel];
    
    // if paused during break, remove this
    [self.breakOverlayView removeFromSuperview];
    
    [self.workoutView resetRepIndex];
    [self.workoutView enableSwipe:YES];
}

- (void)setTimerLabel {
    self.timerLabel.text = [UIViewUtil formatToTime:[[TimerMgr sharedInstance]secondsRemaining]];
}

- (void)overlayTapped:(id)sender {
    UIView *view = [[self.view subviews]lastObject];
    [UIViewUtil removeView:view fromSuperview:self.view];
}

- (void)resetIteration {
    self.timerLabel.text = [UIViewUtil formatToTime:0];
    self.timerLabel.textColor = [UIViewUtil tealColor];
    
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
    [self.startButton setTitle:self.buttonStateStart? @"Start" : @"Pause" forState:UIControlStateNormal];
    [self.startButton setBackgroundImage:[UIImage imageNamed:self.buttonStateStart? @"start_button" : @"stop_button"] forState:UIControlStateNormal];
    self.navigationItem.leftBarButtonItem.enabled = self.buttonStateStart;
    
    // disable pan gesture when timer is running
    [self menuContainerViewController].panMode = self.buttonStateStart? MFSideMenuPanModeDefault : MFSideMenuPanModeNone;
}

// TODO TODO disable swipe gesture when timer is running!
- (IBAction)startButtonPressed:(id)sender {
    
    // start button pressed
    if(self.buttonStateStart) {
        
        // reset page control position etc
        [self setInitialState];
        [self.workoutView enableSwipe:NO];
        
        __block MainViewController *bself = self;
        self.startOverlayView = [MainViewController startOverlayView];
        self.startOverlayView.frame = [UIViewUtil screenFrame];
        
        self.startOverlayView.completionBlock = ^{
            [[TimerMgr sharedInstance] beginSession];
            [[TimerMgr sharedInstance] startWorkoutTimer];
            
            bself.buttonStateStart = !bself.buttonStateStart;
            [bself setButtonState];
        };
        [UIViewUtil addOverlay:self.startOverlayView];
        [self.startOverlayView startCounter];
    }
    // stop button pressed
    else {
        [[TimerMgr sharedInstance]stopCurrentTimer];
        [[SoundMgr sharedInstance]stop];
        
        // show pause overlay
        PauseOverlayView *pauseView = [MainViewController pauseOverlayView];
        pauseView.frame = [UIViewUtil screenFrame];
        
        pauseView.doneBlock = ^{
            // done with workout
            [self setInitialState];
        };
        pauseView.resumeBlock = ^{
            [[TimerMgr sharedInstance]restartCurrentTimer];
        };
        [UIViewUtil addOverlay:pauseView];
    }
}

- (void)updateTimerLabel {
    
    // if workout timer is running
    if([[TimerMgr sharedInstance]currentTimer] == TimerTypeWorkout) {

        // gray color
        self.timerLabel.textColor = [UIViewUtil grayColor];
        [self.workoutView nextWorkout];

        // stop timer if last workout
        if([self.workoutView lastWorkout]) {
            
            // last workout
            // reset all counter except repIndex
            [self resetIteration];
            
            // stop app
            if([self.workoutView lastRep]) {
                [[TimerMgr sharedInstance]endSession]; // stop duration counter
                
                ((UILabel*)[self.completedOverlayView viewWithTag:99]).text = [NSString stringWithFormat:@"%d seconds", [TimerMgr sharedInstance].totalDuration];
                
                // show done overlay
                [UIViewUtil addOverlay:self.completedOverlayView];
                [self setInitialState];
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
        self.timerLabel.text = [UIViewUtil formatToTime:[[TimerMgr sharedInstance]secondsRemaining]];
    }
}

+ (PauseOverlayView*)pauseOverlayView {
    return [[[NSBundle mainBundle]loadNibNamed:@"OverlayView" owner:nil options:nil]objectAtIndex:3];
}

+ (StartOverlayView*)startOverlayView {
    return [[[NSBundle mainBundle]loadNibNamed:@"OverlayView" owner:nil options:nil]objectAtIndex:2];
}

@end
