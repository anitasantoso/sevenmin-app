//
//  SevenMinNavigationController.m
//  sevenmin-app
//
//  Created by Anita Santoso on 18/06/13.
//  Copyright (c) 2013 as. All rights reserved.
//

#import "SevenMinNavigationController.h"
#import "MFSideMenuContainerViewController.h"

@interface SevenMinNavigationController ()

@end

@implementation SevenMinNavigationController

- (MFSideMenuContainerViewController *)menuContainerViewController {
    return (MFSideMenuContainerViewController *)self.parentViewController;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setBackButton];
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    [super pushViewController:viewController animated:animated];
    [self setBackButton];
}

- (void)setBackButton {
    
    // left bar button item
    UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 44, 44)];
    [button setImage:[UIImage imageNamed:@"list_icon"] forState:UIControlStateNormal];
    button.contentMode = UIViewContentModeLeft;
    [button setBackgroundColor:[UIColor clearColor]];
    [button addTarget:self action:@selector(openMenu) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *barBtn = [[UIBarButtonItem alloc]initWithCustomView:button];
    self.visibleViewController.navigationItem.leftBarButtonItem = barBtn;
}

- (void)openMenu {
    [[self menuContainerViewController]toggleLeftSideMenuCompletion:nil];
}

@end
