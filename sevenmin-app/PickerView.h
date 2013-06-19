//
//  RepPickerView.h
//  sevenmin-app
//
//  Created by Anita Santoso on 19/05/13.
//  Copyright (c) 2013 as. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PickerView : UIView<UIPickerViewDataSource, UIPickerViewDelegate>
+ (PickerView*)pickerWithTitle:(NSString*)title currentValue:(id)currentValue values:(NSArray*)values;
@property (strong, nonatomic) IBOutlet UIPickerView *picker;
- (IBAction)cancelButtonPressed:(id)sender;
- (IBAction)doneButtonPressed:(id)sender;
@property (nonatomic) id currentValue;
@property (nonatomic, copy) void (^completionBlock)(id);
@property (strong, nonatomic) IBOutlet UIBarButtonItem *barButtonTitle;
- (void)show;
@end
