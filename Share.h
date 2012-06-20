//
//  Share.h
//  MathsVideoStreameriPhone
//
//  Created by Joseph caxton-Idowu on 19/06/2012.
//  Copyright (c) 2012 caxtonidowu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>
#import "FBConnect.h"
#import "AppDelegate.h"
#import <Twitter/Twitter.h>
#import "GANTracker.h"

@interface Share : UITableViewController<MFMailComposeViewControllerDelegate,FBSessionDelegate,FBDialogDelegate>{
    
    
    Facebook *facebook;
    UIButton *logoutFacebook;
    UIActivityIndicatorView * activityIndicator;
    
}

@property (nonatomic, retain) Facebook *facebook;
@property (nonatomic, retain) UIButton *logoutFacebook;
@property (nonatomic, retain)  UIActivityIndicatorView * activityIndicator;

- (void)AddProgress;


@end
