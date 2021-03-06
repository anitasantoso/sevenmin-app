//
//  WorkoutView.m
//  sevenmin-app
//
//  Created by Anita Santoso on 21/05/13.
//  Copyright (c) 2013 as. All rights reserved.
//

#import "WorkoutView.h"

#define kScrollViewHeight 210

@interface WorkoutView()
@property NSInteger workoutIndex;
@property (nonatomic)  NSInteger repIndex;
@end

@implementation WorkoutView

- (BOOL)lastWorkout {
    return self.workoutIndex == kNumOfWorkout;
}

- (BOOL)lastRep {
    return self.repIndex == self.numOfReps-1;
}

- (void)nextRep {
    self.repIndex = self.repIndex+1;
}

- (void)nextWorkout {
    self.workoutIndex = self.workoutIndex+1;
}

- (void)setRepIndex:(NSInteger)repIndex {
    _repIndex = repIndex;
    self.numOfRepsLabel.text = [NSString stringWithFormat:@"%d/%d reps", self.repIndex+1, self.numOfReps];
}

//- (void)setNumOfReps:(NSInteger)numOfReps {
//    _numOfReps = numOfReps;
//    self.numOfRepsLabel.text = [NSString stringWithFormat:@"%d/%d reps", self.repIndex+1, self.numOfReps];
//}

- (void)resetRepIndex {
    self.repIndex = 0;
}

// do not reset repIndex here
- (void)reset {
    self.workoutIndex = 0;
    
    // page indicator
    self.pageControl.currentPage = 0;
    
    // first workout
    [self.scrollView scrollRectToVisible:CGRectMake(0, self.scrollView.frame.origin.y, [UIViewUtil screenSize].width, kScrollViewHeight) animated:YES];
}

- (void)showNextWorkout {
    [self.scrollView scrollRectToVisible:CGRectMake([UIViewUtil screenSize].width*self.workoutIndex, self.scrollView.frame.origin.y, [UIViewUtil screenSize].width, kScrollViewHeight) animated:YES];
}

- (void)enableSwipe:(BOOL)enable {
    self.scrollView.userInteractionEnabled = enable;
}

- (void)awakeFromNib {
    [self reset];
    self.pageControl.numberOfPages = kNumOfWorkout;
    
    // scroll view
    self.scrollView.contentSize = CGSizeMake([UIViewUtil screenSize].width*kNumOfWorkout, kScrollViewHeight);
    self.scrollView.delegate = self;
    
    NSArray *workouts = @[@"Jumping Jacks", @"Wall Sit", @"Push-Up" , @"Abdominal Crunch", @"Step-up onto Chair", @"Squat", @"Triceps Dip on Chair", @"Plank", @"High-Knees Run", @"Lunge", @"Push-Up and Rotation", @"Side Plank"];
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, [UIViewUtil screenSize].width*kNumOfWorkout, kScrollViewHeight)];

    for(int i=0; i<kNumOfWorkout; i++) {
        NSInteger originX = [UIViewUtil screenSize].width*i;
        
        UIImageView *imgView = [[UIImageView alloc]initWithFrame:CGRectMake(originX, 50, [UIViewUtil screenSize].width, 160)];
        imgView.contentMode = UIViewContentModeCenter;
        imgView.image = [UIImage imageNamed:[NSString stringWithFormat:@"ex%d", i+1]];
        
        UILabel *title = [[UILabel alloc]initWithFrame:CGRectMake(originX, 20, [UIViewUtil screenSize].width, 25)];
        title.backgroundColor = [UIColor whiteColor];
        title.textAlignment = NSTextAlignmentCenter;
        title.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:20];
        title.text = [workouts objectAtIndex:i];
        title.textColor = [UIColor colorWithRed:236.0/255.0 green:100.0/255.0 blue:79.0/255.0 alpha:1.0f];
        
        [view addSubview:title];
        [view addSubview:imgView];
    }
    [self.scrollView addSubview:view];
    [self reset];
    [self setRepIndex:0];

    self.numOfRepsLabel.text = [NSString stringWithFormat:@"%d/%d reps", self.repIndex+1, self.numOfReps];
}

#pragma mark - scroll view delegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat pageWidth = scrollView.frame.size.width;
    int page = floor((scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    self.pageControl.currentPage = page;
}

@end
