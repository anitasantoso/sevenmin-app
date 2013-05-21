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

@end

@implementation WorkoutView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (BOOL)lastWorkout {
    return self.workoutIndex == kNumOfWorkout;
}

- (BOOL)lastRep {
    return self.repIndex == self.numOfReps-1;
}

- (void)nextRep {
    self.repIndex = self.repIndex+1;
}

// TODO
- (void)setRepIndex:(NSInteger)repIndex {
    _repIndex = repIndex;
    self.numOfRepsLabel.text = [NSString stringWithFormat:@"%d/%d reps", self.repIndex+1, self.numOfReps];
}

- (void)resetRepIndex {
    self.repIndex = 0;
}

// do not reset repIndex here
- (void)reset {
    self.workoutIndex = 0;
    
    // page indicator
    self.pageControl.currentPage = 0;
    
    // first workout
    [self.scrollView scrollRectToVisible:CGRectMake(0, self.scrollView.frame.origin.y, 320, kScrollViewHeight) animated:YES];
    
    // remember number of reps from previous session
    NSInteger numOfReps = [[[NSUserDefaults standardUserDefaults]valueForKey:@"7MIN_NUM_OF_REPS"]intValue];
    self.numOfReps = numOfReps == 0? kDefaultNumOfReps : numOfReps;
}

- (void)showNextWorkout {
    [self.scrollView scrollRectToVisible:CGRectMake(320*self.workoutIndex, self.scrollView.frame.origin.y, 320, 210) animated:YES];
}

- (void)awakeFromNib {
    [self reset];
    
    self.pageControl.numberOfPages = kNumOfWorkout;
    
    // scroll view
    self.scrollView.userInteractionEnabled = NO;
    self.scrollView.contentSize = CGSizeMake(320*kNumOfWorkout, kScrollViewHeight);
    self.scrollView.delegate = self;
    
    NSArray *workouts = @[@"Jumping Jacks", @"Wall Sit", @"Push-up" , @"Abdominal Crunch", @"Step-up onto chair", @"Squat", @"Triceps dip on chair", @"Plank", @"High knees run", @"Lunge", @"Push-up and rotation", @"Side plank"];
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 320*kNumOfWorkout, kScrollViewHeight)];

    for(int i=0; i<kNumOfWorkout; i++) {
        NSInteger originX = 320*i;
        
        UIImageView *imgView = [[UIImageView alloc]initWithFrame:CGRectMake(originX, 50, 320, 160)];
        imgView.contentMode = UIViewContentModeCenter;
        imgView.image = [UIImage imageNamed:[NSString stringWithFormat:@"ex%d", i+1]];
        
        UILabel *title = [[UILabel alloc]initWithFrame:CGRectMake(originX, 20, 320, 25)];
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
}

#pragma mark - scroll view delegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat pageWidth = scrollView.frame.size.width;
    int page = floor((scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    self.pageControl.currentPage = page;
}

@end
