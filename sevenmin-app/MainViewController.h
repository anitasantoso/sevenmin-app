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
@property (strong, nonatomic) IBOutlet UIButton *startButton;
@property (strong, nonatomic) IBOutlet UILabel *timerLabel;
@property (strong, nonatomic) IBOutlet UIButton *infoButton;
@property (strong, nonatomic) IBOutlet UIButton *menuButton;

- (IBAction)startButtonPressed:(id)sender;
- (IBAction)menuButtonPressed:(id)sender;
- (IBAction)infoButtonPressed:(id)sender;

@end
