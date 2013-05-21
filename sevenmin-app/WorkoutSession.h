//
//  WorkoutSession.h
//  sevenmin-app
//
//  Created by Anita Santoso on 19/05/13.
//  Copyright (c) 2013 as. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WorkoutSession : NSObject

@property BOOL completed;
@property (nonatomic, strong) NSDate *date;
@property NSInteger numberOfReps;
@property NSTimeInterval totalTime;

@end
