//
//  MainViewController.h
//  sevenmin-app
//
//  Created by Anita Santoso on 19/05/13.
//  Copyright (c) 2013 as. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainViewController : UIViewController<UIScrollViewDelegate, UIActionSheetDelegate>

@property (strong, nonatomic) IBOutlet UIView *workoutContentView;
//@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;
- (IBAction)startButtonPressed:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *startButton;
@property (strong, nonatomic) IBOutlet UILabel *timerLabel;
@property (strong, nonatomic) IBOutlet UIButton *infoButton;
- (IBAction)menuButtonPressed:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *menuButton;
@property (strong, nonatomic) IBOutlet UIButton *infoButtonPressed;

//@property (strong, nonatomic) IBOutlet UILabel *numOfRepsLabel;
//@property (strong, nonatomic) IBOutlet UIPageControl *pageControl;
@end
