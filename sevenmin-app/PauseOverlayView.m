//
//  PauseOverlayView.m
//  sevenmin-app
//
//  Created by Anita Santoso on 21/05/13.
//  Copyright (c) 2013 as. All rights reserved.
//

#import "PauseOverlayView.h"

@implementation PauseOverlayView

- (IBAction)doneButtonPressed:(id)sender {
    if(self.doneBlock) {
        self.doneBlock();
    }
    [self removeFromSuperview];
}

- (void)setDoneBlock:(void (^)(void))doneBlock {
    _doneBlock = doneBlock;
    NSLog(0);
}

- (IBAction)resumeButtonPressed:(id)sender {
    if(self.resumeBlock) {
        self.resumeBlock();
    }
    [self removeFromSuperview];
}
@end
