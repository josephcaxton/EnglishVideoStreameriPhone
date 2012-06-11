//
//  CustomCell.m
//  MathsVideoStreameriPhone
//
//  Created by Joseph caxton-Idowu on 01/06/2012.
//  Copyright (c) 2012 caxtonidowu. All rights reserved.
//

#import "CustomCell.h"

@implementation CustomCell

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

- (void)layoutSubviews {
    [super layoutSubviews];
    self.textLabel.frame = CGRectMake(10.0, 0.0, 140.0, self.frame.size.height);
    self.detailTextLabel.frame = CGRectMake(250.0, 0.0, 60.0, self.frame.size.height);
}


@end
