//
//  RepPickerView.m
//  sevenmin-app
//
//  Created by Anita Santoso on 19/05/13.
//  Copyright (c) 2013 as. All rights reserved.
//

#import "RepPickerView.h"
@interface RepPickerView()
@property (nonatomic) NSInteger selectedValue;
@end

@implementation RepPickerView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    if(self = [super initWithCoder:aDecoder]) {
        self.currentValue = 1;
    }
    return self;
}

- (void)setCurrentValue:(NSInteger)currentValue {
    _currentValue = currentValue;
    self.selectedValue = currentValue;
    [self.picker selectRow:_currentValue-1 inComponent:0 animated:YES];
}

// returns the number of 'columns' to display.
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

// returns the # of rows in each component..
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return 10;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return [NSString stringWithFormat:@"%d", row+1];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    self.selectedValue = row+1;
}

- (IBAction)cancelButtonPressed:(id)sender {
    [self remove];
}

- (void)remove {
    [UIView animateWithDuration:0.2f animations:^{
        CGRect frame = self.frame;
        
        // TODO calculate screen height
        frame.origin = CGPointMake(0, 480);
        self.frame = frame;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

- (IBAction)doneButtonPressed:(id)sender {
    [UIView animateWithDuration:0.2f animations:^{
        CGRect frame = self.frame;
        
        // TODO calculate screen height
        frame.origin = CGPointMake(0, 480);
        self.frame = frame;
    } completion:^(BOOL finished) {
        self.completionBlock(self.selectedValue);
    }];
}

@end
