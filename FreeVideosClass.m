//
//  FreeVideos.m
//  VideoStreamer
//
//  Created by Joseph caxton-Idowu on 14/03/2012.
//  Copyright (c) 2012 caxtonidowu. All rights reserved.
//

#import "FreeVideosClass.h"
#import "AppDelegate.h"
#import "ConfigObject.h"
#import "VideoPlayer.h"
#import "Buy.h"
#import "ListCell.h"


@implementation FreeVideosClass


@synthesize ArrayofConfigObjects,filteredArrayofConfigObjects,ProductIDs,ImageObjects,ProductsSubscibedTo,FullSubscription,mySearchBar;





- (void)viewDidLoad {
    [super viewDidLoad];
	
	
    
	//self.navigationItem.title = @"Free and Subscription Videos";
    
    self.tableView.backgroundView = nil;
    NSString *BackImagePath = [[NSBundle mainBundle] pathForResource:@"back320x450" ofType:@"png"];
	UIImage *BackImage = [[UIImage alloc] initWithContentsOfFile:BackImagePath];
    self.tableView.backgroundColor = [UIColor colorWithPatternImage:BackImage];
    

    
    // Listen to notification
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    [nc addObserver:self selector:@selector(RefreshTable:) name:@"ToFreeVideoClass" object:nil];
	 
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
      //NSLog(@"Subscibed products= %@", appDelegate.SubscibedProducts);
    
    
    UIBarButtonItem *SendSupportMail = [[UIBarButtonItem alloc] initWithTitle:@"Report Problem" style: UIBarButtonItemStyleBordered target:self action:@selector(ReportProblem:)];
    self.navigationItem.rightBarButtonItem = SendSupportMail;
    
    // Get Subscibed products from delegate
    /*if([appDelegate.SubscibedProducts count] > 0){
        
        ProductsSubscibedTo = [[NSMutableArray alloc] initWithArray:appDelegate.SubscibedProducts]; 
        
    }*/
    
    // If User is fully subscibed by logging in or by identifying via DeviceID
    
    FullSubscription = appDelegate.AccessAll;
    
    // Put all the images into an array
    
    ImageObjects = [[NSMutableArray alloc] init];
    int i;
    NSString *loadString;
    
    for(i = 0; i < 70; i++) {
        loadString = [NSString stringWithFormat:@"%d", i + 1]; 
        [ImageObjects addObject:[UIImage imageNamed:loadString]];
        
    }
	
    
    
	// Copy or Update the VideoConfig File;
   
    NSString *domain = appDelegate.DomainName;
    NSString *queryFeed = [NSString stringWithFormat:@"%@/iosStreamv2/English/EnglishConfig_iPhone.xml",domain];
    NSString *Dir = [appDelegate.applicationDocumentsDirectory stringByAppendingPathComponent:@"EnglishConfig_iPhone.xml"];
    
         
   
    if(appDelegate.isDeviceConnectedToInternet){
    
   BOOL DownloadIt =  [self ShouldIDownloadOrNot:queryFeed :Dir];
   
    if(DownloadIt == YES){
        
           NSFileManager *fileManager = [NSFileManager defaultManager];
           NSError *error=[[NSError alloc]init];
            
            BOOL success=[fileManager fileExistsAtPath:Dir];
           
            if(success)
        	{
        		[fileManager removeItemAtPath:Dir error:&error];
            }

    
        [self GetConfigFileFromServeWriteToPath:Dir];
        
    }
    
    
    
    ArrayofConfigObjects = [[NSMutableArray alloc] init];
    filteredArrayofConfigObjects = [[NSMutableArray alloc] init];

   
        
    }
    else
    {
    
        [self Alertfailedconnection];
    
    }
	
    [appDelegate.SecondThread cancel];
    
    mySearchBar = [[UISearchBar alloc] init];
    mySearchBar.placeholder = @"Type a search term";
    mySearchBar.tintColor = [UIColor blackColor];
    mySearchBar.delegate = self;
    [mySearchBar sizeToFit];
    [mySearchBar setAutocapitalizationType:UITextAutocapitalizationTypeNone];
    [mySearchBar sizeToFit];
    self.tableView.tableHeaderView = mySearchBar;

        
}
- (void)viewWillAppear:(BOOL)animated {


    
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    
    //[self AdjustProductSubscribedTo];
    
    // Get Subscibed Status from delegate or Don't check if user is successfully logged in
    
    if(appDelegate.AccessAll == TRUE){
        
        // NSLog(@"%@",appDelegate.AccessAll);
    }
    else{
        
        // NSLog(@"%@",appDelegate.AccessAll);
        
        NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
        NSString *DeviceID = [prefs stringForKey:@"LCUIID"];
        
        [appDelegate SubscriptionStatus: DeviceID];
        
        FullSubscription = appDelegate.AccessAll;
        
    }
    
    
        
    NSString *Dir = [appDelegate.applicationDocumentsDirectory stringByAppendingPathComponent:@"EnglishConfig_iPhone.xml"]; 
   [self MyParser:Dir];
    
    
}

/*-(void)AdjustProductSubscribedTo{

   AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    
    if([appDelegate.TempSubscibedProducts count] > 0){
        
        if([ProductsSubscibedTo count] > 0){
            
            [ProductsSubscibedTo removeAllObjects];
            for(int i = 0; i < [appDelegate.TempSubscibedProducts count]; i++){
                
                [ProductsSubscibedTo addObject:[appDelegate.TempSubscibedProducts objectAtIndex:i]]; 
            }
        }
        else{
            
            
            ProductsSubscibedTo = [[NSMutableArray alloc] initWithArray:appDelegate.TempSubscibedProducts]; 
            
        }
        
        
    }

    
}*/


-(void)RefreshTable:(NSNotification *)note{
    
    
   [self performSelectorOnMainThread:@selector(RefeshTable) withObject:nil waitUntilDone:NO];
}

-(void)RefeshTable{
    
    /*UIActivityIndicatorView * activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    UIBarButtonItem * barButton = [[UIBarButtonItem alloc] initWithCustomView:activityIndicator];
	[self navigationItem].rightBarButtonItem = barButton;
    [(UIActivityIndicatorView *)[self navigationItem].rightBarButtonItem.customView startAnimating];*/
    
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    //NSLog(@"%@", appDelegate.TempSubscibedProducts);
   
    NSString *Dir = [appDelegate.applicationDocumentsDirectory stringByAppendingPathComponent:@"EnglishConfig_iPhone.xml"];
    //[self AdjustProductSubscribedTo];
     FullSubscription = appDelegate.AccessAll;
     //NSLog(@"%@", appDelegate.TempSubscibedProducts);
     //NSLog(@"%@",  ProductsSubscibedTo);
    [ArrayofConfigObjects removeAllObjects];
      [filteredArrayofConfigObjects removeAllObjects];
    [self MyParser:Dir];
    [self.tableView reloadData];
    
    //[activityIndicator stopAnimating];
    //[activityIndicator hidesWhenStopped];
    
}


-(BOOL)ShouldIDownloadOrNot:(NSString*)urllPath:(NSString*)LocalFileLocation{
    
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
   BOOL ReturnVal =  [appDelegate downloadFileIfUpdated:urllPath:LocalFileLocation];
    
    return ReturnVal;
   
    
    
    
}
-(void)GetConfigFileFromServeWriteToPath:(NSString*)Path{
    
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    NSString *domain = appDelegate.DomainName;
    NSString *queryFeed = [NSString stringWithFormat:@"%@/iosStreamv2/English/EnglishConfig_iPhone.xml", domain];
	NSURLRequest *theRequest = [NSURLRequest requestWithURL:[NSURL URLWithString:queryFeed]];
    NSURLResponse *resp = nil; 
    NSError *err = nil;
    NSData *response = [NSURLConnection sendSynchronousRequest: theRequest returningResponse: &resp error: &err];
    
    if (response) {
        
        NSError* error;
        
        [response writeToFile:Path options:NSDataWritingAtomic error:&error];
        
        if(error != nil)
            NSLog(@"write error %@", error);
    }
    

    
    
}

-(void)Alertfailedconnection{
    
    NSString *message = [[NSString alloc] initWithFormat:@"Your device is not connected to the internet. You need access to the internet to stream our videos "];
    
    UIAlertView *alert =[[UIAlertView alloc] initWithTitle:@"Important Notice"
                                                   message:message delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
    
    [alert show];
   

    
}

-(void)MyParser:(NSString *)FileLocation{
	
	NSError* error;
	
	NSString* fileContents = [NSString stringWithContentsOfFile:FileLocation encoding:NSWindowsCP1252StringEncoding error:&error];
	
	
	NSArray* pointStrings = [fileContents componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"±"]];
	
	for(int idx = 0; idx < pointStrings.count - 1; idx++)
	{
		// break the string down even further to the columns
		NSString* currentPointString = [pointStrings objectAtIndex:idx];
		NSArray* arr = [currentPointString componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"|"]];
		
		NSString *Title = [[NSString alloc] initWithFormat:@"%@",[arr objectAtIndex:1]];
		NSString *Description = [[NSString alloc] initWithFormat:@"%@", [arr objectAtIndex:3]];
		NSString *Free = [[NSString alloc] initWithFormat:@"%@", [arr objectAtIndex:5]];
		NSString *Subject = [[NSString alloc] initWithFormat:@"%@",[arr objectAtIndex:7]];
		NSString *M3u8 = [[NSString alloc] initWithFormat:@"%@",[arr objectAtIndex:9]];
		NSString *Sociallyfree = [[NSString alloc] initWithFormat:@"%@",[arr objectAtIndex:11]];
        //Reconfigure for apple approval
        //NSString *ProductID = [[NSString alloc] initWithFormat:@"%@",[arr objectAtIndex:13]];
		
         //if ([Show isEqualToString: @"1"]){
        
        ConfigObject *obj = [[ConfigObject alloc] init];
        obj.VideoTitle = Title;
        obj.VideoDescription = Description;
        if ([Free isEqualToString: @"1"]){
            obj.Free = YES;
        }
        else
        {
            obj.Free = NO; 
        }
        obj.Subject = Subject;
        obj.M3u8 = M3u8;
        
        if ([Sociallyfree isEqualToString: @"1"]){
            
            obj.SociallyFree = YES;
        }
        else
        {
            obj.SociallyFree = NO; 
        }

        obj.ProductID = @"English";
        //NSLog(@"Product is: %@",obj.ProductID);
        /*for (int i = 0; i < ProductsSubscibedTo.count; i++) {
            
            if ([obj.ProductID isEqualToString:[ProductsSubscibedTo objectAtIndex:i]]) {
                
                //NSLog(@"Product is: %@",obj.ProductID);
                obj.Subcribed = YES;
            }
        }*/
        
        [ArrayofConfigObjects addObject:obj];
        
        
       // NSLog(@"Title in my array is: %@",obj.VideoTitle);
				
		

	}
    filteredArrayofConfigObjects = [ArrayofConfigObjects mutableCopy];
}



- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
	
	int	count = 1;
	
	return count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 90;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
   
    NSInteger numberOfRows =[filteredArrayofConfigObjects count];
	
    return numberOfRows;
	
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    ListCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[ListCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    
    
    ConfigObject *obj = [filteredArrayofConfigObjects objectAtIndex:indexPath.row];
    //Change how image is loaded
    //NSString *PicLocation = [[NSString alloc] initWithFormat:@"%@",[obj Thumbnail]];
    //UIImage* theImage = [UIImage imageNamed:PicLocation];
    //UIImage* theImage =[ImageObjects objectAtIndex:indexPath.row];
    // Here i am picking up image randomly in which case i don't have to add any more images to bundle
    UIImage* theImage =[ImageObjects objectAtIndex:arc4random() % 69];
    cell.imageView.image = theImage;
    
    cell.textLabel.text = [obj VideoTitle];
    cell.textLabel.font = [UIFont fontWithName:@"Helvetica" size:12];
    cell.textLabel.lineBreakMode = UILineBreakModeWordWrap;
    cell.textLabel.numberOfLines = 0;
    // Is it free?
    if ([obj Free] == YES){
        
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        NSString* descriptiontxt = [obj VideoDescription];
        NSString* FullDesciption = [descriptiontxt stringByAppendingString:@" - Free view"];
        cell.detailTextLabel.text =FullDesciption;
        cell.detailTextLabel.textColor = [UIColor blueColor];
        cell.detailTextLabel.font = [UIFont fontWithName:@"Helvetica" size:10];
        cell.detailTextLabel.lineBreakMode = UILineBreakModeWordWrap;
        cell.detailTextLabel.numberOfLines = 0;
        
    }
    else if ([obj SociallyFree] == YES){
        
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        NSString* descriptiontxt = [obj VideoDescription];
        NSString* FullDesciption = @"";
        // Check if we are in full subscription if so Change text to paid
        if(FullSubscription == TRUE){
            FullDesciption = [descriptiontxt stringByAppendingString:@" - Subscription Paid"];
        }
        else {
            FullDesciption = [descriptiontxt stringByAppendingString:@" - Free gift if you share"];
        }
        
        cell.detailTextLabel.text =FullDesciption;
        cell.detailTextLabel.textColor = [UIColor blueColor];
        cell.detailTextLabel.font = [UIFont systemFontOfSize:10];
        cell.detailTextLabel.font = [UIFont fontWithName:@"Helvetica" size:10];
        cell.detailTextLabel.lineBreakMode = UILineBreakModeWordWrap;
        cell.detailTextLabel.numberOfLines = 0;
    }
    
    
    // Is user Subscribed?
    else if([obj Subcribed] == YES || FullSubscription == TRUE){
        
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        NSString* descriptiontxt = [obj VideoDescription];
        NSString* FullDesciption = [descriptiontxt stringByAppendingString:@" - Subscription Paid"];
        cell.detailTextLabel.text =FullDesciption;
        cell.detailTextLabel.textColor = [UIColor blueColor];
        cell.detailTextLabel.font = [UIFont fontWithName:@"Helvetica" size:10];
        cell.detailTextLabel.lineBreakMode = UILineBreakModeWordWrap;
        cell.detailTextLabel.numberOfLines = 0;
    }
    // Sorry mate you have to buy
    else
    {
        
        cell.accessoryType =  UITableViewCellAccessoryNone;
        NSString* descriptiontxt = [obj VideoDescription];
        NSString* FullDesciption = [descriptiontxt stringByAppendingString:@" - Subscribe"];
        cell.detailTextLabel.text = FullDesciption;
        cell.detailTextLabel.textColor = [UIColor redColor];
        cell.detailTextLabel.font = [UIFont fontWithName:@"Helvetica" size:10];
        cell.detailTextLabel.lineBreakMode = UILineBreakModeWordWrap;
        cell.detailTextLabel.numberOfLines = 0;
    }
    
    
    
	
	
    return cell;
	
}



- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return NO;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    ConfigObject *obj = [filteredArrayofConfigObjects objectAtIndex:indexPath.row];
    
    if ([obj Free] == YES || [obj Subcribed] == YES || FullSubscription == TRUE) {
        
    VideoPlayer *VP1 = [[VideoPlayer alloc] initWithNibName:nil bundle:nil];
    VP1.FreeView = self;
    VP1.VideoFileName =[NSString stringWithString:[obj M3u8]];
    [self.navigationController pushViewController:VP1 animated:YES];
    }
    
    else if ([obj SociallyFree] == YES){
        // Have you shared if so view video
        NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
        if([[prefs objectForKey:@"AddOneFree"] isEqualToString:@"1"]){
            
            VideoPlayer *VP1 = [[VideoPlayer alloc] initWithNibName:nil bundle:nil];
            VP1.FreeView = self;
            VP1.VideoFileName =[NSString stringWithString:[obj M3u8]];
            [self.navigationController pushViewController:VP1 animated:YES];
            
        }
        
        else {
            
            UIAlertView *alertView = [[UIAlertView alloc] 
                                      initWithTitle:@"Sorry"                                                             
                                      message:@"You can only view this video for free if you share"                                                          
                                      delegate:self                                              
                                      cancelButtonTitle:@"OK"                                                   
                                      otherButtonTitles:nil];
            [alertView show];
            
            return;
            
        }
        
    }

    else{
        // To store for buying
        //NSLog(@"my product id is %@",[obj ProductID]);
               
        [self ConfigureProductList:[obj ProductID]];
        
        Buy *buyer = [[Buy alloc ]initWithNibName:nil bundle:nil];
        buyer.ProductsToIstore = ProductIDs;
        //NSLog(@"%@",ProductIDs);
        [self.navigationController pushViewController:buyer animated:YES];
        
        
        
    }
         


}

-(void)ConfigureProductList:(NSString *)ProductID{
    
    ProductIDs = [[NSMutableArray alloc] init];
    
    NSString* OneMonth = [ProductID stringByAppendingString:@"iPhone1month"];
    [ProductIDs addObject:OneMonth];
    
    NSString* ThreeMonths = [ProductID stringByAppendingString:@"iPhone3months"];
    [ProductIDs addObject:ThreeMonths];
    
    NSString* SixMonths = [ProductID stringByAppendingString:@"iPhone6months"];
    [ProductIDs addObject:SixMonths];
    
    NSString* NineMonths = [ProductID stringByAppendingString:@"iPhone9months"];
    [ProductIDs addObject:NineMonths];
    
    NSString* TwelveMonths = [ProductID stringByAppendingString:@"iPhone12months"];
    [ProductIDs addObject:TwelveMonths]; 
    
    

    
    
    
    
    
}

// For ios 6
-(NSUInteger)supportedInterfaceOrientations{
    
    
    return UIInterfaceOrientationMaskPortrait;
    
    
}

// for ios 5
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    
    return  (interfaceOrientation == UIInterfaceOrientationPortrait);
	
}




-(IBAction)ReportProblem:(id)sender{
	
	if ([MFMailComposeViewController canSendMail]) {
        
        NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
        NSString *DeviceID = [prefs stringForKey:@"LCUIID"];
        
        NSArray *SendTo = [NSArray arrayWithObjects:@"support@LearnersCloud.com",nil];
        
        MFMailComposeViewController *SendMailcontroller = [[MFMailComposeViewController alloc]init];
        SendMailcontroller.mailComposeDelegate = self;
        [SendMailcontroller setToRecipients:SendTo];
        [SendMailcontroller setSubject:[NSString stringWithFormat:@"%@ English video streaming iPhone",DeviceID]];
        
        [SendMailcontroller setMessageBody:[NSString stringWithFormat:@"Add message here "] isHTML:NO];
        [self presentModalViewController:SendMailcontroller animated:YES];
        
		
	}
	
	else {
		UIAlertView *Alert = [[UIAlertView alloc] initWithTitle: @"Cannot send mail" 
                                                        message: @"Device is unable to send email in its current state. Configure email" delegate: self 
                                              cancelButtonTitle: @"Ok" otherButtonTitles: nil];
		
		
		
		[Alert show];
		
		
	}
    
    // This is to fix a problem on Iphone. Status bar is going on top of the navigationcontroller.
    
    [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationFade];	
}


- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error{
	
	
	[self becomeFirstResponder];
	[self dismissModalViewControllerAnimated:YES];
	
	
	
	
}

- (void)alertView:(UIAlertView *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    if (buttonIndex == 1){
        
        [self reviewPressed];
        
    }
    
    else {
        NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
        NSString *ReviewID = [prefs stringForKey:@"Review"];
        NSInteger Counter = [ReviewID integerValue];
        NSInteger CounterPlus = Counter + 1;
        NSString *ID = [NSString stringWithFormat:@"%d",CounterPlus];
        [prefs setObject:ID  forKey:@"Review"];
        [prefs synchronize];
        
    }
    
    

    
}

- (void)reviewPressed {
    
    //Set user has reviewed.
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    NSString *ID = @"1";
    [prefs setObject:ID forKey:@"IHaveLeftReview"];
    
    [prefs synchronize];
    
    // Report to  analytics
    NSError *error;
    if (![[GANTracker sharedTracker] trackEvent:@"User Sent to Review English Videos iPhone at app store"
                                         action:@"User Sent to Review English Videos iPhone at app store"
                                          label:@"User Sent to Review English Videos iPhone at app store"
                                          value:1
                                      withError:&error]) {
        NSLog(@"error in trackEvent");
    }
    
    
    NSString *str = @"https://userpub.itunes.apple.com/WebObjects/MZUserPublishing.woa/wa/addUserReview?id=535073858&type=Purple+Software"; 
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
}


- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar{
    
    mySearchBar.showsCancelButton = YES;
    mySearchBar.autocorrectionType = UITextAutocorrectionTypeNo;
    
    //empty previous search results
    [filteredArrayofConfigObjects removeAllObjects];
    [self.tableView reloadData];
}
- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar{
    mySearchBar.showsCancelButton = NO;
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    
    //empty previous search results
    [filteredArrayofConfigObjects removeAllObjects];
    
    if([searchText isEqualToString:@""] || searchText==nil){
        //show original dataset records
        filteredArrayofConfigObjects = [ArrayofConfigObjects mutableCopy];
        [self.tableView reloadData];
    }
    
    else {
        
        for(ConfigObject *obj in ArrayofConfigObjects){
            
            NSRange foundInTitle = [[obj.VideoTitle lowercaseString] rangeOfString:[searchText lowercaseString]];
            
            if(foundInTitle.location != NSNotFound){
                
                [filteredArrayofConfigObjects addObject:obj];
                
            }else {
                
                NSRange foundInDescrption = [[obj.VideoDescription lowercaseString] rangeOfString:[searchText lowercaseString]];
                
                if(foundInDescrption.location != NSNotFound){
                    
                    [filteredArrayofConfigObjects addObject:obj];
                }
            }
        }
        
        [self.tableView reloadData];
        
    }
    
    
}
- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar{
    
    [filteredArrayofConfigObjects removeAllObjects];
    filteredArrayofConfigObjects = [ArrayofConfigObjects mutableCopy];
    [self.tableView reloadData];
    [searchBar resignFirstResponder];
    searchBar.text = @"";
    
}
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    [searchBar resignFirstResponder];
}







- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}
-(void) dealloc {
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
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

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


@end
