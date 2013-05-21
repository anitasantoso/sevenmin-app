//
//  WorkoutView.h
//  sevenmin-app
//
//  Created by Anita Santoso on 21/05/13.
//  Copyright (c) 2013 as. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WorkoutView : UIView<UIScrollViewDelegate>
@property NSInteger workoutIndex;
@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;
@property (strong, nonatomic) IBOutlet UIPageControl *pageControl;

@property (nonatomic)  NSInteger repIndex;
@property NSInteger numOfReps;
@property (strong, nonatomic) IBOutlet UILabel *numOfRepsLabel;
@property (strong, nonatomic) IBOutlet UIView *mainContentView;

- (void)reset;
- (void)resetRepIndex;
- (void)showNextWorkout;
- (BOOL)lastWorkout;
- (BOOL)lastRep;
- (void)nextRep;
@end
