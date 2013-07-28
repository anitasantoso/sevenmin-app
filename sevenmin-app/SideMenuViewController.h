//
//  SideMenuViewController.h
//  sevenmin-app
//
//  Created by Anita Santoso on 18/06/13.
//  Copyright (c) 2013 as. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SideMenuViewController : UIViewController
- (IBAction)workoutPressed:(id)sender;
- (IBAction)aboutPressed:(id)sender;
//- (IBAction)recordsPressed:(id)sender;
- (IBAction)settingsPressed:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *workoutButton;
@property (strong, nonatomic) IBOutlet UIButton *settingsButton;
@property (strong, nonatomic) IBOutlet UIButton *aboutButton;


//@property (strong, nonatomic) IBOutlet UIButton *recordsButton;
@end
