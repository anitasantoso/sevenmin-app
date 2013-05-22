//
//  StartOverlayView.m
//  sevenmin-app
//
//  Created by Anita Santoso on 21/05/13.
//  Copyright (c) 2013 as. All rights reserved.
//

#import "StartOverlayView.h"

@interface StartOverlayView()
@property NSInteger counter;
@end

@implementation StartOverlayView

- (void)awakeFromNib {
    self.label2.hidden = YES;
    self.label3.hidden = YES;
}

- (void)startCounter {
    [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(updateLabels) userInfo:nil repeats:YES];
}

- (void)updateLabels {
    switch(self.counter) {
        case 0:
            self.label2.hidden = NO;
            break;
        case 1:
            self.label3.hidden = NO;
            break;
        case 2: {
            [UIView animateWithDuration:.2 animations:^{
                [self removeFromSuperview];
            } completion:^(BOOL finished) {
                self.completionBlock();
            }];
            break;
        }
        default:
            break;
    }
    self.counter++;
}

@end
