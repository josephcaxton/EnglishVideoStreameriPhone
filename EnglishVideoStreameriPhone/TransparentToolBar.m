//
//  TransparentToolBar.m
//  VideoStreamer
//
//  Created by Joseph caxton-Idowu on 13/10/2012.
//  Copyright (c) 2012 caxtonidowu. All rights reserved.
//

#import "TransparentToolBar.h"

@implementation TransparentToolBar


// Override init.
- (id) init
{
    self = [super init];
    [self applyTranslucentBackground];
    return self;
}
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    [self applyTranslucentBackground];
    return self;}

- (void)drawRect:(CGRect)rect {
    // do nothing in here
}

// Set properties to make background
// translucent.
- (void) applyTranslucentBackground
{
    self.backgroundColor = [UIColor clearColor];
    self.opaque = NO;
    self.translucent = YES;
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
