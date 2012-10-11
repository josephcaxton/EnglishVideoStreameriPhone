//
//  UnderlinedButton.m
//  MathsVideoStreameriPhone
//
//  Created by Joseph caxton-Idowu on 09/10/2012.
//  Copyright (c) 2012 caxtonidowu. All rights reserved.
//

#import "UnderlinedButton.h"

@implementation UnderlinedButton


+ (UnderlinedButton*) underlinedButton {
    UnderlinedButton* button = [[UnderlinedButton alloc] init];
    return button;
}


- (void) drawRect:(CGRect)rect {
    CGRect textRect = self.titleLabel.frame;
    
    // need to put the line at top of descenders (negative value)
    CGFloat descender = self.titleLabel.font.descender;
    
    CGContextRef contextRef = UIGraphicsGetCurrentContext();
    
    // set to same colour as text
    CGContextSetStrokeColorWithColor(contextRef, self.titleLabel.textColor.CGColor);
    
    CGContextMoveToPoint(contextRef, textRect.origin.x, textRect.origin.y + textRect.size.height + descender);
    
    CGContextAddLineToPoint(contextRef, textRect.origin.x + textRect.size.width, textRect.origin.y + textRect.size.height + descender);
    
    CGContextClosePath(contextRef);
    
    CGContextDrawPath(contextRef, kCGPathStroke);
}
@end
