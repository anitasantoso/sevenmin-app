//
//  ButtonCell.h
//  sevenmin-app
//
//  Created by Anita Santoso on 19/06/13.
//  Copyright (c) 2013 as. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ButtonCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *textLabel;
@property (strong, nonatomic) IBOutlet UIButton *valueButton;
- (IBAction)buttonPressed:(id)sender;
@property (nonatomic, copy) void(^onButtonPressed)(void);
@property (nonatomic, strong) NSString *value;
@end
