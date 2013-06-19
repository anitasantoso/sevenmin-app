//
//  SettingsUtil.m
//  sevenmin-app
//
//  Created by Anita Santoso on 19/06/13.
//  Copyright (c) 2013 as. All rights reserved.
//

#import "SettingsUtil.h"

@implementation SettingsUtil
JTSYNTHESIZE_SINGLETON_FOR_CLASS(SettingsUtil)

- (id)init {
    if(self = [super init]) {
        
        // set default values
        [self valueForKey:kSettingsWhistleSound defaultValue:[NSNumber numberWithBool:YES]];
        [self valueForKey:kSettingsClockSound defaultValue:[NSNumber numberWithBool:YES]];
        [self valueForKey:kSettingsNumOfReps defaultValue:[NSNumber numberWithInt:3]];
        [self valueForKey:kSettingsWorkoutDuration defaultValue:[NSNumber numberWithInt:30]];
        [self valueForKey:kSettingsBreakDuration defaultValue:[NSNumber numberWithInt:10]];
        
        [self reload];
    }
    return self;
}

- (void)reload {
    self.whistleSoundEnabled = [[self valueForKey:kSettingsWhistleSound]boolValue];
    self.clockSoundEnabled = [[self valueForKey:kSettingsClockSound]boolValue];
    self.workoutDuration = [[self valueForKey:kSettingsWorkoutDuration]intValue];
    self.breakDuration = [[self valueForKey:kSettingsBreakDuration]intValue];
    self.numberOfReps = [[self valueForKey:kSettingsNumOfReps]intValue];
}

- (id)valueForKey:(NSString *)key {
    return [self valueForKey:key defaultValue:nil];
}

- (id)valueForKey:(NSString*)key defaultValue:(id)defaultValue {
    id val = [[NSUserDefaults standardUserDefaults]valueForKey:key];
    if(!val && defaultValue) {
        [self setValue:defaultValue forKey:key];
    }
    return [[NSUserDefaults standardUserDefaults]objectForKey:key];
}

- (void)setValue:(id)value forKey:(NSString*)key {
    [[NSUserDefaults standardUserDefaults]setObject:value forKey:key];
    [[NSUserDefaults standardUserDefaults]synchronize];
    [self reload];
}

@end
