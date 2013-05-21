//
//  TimerMgr.h
//  sevenmin-app
//
//  Created by Anita Santoso on 21/05/13.
//  Copyright (c) 2013 as. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JTSingleton.h"

typedef enum {
    TimerTypeWorkout, TimerTypeBreak
} TimerType;

@interface TimerMgr : NSObject
+ (TimerMgr*)sharedInstance;

@property (nonatomic, copy) void(^workoutTimerCompleted)(void);
@property (nonatomic, copy) void(^breakTimerCompleted)(void);
@property (nonatomic, copy) void(^timerDidFire)(void);

@property (nonatomic) NSInteger totalDuration;
- (void)reset;
- (void)startWorkoutTimer;
- (void)stopWorkoutTimer;
- (void)startBreakTimer;
- (void)stopBreakTimer;
- (TimerType)currentTimer;
- (void)stopCurrentTimer;
- (void)restartCurrentTimer;
- (NSTimeInterval)secondsRemaining;
@end
