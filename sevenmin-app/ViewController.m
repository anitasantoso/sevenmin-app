//
//  ViewController.m
//  sevenmin-app
//
//  Created by Anita Santoso on 18/05/13.
//  Copyright (c) 2013 as. All rights reserved.
//

#import "ViewController.h"

#define kNumOfWorkout 3

@interface ViewController ()
@property (nonatomic, strong) NSTimer *workoutTimer;
@property (nonatomic, strong) NSTimer *breakTimer;
@property NSInteger workoutSecondsRemaining;
@property NSInteger breakSecondsRemaining;
@property NSInteger exerciseIndex;
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.scrollView.contentSize = CGSizeMake(320*3, 200);
    self.scrollView.delegate = self;
    UIView *view = [[[NSBundle mainBundle]loadNibNamed:@"ViewController" owner:nil options:nil]objectAtIndex:1];
    [self.scrollView addSubview:view];
    
    
}

#pragma mark - scroll view delegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat pageWidth = scrollView.frame.size.width;
    int page = floor((scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    self.pageControl.currentPage = page;
}

- (IBAction)startButtonPressed:(id)sender {
    self.startButton.enabled = NO;
    [self startWorkoutTimer];
}

- (void)startWorkoutTimer {
    self.breakSecondsRemaining = 10;
    self.workoutTimer = [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(updateTimerLabel) userInfo:nil repeats:YES];
}

- (void)stopWorkoutTimer {
    self.workoutTimer = nil;
}

- (void)startBreakTimer {
    self.breakSecondsRemaining = 10;
    self.breakTimer = [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(updateTimerLabel) userInfo:nil repeats:YES];
}

- (void)stopBreakTimer {
    self.breakTimer = nil;
}

- (void)updateTimerLabel {
    
    // if workout timer is running
    if(self.workoutTimer.isValid) {
        self.workoutSecondsRemaining--;
        
        // end of workout
        if(self.workoutSecondsRemaining == 0) {
            self.exerciseIndex++;
            
            // stop workout timer
            [self stopWorkoutTimer];
            
            // next workout
            self.scrollView.contentOffset = CGPointMake(320*self.exerciseIndex, 200);
            
            // stop timer if last workout
            if(self.exerciseIndex == kNumOfWorkout-1) {
                return;
            }
            [self startBreakTimer];
            // TODO add break overlay
        }
    }
    // if break timer is running
    else if(self.workoutTimer.isValid) {
        self.breakSecondsRemaining--;
        
        // end of break
        if(self.breakSecondsRemaining == 0) {
            [self stopBreakTimer];
            
            // TODO remove overlay
            [self startWorkoutTimer];
        }
    }
    
    // update time label
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc]init];
    [formatter setMinimumIntegerDigits:2];
    self.timerLabel.text = [NSString stringWithFormat:@"00:%@", [formatter stringFromNumber:[NSNumber numberWithInt:self.workoutSecondsRemaining]]];
}

@end
