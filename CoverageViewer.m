//
//  CoverageViewer.m
//  MathsiGCSEVideosiPad
//
//  Created by Joseph caxton-Idowu on 04/01/2013.
//  Copyright (c) 2013 caxtonidowu. All rights reserved.
//

#import "CoverageViewer.h"

@implementation CoverageViewer

@synthesize WebBox,DocumentName,EmailDoc;

#define SCREEN_WIDTH 320
#define SCREEN_HEIGHT 460



- (void)viewDidLoad {
    [super viewDidLoad];
	self.navigationItem.title = @"Exam Board";
    
       
    self.WebBox = [[UIWebView alloc ] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
	self.WebBox.scalesPageToFit = YES;
	self.WebBox.delegate = self;
	
	
	[self loadDocument:DocumentName inView:self.WebBox];
	[self.view addSubview:WebBox];
    
     EmailDoc = [[UIBarButtonItem alloc] initWithTitle:@"Email Document" style: UIBarButtonItemStyleBordered target:self action:@selector(SendDocViaMail:)];
    self.navigationItem.rightBarButtonItem = EmailDoc;
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


-(IBAction)SendDocViaMail:(id)sender{
	
	if ([MFMailComposeViewController canSendMail]) {
        
        MFMailComposeViewController *SendMailcontroller = [[MFMailComposeViewController alloc]init];
        
        NSString *filePath = [[NSBundle mainBundle] pathForResource: DocumentName ofType: @"pdf"];
        NSData *pdfData = [NSData dataWithContentsOfFile: filePath];
        [SendMailcontroller addAttachmentData: pdfData mimeType:@"application/pdf" fileName:@"LearnersCloud-Exam-Board-Document.pdf"];
        
        SendMailcontroller.mailComposeDelegate = self;
       
        [SendMailcontroller setSubject:@"LearnersCloud Exam Board Document Attached"];
        
        [SendMailcontroller setMessageBody:[NSString stringWithFormat:@"Find attached the LearnersCloud coverage document you selected, please feel free to print.<p>For more information or support visit us at</p><br/><a href=http://www.learnersCloud.com> www.LearnersCloud.com</a>"] isHTML:YES];
        [self presentModalViewController:SendMailcontroller animated:YES];
        
       	}
	
	else {
		UIAlertView *Alert = [[UIAlertView alloc] initWithTitle: @"Cannot send mail"
                                                        message: @"Device is unable to send email in its current state. Configure email" delegate: self
                                              cancelButtonTitle: @"Ok" otherButtonTitles: nil];
		
		
		
		[Alert show];
		
		
	}
    
	
}

- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error{
    
    
   	
	[self becomeFirstResponder];
	[self dismissModalViewControllerAnimated:YES];
	
	
	
	
}




- (void)viewDidUnload
{
    WebBox = nil;
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}


@end
