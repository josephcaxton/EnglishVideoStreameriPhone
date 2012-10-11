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
    
    NSString *HeaderLocation = [[NSBundle mainBundle] pathForResource:@"header_bar" ofType:@"png"];
    UIImage *HeaderBackImage = [[UIImage alloc] initWithContentsOfFile:HeaderLocation];
    [self.navigationController.navigationBar setBackgroundImage:HeaderBackImage forBarMetrics:UIBarMetricsDefault];
    
    
    

    
    NSError *error;
    // Report to  analytics
    if (![[GANTracker sharedTracker] trackPageview:@"/SocialMediaPage"
                                         withError:&error]) {
        NSLog(@"error in trackPageview");
    }


}

- (void)viewDidUnload
{
    [super viewDidUnload];
    
    
    
    
}

// For ios 6
-(NSUInteger)supportedInterfaceOrientations{
    return UIInterfaceOrientationMaskPortrait;
    
    
}

// for ios 5
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    
    return  (interfaceOrientation == UIInterfaceOrientationPortrait);
	
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
        
        
        return 4;
        
    }
    else if (section == 2){
        
        return 3;
    }
    
    else {
        return 0;
    }

}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath: (NSIndexPath *) indexPath {
    
    if((indexPath.row == 0 && indexPath.section == 0)){
        
        return 70;
    }
    else if((indexPath.row == 0 && indexPath.section == 1) || (indexPath.row == 0 && indexPath.section == 2)){
        
        return 25;
    }
    
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
        
        UIView *headerView = [[UIView alloc] init];
        
        NSString *HeaderImagePath = [[NSBundle mainBundle] pathForResource:@"share_intro" ofType:@"png"];
        UIImage *HeaderImage = [[UIImage alloc] initWithContentsOfFile:HeaderImagePath];
        UIImageView *HeaderImageView = [[UIImageView alloc] initWithImage:HeaderImage];
        HeaderImageView.frame = CGRectMake(0.0, 0.0, 320, 70);
        HeaderImageView.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin;
        [headerView addSubview:HeaderImageView];
        [cell addSubview:headerView];
        
        
        
        
    }
    
    else if(indexPath.section == 1 && indexPath.row == 0){
        
        UIView *shareView = [[UIView alloc] init];
        
        NSString *sharedividerImagePath = [[NSBundle mainBundle] pathForResource:@"divider_share" ofType:@"png"];
        UIImage *sharedividerImage = [[UIImage alloc] initWithContentsOfFile:sharedividerImagePath];
        UIImageView *sharedividerView = [[UIImageView alloc] initWithImage:sharedividerImage ];
        sharedividerView.frame = CGRectMake(0.0, 0.0, 320, 30);
        sharedividerView.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin;
        [shareView addSubview: sharedividerView];
        [cell addSubview:shareView];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        
    }
    else  if (indexPath.section == 1 && indexPath.row == 1){
        
        UIImage* mailImage = [UIImage imageNamed:@"icon_email_to_friend.png"];
        cell.imageView.image = mailImage;
        cell.textLabel.text = @"Email to a friend";
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
    }
    else if (indexPath.section == 1 && indexPath.row == 2)
    {
        UIImage* mailImage = [UIImage imageNamed:@"icon_share_on_facebook"];
        cell.imageView.image = mailImage;
        cell.textLabel.text = @"Share on Facebook";
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        // Show logout facebook
        
        /* NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
         if ([defaults objectForKey:@"FBAccessTokenKey"] && [defaults objectForKey:@"FBExpirationDateKey"]) {
         
         UIImage* logoutImage = [UIImage imageNamed:@"logout.png"];
         logoutFacebook = [UIButton buttonWithType:UIButtonTypeRoundedRect];
         logoutFacebook.frame = CGRectMake(250, 10, 54, 30);
         [logoutFacebook setBackgroundImage:logoutImage forState:UIControlStateNormal];
         [logoutFacebook addTarget:self action:@selector(logoutButtonClicked:)forControlEvents:UIControlEventTouchUpInside];
         [cell addSubview:logoutFacebook];
         }*/
        
        
        
    }
    
    else if (indexPath.section == 1 && indexPath.row == 3) {
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        UIImage* TwitterImage = [UIImage imageNamed:@"icon_share_on_twitter.png"];
        cell.imageView.image = TwitterImage;
        cell.textLabel.text = @"Share on Twitter";
        
    }
    else if (indexPath.section == 2 && indexPath.row == 0){
        
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        UIView *NotView = [[UIView alloc] init];
        
        NSString *NotdividerImagePath = [[NSBundle mainBundle] pathForResource:@"divider_notifications" ofType:@"png"];
        UIImage *NotdividerImage = [[UIImage alloc] initWithContentsOfFile:NotdividerImagePath];
        UIImageView *NotdividerView = [[UIImageView alloc] initWithImage:NotdividerImage ];
        NotdividerView.frame = CGRectMake(0.0, 0.0, 320, 30);
        NotdividerView.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin;
        [NotView addSubview: NotdividerView];
        [cell addSubview:NotView];
        
        
        
        
    }
    else if (indexPath.section == 2 && indexPath.row == 1){
        
        UIImage* FollowUsOnTwitterImage = [UIImage imageNamed:@"icon_follow_on_twitter.png"];
        cell.imageView.image = FollowUsOnTwitterImage;
        cell.textLabel.text = @"Follow us on Twitter";
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    else if(indexPath.section == 2 && indexPath.row == 2){
        
        UIImage* LikeUsImage = [UIImage imageNamed:@"icon_like_on_facebook.png"];
        cell.imageView.image = LikeUsImage;
        cell.textLabel.text = @"Like us on Facebook";
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
    }
    
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section == 1 && indexPath.row ==1){
        
        [self ShareThisAppViaMail:self];
        
        
        
    }
    else if (indexPath.section == 1 && indexPath.row == 2){
        
        [self ConnectToFaceBook];
        
    }
    
    else if (indexPath.section == 1 && indexPath.row == 3){
        
        [self Twit];
    }
    
    else if (indexPath.section == 2 && indexPath.row == 1){
        
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
        [SendMailcontroller setSubject:@"Learn and revise GCSE English on the go - English App"];
        
        [SendMailcontroller setMessageBody:[NSString stringWithFormat:@"Checkout the FREE LearnersCloud Video App loaded with quality revision videos. To download this App for iPad <a href=http://itunes.apple.com/us/app/gcse-english-english-literature/id533079978?ls=1&mt=8> click here </a>. For iPhone <a href=http://itunes.apple.com/us/app/gcse-english-english-literature/id535073858?ls=1&mt=8> click here</a>. Or search LearnersCloud in your device’s App store. For loads more: www.Learnerscloud.com"] isHTML:YES];
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
                                              value:1
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
    
    facebook = [[Facebook alloc] initWithAppId:@"400532876670410" andDelegate:self];
    
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
                                   @"I’ve just started using a new GCSE English videos App! Hundreds of quality English videos. You should check it out, or search LearnersCloud in your device’s App store.",  @"message",
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
    
    facebook = [[Facebook alloc] initWithAppId:@"400532876670410" andDelegate:self];
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
    
    [self.tableView reloadData]; 
    
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
                                          value:1
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
        [tweetSheet setInitialText:@"Checkout @LearnersCloud #GCSE English video app. Learn and revise English on the go."];
        [tweetSheet addImage:[UIImage imageNamed:@"Icon.png"]];
        [tweetSheet addURL:[NSURL URLWithString:UrlString]];
        
        
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
                                                          value:1
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
        activityIndicator.center = CGPointMake(250, 215);
        
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
