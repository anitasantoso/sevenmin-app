//
//  PauseOverlayView.h
//  sevenmin-app
//
//  Created by Anita Santoso on 21/05/13.
//  Copyright (c) 2013 as. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PauseOverlayView : UIView
- (IBAction)doneButtonPressed:(id)sender;
- (IBAction)resumeButtonPressed:(id)sender;
@property (nonatomic, copy) void(^doneBlock)(void);
@property (nonatomic, copy) void(^resumeBlock)(void);
@end
