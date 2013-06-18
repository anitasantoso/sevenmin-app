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
#import "MFSideMenuContainerViewController.h"

@interface SideMenuViewController ()

@end

@implementation SideMenuViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (MFSideMenuContainerViewController *)menuContainerViewController {
    return (MFSideMenuContainerViewController *)self.parentViewController;
}

- (IBAction)aboutPressed:(id)sender {
    UIViewController *settingsViewCon = [[UIStoryboard storyboardWithName:@"MainStoryboard" bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier:@"aboutViewController"];
    [[self menuContainerViewController].centerViewController pushViewController:settingsViewCon animated:YES];
    self.menuContainerViewController.menuState = MFSideMenuStateClosed;
}

- (IBAction)recordsPressed:(id)sender {
}

- (IBAction)settingsPressed:(id)sender {

    UIViewController *settingsViewCon = [[UIStoryboard storyboardWithName:@"MainStoryboard" bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier:@"settingsViewController"];
     [[self menuContainerViewController].centerViewController pushViewController:settingsViewCon animated:YES];
    self.menuContainerViewController.menuState = MFSideMenuStateClosed;
}

@end
