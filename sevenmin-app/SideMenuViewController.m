//
//  SideMenuViewController.m
//  sevenmin-app
//
//  Created by Anita Santoso on 18/06/13.
//  Copyright (c) 2013 as. All rights reserved.
//

#import "SideMenuViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "UIViewUtil.h"
#import "UIView+Position.h"
#import "UIViewController+MenuContainer.h"

@interface SideMenuViewController ()
@property (nonatomic, strong) UIViewController *settingsViewCon;
@property (nonatomic, strong) UIViewController *workoutViewCon;
@property (nonatomic, strong) UIViewController *aboutViewCon;
@property (nonatomic, strong) UIViewController *recordsViewCon;
@end

@implementation SideMenuViewController

- (IBAction)workoutPressed:(id)sender {
    [self showViewControllerWithIdentifier:@"workout"];
}

- (IBAction)aboutPressed:(id)sender {
    [self showViewControllerWithIdentifier:@"about"];
}

- (IBAction)recordsPressed:(id)sender {
    [self showViewControllerWithIdentifier:@"records"];
}

- (IBAction)settingsPressed:(id)sender {
    [self showViewControllerWithIdentifier:@"settings"];
}

- (void)showViewControllerWithIdentifier:(NSString*)identifier {
    BOOL isWorkoutSelected = [identifier isEqualToString:@"workout"];
    BOOL isSettingsSelected = [identifier isEqualToString:@"settings"];
    BOOL isRecordsSelected = [identifier isEqualToString:@"records"];
    BOOL isAboutSelected = [identifier isEqualToString:@"about"];
    
    [self.workoutButton setImage:[UIImage imageNamed:isWorkoutSelected? @"workout_icon_sel" : @"workout_icon"] forState:UIControlStateNormal];
    [self.settingsButton setImage:[UIImage imageNamed:isSettingsSelected? @"settings_icon_sel" : @"settings_icon"] forState:UIControlStateNormal];
    [self.aboutButton setImage:[UIImage imageNamed:isAboutSelected? @"about_icon_sel" : @"about_icon"] forState:UIControlStateNormal];
    [self.recordsButton setImage:[UIImage imageNamed:isRecordsSelected? @"records_icon_sel" : @"records_icon"] forState:UIControlStateNormal];
    
    UIViewController *viewCon;
    if(isSettingsSelected) {
        if(!self.settingsViewCon) {
            self.settingsViewCon = [self viewControllerWithIdentifier:identifier];
        }
        viewCon = self.settingsViewCon;
    } else if(isWorkoutSelected) {
        if(!self.workoutViewCon) {
            self.workoutViewCon = [self viewControllerWithIdentifier:identifier];
        }
        viewCon = self.workoutViewCon;
    } else if(isAboutSelected) {
        if(!self.aboutViewCon) {
            self.aboutViewCon = [self viewControllerWithIdentifier:identifier];
        }
        viewCon = self.aboutViewCon;
    } else if(isRecordsSelected) {
        if(!self.recordsViewCon) {
            self.recordsViewCon = [self viewControllerWithIdentifier:identifier];
        }
        viewCon = self.recordsViewCon;
    }
    
    // show view controller
    UINavigationController *navCon = [self menuContainerViewController].centerViewController;
    if([navCon visibleViewController] != viewCon) {

        CATransition* transition = [CATransition animation];
        transition.duration = 0.2;
        transition.type = kCATransitionFade;
        transition.subtype = kCATransitionFromTop;
        transition.delegate = self;
        
        [navCon.view.layer addAnimation:transition forKey:kCATransition];
        [navCon popViewControllerAnimated:NO];
        [navCon pushViewController:viewCon animated:NO];
    }
}

- (void)animationDidStop:(CAAnimation *)theAnimation finished:(BOOL)flag {
    [[self menuContainerViewController] toggleLeftSideMenuCompletion:^{
        
    }];

}

- (UIViewController*)viewControllerWithIdentifier:(NSString*)identifier {
    return [[UIStoryboard storyboardWithName:@"MainStoryboard" bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier:[NSString stringWithFormat:@"%@ViewController", identifier]];
}

@end
