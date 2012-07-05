//
//  Share.m
//  MathsVideoStreameriPhone
//
//  Created by Joseph caxton-Idowu on 19/06/2012.
//  Copyright (c) 2012 caxtonidowu. All rights reserved.
//

#import "Share.h"

@interface Share ()

@end

@implementation Share

@synthesize facebook,logoutFacebook,activityIndicator;


- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title = @"Share this app";

}

- (void)viewDidUnload
{
    [super viewDidUnload];
    
    self.navigationItem.title = @"Share this app";
    
    NSError *error;
    // Report to  analytics
    if (![[GANTracker sharedTracker] trackPageview:@"/SocialMediaPage"
                                         withError:&error]) {
        NSLog(@"error in trackPageview");
    }

    
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(section == 0){
        
        return 1;
    }
    else if (section == 1)
    {
        
        
        return 3;
        
    }
    else if (section == 2){
        
        return 3;
    }
    
    else {
        return 0;
    }

}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath: (NSIndexPath *) indexPath {
    
    if((indexPath.row == 0 && indexPath.section == 0) || (indexPath.row == 0 && indexPath.section == 2)){
        
        return 60;
    }
    else
        
    {
        return 50;
    }
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    if (indexPath.section == 0 ){
        
        // UIImage* mailImage = [UIImage imageNamed:@"mail.png"];
        //cell.imageView.image = mailImage;
        
        cell.textLabel.text = @"Like what you see here? Share this app with a friend and we give one more video free!";
        cell.textLabel.lineBreakMode = UILineBreakModeWordWrap;
        cell.textLabel.numberOfLines = 0;
        cell.textLabel.font = [UIFont fontWithName:@"Helvetica" size:17.0];
        
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.contentView.backgroundColor = [ UIColor blackColor ];
        cell.textLabel.backgroundColor = [UIColor blackColor];
        cell.textLabel.textColor = [UIColor whiteColor];
        cell.textLabel.textAlignment = UITextAlignmentCenter;
        
        
    }
    else  if (indexPath.section == 1 && indexPath.row == 0){
        
        UIImage* mailImage = [UIImage imageNamed:@"mail.png"];
        cell.imageView.image = mailImage;
        cell.textLabel.text = @"Email to a friend";
        
        
    }
    else if (indexPath.section == 1 && indexPath.row == 1)
    {
        UIImage* mailImage = [UIImage imageNamed:@"facebook.png"];
        cell.imageView.image = mailImage;
        cell.textLabel.text = @"Facebook";
        
        // Show logout facebook
        
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        if ([defaults objectForKey:@"FBAccessTokenKey"] && [defaults objectForKey:@"FBExpirationDateKey"]) {
            
            UIImage* logoutImage = [UIImage imageNamed:@"logoutfacebook.png"];
            logoutFacebook = [UIButton buttonWithType:UIButtonTypeRoundedRect];
            logoutFacebook.frame = CGRectMake(320, 10, 72, 22);
            [logoutFacebook setBackgroundImage:logoutImage forState:UIControlStateNormal];
            //[logoutFacebook setTitle:@"Log Out" forState:UIControlStateNormal];
            [logoutFacebook addTarget:self action:@selector(logoutButtonClicked:)forControlEvents:UIControlEventTouchUpInside];
            [cell addSubview:logoutFacebook];  
            
            
        }
        
    }
    
    else if (indexPath.section == 1 && indexPath.row == 2) {
        
        UIImage* TwitterImage = [UIImage imageNamed:@"twitter.png"];
        cell.imageView.image = TwitterImage;
        cell.textLabel.text = @"Twitter";
        
    }
    else if (indexPath.section == 2 && indexPath.row == 0){
        
        cell.textLabel.text = @"****** Very important – We operate an alerts service through Twitter, follow us to get the latest service notifications ***";
        cell.textLabel.lineBreakMode = UILineBreakModeWordWrap;
        cell.textLabel.numberOfLines = 0;
        cell.textLabel.font = [UIFont fontWithName:@"Helvetica" size:14.0];
        
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        CGFloat nRed=236.0/255.0; 
        CGFloat nBlue=207/255.0;
        CGFloat nGreen=141.0/255.0;
        UIColor *mycolor=[[UIColor alloc]initWithRed:nRed green:nBlue blue:nGreen alpha:1];
        cell.contentView.backgroundColor = mycolor;
        cell.textLabel.backgroundColor =  mycolor;
        cell.textLabel.textColor = [UIColor blackColor];
        cell.textLabel.textAlignment = UITextAlignmentCenter;
        
    }
    else if (indexPath.section == 2 && indexPath.row == 1){
        
        UIImage* FollowUsOnTwitterImage = [UIImage imageNamed:@"FollowUsOnTwitter.png"];
        cell.imageView.image = FollowUsOnTwitterImage;
        cell.textLabel.text = @"Follow us on Twitter";
    }

    else if(indexPath.section == 2 && indexPath.row == 2){
        
        UIImage* LikeUsImage = [UIImage imageNamed:@"LikeUsOnFaceBook.png"];
        cell.imageView.image = LikeUsImage;
        cell.textLabel.text = @"Like us on Facebook";
        
    }

    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section == 1 && indexPath.row ==0){
        
        [self ShareThisAppViaMail:self];
        
        
        
    }
    else if (indexPath.section == 1 && indexPath.row == 1){
        
        [self ConnectToFaceBook];
        
    }
    
    else if (indexPath.section == 1 && indexPath.row == 2){
        
        [self Twit];
    }
    
    else if (indexPath.section == 2 && indexPath.row < 2){
        
        [self FollowUsOnTwitter];
    }
    else if (indexPath.section == 2 && indexPath.row == 2){
        
        [self LikeUsOnFaceBook];
    }

}

-(IBAction)ShareThisAppViaMail:(id)sender{
	
	if ([MFMailComposeViewController canSendMail]) {
        
        
        //NSArray *SendTo = [NSArray arrayWithObjects:@"support@LearnersCloud.com",nil];
        
        MFMailComposeViewController *SendMailcontroller = [[MFMailComposeViewController alloc]init];
        SendMailcontroller.mailComposeDelegate = self;
        //[SendMailcontroller setToRecipients:SendTo];
        [SendMailcontroller setSubject:@"Get LearnersCloud app on your iPhone, iPod Touch, or iPad"];
        
        [SendMailcontroller setMessageBody:[NSString stringWithFormat:@"Checkout the free LearnersCloud video app. Its loaded with quality revision videos from <a href=http://itunes.apple.com/us/app/gcse-english-english-literature/id535073858?ls=1&mt=8>here at the app store</a> or do a search for LearnersCloud in the app store to view a list of all LearnersCloud apps. LearnersCloud is a top 20 winner of the BETT show award 2012. "] isHTML:YES];
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
    
    
    if(MFMailComposeResultSent){
        
        NSError *error;
        // Report to  analytics
        if (![[GANTracker sharedTracker] trackEvent:@"Shared via email"
                                             action:@"Email shared"
                                              label:@"Email shared"
                                              value:69
                                          withError:&error]) {
            NSLog(@"error in trackEvent");
        }

        
        NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
        // Give user one free video.
        if(![prefs objectForKey:@"AddOneFreeEnglish"]){
            
            [prefs setObject:@"1" forKey:@"AddOneFreeEnglish"];
            [prefs synchronize];
            
        }
        
    }
	
	[self becomeFirstResponder];
	[self dismissModalViewControllerAnimated:YES];
	
	
	
	
}

-(void)ConnectToFaceBook {
    
    facebook = [[Facebook alloc] initWithAppId:@"269396469833912" andDelegate:self];
    
    //Save a pointer to this object for return from facebook
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    appDelegate.m_facebook = facebook;
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if ([defaults objectForKey:@"FBAccessTokenKey"] && [defaults objectForKey:@"FBExpirationDateKey"]) {
        
        facebook.accessToken = [defaults objectForKey:@"FBAccessTokenKey"];
        facebook.expirationDate = [defaults objectForKey:@"FBExpirationDateKey"];
        
    }
    
    
    if (![facebook isSessionValid]) {
        [facebook authorize:nil];
    }
    
    NSMutableDictionary* params = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                   @"Hey!!!. I'm watching amazing english videos on this great new app, it really helped me and i hope it helps you too. You should try it out. Download it now for your iPad, iPhone and iPod Touch",  @"message",
                                   nil];
    
    [facebook dialog:@"apprequests"
           andParams:params
         andDelegate:self];
    
}


- (void)fbDidLogin {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:[facebook accessToken] forKey:@"FBAccessTokenKey"];
    [defaults setObject:[facebook expirationDate] forKey:@"FBExpirationDateKey"];
    
    [defaults synchronize];
    
}

- (void)fbDidNotLogin:(BOOL)cancelled{
    
    
    
}


- (void) logoutButtonClicked:(id)sender {
    
    facebook = [[Facebook alloc] initWithAppId:@"269396469833912" andDelegate:self];
    //Save a pointer to this object for return from facebook
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    appDelegate.m_facebook = facebook;
    
    [facebook logout];
    
    // Remove saved authorization information if it exists
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if ([defaults objectForKey:@"FBAccessTokenKey"]) {
        [defaults removeObjectForKey:@"FBAccessTokenKey"];
        [defaults removeObjectForKey:@"FBExpirationDateKey"];
        [defaults synchronize];
    }
    
    
    
}

- (void) fbDidLogout {
    
    
}


- (void)fbDidExtendToken:(NSString*)accessToken
               expiresAt:(NSDate*)expiresAt{
    
}

- (void)fbSessionInvalidated{
    
    
}

- (void)dialogDidComplete:(FBDialog *)dialog {
    
    NSError *error;
    // Report to  analytics
    if (![[GANTracker sharedTracker] trackEvent:@"Shared via facebook"
                                         action:@"Facebook shared"
                                          label:@"Facebook shared"
                                          value:69
                                      withError:&error]) {
        NSLog(@"error in trackEvent");
    }

    
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    // Give user one free video.
    if(![prefs objectForKey:@"AddOneFreeEnglish"]){
        
        
        [prefs setObject:@"1" forKey:@"AddOneFreeEnglish"];
        [prefs synchronize];
        
    }
    
    
}

- (void) dialogDidNotComplete:(FBDialog *)dialog{
    
    
}

- (void)dialogCompleteWithUrl:(NSURL *)url{
    
    
}

-(void)Twit {
    
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    appDelegate.SecondThread = [[NSThread alloc]initWithTarget:self selector:@selector(AddProgress) object:nil];
    [appDelegate.SecondThread start];
    
    if ([TWTweetComposeViewController canSendTweet])
    {
        NSString *UrlString = @"http://itunes.apple.com/us/app/gcse-english-english-literature/id535073858?ls=1&mt=8";
        
        TWTweetComposeViewController *tweetSheet = [[TWTweetComposeViewController alloc] init];
        [tweetSheet setInitialText:@"Checkout LearnersCloud video app. Quality english revision videos. :)"];
        [tweetSheet addURL:[NSURL URLWithString:UrlString]];
        [tweetSheet addImage:[UIImage imageNamed:@"Icon"]];
        
        NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
        
        tweetSheet.completionHandler = ^(TWTweetComposeViewControllerResult result) {
            NSError *error;
            switch (result) {
                case TWTweetComposeViewControllerResultCancelled:                    
                    break;
                    
                case TWTweetComposeViewControllerResultDone:
                    
                    // Report to  analytics
                    if (![[GANTracker sharedTracker] trackEvent:@"Shared via twitter"
                                                         action:@"twitter shared"
                                                          label:@"twitter shared"
                                                          value:69
                                                      withError:&error]) {
                        NSLog(@"error in trackEvent");
                    }

                    // Give user one free video.
                    if(![prefs objectForKey:@"AddOneFreeEnglish"]){
                        
                        [prefs setObject:@"1" forKey:@"AddOneFreeEnglish"];
                        [prefs synchronize];
                        
                    }
                    
                    
                    break;
                    
                default:
                    break;
            }
            [self dismissModalViewControllerAnimated:YES];
        };
        
        
        [activityIndicator stopAnimating];
        
	    [self presentModalViewController:tweetSheet animated:YES];
    }
    else
    {
        [activityIndicator stopAnimating];
        UIAlertView *alertView = [[UIAlertView alloc] 
                                  initWithTitle:@"Sorry"                                                             
                                  message:@"You can't send a tweet right now, make sure  your device has an internet connection and you have at least one Twitter account setup"                                                          
                                  delegate:self                                              
                                  cancelButtonTitle:@"OK"                                                   
                                  otherButtonTitles:nil];
        [alertView show];
    }
    
}

- (void)AddProgress{
	
    @autoreleasepool {
        
        
        activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        [activityIndicator stopAnimating];
        [activityIndicator hidesWhenStopped];
        activityIndicator.center = CGPointMake(250, 185);
        
        [self.view addSubview:activityIndicator];
        [activityIndicator startAnimating];
        
    }
	
}
-(void)FollowUsOnTwitter{
    
    // Report to  analytics
    NSError *error;
    if (![[GANTracker sharedTracker] trackEvent:@"User sent to our twitter page to follow us"
                                         action:@"User sent to our twitter page to follow us"
                                          label:@"User sent to our twitter page to follow us"
                                          value:1
                                      withError:&error]) {
        NSLog(@"error in trackEvent");
    }
    
    
    NSString *str = @"http://twitter.com/#!/learnerscloud"; 
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
    
}

-(void)LikeUsOnFaceBook{
    
    // Report to  analytics
    NSError *error;
    if (![[GANTracker sharedTracker] trackEvent:@"User likes us on Facebook"
                                         action:@"User likes us on Facebook"
                                          label:@"User likes us on Facebook"
                                          value:1
                                      withError:&error]) {
        NSLog(@"error in trackEvent");
    }
    
    
    NSString *str = @"http://www.facebook.com/LearnersCloud"; 
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
    
}



@end
