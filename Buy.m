//
//  Buy.m
//  EvaluatorForIPad
//
//  Created by Joseph caxton-Idowu on 15/02/2011.
//  Copyright 2011 caxtonidowu. All rights reserved.
//

#import "Buy.h"
#import <SystemConfiguration/SystemConfiguration.h>
#import <netinet/in.h>
#import "CustomCell.h"

@implementation Buy

@synthesize ProductFromIstore,ProductsToIstore,ProductsToIStoreInArray,SortedDisplayProducts,observer;

int dontShowPriceList = 0;
#pragma mark -
#pragma mark Initialization



#pragma mark -
#pragma mark View lifecycle


- (void)viewDidLoad {
    [super viewDidLoad];
	
		observer = [[CustomStoreObserver alloc] init];
		dontShowPriceList = 0;
		
    
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
	
	[self AddProgress] ;
	
	if ([SKPaymentQueue canMakePayments] == YES && [self isDataSourceAvailable] == YES){
		
        
		ProductsToIStoreInArray = ProductsToIstore;
        
//        for (int i = 0; i < 2; i++) {
//            NSLog(@"product is = %@", [ProductsToIStoreInArray objectAtIndex:i]);
//        }
		
		[self requestProductData];
		
    }
	
	else {
		
		UIAlertView *Alert = [[UIAlertView alloc] initWithTitle: @"Cannot use In App purchase" 
														message: @"In-App purchase has been disabled or internet connection is unavailable, please enable" delegate: self 
											  cancelButtonTitle: @"OK" otherButtonTitles: nil];
		
		[Alert show];
		
		
		
	}
	
	
	
}

- (void) requestProductData{
    
	[(UIActivityIndicatorView *)[self navigationItem].rightBarButtonItem.customView startAnimating];
	
	SKProductsRequest *request= [[SKProductsRequest alloc] initWithProductIdentifiers: [NSSet setWithArray:ProductsToIStoreInArray]];
	request.delegate = self;
	[request start];
   
}




- (void)AddProgress{
	
	
	UIActivityIndicatorView * activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
	[activityIndicator stopAnimating];
	[activityIndicator hidesWhenStopped];
	UIBarButtonItem * barButton = [[UIBarButtonItem alloc] initWithCustomView:activityIndicator];
	[self navigationItem].rightBarButtonItem = barButton;
	
	
	
	
}

- (BOOL)isDataSourceAvailable{
    static BOOL checkNetwork = YES;
	BOOL _isDataSourceAvailable;
    if (checkNetwork) { // Since checking the reachability of a host can be expensive, cache the result and perform the reachability check once.
		// checkNetwork = NO; don't cache
		
        Boolean success;    
        const char *host_name = "www.apple.com"; // my data source host name
		
        SCNetworkReachabilityRef reachability = SCNetworkReachabilityCreateWithName(NULL, host_name);
        SCNetworkReachabilityFlags flags;
        success = SCNetworkReachabilityGetFlags(reachability, &flags);
        _isDataSourceAvailable = success && (flags & kSCNetworkFlagsReachable) && !(flags & kSCNetworkFlagsConnectionRequired);
        CFRelease(reachability);
    }
    return _isDataSourceAvailable;
}

- (void)productsRequest:(SKProductsRequest *)request didReceiveResponse:(SKProductsResponse *)response{
	
	ProductFromIstore = response.products;
	
	
	
	NSSortDescriptor *sortDescriptor;
	sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"price"
												  ascending:YES];
	NSArray *sortDescriptors = [NSArray arrayWithObject:sortDescriptor];
	
	
	SortedDisplayProducts = [ProductFromIstore sortedArrayUsingDescriptors:sortDescriptors]; 
	

	[self.tableView reloadData];
	
	[(UIActivityIndicatorView *)[self navigationItem].rightBarButtonItem.customView stopAnimating];
	
}




/*
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}
*/
/*
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}
*/
/*
- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
}
*/


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Override to allow orientations other than the default portrait orientation.
    return YES;
}


#pragma mark -
#pragma mark Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
	
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
   
    return [SortedDisplayProducts count];
	
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{

    return 100;
}




- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    CustomCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[CustomCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
        cell.textLabel.lineBreakMode = UILineBreakModeTailTruncation;
        cell.textLabel.numberOfLines = 0;
        cell.textLabel.font = [UIFont fontWithName:@"Helvetica" size:12.0];
             

    }
    
	SKProduct *product = [SortedDisplayProducts objectAtIndex:indexPath.row];
	
	NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
	[numberFormatter setFormatterBehavior:NSNumberFormatterBehavior10_4];
	[numberFormatter setNumberStyle:NSNumberFormatterCurrencyStyle];
	[numberFormatter setLocale:product.priceLocale];
	
	UIButton *BuyNow = [UIButton buttonWithType:UIButtonTypeRoundedRect];  
	
	//[BuyNow setTitle:@""  forState:UIControlStateNormal];
	BuyNow.frame = CGRectMake(178, 30, 75, 44);
	BuyNow.tag = indexPath.row;
	[BuyNow addTarget:self action:@selector(BuyVideo:) forControlEvents:UIControlEventTouchUpInside];
	
	UIImage *buttonImageNormal = [UIImage imageNamed:@"buynow.jpeg"];
	//UIImage *strechableButtonImageNormal = [buttonImageNormal stretchableImageWithLeftCapWidth:0 topCapHeight:0];
	[BuyNow setBackgroundImage:buttonImageNormal forState:UIControlStateNormal];
	
	[cell.contentView addSubview:BuyNow];
	cell.selectionStyle = UITableViewCellSelectionStyleNone;
	cell.detailTextLabel.text = [numberFormatter stringFromNumber:product.price];
	cell.textLabel.text = [product localizedTitle];
	//NSLog(@"%@",[product localizedTitle]);


    
    return cell;
}


-(void) BuyVideo: (id)sender{
	
	[(UIActivityIndicatorView *)[self navigationItem].rightBarButtonItem.customView startAnimating];
	AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
	appDelegate.buyScreen = self;
    int myTag = [sender tag];
    
    SKProduct* SelectedProductid = [SortedDisplayProducts objectAtIndex:myTag];
    
    
    // Store Selected ProductID in Delegate
    appDelegate.SelectProductID = nil;
    appDelegate.SelectProductID = (NSString*)SelectedProductid.productIdentifier;
    
   
            
    SKPayment *payment = [SKPayment paymentWithProductIdentifier:SelectedProductid.productIdentifier];
            [[SKPaymentQueue defaultQueue] addPayment:payment];
           			
	
	
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/


/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source.
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }   
}
*/


/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/


/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Navigation logic may go here. Create and push another view controller.
    /*
    <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
    // ...
    // Pass the selected object to the new view controller.
    [self.navigationController pushViewController:detailViewController animated:YES];
    [detailViewController release];
	 */
}


#pragma mark -
#pragma mark Memory management

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Relinquish ownership any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
    // Relinquish ownership of anything that can be recreated in viewDidLoad or on demand.
    // For example: self.myOutlet = nil;
}



@end

