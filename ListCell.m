//
//  ListCell.m
//  MathsVideoStreameriPhone
//
//  Created by Joseph caxton-Idowu on 06/03/2013.
//  Copyright (c) 2013 caxtonidowu. All rights reserved.
//

#import "ListCell.h"

@implementation ListCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.imageView.frame = CGRectMake(5,10,70,40);
    self.imageView.backgroundColor = [UIColor blackColor];
    self.textLabel.frame = CGRectMake(90,5,200,40);
    self.detailTextLabel.frame = CGRectMake(90,46,200,40);
}

@end
