//
//  CustomStoreObserver.m
//  EvaluatorForIPad
//
//  Created by Joseph caxton-Idowu on 20/02/2011.
//  Copyright 2011 caxtonidowu. All rights reserved.
//

#import "CustomStoreObserver.h"



@implementation CustomStoreObserver

@synthesize AlertTitle,EmailAddress,Password,MyDeviceId,ProductID,FinalProductID,SubscriptionInDays,TransactionID,EncodedReceipt,VerificationAppID,textField;

- (id) init

{
	
	if(self = [super init])
		
	{
		
		[ [SKPaymentQueue defaultQueue] addTransactionObserver: self];
		
	}
	
	return self;
	
}

- (void)paymentQueue:(SKPaymentQueue *)queue updatedTransactions:(NSArray *)transactions
{
	AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
	
	for (SKPaymentTransaction *transaction in transactions)
	{
		switch (transaction.transactionState)
		{
			case SKPaymentTransactionStatePurchased:{
				[self completeTransaction:transaction];
				[appDelegate.buyScreen viewWillAppear:YES];
				[(UIActivityIndicatorView *)[appDelegate.buyScreen navigationItem].rightBarButtonItem.customView stopAnimating];
				
				break;
            }
			case SKPaymentTransactionStateFailed:{
				[self failedTransaction:transaction];
				[appDelegate.buyScreen viewWillAppear:YES];
				[(UIActivityIndicatorView *)[appDelegate.buyScreen navigationItem].rightBarButtonItem.customView stopAnimating];
				break;
            }
			case SKPaymentTransactionStateRestored:{
				[self restoreTransaction:transaction];
				[appDelegate.buyScreen viewWillAppear:YES];
				[(UIActivityIndicatorView *)[appDelegate.buyScreen navigationItem].rightBarButtonItem.customView stopAnimating];
				break;
            }
			default:
				break;
		}
	}
}

- (void) failedTransaction: (SKPaymentTransaction *)transaction
{
	if (transaction.error.code != SKErrorPaymentCancelled)
	{
		UIAlertView *PaymentError = [[UIAlertView alloc] initWithTitle: @"Error On Payment" 
															message: @"There has been an error completing your payment transaction, please try again" delegate: self 
												  cancelButtonTitle: @"Ok" otherButtonTitles: nil];
		
		
		
		[PaymentError show];
		
				
	}
	[[SKPaymentQueue defaultQueue] finishTransaction: transaction];
}

- (void) restoreTransaction: (SKPaymentTransaction *)transaction
{
	//Non-renewing subscriptions and consumable products are not automatically restored by Store Kit
    // So is i need to implement my own restore.
	// [self recordTransaction: transaction];
	
	//Provide the new content
	 //[self provideContent: transaction.originalTransaction.payment.productIdentifier];
	
	//Finish the transaction
	[[SKPaymentQueue defaultQueue] finishTransaction: transaction];
	
}

- (void) completeTransaction: (SKPaymentTransaction *)transaction
{
	//If you want to save the transaction
	// [self recordTransaction: transaction];
	
	//Provide the new content
    [self recordTransaction:transaction];
	//[self provideContent: transaction.payment.productIdentifier];
	
	[[SKPaymentQueue defaultQueue] finishTransaction: transaction];
	
}

-(void)recordTransaction:(SKPaymentTransaction *)transaction{
    
    NSData *Receipt = transaction.transactionReceipt;
    
   // NSString *receiptDataString = [[NSString alloc] initWithData:Receipt 
                                                       // encoding:NSASCIIStringEncoding];
    //Unique Device ID
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    MyDeviceId = [prefs stringForKey:@"LCUIID"];
    // Subscipion in Days
   AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
   ProductID = [[NSString alloc] initWithString: appDelegate.SelectProductID];
   SubscriptionInDays = [[NSString alloc] initWithString:[self WorkOutSubsriptionInDays:ProductID]];
    //Prodcut ID -- Note we have to return the Product ID as it is in the database... without 1month or 7days string
    
    FinalProductID = ProductID ;
    
    //NSLog(@"%@",FinalProductID);    
    //ProductID = [[NSString alloc] initWithString: appDelegate.SelectProductID];
    
    
    //Transaction ID
    TransactionID =[[NSString alloc] initWithString:transaction.transactionIdentifier];
    //Encoded Receipt
    // Now apple has added an equal sign to the end of the receipt lets remove it, Update now i can see 2 equal signs so change code
    NSString *TempReceipt = [[NSString alloc]initWithString:[self Base64Encode:Receipt]];
    //NSLog(@"%@",TempReceipt);
    EncodedReceipt =[TempReceipt stringByReplacingOccurrencesOfString:@"=" withString:@""];
    //EncodedReceipt = [TempReceipt substringWithRange:NSMakeRange(0, [TempReceipt length]-1)];
    //NSLog(@"%@",EncodedReceipt);
    
    //NSLog(@"%@",appDelegate.DoesUserHaveEmail);
    if(appDelegate.DoesUserHaveEmail == FALSE){
        
        [self AskForUserEmailAndPassword];
        
    }
    else {
        [self SendToLearnersCloud];
        
    }
        
    //NSString* json = [NSString stringWithFormat:@"{\"receipt-data\" : \"%@\" }", EncodedReceipt];
    
   // NSURL *url = [NSURL URLWithString:@"https://sandbox.itunes.apple.com/verifyReceipt"];
    //NSMutableURLRequest *request= [[NSMutableURLRequest alloc] init];
    //[request setURL:url];
    //[request setHTTPMethod:@"POST"];
    //[request setHTTPBody:[json dataUsingEncoding:NSUTF8StringEncoding]];
     
    // NSData *returnData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
     //NSString *returnString = [[NSString alloc] initWithData:returnData encoding:NSUTF8StringEncoding];
     //NSLog(@"%@",returnString);
     //NSLog(@"%@",json);


        
    
    
}

-(NSString *)WorkOutSubsriptionInDays:(NSString*)theProductID{
    // Only 1 month to 1 Year subscription supported
    
    if ([[theProductID lowercaseString] isEqualToString:@"englishiphone1week"] ){
        
        return @"7";
        
    }
    
    
    else if ([[theProductID lowercaseString] isEqualToString:@"englishiphone1month"] ){
        
        return @"31";
        
    }
    
    else if ([[theProductID lowercaseString] isEqualToString:@"englishiphone3months"] ){
        
        return @"93";
        
    }
    else if ([[theProductID lowercaseString] isEqualToString:@"englishiphone6months"] ){
        
        return @"186";
        
    }
    
    else if ([[theProductID lowercaseString] isEqualToString:@"englishiphone9months"] ){
        
        return @"279";
        
    }
    else if ([[theProductID lowercaseString] isEqualToString:@"englishiphone12months"] ){
        
        return @"372";
        
    }
    
    else {
        return @"Error";
    }
    
        
    
}
-(void)AskForUserEmailAndPassword{
    
    if(EmailAddress != nil){
        
        
         
        AlertTitle = @"The email address you entered is not in the right format or password is empty. Try again?";
        
    } 
    else
    {
    
   AlertTitle = @"If you need to restore your subscriptions on another device, you will need to provide an email address and a password. Do you want to enter email address and a password?";
    }
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:AlertTitle message:@"\n" delegate:self cancelButtonTitle:@"No" otherButtonTitles:@"Yes", nil];
    alertView.tag = 1212;
    [alertView show];
    

}

-(void)GetUsernameAndPassword{
    //@"If you need to restore your subscriptions on another device, please provide your email address and a password"
    
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Registration"
                                                        message:[NSString stringWithFormat:@"Enter details"]
                                                       delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Done",nil];
    
    [alertView setAlertViewStyle:UIAlertViewStyleLoginAndPasswordInput];
    [alertView show];
    
    UITextField *utextfield = [alertView textFieldAtIndex:0];
    utextfield.placeholder = @"EmailAddress";
    utextfield.tag = 1717;
    utextfield.enablesReturnKeyAutomatically = NO;
    [utextfield setKeyboardType:UIKeyboardTypeEmailAddress];
    [utextfield setDelegate:self];
    
    UITextField	*ptextfield = [alertView textFieldAtIndex:1];
    ptextfield.placeholder = @"Password";
    ptextfield.tag = 1818;
    ptextfield.enablesReturnKeyAutomatically = NO;
    [ptextfield setDelegate:self];
    
    alertView.tag = 1313;
    

   /* NSString *myTitle = @"Enter your details";
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:myTitle message:@"\n \n \n \n" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"OK", nil];

    	
    UITextField *utextfield = [[UITextField alloc] initWithFrame:CGRectMake(12.0, 60.0, 260.0, 30.0)];
    utextfield.placeholder = @"EmailAddress";
    utextfield.tag = 1717;
    [utextfield setBackgroundColor:[UIColor whiteColor]];
    utextfield.enablesReturnKeyAutomatically = YES;
    [utextfield setReturnKeyType:UIReturnKeyDone];
    [utextfield setDelegate:self];
    [alertView addSubview:utextfield];
        
    	// Adds a password Field
    UITextField	*ptextfield = [[UITextField alloc] initWithFrame:CGRectMake(12.0, 95.0, 260.0, 30.0)];
    ptextfield.placeholder = @"Password";
    ptextfield.tag = 1818;
    [ptextfield setSecureTextEntry:YES];
    ptextfield.enablesReturnKeyAutomatically = YES;
    [ptextfield setBackgroundColor:[UIColor whiteColor]];
    [ptextfield setReturnKeyType:UIReturnKeyDone];
    [ptextfield setDelegate:self];   
    [alertView addSubview:ptextfield];
    
    alertView.tag = 1313; */

    	 
    	// Move a little to show up the keyboard
    	//CGAffineTransform transform = CGAffineTransformMakeTranslation(00.0, 00.0);
    	//[alertView setTransform:transform];
    	 
    	// Show alert on screen.
    	[alertView show];
       
       // CGRect frame = alertView.frame;

    	//alertView.frame = CGRectMake( 0, 60, 400, 300 );
//        frame.origin.y -= 100.0f;
//        frame.size.height += 50.0f;
//       alertView.frame = frame;
//

    
}

- (void)alertView:(UIAlertView *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    // the user clicked one of the OK/Cancel buttons
   
    
    if (actionSheet.tag == 1212){
        if (buttonIndex == 1) 
        {
            [self GetUsernameAndPassword];
            
        }
        else
        {
            [self SendToLearnersCloud];
        }
    }
    else if (actionSheet.tag == 1313){
        
        if (buttonIndex == 1)
        {
            // Update Username and password in Database
            for (UIView* view in actionSheet.subviews)
            {
                if ([view isKindOfClass:[UITextField class]])
                {
                    textField = (UITextField*)view;
                    int TaggedAs = textField.tag;
                    if (TaggedAs == 1717) {
                        EmailAddress = [[NSString alloc] initWithString: textField.text == nil ? @"" : textField.text];
                        [textField resignFirstResponder];
                    }
                    else
                    {
                        Password = [[NSString alloc]initWithString:textField.text == nil ? @"" : textField.text];
                        [textField resignFirstResponder];
                    }
                    
                   // break;
                }
            }

            
            
            NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"; 
            NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",emailRegex];
            BOOL notAValidEmail = ![emailTest evaluateWithObject:EmailAddress];
            
            if (notAValidEmail || [Password length] == 0) {
               [self AskForUserEmailAndPassword];
            }
            else
            {
                // Updated database with email address and password;
               [self SendToLearnersCloud];   
            }
            
        }
        else
        {
            //NSLog(@"cancel"); Do nothing
           [self SendToLearnersCloud];
        }

        
    }
    else if(actionSheet.tag == 4444){
        
        // Reload Subsciptions from server.
        AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
        NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
        NSString *DeviceID = [prefs stringForKey:@"LCUIID"];
        [appDelegate SubscriptionStatus: DeviceID];
        
        // End of trasaction by poping the buy screeen nav
        //AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
        [appDelegate.buyScreen.navigationController popViewControllerAnimated:YES]; 
        
    }
}

- (BOOL)textFieldShouldEndEditing:(UITextView *)textView{
   
    if(textView.tag == 1717){
        if(textView.text.length > 0 ){
        //EmailAddress = [[NSString alloc] initWithString: textView.text];
        [textView resignFirstResponder];
        return true;
        }
        else
        {
         return false;
        [textView resignFirstResponder];
        return true;
        }
        
    }
    
    else if(textView.tag == 1818){
          if(textView.text.length > 0 ){
        //Password = [[NSString alloc]initWithString: textView.text];
        [textView resignFirstResponder];
        return true;
          }
          else
          {
              return true;
          }
        }
    else
    {
        return false;
    }
}


-(void)SendToLearnersCloud{
   
    if (EmailAddress == nil || Password == nil){
       
        EmailAddress = @"";
        Password = @"";
    }
        
             
        AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
        NSString *domain = appDelegate.DomainName;
        
        
        NSString *queryString = [NSString stringWithFormat:@"%@/Services/iOS/VideoSubscription.asmx/VerifySubscription",domain];
                        
   
    
    NSURL *url = [NSURL URLWithString:queryString];
    NSMutableURLRequest *req = [NSMutableURLRequest requestWithURL:url];
    
    VerificationAppID = @"4"; //English iPhone
    
    NSString *FullString = [NSString stringWithFormat:@"productIdentifier=%@&DeviceID=%@&days=%@&transactionIdentifier=%@&B64receipt=%@&email=%@&password=%@&AppID=%@",FinalProductID,MyDeviceId,SubscriptionInDays,TransactionID,EncodedReceipt,EmailAddress,Password,VerificationAppID];
    
    /*NSString * encodedString = (__bridge_transfer NSString *)CFURLCreateStringByAddingPercentEscapes(
                                                                                       NULL,
                                                                                       (__bridge_retained  CFStringRef)FullString,
                                                                                       NULL,
                                                                                       (CFStringRef)@"!*'();:@&=+$,/?%#[]",
                                                                                       kCFStringEncodingUTF8 ); */
         
       // NSLog(@"%@",encodedString);
       // NSLog(@"%@",FullString);
        
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
   
     0  all OK
    >0 Apple code
    <0 Our code
    -2 Failed to pre-record
    -3 Failed to parse apple's response
    -4 Failed to post-record
    -5 Exception communicating with apple's server
    -1 anything else - see see server log file */
    
    NSString *returnedString = [[NSString alloc] initWithData:someData encoding:NSUTF8StringEncoding];
    //NSLog(@"%@",returnedString);
    
    [self ParseReturnVal:returnedString];
    
    
    
}

-(void)ParseReturnVal:(NSString *)value {
    
    NSData *xmlData = [value dataUsingEncoding:NSUTF8StringEncoding];
    NSXMLParser *parser = [[NSXMLParser alloc] initWithData:xmlData];
    [parser setDelegate:self];
    [parser parse];


}
- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qualifiedName attributes:(NSDictionary *)attributeDict {
    
   /* if ([elementName isEqualToString:@"int"]) {
        
        int Returnid = [[attributeDict valueForKey:@"int"] intValue];
        
            if (Returnid == 0) {
    
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Successful" message:@"Transaction was successful" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
                alertView.tag = 4444;
                [alertView show];
            }
            else if (Returnid > 0){
                        
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Not successful" message:@"There has been an error from apple, please try again" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
                alertView.tag = 4444;
                [alertView show];
            }
            else if (Returnid < 0){
                
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Not successful" message:@"There has been an error from LearnersCloud, please try again" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
                alertView.tag = 4444;
                [alertView show];
                
            }
        
        } */
    }

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
    
    NSString *CleanString = [string stringByTrimmingCharactersInSet:
                             [NSCharacterSet whitespaceAndNewlineCharacterSet]];
    if([CleanString isEqualToString:@""]){
        
        //Do nothing
        return;
        
    }
    
    int Returnid = [string intValue];
    
    if (Returnid == 0) {
        
        
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Successful" message:@"Transaction was successful" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        alertView.tag = 4444;
        [alertView show];
    }
    else if (Returnid > 0){
        
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Not successful" message:@"There has been an error from apple, please try again" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        alertView.tag = 4444;
        [alertView show];
    }
    else if (Returnid < 0){
        
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Not successful" message:@"There has been an error from LearnersCloud, please try again" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        alertView.tag = 4444;
        [alertView show];
        
    }

    
}


-(void) provideContent:(NSString *)productIdentifier{
	
				
}


-(NSString *)Base64Encode:(NSData *)data{
    //Point to start of the data and set buffer sizes
    int inLength = [data length];
    int outLength = ((((inLength * 4)/3)/4)*4) + (((inLength * 4)/3)%4 ? 4 : 0);
    const char *inputBuffer = [data bytes];
    char *outputBuffer = malloc(outLength);
    outputBuffer[outLength] = 0;
    
    //64 digit code
    static char Encode[] = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/";
    
    //start the count
    int cycle = 0;
    int inpos = 0;
    int outpos = 0;
    char temp;
    
    //Pad the last to bytes, the outbuffer must always be a multiple of 4
    outputBuffer[outLength-1] = '=';
    outputBuffer[outLength-2] = '=';
    
    
    
    while (inpos < inLength){
        switch (cycle) {
            case 0:
                outputBuffer[outpos++] = Encode[(inputBuffer[inpos]&0xFC)>>2];
                cycle = 1;
                break;
            case 1:
                temp = (inputBuffer[inpos++]&0x03)<<4;
                outputBuffer[outpos] = Encode[temp];
                cycle = 2;
                break;
            case 2:
                outputBuffer[outpos++] = Encode[temp|(inputBuffer[inpos]&0xF0)>> 4];
                temp = (inputBuffer[inpos++]&0x0F)<<2;
                outputBuffer[outpos] = Encode[temp];
                cycle = 3;                  
                break;
            case 3:
                outputBuffer[outpos++] = Encode[temp|(inputBuffer[inpos]&0xC0)>>6];
                cycle = 4;
                break;
            case 4:
                outputBuffer[outpos++] = Encode[inputBuffer[inpos++]&0x3f];
                cycle = 0;
                break;                          
            default:
                cycle = 0;
                break;
        }
    }
    NSString *pictemp = [NSString stringWithUTF8String:outputBuffer];
    free(outputBuffer); 
    return pictemp;

}
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    
    
    return YES;
    
}

	
- (void) dealloc

{
	
	[ [SKPaymentQueue defaultQueue] removeTransactionObserver: self];
	
		
}

@end
