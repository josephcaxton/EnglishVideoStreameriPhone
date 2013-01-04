//
//  CoverageViewer.h
//  MathsiGCSEVideosiPad
//
//  Created by Joseph caxton-Idowu on 04/01/2013.
//  Copyright (c) 2013 caxtonidowu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>
#import "AppDelegate.h"
@interface CoverageViewer :UIViewController  <UIWebViewDelegate,MFMailComposeViewControllerDelegate>{
    
    UIWebView *WebBox;
    NSString *DocumentName;
     UIBarButtonItem *EmailDoc;
}

@property (nonatomic, retain) UIWebView *WebBox;
@property (nonatomic, retain)  NSString *DocumentName;
@property (nonatomic, retain) UIBarButtonItem *EmailDoc;
-(void)loadDocument:(NSString*)documentName inView:(UIWebView*)webView;


@end
