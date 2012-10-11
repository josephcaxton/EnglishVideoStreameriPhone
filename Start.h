//
//  Start.h
//  VideoStreamer
//
//  Created by Joseph caxton-Idowu on 13/03/2012.
//  Copyright (c) 2012 caxtonidowu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Start : UIViewController <UITextFieldDelegate,UIAlertViewDelegate,NSXMLParserDelegate>{
    
    UIView *FirstView;
    UIButton *FreeVideos;
	UIButton *BtnTransfermysubscription;
    UIBarButtonItem *LoginViaLearnersCloud;
    UIButton *WhichButton; // this is track which button we pressed- either BtnTransfermysubscription or LoginViaLearnersCloud
    UIButton *RentaVideo;
    UIImage *Image;
    UIImageView *ImageView;
    
    UIImage *TVHeaderImage;
    UIImageView *TVHeaderImageView;
    

    
    UITextField *UsernameText;
    UITextField *PasswordText;
    UITextField* TextField;
    NSMutableData *ReponseFromServer;
    BOOL PassageFlag;
    NSString *LoginTitle;
    BOOL iPhone5;
}

@property (nonatomic, retain) UIView *FirstView;
@property (nonatomic, retain) UIButton *FreeVideos;
@property (nonatomic, retain) UIButton *BtnTransfermysubscription;
@property (nonatomic, retain) UIBarButtonItem *LoginViaLearnersCloud;
@property (nonatomic, retain)  UIButton *RentaVideo;
@property (nonatomic, retain)  UIImage *Image;
@property (nonatomic, retain)  UIImageView *ImageView;
@property (nonatomic, retain)  UIImage *TVHeaderImage;
@property (nonatomic, retain)  UIImageView *TVHeaderImageView;
@property (nonatomic, retain)  UITextField *UsernameText;
@property (nonatomic, retain)  UITextField *PasswordText;
@property (nonatomic, retain)  UITextField* TextField;
@property (nonatomic, retain)  NSMutableData *ReponseFromServer;
@property (nonatomic, assign) BOOL PassageFlag;
@property (nonatomic, retain)  UIButton *WhichButton;
@property (nonatomic, retain)  NSString *LoginTitle;
@property (nonatomic, assign) BOOL iPhone5;

-(IBAction)ViewFreeVideos:(id)sender;
-(IBAction)TransferSubscription:(id)sender;
- (void)AddProgress;
-(void)SubscriptionTransferServer:(NSString *)DeviceID;
@end
