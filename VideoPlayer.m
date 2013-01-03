    //
//  VideoPlayer.m
//  EvaluatorForIPad
//
//  Created by Joseph caxton-Idowu on 21/02/2011.
//  Copyright 2011 caxtonidowu. All rights reserved.
//

#import "VideoPlayer.h"
#import "AppDelegate.h"
#import "GANTracker.h"

@implementation VideoPlayer

@synthesize VideoFileName,ServerLocation,credential,protectionSpace,domain,ImageViewer1,moviePlayerViewController,FreeView;

#define SCREEN_WIDTH 768
#define SCREEN_HEIGHT 950


- (void)movieFinishedCallback:(NSNotification*) notification  {  
	
    NSError *error;
    // Report to  analytics
    if (![[GANTracker sharedTracker] trackEvent:@"Finished playing video"
                                         action:@"Playing Finished"
                                          label:@"Playing Finished"
                                          value:69
                                      withError:&error]) {
        NSLog(@"error in trackEvent");
    }
    [self RecordStatusToLearnersCloud: NO];
    
    MPMoviePlayerController *player = [notification object];  
	[[NSNotificationCenter defaultCenter] removeObserver:self  
													name:MPMoviePlayerPlaybackDidFinishNotification  
												  object:player];  
	[player stop];
	[moviePlayerViewController.view removeFromSuperview];  
	
	
	[self.navigationController popViewControllerAnimated:YES];
	
	
}



// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
    
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    domain = appDelegate.DomainName;
    ServerLocation = [NSString stringWithFormat:@"%@/iosStreamv2/English/",domain];
	
    NSError *error;
    // Report to  analytics
    if (![[GANTracker sharedTracker] trackPageview:@"/VideoPlayerPage"
                                         withError:&error]) {
        NSLog(@"error in trackPageview");
    }
    [self RecordStatusToLearnersCloud: YES];
	
}

-(void)viewWillAppear:(BOOL)animated{
	
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    
    if(appDelegate.isDeviceConnectedToInternet){
    NSError *error;
    // Report to  analytics
    if (![[GANTracker sharedTracker] trackEvent:@"Playing Video"
                                         action:@"Playing"
                                          label:@"Playing"
                                          value:1
                                      withError:&error]) {
        NSLog(@"error in trackEvent");
    }
    

    //Authentication Details here
    
   NSURLCredential *credential1 = [[NSURLCredential alloc] 
                                   initWithUser:@"iosuser"
                                   password:@"letmein2"
                                   persistence: NSURLCredentialPersistenceForSession];
    self.credential = credential1;
    
    NSString *DomainLocation = @"www.learnerscloud.com"; //[domain stringByReplacingOccurrencesOfString:@"http://" withString:@""];
    //NSString *DomainLocationPlus = [DomainLocation stringByAppendingString:@"/maths"];
   NSURLProtectionSpace *protectionSpace1 = [[NSURLProtectionSpace alloc]
                                             initWithHost: DomainLocation 
                                             port:443
                                             protocol:@"https"
                                             realm: DomainLocation   
                                             authenticationMethod:NSURLAuthenticationMethodDefault];
    self.protectionSpace = protectionSpace1;
    
    
    [[NSURLCredentialStorage sharedCredentialStorage] setDefaultCredential:credential
                                                        forProtectionSpace:protectionSpace]; 

    
	
    NSString *ServerpathAndVideoFileName = [ServerLocation stringByAppendingString:VideoFileName];
    
    // We can implement diffeerent Bandwidth size here..... TODO
    
    NSString *Finalpath = [ServerpathAndVideoFileName stringByAppendingString:@"/all.m3u8"];
    //NSLog(@"this is my final path ... %@", Finalpath);
	
	NSURL    *fileURL    =   [NSURL URLWithString:Finalpath]; 
   

	moviePlayerViewController = [[MPMoviePlayerViewController alloc] initWithContentURL:fileURL];
    moviePlayerViewController.moviePlayer.movieSourceType = MPMovieSourceTypeStreaming;
	 
	[[NSNotificationCenter defaultCenter] addObserver:self  
											 selector:@selector(movieFinishedCallback:)  
												 name:MPMoviePlayerPlaybackDidFinishNotification  
											   object:[moviePlayerViewController moviePlayer]];
    
    [self presentMoviePlayerViewControllerAnimated:moviePlayerViewController];
    

}
    else
    {
        NSString *message = [[NSString alloc] initWithFormat:@"Your device is not connected to the internet. You need access to the internet to stream our videos "];
        
        UIAlertView *alert =[[UIAlertView alloc] initWithTitle:@"Important Notice"
                                                       message:message delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        
        [alert show];
        
        
        [self.navigationController popViewControllerAnimated:YES];
        
    }
}







- (void)viewWillDisappear:(BOOL)animated {
	
	[moviePlayerViewController.moviePlayer stop];
	
    // Lets ask for review after user has viewed videos 5 times
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    NSString *ReviewID = [prefs stringForKey:@"Review"];
    NSString *IhaveReviewed = [prefs stringForKey:@"IHaveLeftReview"];
    
    
    if ([ReviewID isEqualToString:@"11"] && [IhaveReviewed isEqualToString:@"0"] ) {
        
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Review this app" message:@"Do you like this app enough to leave us a review?" delegate:FreeView cancelButtonTitle:@"Cancel" otherButtonTitles:@"OK", nil];
        [alertView show];
        
	}
    else {
        
        NSInteger Counter = [ReviewID integerValue];
        NSInteger CounterPlus = Counter + 1;
        NSString *ID = [NSString stringWithFormat:@"%d",CounterPlus];
        [prefs setObject:ID  forKey:@"Review"];
        [prefs synchronize];
        
    }
    

	
}



- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    
    return  (interfaceOrientation != UIInterfaceOrientationPortrait );
	
	
}

- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation duration:(NSTimeInterval)duration{
	
	if (interfaceOrientation == UIInterfaceOrientationPortrait || interfaceOrientation == UIInterfaceOrientationPortraitUpsideDown) {
		
		[[moviePlayerViewController view] setFrame:CGRectMake(30 ,150, 700, 600)];
		
	}
	
	else {
		
		[[moviePlayerViewController view] setFrame:CGRectMake(180 ,20, 700, 600)];
		
		
	}
	
	
	
}

-(void)RecordStatusToLearnersCloud:(BOOL)isStarting{
    
    // This will send a record to the users account at learnerscloud to log when the user start of finished watching video
    
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    NSString *domainURL = appDelegate.DomainName;
    
    
    NSString *queryString = [NSString stringWithFormat:@"%@/Services/iOS/VideoSubscription.asmx/RecordVideoActivity",domainURL];
    
    
    
    NSURL *url = [NSURL URLWithString:queryString];
    NSMutableURLRequest *req = [NSMutableURLRequest requestWithURL:url];
    
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    NSString *deviceID = [prefs stringForKey:@"LCUIID"];
    
    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat: @"yyyy-MM-dd HH:mm:ss zzz"];
    
    
    NSDate *Timenow = [[NSDate alloc] init];
    
    NSString *now = [dateFormatter stringFromDate:Timenow];
    // We have to encode the Date change : to %3A
    NSMutableString *Mutabletime = [NSMutableString stringWithString:now];
    
    [Mutabletime replaceOccurrencesOfString:@":" withString:@"%3A" options:NSCaseInsensitiveSearch range:NSMakeRange(0, Mutabletime.length)];
    
    //NSLog(@"%@",[Mutabletime stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]);
    
    NSString *AppId = @"58";   // 58 means this is English
    NSString *Starting = isStarting ? @"True" : @"False";
    NSString *ClipURN = self.VideoFileName;
    
    NSString *FullString = [NSString stringWithFormat:@"DeviceID=%@&AppID=%@&clipURN=%@&isStart=%@&eventTime=%@",deviceID,AppId,ClipURN,Starting,Mutabletime];
    
    
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

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)someData {
    
    /*VerifySubscription return codes from server:
     
     0 OK
     -1 Error other than those below
     -2 Sql Error
     -3 DeviceID not recognised
     -4 clipURN not recognised
     -5 Theoretically cant happen - just to keep compiler happy */
    
    //NSString *returnedString = [[NSString alloc] initWithData:someData encoding:NSUTF8StringEncoding];
    //NSLog(@"%@",returnedString);
    
    
    
    
    
}


- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}


- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}





@end
