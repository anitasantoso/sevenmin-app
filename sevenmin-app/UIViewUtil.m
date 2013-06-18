//
//  UIViewUtil.m
//  sevenmin-app
//
//  Created by Anita Santoso on 22/05/13.
//  Copyright (c) 2013 as. All rights reserved.
//

#import "UIViewUtil.h"
#import "UIView+Position.h"

@implementation UIViewUtil

+ (void)addView:(UIView*)view toSuperview:(UIView*)superView {
    view.alpha = 0.0f;
    [superView addSubview:view];
    [view centerOnScreen];
    [UIView animateWithDuration:.2 animations:^{
        view.alpha = 1.0f;
    }];
}

+ (void)removeView:(UIView*)view fromSuperview:(UIView*)superView {
    [UIView animateWithDuration:.2 animations:^{
        view.alpha = 0.0f;
    } completion:^(BOOL finished) {
        [view removeFromSuperview];
    }];
}

+ (UITapGestureRecognizer*)tapToDismissGestureWithTarget:(id)target selector:(SEL)selector {
      return [[UITapGestureRecognizer alloc]initWithTarget:target action:selector];
}

+ (UIColor*)tealColor {
    return [UIColor colorWithRed:55.0/255.0 green:189.0/255.0 blue:190.0/255.0 alpha:1.0];
}

+ (UIColor*)grayColor {
    return [UIColor colorWithRed:130.0/255.0 green:130.0/255.0 blue:130.0/255.0 alpha:1.0f];
}

+ (CGSize)screenSize {
    return [UIScreen mainScreen].bounds.size;
}

+ (CGRect)screenFrame {
    CGRect frame = [UIScreen mainScreen].bounds;
    frame.origin = CGPointZero;
    return frame;
}

+ (NSString*)formatToTime:(int)secondsRemaining {
    
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc]init];
    [formatter setMinimumIntegerDigits:2];
    return [NSString stringWithFormat:@"00:%@", [formatter stringFromNumber:[NSNumber numberWithInt:secondsRemaining]]];
}

+ (void)addOverlay:(UIView*)view {
    [UIViewUtil addView:view toSuperview:[[UIApplication sharedApplication]keyWindow]];
}

@end
