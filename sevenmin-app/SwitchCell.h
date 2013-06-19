//
//  SwitchCell.h
//  sevenmin-app
//
//  Created by Anita Santoso on 19/06/13.
//  Copyright (c) 2013 as. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SwitchCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *textLabel;
- (IBAction)switchValueChanged:(id)sender;
@property (nonatomic, strong) NSString *settingsKey;
@property (strong, nonatomic) IBOutlet UISwitch *valueSwitch;
@property (nonatomic, copy) void(^onValueChanged)(NSString *settingsKey, BOOL on);
@end
