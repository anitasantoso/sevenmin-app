//
//  ButtonCell.m
//  sevenmin-app
//
//  Created by Anita Santoso on 19/06/13.
//  Copyright (c) 2013 as. All rights reserved.
//

#import "ButtonCell.h"

@implementation ButtonCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)buttonPressed:(id)sender {
    self.onButtonPressed();
}

- (void)setValue:(NSString *)value {
    _value = value;
    [self.valueButton setTitle:value forState:UIControlStateNormal];
}

@end
