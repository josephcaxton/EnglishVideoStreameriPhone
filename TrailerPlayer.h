//
//  TrailerPlayer.h
//  VideoStreamer
//
//  Created by Joseph caxton-Idowu on 30/04/2013.
//  Copyright (c) 2013 caxtonidowu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MediaPlayer/MediaPlayer.h>
#import <AVFoundation/AVFoundation.h>
#import "LearnersCloudSamplesVideos.h"


@interface TrailerPlayer : UIViewController {
    MPMoviePlayerViewController *moviePlayerViewController;
	NSString *VideoFileName;
    NSString *ServerLocation;
    NSURLCredential *credential;
    NSURLProtectionSpace *protectionSpace;
    NSString *domain;
    UIImageView *ImageViewer1;
    LearnersCloudSamplesVideos *FreeView;
    
	
}
@property (nonatomic, retain) NSString *VideoFileName;
@property (nonatomic, retain) NSString *ServerLocation;
@property (nonatomic, retain) NSURLCredential *credential;
@property (nonatomic, retain) NSURLProtectionSpace *protectionSpace;
@property (nonatomic, retain) NSString *domain;
@property (nonatomic, retain) UIImageView *ImageViewer1;
@property (nonatomic, retain) MPMoviePlayerViewController *moviePlayerViewController;
@property (nonatomic, retain) LearnersCloudSamplesVideos *FreeView;


@end