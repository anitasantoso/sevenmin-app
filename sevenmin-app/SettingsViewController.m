//
//  SettingsViewController.m
//  sevenmin-app
//
//  Created by Anita Santoso on 18/06/13.
//  Copyright (c) 2013 as. All rights reserved.
//

#import "SettingsViewController.h"
#import "SwitchCell.h"
#import "ButtonCell.h"
#import "SettingsUtil.h"
#import "PickerView.h"

@interface SettingsViewController ()
@property (nonatomic, strong) NSArray *settings;
@property (nonatomic, strong) NSArray *settingsKey;
@property (nonatomic, strong) NSArray *durationValues;
@property (nonatomic, strong) NSArray *repValues;
@end

@implementation SettingsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.settings = @[@"Whistle sound", @"Timer sound", @"Number of repetition", @"Workout duration", @"Break duration"];
    self.settingsKey = @[kSettingsWhistleSound, kSettingsClockSound, kSettingsNumOfReps, kSettingsWorkoutDuration, kSettingsBreakDuration];
    self.durationValues = @[[NSNumber numberWithInt:5], [NSNumber numberWithInt:10], [NSNumber numberWithInt:20], [NSNumber numberWithInt:30], [NSNumber numberWithInt:40], [NSNumber numberWithInt:50]];
    self.repValues = @[[NSNumber numberWithInt:1], [NSNumber numberWithInt:2], [NSNumber numberWithInt:3], [NSNumber numberWithInt:4], [NSNumber numberWithInt:5]];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 55.0f;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.settings count];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if([cell isKindOfClass:[SwitchCell class]]) {
        return;
    }
    [self showPickerOnTableView:tableView indexPath:indexPath];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    BOOL isSwitchCell = indexPath.row == 0 || indexPath.row == 1;
    UITableViewCell *cell;
    
    NSString *title = [self.settings objectAtIndex:indexPath.row];
    NSString *settingsKey = [self.settingsKey objectAtIndex:indexPath.row];
    
    if(isSwitchCell) {
        SwitchCell *switchCell = [tableView dequeueReusableCellWithIdentifier:@"switchCell"];
        switchCell.textLabel.text = title;
        switchCell.settingsKey = settingsKey;
        
        NSNumber *val = [[SettingsUtil sharedInstance]valueForKey:[self.settingsKey objectAtIndex:indexPath.row]];
        switchCell.valueSwitch.on = [val boolValue];
        switchCell.onValueChanged = ^(NSString *settingsKey, BOOL on) {
            [[SettingsUtil sharedInstance]setValue:[NSNumber numberWithBool:on] forKey:settingsKey];
        };
        cell = switchCell;
    } else {
        ButtonCell *buttonCell = [tableView dequeueReusableCellWithIdentifier:@"buttonCell"];
        buttonCell.textLabel.text = title;
        
        NSNumber *val = [[SettingsUtil sharedInstance]valueForKey:[self.settingsKey objectAtIndex:indexPath.row]];
        buttonCell.value = [val stringValue];
        
        buttonCell.onButtonPressed = ^{
            [self showPickerOnTableView:tableView indexPath:indexPath];
        };
        cell = buttonCell;
    }
    return cell;
}

- (void)showPickerOnTableView:(UITableView*)tableView indexPath:(NSIndexPath*)indexPath {
    [tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionTop animated:YES];
    
    NSString *title = [self.settings objectAtIndex:indexPath.row];
    NSString *settingsKey = [self.settingsKey objectAtIndex:indexPath.row];
    
    NSArray *values = indexPath.row == 2? self.repValues : self.durationValues;
    PickerView *picker = [PickerView pickerWithTitle:title currentValue:nil values:values];
    picker.currentValue = [[SettingsUtil sharedInstance]valueForKey:settingsKey];
    picker.completionBlock = ^(id selectedValue) {
        [[SettingsUtil sharedInstance]setValue:selectedValue forKey:settingsKey];
        [tableView reloadData];
    };
    [picker show];
}

@end
