//
//  SettingsUtil.h
//  sevenmin-app
//
//  Created by Anita Santoso on 19/06/13.
//  Copyright (c) 2013 as. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JTSingleton.h"

#define kSettingsWhistleSound @"7MIN_WHISTLE_SOUND"
#define kSettingsClockSound @"7MIN_CLOCK_SOUND"
#define kSettingsNumOfReps @"7MIN_NUM_OF_REPS"
#define kSettingsWorkoutDuration @"7MIN_WORKOUT_DURATION"
#define kSettingsBreakDuration @"7MIN_BREAK_DURATION"

@interface SettingsUtil : NSObject
+(SettingsUtil*)sharedInstance;
@property BOOL whistleSoundEnabled;
@property BOOL clockSoundEnabled;
@property int workoutDuration;
@property int breakDuration;
@property int numberOfReps;
@end
