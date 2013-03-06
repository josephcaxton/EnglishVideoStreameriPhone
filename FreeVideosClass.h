//
//  FreeVideos.h
//  VideoStreamer
//
//  Created by Joseph caxton-Idowu on 14/03/2012.
//  Copyright (c) 2012 caxtonidowu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>
#import "FBConnect.h"
#import "GANTracker.h"

@interface FreeVideosClass :  UITableViewController  <UITableViewDataSource, UITableViewDelegate,UIAlertViewDelegate,MFMailComposeViewControllerDelegate,UISearchBarDelegate>{
    
    NSMutableArray *ArrayofConfigObjects;
    NSMutableArray *filteredArrayofConfigObjects;
    NSMutableArray *ProductIDs;
    NSMutableArray *ImageObjects;
    NSMutableArray *ProductsSubscibedTo;
    BOOL FullSubscription;
    UISearchBar  *mySearchBar;
    
    
}

@property (nonatomic, retain) NSMutableArray *ArrayofConfigObjects;
@property (nonatomic, retain) NSMutableArray *filteredArrayofConfigObjects;
@property (nonatomic, retain) NSMutableArray *ProductIDs;
@property (nonatomic, retain)  NSMutableArray *ImageObjects;
@property (nonatomic, retain)  NSMutableArray *ProductsSubscibedTo;
@property (nonatomic, assign) BOOL FullSubscription;
@property (nonatomic, retain) UISearchBar *mySearchBar;



-(BOOL)ShouldIDownloadOrNot:(NSString*)urllPath:(NSString*)LocalFileLocation;
-(void)GetConfigFileFromServeWriteToPath:(NSString*)Path;
-(void)Alertfailedconnection;
-(void)MyParser:(NSString *)FileLocation;
-(void)ConfigureProductList:(NSString *)ProductID;
-(void)RefreshTable:(NSNotification *)note;
-(void)RefeshTable;
//-(void)AdjustProductSubscribedTo;

- (void)reviewPressed;

@end
