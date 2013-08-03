//
//  FreeVideos.h
//  VideoStreamer
//
//  Created by Joseph caxton-Idowu on 14/03/2012.
//  Copyright (c) 2012 caxtonidowu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FBConnect.h"
#import "GANTracker.h"

@interface FreeVideosClass :  UITableViewController  <UITableViewDataSource, UITableViewDelegate,UIAlertViewDelegate,UISearchBarDelegate>{
    
    NSMutableArray *ArrayofConfigObjects;
    NSMutableArray *filteredArrayofConfigObjects;
    NSMutableArray *ProductIDs;
    NSMutableArray *ImageObjects;
    NSMutableArray *ProductsSubscibedTo;
    BOOL FullSubscription;
    UISearchBar  *mySearchBar;
    NSMutableArray* buttons;
    UIBarButtonItem *LoginViaLearnersCloud;
    NSMutableArray *FreeSamples;
    NSMutableArray *FreeSamples_Copy;

    
}

@property (nonatomic, retain) NSMutableArray *ArrayofConfigObjects;
@property (nonatomic, retain) NSMutableArray *filteredArrayofConfigObjects;
@property (nonatomic, retain) NSMutableArray *ProductIDs;
@property (nonatomic, retain)  NSMutableArray *ImageObjects;
@property (nonatomic, retain)  NSMutableArray *ProductsSubscibedTo;
@property (nonatomic, assign) BOOL FullSubscription;
@property (nonatomic, retain) UISearchBar *mySearchBar;
@property (nonatomic, retain) NSMutableArray* buttons;
@property (nonatomic, retain) UIBarButtonItem *LoginViaLearnersCloud;
@property (nonatomic, retain)  NSMutableArray *FreeSamples;
@property (nonatomic, retain)  NSMutableArray *FreeSamples_Copy;


-(BOOL)ShouldIDownloadOrNot:(NSString*) urllPath :(NSString*)LocalFileLocation;
-(void)GetConfigFileFromServeWriteToPath:(NSString*)Path;
-(void)Alertfailedconnection;
-(void)MyParser:(NSString *)FileLocation;
-(void)ConfigureProductList:(NSString *)ProductID;
-(void)RefreshTable:(NSNotification *)note;
-(void)RefeshTable;
//-(void)AdjustProductSubscribedTo;

- (void)reviewPressed;

@end
