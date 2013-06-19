//
//  UIViewController+MenuContainer.m
//  sevenmin-app
//
//  Created by Anita Santoso on 19/06/13.
//  Copyright (c) 2013 as. All rights reserved.
//

#import "UIViewController+MenuContainer.h"

@implementation UIViewController (MenuContainer)

- (MFSideMenuContainerViewController *)menuContainerViewController {
    if(!self.navigationController) {
        return (MFSideMenuContainerViewController *)self.parentViewController;
    }
    return (MFSideMenuContainerViewController *)self.navigationController.parentViewController;
}

@end
