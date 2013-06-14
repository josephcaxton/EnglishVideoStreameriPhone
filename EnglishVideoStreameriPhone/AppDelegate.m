//
//  AppDelegate.m
//  MathsVideoStreameriPhone
//
//  Created by Joseph caxton-Idowu on 30/05/2012.
//  Copyright (c) 2012 caxtonidowu. All rights reserved.
//

#import "AppDelegate.h"
#import <SystemConfiguration/SystemConfiguration.h>
#import <netinet/in.h>
#import "GANTracker.h"
#import "Reachability.h"


//#import "FirstViewController.h"

//#import "SecondViewController.h"

// Dispatch period in seconds
static const NSInteger kGANDispatchPeriodSec = 10;
static NSString* const kAnalyticsAccountId = @"UA-32471393-1";

@implementation AppDelegate

@synthesize window;
@synthesize tabBarController;
@synthesize SecondThread,SelectProductID,buyScreen,DomainName,SubscriptionStatusData,PassageFlag,EmailFlag,UserEmail,DoesUserHaveEmail,AccessAll,m_facebook,DeviceScreenType;

#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    //Remove useless tabbarItems ..
   // NSMutableArray *viewControllers = [NSMutableArray arrayWithArray:tabBarController.viewControllers];
    //[viewControllers removeObjectAtIndex:1];
   // [viewControllers removeObjectAtIndex:2];
   // [viewControllers removeObjectAtIndex:2];
   // [viewControllers removeObjectAtIndex:2];
   // [tabBarController setViewControllers:viewControllers];
    
    SecondThread = nil;
    DomainName = @"http://learnerscloud.com";
    //Check phone Screen Size
    if([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone){
        if([UIScreen mainScreen].bounds.size.height == 568.0){
            //This is iphone5 Screen size
            DeviceScreenType =[[NSNumber alloc] initWithInt:1136];
        }
        else{
            // This is NOT iPhone5 Screen Size
            DeviceScreenType = [[NSNumber alloc] initWithInt:0];
        }
    }
    
    
    
    //[window addSubview: tabBarController.view];
    self.window.rootViewController = tabBarController;
	[window makeKeyAndVisible];
    
   

    
    
	//NSString *DeviceID = (NSString *)[[NSUserDefaults standardUserDefaults] objectForKey:@"LCUIID"];
    
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    NSString *DeviceID = [prefs stringForKey:@"LCUIID"];
    
    //testing
    //[prefs setObject:@"0" forKey:@"AddOneFreeEnglish"];
    //[prefs synchronize];
    
    if (DeviceID == nil) {
		
		NSString *mydeviceid = [self GetUUID];
        
        /* NSDictionary *appDefaults  = [NSDictionary dictionaryWithObjectsAndKeys:mydeviceid, @"LCUIID", nil];
         [[NSUserDefaults standardUserDefaults] registerDefaults:appDefaults];
         [[NSUserDefaults standardUserDefaults] synchronize]; */
        
        NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
        [prefs setObject:mydeviceid forKey:@"LCUIID"];
        [prefs synchronize];
		
	}
    else {
        //Check SubscriptionStatus
        
        
        [self SubscriptionStatus: DeviceID];
        
    }
    
    // Review
    
    NSString *ReviewID = [prefs stringForKey:@"Review"];
    if (ReviewID == nil) {
        
        NSString *ID = @"0";
        [prefs setObject:ID forKey:@"Review"];
        [prefs setObject:ID forKey:@"IHaveLeftReview"];
        
        [prefs synchronize];
        
    }
    //for testing
    /* NSString *ID = @"0";
     [prefs setObject:ID forKey:@"Review"];
     [prefs setObject:ID forKey:@"IHaveLeftReview"];
     
     [prefs synchronize];*/
    

    
    // Notification Service Registration
    
    NSLog(@"Registering for push notifications...");    
    [[UIApplication sharedApplication] registerForRemoteNotificationTypes:(UIRemoteNotificationTypeAlert | UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeSound)];
	// Reset Badge Count 
    application.applicationIconBadgeNumber = 0; 
    
    //Analytics
    [[GANTracker sharedTracker] startTrackerWithAccountID:kAnalyticsAccountId
                                           dispatchPeriod:kGANDispatchPeriodSec
                                                 delegate:nil];
    NSError *error;
    
    /* if (![[GANTracker sharedTracker] setCustomVariableAtIndex:1
     name:@"iOS1"
     value:@"iv1"
     withError:&error]) {
     NSLog(@"error in setCustomVariableAtIndex");
     } */
    
    if (![[GANTracker sharedTracker] trackEvent:@"English Video Streamer Started"
                                         action:@"Launch iOS"
                                          label:@"Launch iOS"
                                          value:99
                                      withError:&error]) {
        NSLog(@"error in trackEvent");
    }
    
    if (![[GANTracker sharedTracker] trackPageview:@"/AppDelegate"
                                         withError:&error]) {
        NSLog(@"error in trackPageview");
    }
    
   

    
    return YES;
}

-(void)SubscriptionStatus:(NSString *)DeviceID{
    
   /* if(SubscriptionStatusData){
        [SubscriptionStatusData setLength:0];
    }
    
    
    NSString *Filter =[NSString stringWithString:@"1"];
    
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    NSString *domain = appDelegate.DomainName;
    
    
    NSString *queryString = [NSString stringWithFormat:@"%@/Services/iOS/VideoSubscription.asmx/ViewSubscriptionStatus",domain];
    NSURL *url = [NSURL URLWithString:queryString];
    NSMutableURLRequest *req = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:60.0];
    
    NSString *FullString = [NSString stringWithFormat:@"DeviceID=%@&filter=%@&",DeviceID,Filter];
    NSData* data=[FullString dataUsingEncoding:NSUTF8StringEncoding];
    
    //NSLog(@"%@",FullString);
    NSString *contentType = @"application/x-www-form-urlencoded; charset=utf-8";
    [req addValue:contentType forHTTPHeaderField:@"Content-Length"];
    unsigned long long postLength = data.length;
    NSString *contentLength = [NSString stringWithFormat:@"%llu",postLength];
    [req addValue:contentLength forHTTPHeaderField:@"Content-Length"];
    
    [req setHTTPMethod:@"POST"];
    [req setHTTPBody:data];
    
    NSURLConnection *conn;
    conn = [[NSURLConnection alloc] initWithRequest:req delegate:self];
    [conn start];
    if (!conn) {
        NSLog(@"error while starting the connection");
    } */
    
    if(SubscriptionStatusData){
        [SubscriptionStatusData setLength:0];
        
    }
    
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    NSString *deviceID = [prefs stringForKey:@"LCUIID"];
    
    NSString *AppID = @"58";   // 58 means this is English
    NSString *queryString = [NSString stringWithFormat:@"%@/Services/iOS/VideoSubscription.asmx/HasCurrentSubscription",DomainName];
    NSURL *url = [NSURL URLWithString:queryString];
    NSMutableURLRequest *req = [NSMutableURLRequest requestWithURL:url];
    
    NSString *FullString = [NSString stringWithFormat:@"DeviceID=%@&CourseID=%@&",deviceID,AppID];
    NSData* data=[FullString dataUsingEncoding:NSUTF8StringEncoding];
    
    NSString *contentType = @"application/x-www-form-urlencoded; charset=utf-8";
    [req addValue:contentType forHTTPHeaderField:@"Content-Length"];
    unsigned long long postLength = data.length;
    NSString *contentLength = [NSString stringWithFormat:@"%llu",postLength];
    [req addValue:contentLength forHTTPHeaderField:@"Content-Length"];
    
    [req setHTTPMethod:@"POST"];
    [req setHTTPBody:data];
    
    NSURLConnection *conn;
    conn = [[NSURLConnection alloc] initWithRequest:req delegate:self];
    if (!conn) {
        NSLog(@"error while starting the connection");
    } 
    
    
    
    
 
    
    
    
}

- (NSCachedURLResponse *)connection:(NSURLConnection *)connection willCacheResponse:(NSCachedURLResponse *)cachedResponse {
    
    return nil;
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)someData {
    
    /*ViewSubscriptionStatus returns from server:
     
     A Jason object with 
     1, DateTo
     2, EmailAddress
     3,ProductIdentifier */
    
    if(!SubscriptionStatusData){
        SubscriptionStatusData = [[NSMutableData alloc]init ];
    }
    
    
    [SubscriptionStatusData appendData:someData];
    //NSString *returnedString = [[NSString alloc] initWithData:someData encoding:NSUTF8StringEncoding];
    //NSLog(@"%@",returnedString);
    
    
    
}

-(void)connectionDidFinishLoading:(NSURLConnection *)connection{
    
    
    
    NSString *returnedString = [[NSString alloc] initWithData:SubscriptionStatusData encoding:NSASCIIStringEncoding];
    //NSLog(@"%@",returnedString);
    NSString *Clean1 = [returnedString stringByReplacingOccurrencesOfString:@"&lt;" withString:@"<"];
    NSString *Clean2 =[Clean1 stringByReplacingOccurrencesOfString:@"&gt;" withString:@">"];
    NSString *Clean3 =[Clean2 stringByReplacingOccurrencesOfString:@"&lt;/" withString:@"/>"];
    //NSLog(@"%@",Clean3);
    NSData *xmlData = [Clean3 dataUsingEncoding:NSUTF8StringEncoding];
    NSXMLParser *parser = [[NSXMLParser alloc] initWithData:xmlData];
    [parser setDelegate:self];
    [parser parse];
    
    //[self WorkOutSubsriptionName:TempSubscibedProducts];
    //SubscibedProducts = TempSubscibedProducts;
    
    //NSLog(@"Subscibed products= %i", [TempSubscibedProducts count]);
    
    // Post notification to refresh table
    
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    [nc postNotificationName:@"ToFreeVideoClass" object:self];
    
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qualifiedName attributes:(NSDictionary *)attributeDict {
    
    if ([elementName isEqualToString:@"hasSubscription"]) {
        
        PassageFlag = TRUE;
        
    }
    else if([elementName isEqualToString:@"hasEmail"]){
        
        PassageFlag = FALSE;
        EmailFlag = TRUE;
    }
    
    
    // NSLog(@"%@", elementName);
}
- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
    
    NSString *CleanString = [string stringByTrimmingCharactersInSet:
                             [NSCharacterSet whitespaceAndNewlineCharacterSet]];
    if([CleanString isEqualToString:@""]){
        
        //Do nothing
        PassageFlag = FALSE;
        EmailFlag = FALSE;
        return;
        
    }
    
    /*if(PassageFlag == TRUE)
        
    {
        NSString *SubscribedProductID = CleanString;
        //NSString *ProductID = [self WorkOutSubsriptionName:SubscribedProductID];
        
        if(!TempSubscibedProducts){
            TempSubscibedProducts = [[NSMutableArray alloc] init ];
        }
        //NSLog(@"%@",string);
        [TempSubscibedProducts addObject:SubscribedProductID];
        PassageFlag = FALSE;
    }
    
    else if(EmailFlag == TRUE){
        
        NSString *EmailAddress = CleanString;
        UserEmail = [NSString stringWithString:EmailAddress];
        EmailFlag = FALSE;
    }*/
    
    if(PassageFlag == TRUE){
    
        NSString *UserHasCurrentSubscription = CleanString;
    
        if([UserHasCurrentSubscription isEqualToString:@"True"]){ 
        
        AccessAll = TRUE; 
        
        }
        else {
        AccessAll = FALSE;
        }
    
    }
    
    if(EmailFlag == TRUE){
        
        NSString *UserHasEmail = CleanString;
        if([UserHasEmail isEqualToString:@"True"]){ 
            
            //[self setDoesUserHaveEmail:TRUE]; 
            DoesUserHaveEmail =TRUE;
        }
        else {
            //[self setDoesUserHaveEmail:FALSE]; 
            DoesUserHaveEmail=FALSE;
        }
        
        
    }

    
    
}




/*-(void)WorkOutSubsriptionName:(NSMutableArray*)SubscibedProductsInArray{
 // Only 7 days and 30days subscription supported
 
 for (int i = 0; i < SubscibedProductsInArray.count; i++) {
 
 NSString *Product =[[NSString alloc] initWithString:[SubscibedProductsInArray objectAtIndex:i]];
 //NSLog(@"%@",Product);
 NSString *FinalVal;
 if(!SubscibedProducts){
 SubscibedProducts = [[NSMutableArray alloc] init ]; 
 }
 int lenghtofString = [Product length];
 // NSLog(@"%i",lenghtofString);
 
 NSString *Result = [Product substringWithRange:NSMakeRange(lenghtofString - 5, 5)];
 
 //NSLog(@"%@",Result);
 
 if ([[Result lowercaseString] isEqualToString:@"month"] ){
 // string minus 1Month
 FinalVal = [Product substringWithRange:NSMakeRange(0, lenghtofString - 6)];
 
 }
 else 
 {
 // string minus 7days
 FinalVal = [Product substringWithRange:NSMakeRange(0, lenghtofString - 5)];
 
 }
 //NSLog(@"%@",Product);
 //NSLog(@"%@",FinalVal);
 
 
 [SubscibedProducts addObject:FinalVal];
 
 
 
 }
 
 
 
 
 
 
 }*/



- (NSString *)applicationDocumentsDirectory {
    
    return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
}

- (NSString *)GetUUID{
    
    CFUUIDRef theUUID = CFUUIDCreate(NULL);
    CFStringRef idstring = CFUUIDCreateString(NULL, theUUID);
    CFRelease(theUUID);
    NSString *Deviceid = [NSString stringWithFormat:@"%@",idstring];
    return Deviceid;
}


-(BOOL)isDeviceConnectedToInternet{
    
    Reachability *reachability = [Reachability reachabilityForInternetConnection];
    NetworkStatus networkStatus = [reachability currentReachabilityStatus];
    
    BOOL internetActive = NO;
    switch (networkStatus)
    {
        case NotReachable:
        {
            NSLog(@"The internet is down.");
            
            internetActive = NO;
            
            break;
        }
        case ReachableViaWiFi:
        {
            NSLog(@"The internet is working via WIFI.");
            
            internetActive = YES;
            
            break;
        }
            
        case ReachableViaWWAN:
        {
            NSLog(@"The internet is working via WWAN.");
            
            internetActive = YES;
            
            break;
        }
    }
    return internetActive;
    
    
}

//Return True is file does not exist in device -- so download from server;
// Return True if the file exist but version is defferent--- So we need to download the file;
// Return false if the file is same version --- so don't download;
-(BOOL)downloadfileifUpdated:(NSString*)urLString location:(NSString*)LocalFileLocation {  
    
    //DLog(@"Downloading HTTP header from: %@", urlString);
    
    NSURL *url = [NSURL URLWithString:urLString];
    
    NSString *cachedPath = LocalFileLocation;
    NSFileManager *fileManager = [NSFileManager defaultManager];  
    
    //BOOL downloadFromServer = NO; 
    NSString *lastModifiedString = nil;  
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];  
    [request setHTTPMethod:@"HEAD"];  
    NSHTTPURLResponse *response;  
    // Get Date from server first 
    [NSURLConnection sendSynchronousRequest:request returningResponse:&response error: NULL];  
    if ([response respondsToSelector:@selector(allHeaderFields)]) {  
        lastModifiedString = [[response allHeaderFields] objectForKey:@"Last-Modified"];  
    }
    
    NSDate *lastModifiedServer = nil;  
    @try {  
        NSDateFormatter *df = [[NSDateFormatter alloc] init];  
        df.dateFormat = @"EEE',' dd MMM yyyy HH':'mm':'ss 'GMT'";  
        df.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_GB"];  
        df.timeZone = [NSTimeZone timeZoneWithAbbreviation:@"GMT"];  
        lastModifiedServer = [df dateFromString:lastModifiedString];
        
        
    }  
    @catch (NSException * e) {  
        NSLog(@"Error parsing last modified date: %@ - %@", lastModifiedString, [e description]);  
    }  
    // NSLog(@"lastModifiedServer: %@", lastModifiedServer);
    
    // Get Date on Local device
    NSDate *lastModifiedLocal = nil;  
    if ([fileManager fileExistsAtPath:cachedPath]) {  
        NSError *error = nil;  
        NSDictionary *fileAttributes = [fileManager attributesOfItemAtPath:cachedPath error:&error];  
        if (error) {  
            NSLog(@"Error reading file attributes for: %@ - %@", cachedPath, [error localizedDescription]);  
        }  
        lastModifiedLocal = [fileAttributes fileModificationDate];  
        // NSLog(@"lastModifiedLocal : %@", lastModifiedLocal);  
    }
    
    // Download file from server if we don't have a local file  
    if (!lastModifiedLocal) {  
        return YES;  
    }
    
    if ([lastModifiedLocal laterDate:lastModifiedServer] == lastModifiedServer) {  
        return YES;  
    }
    
    //NSLog(@"This is to compare the date %@ localDate , %@ serverdate",lastModifiedLocal,lastModifiedServer);
    return NO;
    
} 

- (void)application:(UIApplication *)app didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    
    //NSString *str = [NSString stringWithFormat:@"Device Token=%@",deviceToken];
    //NSLog(@"%@",str);
    
    
    // Add the Device Token to our database.
    
    // NSString *Raw_DeviceToken = [NSString stringWithFormat:@"%@",deviceToken];
    
   // NSString *DeviceUDID = [NSString stringWithFormat:@"%@",[UIDevice currentDevice].uniqueIdentifier];
    // We don't support notifiation on < ios any more
    if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"6.0")){
     NSString *DeviceUDID = [[[UIDevice currentDevice] identifierForVendor] UUIDString];
    
    NSString *DeviceTokenRemoveCh1 = [[deviceToken description] stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"<>"]];
    
    NSString *DeviceToken = [DeviceTokenRemoveCh1 stringByReplacingOccurrencesOfString: @" " withString: @""];
    
    
    NSURLConnection *conn;
    NSString *queryString = [NSString stringWithFormat:@"http://www.learnerscloud.com/services/ios/deviceToken.asmx/Update?UDID=%@&deviceToken=%@" , DeviceUDID, DeviceToken ];
    NSURL *url = [NSURL URLWithString:queryString];
    
    NSMutableURLRequest *req = [NSMutableURLRequest requestWithURL:url];
    [req addValue:@"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [req addValue:0 forHTTPHeaderField:@"Content-Length"];
    [req setHTTPMethod:@"GET"];
    
    conn = [[NSURLConnection alloc] initWithRequest:req delegate:self];
    if (conn) {
        
    }
    }
}

- (void)application:(UIApplication *)app didFailToRegisterForRemoteNotificationsWithError:(NSError *)err {
    
    NSString *str = [NSString stringWithFormat: @"Error: %@", err];
    NSLog(@"%@",str);    
    
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    
    for (id key in userInfo) {
        NSLog(@"key: %@, value: %@", key, [userInfo objectForKey:key]);
    }    
    
}



- (void)applicationWillResignActive:(UIApplication *)application
{
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    [[NSUserDefaults standardUserDefaults] synchronize];
    [[GANTracker sharedTracker] stopTracker];
    
    /*AccessAll = FALSE;
    if (UserEmail) {
        UserEmail = nil;
    }*/

}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    /*
     Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
     */
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    [[GANTracker sharedTracker] stopTracker];
    /*
     Called when the application is about to terminate.
     Save data if appropriate.
     See also applicationDidEnterBackground:.
     */
}

/*
 // Optional UITabBarControllerDelegate method.
 - (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController
 {
 }
 */

/*
 // Optional UITabBarControllerDelegate method.
 - (void)tabBarController:(UITabBarController *)tabBarController didEndCustomizingViewControllers:(NSArray *)viewControllers changed:(BOOL)changed
 {
 }
 */

// Pre iOS 4.2 support
- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url {
    return [m_facebook handleOpenURL:url]; 
}

// For iOS 4.2+ support
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    return [m_facebook handleOpenURL:url]; 
}

-(BOOL)IsThisiPhone5{
    
    if(DeviceScreenType.intValue == 1136 ){
        
        return YES;
    }
    else
    {
        //NSLog(@"Result %i", DeviceScreenType.intValue);
        return NO;
    }
    
}





@end
