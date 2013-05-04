//
//  TrailerPlayer.m
//  VideoStreamer
//
//  Created by Joseph caxton-Idowu on 30/04/2013.
//  Copyright (c) 2013 caxtonidowu. All rights reserved.
//

#import "TrailerPlayer.h"
#import "AppDelegate.h"
#import "GANTracker.h"

@implementation TrailerPlayer

@synthesize VideoFileName,ServerLocation,credential,protectionSpace,domain,ImageViewer1,moviePlayerViewController,FreeView;

#define SCREEN_WIDTH  320
#define SCREEN_HEIGHT 460



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
    
    //[self RecordStatusToLearnersCloud: NO];
    
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
    //ServerLocation = [NSString stringWithFormat:@"%@/iosStreamv2/Trailers/",domain];
	
    NSError *error;
    // Report to  analytics
    if (![[GANTracker sharedTracker] trackPageview:@"/VideoPlayerPage"
                                         withError:&error]) {
        NSLog(@"error in trackPageview");
    }
    
	//[self RecordStatusToLearnersCloud: YES];
}

-(void)viewWillAppear:(BOOL)animated{
	
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    
    if(appDelegate.isDeviceConnectedToInternet){
        
        NSError *error;
        // Report to  analytics
        if (![[GANTracker sharedTracker] trackEvent:@"Playing Video"
                                             action:@"Playing"
                                              label:@"Playing"
                                              value:69
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
        NSError *_error = nil;
        
        [[AVAudioSession sharedInstance] setCategory: AVAudioSessionCategoryPlayback error:&_error];
        
        
        
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
    
    
	}




- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    
    return  (interfaceOrientation != UIInterfaceOrientationPortrait );
	
	
}

- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation duration:(NSTimeInterval)duration{
	
		
	
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

