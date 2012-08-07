//
//  CustomStoreObserver.h
//  EvaluatorForIPad
//
//  Created by Joseph caxton-Idowu on 20/02/2011.
//  Copyright 2011 caxtonidowu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <StoreKit/StoreKit.h>
#import "AppDelegate.h"


@interface CustomStoreObserver  : NSObject<SKPaymentTransactionObserver,UITextFieldDelegate,UIAlertViewDelegate,NSXMLParserDelegate>{
    
    NSString *AlertTitle;
    NSString *EmailAddress;
    NSString *Password;
    
    NSString *MyDeviceId;
    NSString *ProductID;
    NSString *FinalProductID;
    NSString *SubscriptionInDays;
    NSString *TransactionID;
    NSString *EncodedReceipt;
    NSString *VerificationAppID;
    UITextField* textField;
    

}


@property (nonatomic, retain)  NSString *AlertTitle;
@property (nonatomic, retain) NSString *EmailAddress;
@property (nonatomic, retain) NSString *Password;

@property (nonatomic, retain) NSString *MyDeviceId;
@property (nonatomic, retain) NSString *ProductID;
@property (nonatomic, retain) NSString *FinalProductID;
@property (nonatomic, retain) NSString *SubscriptionInDays;
@property (nonatomic, retain)  NSString *TransactionID;
@property (nonatomic, retain)  NSString *EncodedReceipt;
@property (nonatomic, retain)  NSString *VerificationAppID;
@property (nonatomic, retain)  UITextField* textField;


- (void)paymentQueue:(SKPaymentQueue *)queue updatedTransactions:(NSArray *)transactions;
- (void) failedTransaction: (SKPaymentTransaction *)transaction;
- (void) restoreTransaction: (SKPaymentTransaction *)transaction;
- (void) completeTransaction: (SKPaymentTransaction *)transaction;
-(void)recordTransaction:(SKPaymentTransaction *)transaction;

-(void) provideContent:(NSString *)productIdentifier;
-(NSString *)Base64Encode:(NSData *)data;
-(NSString *)WorkOutSubsriptionInDays:(NSString*)theProductID;
-(void)AskForUserEmailAndPassword;
-(void)GetUsernameAndPassword;
-(void)SendToLearnersCloud;
-(void)ParseReturnVal:(NSString *)value;

@end
