//
//  RepPickerView.m
//  sevenmin-app
//
//  Created by Anita Santoso on 19/05/13.
//  Copyright (c) 2013 as. All rights reserved.
//

#import "PickerView.h"
@interface PickerView()
@property (nonatomic) id selectedValue;
@property (nonatomic, strong) NSArray *values;
@end

@implementation PickerView

+ (PickerView*)pickerWithTitle:(NSString*)title currentValue:(id)currentValue values:(NSArray*)values {
    PickerView *pickerView = [[[NSBundle mainBundle]loadNibNamed:@"PickerView" owner:nil options:nil]objectAtIndex:0];
    pickerView.currentValue = currentValue;
    pickerView.values = values;
    [pickerView.barButtonTitle setTitle:title];
    return pickerView;
}

- (void)setCurrentValue:(id)currentValue {
    _currentValue = currentValue;
    self.selectedValue = currentValue;
    [self.values enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        if([[obj stringValue] isEqualToString:[currentValue stringValue]]) {
            [self.picker selectRow:idx inComponent:0 animated:YES];
            *stop = YES;
        }
    }];
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return self.values.count;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return [[self.values objectAtIndex:row]stringValue];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    self.selectedValue = [self.values objectAtIndex:row];
}

- (IBAction)cancelButtonPressed:(id)sender {
    [self remove];
}

- (void)show {
    __block CGRect pickerFrame = self.frame;
    pickerFrame.origin = CGPointMake(0, [UIViewUtil screenSize].height);
    self.frame = pickerFrame;
    
    [[[UIApplication sharedApplication]keyWindow] addSubview:self];
    [UIView animateWithDuration:0.2f animations:^{
        pickerFrame.origin = CGPointMake(0, [UIViewUtil screenSize].height-self.frame.size.height);
        self.frame = pickerFrame;
    }];
}

- (void)remove {
    [UIView animateWithDuration:0.2f animations:^{
        CGRect frame = self.frame;
        frame.origin = CGPointMake(0, [UIViewUtil screenSize].height);
        self.frame = frame;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

- (IBAction)doneButtonPressed:(id)sender {
    [UIView animateWithDuration:0.2f animations:^{
        CGRect frame = self.frame;
        frame.origin = CGPointMake(0, [UIViewUtil screenSize].height);
        self.frame = frame;
    } completion:^(BOOL finished) {
        self.completionBlock(self.selectedValue);
    }];
}

@end
