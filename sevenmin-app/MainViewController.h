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

- (IBAction)startButtonPressed:(id)sender;

@end
