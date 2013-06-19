//
//  AppDelegate.m
//  sevenmin-app
//
//  Created by Anita Santoso on 18/05/13.
//  Copyright (c) 2013 as. All rights reserved.
//

#import "AppDelegate.h"
#import "MFSideMenuContainerViewController.h"
#import "MainViewController.h"

@interface AppDelegate()
@property (nonatomic, strong) MFSideMenuContainerViewController *containerViewCon;
@end
@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    // doesn't work?
    [[UINavigationBar appearance]setBackgroundImage:[UIImage imageNamed:@"navbar"] forBarMetrics:UIBarMetricsDefault];
    [[UINavigationBar appearance]setTitleTextAttributes:
     [NSDictionary dictionaryWithObjectsAndKeys:
      [UIColor whiteColor], UITextAttributeTextColor,
      [UIFont fontWithName:@"Helvetica-Neue" size:12.0], UITextAttributeFont,nil]];
    
    [[UIBarButtonItem appearance]setBackButtonBackgroundImage:[UIImage imageNamed:@"navbar"] forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    
    // load storyboard
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:[NSBundle mainBundle]];
    
    // side menu controller
    UIViewController *leftViewCon = [storyboard instantiateViewControllerWithIdentifier:@"sideViewController"];

    // main controller
    UINavigationController *navCon = [storyboard instantiateViewControllerWithIdentifier:@"navigationController"];
    
    // container
    self.containerViewCon = [MFSideMenuContainerViewController containerWithCenterViewController:navCon leftMenuViewController:leftViewCon rightMenuViewController:nil];
    self.containerViewCon.menuWidth = 90.0f;
    
    self.window.rootViewController = self.containerViewCon;
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)openMenu {
    [self.containerViewCon toggleLeftSideMenuCompletion:nil];
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
