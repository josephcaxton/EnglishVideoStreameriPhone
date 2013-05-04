//
//  LearnersCloudSamplesVideos.h
//  VideoStreamer
//
//  Created by Joseph caxton-Idowu on 13/03/2012.
//  Copyright (c) 2012 caxtonidowu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

@interface LearnersCloudSamplesVideos : UIViewController <UITableViewDataSource, UITableViewDelegate>  {
    
	NSMutableArray *listofItems;
    NSMutableArray *ImageNames;
	UIButton *LCButton;
    UITableView *FirstTable;
    CGRect FirstViewframe;
    UIImageView *PromoImageView;
	
}

@property (nonatomic, retain) NSMutableArray *listofItems;
@property (nonatomic, retain) NSMutableArray *ImageNames;
@property (nonatomic, retain) UIButton *LCButton;
@property (nonatomic, retain) UITableView *FirstTable;
@property (nonatomic, assign)  CGRect FirstViewframe;
@property (nonatomic, retain)  UIImageView *PromoImageView;

- (void)WebsitebuttonPressed;


@end
