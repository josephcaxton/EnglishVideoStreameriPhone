//
//  VideoPlayer.h
//  EvaluatorForIPad
//
//  Created by Joseph caxton-Idowu on 21/02/2011.
//  Copyright 2011 caxtonidowu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MediaPlayer/MediaPlayer.h>
#import "FreeVideosClass.h"

@interface VideoPlayer : UIViewController {

	MPMoviePlayerViewController *moviePlayerViewController;
	NSString *VideoFileName;
    NSString *ServerLocation;
    NSURLCredential *credential;
    NSURLProtectionSpace *protectionSpace;
    NSString *domain;
    UIImageView *ImageViewer1;
    FreeVideosClass *FreeView;
    
	
}
@property (nonatomic, retain) NSString *VideoFileName;
@property (nonatomic, retain) NSString *ServerLocation;
@property (nonatomic, retain) NSURLCredential *credential;
@property (nonatomic, retain) NSURLProtectionSpace *protectionSpace;
@property (nonatomic, retain) NSString *domain;
@property (nonatomic, retain) UIImageView *ImageViewer1;
@property (nonatomic, retain) MPMoviePlayerViewController *moviePlayerViewController;
@property (nonatomic, retain) FreeVideosClass *FreeView;
-(void)RecordStatusToLearnersCloud:(BOOL)isStarting;

@end
