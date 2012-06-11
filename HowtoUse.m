//
//  HowtoUse.m
//  VideoStreamer
//
//  Created by Joseph caxton-Idowu on 07/05/2012.
//  Copyright (c) 2012 caxtonidowu. All rights reserved.
//

#import "HowtoUse.h"

@interface HowtoUse ()

@end

@implementation HowtoUse

@synthesize WebBox;

#pragma mark -
#pragma mark Initialization

#define SCREEN_WIDTH  320    
#define SCREEN_HEIGHT 450


- (void)viewDidLoad {
    [super viewDidLoad];
	self.navigationItem.title = @"How to use this app";
    self.WebBox = [[UIWebView alloc ] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
	self.WebBox.scalesPageToFit = YES;
	self.WebBox.delegate = self;
	
	
	[self loadDocument:@"HowtouseVideoStreamer_iphone" inView:self.WebBox];
	[self.view addSubview:WebBox];
	
}

-(void)loadDocument:(NSString*)documentName inView:(UIWebView*)webView{
	
    NSString *path = [[NSBundle mainBundle] pathForResource:documentName ofType:@"pdf"];
    NSURL *url = [NSURL fileURLWithPath:path];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [webView loadRequest:request];
	
	
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
	[self willAnimateRotationToInterfaceOrientation:self.interfaceOrientation duration:1];
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation duration:(NSTimeInterval)duration{
	
	if (self.interfaceOrientation == UIInterfaceOrientationPortrait || self.interfaceOrientation == UIInterfaceOrientationPortraitUpsideDown ) {
		
		self.WebBox.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
		
		
		
	}
	
	else {
		
		self.WebBox.frame = CGRectMake(140, 0,  SCREEN_HEIGHT - 182, SCREEN_WIDTH);
		
		
		
	}
	
	
	
}


- (void)viewDidUnload
{
    WebBox = nil;
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}


@end
