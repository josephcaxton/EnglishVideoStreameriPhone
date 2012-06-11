//
//  TermsAndConditions.h
//  VideoStreamer
//
//  Created by Joseph caxton-Idowu on 07/05/2012.
//  Copyright (c) 2012 caxtonidowu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TermsAndConditions : UIViewController <UIWebViewDelegate>{
    
    UIWebView *WebBox;
    
}

@property (nonatomic, retain) UIWebView *WebBox;
-(void)loadDocument:(NSString*)documentName inView:(UIWebView*)webView;

@end
