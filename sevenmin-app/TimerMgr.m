//
//  TimerMgr.m
//  sevenmin-app
//
//  Created by Anita Santoso on 21/05/13.
//  Copyright (c) 2013 as. All rights reserved.
//

#import "TimerMgr.h"

@interface TimerMgr()
@property (nonatomic, strong) NSTimer *workoutTimer;
@property (nonatomic, strong) NSTimer *breakTimer;
@property (nonatomic, strong) NSTimer *durationTimer;

@property TimerType lastTimer;
@property NSInteger workoutSecondsRemaining;
@property NSInteger breakSecondsRemaining;
@end

@implementation TimerMgr

JTSYNTHESIZE_SINGLETON_FOR_CLASS(TimerMgr)

- (id)init {
    if(self = [super init]) {
        [self reset];
    }
    return self;
}

- (void)startWorkoutTimer {
    [self startWorkoutTimerAndReset:YES];
    self.durationTimer = [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(updateDuration) userInfo:nil repeats:YES];
}

- (void)updateDuration {
    self.totalDuration++;
}

- (NSInteger)totalDuration {
    [self.durationTimer invalidate];
    return _totalDuration;
}

- (void)startWorkoutTimerAndReset:(BOOL)reset {
    [self stopWorkoutTimer];
    if(reset) {
        self.workoutSecondsRemaining = kWorkoutDuration;
    }
    self.workoutTimer = [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(timerExpired) userInfo:nil repeats:YES];
}

- (void)reset {
    self.workoutSecondsRemaining = kWorkoutDuration;
    self.breakSecondsRemaining = kBreakDuration;
    [self stopBreakTimer];
    [self stopWorkoutTimer];
}

- (void)stopWorkoutTimer {
    [self.workoutTimer invalidate];
    self.workoutTimer = nil;
}

- (void)startBreakTimer {
    [self startBreakTimerAndReset:YES];
}

- (void)startBreakTimerAndReset:(BOOL)reset {
    [self stopBreakTimer];
    if(reset) {
        self.breakSecondsRemaining = kBreakDuration;
    }
    self.breakTimer = [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(timerExpired) userInfo:nil repeats:YES];
}

- (void)timerExpired {
    if([self currentTimer] == TimerTypeBreak) {
        self.breakSecondsRemaining--;
        if(self.breakSecondsRemaining == -1) {
            self.breakTimerCompleted();
        }
    } else {
        self.workoutSecondsRemaining--;
        if(self.workoutSecondsRemaining == -1) {
            self.workoutTimerCompleted();
        }
    }
    self.timerDidFire();
}

- (void)stopBreakTimer {
    [self.breakTimer invalidate];
    self.breakTimer = nil;
}

- (TimerType)currentTimer {
    return self.breakTimer.isValid? TimerTypeBreak : TimerTypeWorkout;
}

- (NSTimeInterval)secondsRemaining {
    return [self currentTimer] == TimerTypeBreak? self.breakSecondsRemaining : self.workoutSecondsRemaining;
}

- (void)stopCurrentTimer {
    if(self.breakTimer.isValid) {
        [self.breakTimer invalidate];
        self.lastTimer = TimerTypeBreak;
    } else {
        [self.workoutTimer invalidate];
        self.lastTimer = TimerTypeWorkout;
    }
}

- (void)restartCurrentTimer {
    if(self.lastTimer == TimerTypeBreak) {
        [self startBreakTimerAndReset:NO];
    } else {
        [self startWorkoutTimerAndReset:NO];
    }
}

@end
