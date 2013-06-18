//
//  UIViewUtil.h
//  sevenmin-app
//
//  Created by Anita Santoso on 22/05/13.
//  Copyright (c) 2013 as. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UIViewUtil : NSObject
+ (void)addView:(UIView*)view toSuperview:(UIView*)superView;
+ (void)removeView:(UIView*)view fromSuperview:(UIView*)superView;
+ (UITapGestureRecognizer*)tapToDismissGestureWithTarget:(id)target selector:(SEL)selector;
+ (UIColor*)tealColor;
+ (UIColor*)grayColor;
+ (CGSize)screenSize;
+ (CGRect)screenFrame;
+ (NSString*)formatToTime:(int)secondsRemaining;
+ (void)addOverlay:(UIView*)view;
@end
