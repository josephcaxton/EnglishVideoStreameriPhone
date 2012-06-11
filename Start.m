//
//  Start.m
//  VideoStreamer
//
//  Created by Joseph caxton-Idowu on 13/03/2012.
//  Copyright (c) 2012 caxtonidowu. All rights reserved.
//

#import "Start.h"
#import "FreeVideosClass.h"
#import "AppDelegate.h"
#import "GANTracker.h"

@implementation Start

@synthesize FirstView,FreeVideos,BtnTransfermysubscription,RentaVideo,Image,ImageView,UsernameText,PasswordText,TextField,ReponseFromServer,PassageFlag,LoginViaLearnersCloud,WhichButton,LoginTitle;

#define SCREEN_WIDTH  320    
#define SCREEN_HEIGHT 450



- (void)viewDidLoad {
    [super viewDidLoad];
    

    
    self.navigationItem.title = @"www.LearnersCloud.com";
    CGRect FirstViewframe = CGRectMake(0 ,0, SCREEN_WIDTH, SCREEN_HEIGHT);
	self.FirstView = [[UIView alloc] initWithFrame:FirstViewframe];
    
    LoginTitle = [[NSString alloc] initWithString:@""];
    Image = [UIImage imageNamed:@"EnglishBackground.png"];
    ImageView = [[UIImageView alloc] initWithImage:Image];
   // ImageView.frame = CGRectMake(0 ,0, 540, 950);
    ImageView.frame = CGRectMake(20 ,80, 280, 200);

    
   // UIColor *patternColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"Cinema_port.png"]];

    [FirstView addSubview:ImageView];

    [self.view addSubview:FirstView];
    
   
    FreeVideos = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [FreeVideos setTitle:@"Start here to view free and subscription videos!" forState:UIControlStateNormal];
    FreeVideos.frame = CGRectMake(20 ,30, 280, 34);
    FreeVideos.titleLabel.font = [UIFont systemFontOfSize:12];
   // UIImage *FreeVideosbuttonImage = [UIImage imageNamed:@"YellowBackground.png"];
   // [FreeVideos setBackgroundImage:FreeVideosbuttonImage forState:UIControlStateNormal];
    

    [FreeVideos addTarget:self action:@selector(ViewFreeVideos:) forControlEvents:UIControlEventTouchUpInside];
    
    [FirstView addSubview:FreeVideos];
    
    
    
    BtnTransfermysubscription = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [BtnTransfermysubscription setTitle:@"Transfer my subscription" forState:UIControlStateNormal];
    [BtnTransfermysubscription setTitleColor:[UIColor redColor] forState: UIControlStateNormal];
    BtnTransfermysubscription.frame = CGRectMake(170,310, 130, 34);
    BtnTransfermysubscription.titleLabel.font = [UIFont systemFontOfSize:10];
   // UIImage *BtnTransfermysubscriptionbuttonImage = [UIImage imageNamed:@"blueBackground.png"];
    //[BtnTransfermysubscription setBackgroundImage:BtnTransfermysubscriptionbuttonImage forState:UIControlStateNormal];
    BtnTransfermysubscription.tag = 999;
    [BtnTransfermysubscription addTarget:self action:@selector(TransferSubscription:) forControlEvents:UIControlEventTouchUpInside];
    
    [FirstView addSubview:BtnTransfermysubscription];
    
    LoginViaLearnersCloud = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [LoginViaLearnersCloud setTitle:LoginTitle forState:UIControlStateNormal];
    [LoginViaLearnersCloud setTitleColor:[UIColor redColor] forState: UIControlStateNormal];
    LoginViaLearnersCloud.frame = CGRectMake(20 ,310, 130, 34);
    LoginViaLearnersCloud.titleLabel.font = [UIFont systemFontOfSize:10];
    LoginViaLearnersCloud.tag = 101010;
    
    
    [FirstView addSubview:LoginViaLearnersCloud];
    
    NSError *error;
    // Report to  analytics
    if (![[GANTracker sharedTracker] trackPageview:@"/StartPage"
                                         withError:&error]) {
        NSLog(@"error in trackPageview");
    }
    

   

}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    
    
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    if(appDelegate.UserEmail == nil){
        
        LoginTitle =@"Login";
        [LoginViaLearnersCloud addTarget:self action:@selector(TransferSubscription:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    else if([appDelegate.UserEmail isEqualToString:@"JustAGeneralEmail@thisapp.com"]){
        
        LoginTitle =@"Logout";
        [LoginViaLearnersCloud addTarget:self action:@selector(LogoutUser:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    else {
        
        LoginTitle =@"Login";
        [LoginViaLearnersCloud addTarget:self action:@selector(TransferSubscription:) forControlEvents:UIControlEventTouchUpInside];
    }
    
   

    [LoginViaLearnersCloud setTitle:LoginTitle forState:UIControlStateNormal];
    
}

-(IBAction)ViewFreeVideos:(id)sender{
    
   
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    appDelegate.SecondThread = [[NSThread alloc]initWithTarget:self selector:@selector(AddProgress) object:nil];
    [appDelegate.SecondThread start];
        
   
   
    FreeVideosClass *Free_View = [[FreeVideosClass alloc] initWithStyle:UITableViewStyleGrouped];
    [self.navigationController pushViewController:Free_View animated:YES];
    
    
}

-(IBAction)RefreshSubsciptionStatus:(id)sender{
    
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    appDelegate.SecondThread = [[NSThread alloc]initWithTarget:self selector:@selector(AddProgress) object:nil];
    [appDelegate.SecondThread start];
    
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    NSString *DeviceID = [prefs stringForKey:@"LCUIID"];
    
    [appDelegate SubscriptionStatus:DeviceID];

    
}

-(IBAction)LogoutUser:(id)sender{
    if ([LoginTitle isEqualToString:@"Login"]) {
        
        
    }
    else {
        
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    appDelegate.AccessAll = FALSE;
        if (appDelegate.UserEmail) {
             appDelegate.UserEmail = nil;
        }
   
   UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Logout" message:@"Logout successful" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil,nil];
        alertView.tag = 1111;
   
        
    [alertView show];
    
    }
   
}


-(IBAction)TransferSubscription:(id)sender{
    if ([LoginTitle isEqualToString:@"Logout"]) {
         
        
    }
    else {
        
    
    
    WhichButton = (UIButton *)sender;
   // NSLog(@"%i",WhichButton.tag);
    
    NSString *myTitle = [[NSString alloc] initWithString:@"Enter your details"];
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:myTitle message:@"\n \n \n \n" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"OK", nil];
    
    
    UsernameText = [[UITextField alloc] initWithFrame:CGRectMake(12.0, 60.0, 260.0, 30.0)];
    UsernameText.placeholder = @"EmailAddress";
    UsernameText.tag = 1717;
    [UsernameText setBackgroundColor:[UIColor whiteColor]];
    UsernameText.enablesReturnKeyAutomatically = YES;
    [UsernameText setReturnKeyType:UIReturnKeyDone];
    [UsernameText setDelegate:self];
    [alertView addSubview:UsernameText];
    
    // Adds a password Field
   PasswordText = [[UITextField alloc] initWithFrame:CGRectMake(12.0, 95.0, 260.0, 30.0)];
    PasswordText.placeholder = @"Password";
    PasswordText.tag = 1818;
    [PasswordText setSecureTextEntry:YES];
    PasswordText.enablesReturnKeyAutomatically = YES;
    [PasswordText setBackgroundColor:[UIColor whiteColor]];
    [PasswordText setReturnKeyType:UIReturnKeyDone];
    [PasswordText setDelegate:self];   
    [alertView addSubview:PasswordText];
    
    alertView.tag = 1313;
    [alertView show];
    
    }
}

- (void)alertView:(UIAlertView *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    // the user clicked one of the OK/Cancel buttons
    if (buttonIndex == 1 && actionSheet.tag == 1313){
            NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"; 
            NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",emailRegex];
            BOOL notAValidEmail = ![emailTest evaluateWithObject:UsernameText.text];
            
            if (notAValidEmail || [UsernameText.text length] == 0) {
                // Your email is not valid or you have not entered an emailaddress
               NSString *AlertTitle = [[NSString alloc] initWithString:@"Your email is not valid or you have not entered an email address. Try again?"];
               UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:AlertTitle message:@"\n" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Ok", nil];
                alertView.tag = 1212;
                [alertView show];
            }
            else if([PasswordText.text length] == 0 ){
                // "password missing
                NSString *AlertTitle = [[NSString alloc] initWithString:@"You did not enter a password. Try again?"];
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:AlertTitle message:@"\n" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Ok", nil];
                alertView.tag = 1212;
                [alertView show];

            }
            else
            {
                // To database with email address,password and UIID;
                NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
                NSString *MyDeviceId = [prefs stringForKey:@"LCUIID"];
                [self SubscriptionTransferServer:MyDeviceId];
                
            }
            
            
        
    }
    else if(buttonIndex == 1 && actionSheet.tag == 1212){
        
        
        [self TransferSubscription:self];
        
    }
    
    else if(actionSheet.tag == 1111) {
        
        LoginTitle = @"Login";
        [LoginViaLearnersCloud addTarget:self action:@selector(TransferSubscription:) forControlEvents:UIControlEventTouchUpInside];
        [LoginViaLearnersCloud setTitle:LoginTitle forState:UIControlStateNormal];

        }
    else {
        
        
    }
    
}



- (BOOL)textFieldShouldEndEditing:(UITextView *)textView{
    
    if(textView.tag == 1717){
        if(UsernameText.text.length > 0 ){
            
            [UsernameText resignFirstResponder];
            
            return true;
        }
        else
        {
            
            [UsernameText resignFirstResponder];
            return true;
        }
        
    }
    
    else if(textView.tag == 1818){
            
        if(PasswordText.text.length > 0 ){
            
            [PasswordText resignFirstResponder];
            
            return true;
            }
        else
            {
                [PasswordText resignFirstResponder];
                return true;
                
            }
    }
    else
    {
        return false;
    }
}



-(void)SubscriptionTransferServer:(NSString *)DeviceID{
    
    int ButtonNumber = WhichButton.tag;
    if(ReponseFromServer){
        [ReponseFromServer setLength:0];
    }

    
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    NSString *domain = appDelegate.DomainName;
    
    appDelegate.SecondThread = [[NSThread alloc]initWithTarget:self selector:@selector(AddProgress) object:nil];
    [appDelegate.SecondThread start];

    if (ButtonNumber == 999) {
        
    NSString *queryString = [NSString stringWithFormat:@"%@/Services/iOS/VideoSubscription.asmx/UpdateDeviceID",domain];
    NSURL *url = [NSURL URLWithString:queryString];
    NSMutableURLRequest *req = [NSMutableURLRequest requestWithURL:url];
    
    NSString *FullString = [NSString stringWithFormat:@"DeviceID=%@&email=%@&password=%@&",DeviceID,UsernameText.text,PasswordText.text];
    //NSLog(@"%@",DeviceID);
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
    
    else {
        
        // This is requesting access via Silverlight credentials
        
        NSString *AppID = @"1";   // 2 means this is maths, 1 is English , 3 is physics 
        NSString *queryString = [NSString stringWithFormat:@"%@/Services/iOS/VideoSubscription.asmx/FindSLSubscription",domain];
        NSURL *url = [NSURL URLWithString:queryString];
        NSMutableURLRequest *req = [NSMutableURLRequest requestWithURL:url];
        
        NSString *FullString = [NSString stringWithFormat:@"AppID=%@&SLemail=%@&SLpassword=%@&",AppID,UsernameText.text,PasswordText.text];
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
    
       
    
    
    
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)someData {
    
    /* Response from server for Transfer subscription:
      0 = Successfully updated
     -1 = Error
     -2 = Error
     -3 = Error
     -4 = User does not exist */
     
    /* Response from Silverlight Authentication
      0 = OK
     -1 = No current subscription
     -2 = Authentication failed
     -3 = AppID not recognised
     -4 = Any other exception*/
    
    if(!ReponseFromServer){
        ReponseFromServer = [[NSMutableData alloc]init ];
    }
    
    
    [ReponseFromServer appendData:someData];
    
    
    
    
}

-(void)connectionDidFinishLoading:(NSURLConnection *)connection{
    
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    appDelegate.SecondThread = [[NSThread alloc]initWithTarget:self selector:@selector(AddProgress) object:nil];
    [appDelegate.SecondThread cancel];
    [self navigationItem].rightBarButtonItem = nil;
    
    NSString *returnedString = [[NSString alloc] initWithData:ReponseFromServer encoding:NSASCIIStringEncoding];
    //NSLog(@"%@",returnedString);
    NSString *Clean1 = [returnedString stringByReplacingOccurrencesOfString:@"&lt;" withString:@"<"];
    NSString *Clean2 =[Clean1 stringByReplacingOccurrencesOfString:@"&gt;" withString:@">"];
    NSString *Clean3 =[Clean2 stringByReplacingOccurrencesOfString:@"&lt;/" withString:@"/>"];
    //NSLog(@"%@",Clean3);
    NSData *xmlData = [Clean3 dataUsingEncoding:NSUTF8StringEncoding];
    NSXMLParser *parser = [[NSXMLParser alloc] initWithData:xmlData];
    [parser setDelegate:self];
    [parser parse];

}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qualifiedName attributes:(NSDictionary *)attributeDict {
    
    }


- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
    
    NSString *CleanString = [string stringByTrimmingCharactersInSet:
                             [NSCharacterSet whitespaceAndNewlineCharacterSet]];
    if([CleanString isEqualToString:@""]){
        
        //Do nothing
       
        return;
        
    }
    
        int Returnid = [string intValue];
        
        //NSLog(@"%i",Returnid);
    
        int ButtonNumber = WhichButton.tag;
    
    if (ButtonNumber == 999) {
        
    
            if (Returnid == 0) {
        
                NSError *error;
                // Report to  analytics
                if (![[GANTracker sharedTracker] trackEvent:@"User transfer subscription to another device"
                                                     action:@"Transfer successful"
                                                      label:@"Transfer successful"
                                                      value:89
                                                  withError:&error]) {
                    NSLog(@"error in trackEvent");
                }
                
                

                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Successful" message:@"Update successful" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
                alertView.tag = 4444;
                [self RefreshSubsciptionStatus:self];
                [alertView show];
             }
    
          else if (Returnid < 0){
            
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Not successful" message:@"You don't have any running subscription" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            alertView.tag = 4444;
            [alertView show];
            
             }

     }
    else {
        
          if (Returnid == 0) {
              // User is allowed access to all videos
               NSError *error;
              // Report to  analytics
              if (![[GANTracker sharedTracker] trackEvent:@"Successful Login via credentials"
                                                   action:@"Login to maths successful"
                                                    label:@"Login to maths successful"
                                                    value:79
                                                withError:&error]) {
                  NSLog(@"error in trackEvent");
              }

              AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
              appDelegate.AccessAll = TRUE;
              appDelegate.UserEmail = @"JustAGeneralEmail@thisapp.com";
              LoginTitle = @"Logout";
              [LoginViaLearnersCloud addTarget:self action:@selector(LogoutUser:) forControlEvents:UIControlEventTouchUpInside];
              [LoginViaLearnersCloud setTitle:LoginTitle forState:UIControlStateNormal];
              [self ViewFreeVideos:self];
          }
         else if (Returnid == -1)
             
         {
             NSError *error;
             // Report to  analytics
             if (![[GANTracker sharedTracker] trackEvent:@"User rejected login due to no subscription"
                                                  action:@"No subscription"
                                                   label:@"No subscription"
                                                   value:79
                                               withError:&error]) {
                 NSLog(@"error in trackEvent");
             }

             UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Not successful" message:@"You don't have any running subscription" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
             alertView.tag = 4444;
             [alertView show];
         
         }
         else {
             
             NSError *error;
             // Report to  analytics
             if (![[GANTracker sharedTracker] trackEvent:@"User login failed"
                                                  action:@"Login to english failed"
                                                   label:@"Login to english failed"
                                                   value:79
                                               withError:&error]) {
                 NSLog(@"error in trackEvent");
             }

             UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Not successful" message:@"Login failed" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
             alertView.tag = 4444;
             [alertView show];
         }
    
    }

       
    
}




- (void)AddProgress{
	
    @autoreleasepool {

	
	UIActivityIndicatorView * activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
	[activityIndicator stopAnimating];
    [activityIndicator hidesWhenStopped];
	UIBarButtonItem * barButton = [[UIBarButtonItem alloc] initWithCustomView:activityIndicator];
	[self navigationItem].rightBarButtonItem = barButton;
	
	[(UIActivityIndicatorView *)[self navigationItem].rightBarButtonItem.customView startAnimating];
	
    }
	
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    
    
   return (interfaceOrientation == UIInterfaceOrientationPortrait);
    
	
}


 
 

- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation duration:(NSTimeInterval)duration{
    
    
    if (interfaceOrientation == UIInterfaceOrientationPortrait  || interfaceOrientation == UIInterfaceOrientationPortraitUpsideDown) {
        
        FreeVideos.frame = CGRectMake(20 ,30, 280, 34);
        BtnTransfermysubscription.frame = CGRectMake(170,310, 130, 34);
        ImageView.frame = CGRectMake(20 ,80, 280, 200);
        FirstView.frame = CGRectMake(0, 0,SCREEN_WIDTH, SCREEN_HEIGHT);
        LoginViaLearnersCloud.frame = CGRectMake(20 ,310, 130, 34);
        
    }
    else
    {
    
        
        FreeVideos.frame = CGRectMake(80,5, 280, 34);
        BtnTransfermysubscription.frame = CGRectMake(240 ,160, 120, 34);
        ImageView.frame = CGRectMake(105,45, 240, 100);
        FirstView.frame = CGRectMake(0, 0, SCREEN_WIDTH , SCREEN_HEIGHT + 80);
        LoginViaLearnersCloud.frame = CGRectMake(80,160, 120, 34); 
        
    }
    
}

- (void)viewDidAppear:(BOOL)animated{
    
    [(UIActivityIndicatorView *)[self navigationItem].rightBarButtonItem.customView stopAnimating];
    [self willAnimateRotationToInterfaceOrientation:self.interfaceOrientation duration:1];

}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    [textField resignFirstResponder];
    
    return YES;

}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
}
*/

/*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
}
*/
- (void)dealloc {
// NSLog(@"I am gone dear");

}
- (void)viewDidUnload
{
    [super viewDidUnload];
   
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


@end
