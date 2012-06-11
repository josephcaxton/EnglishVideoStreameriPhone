//
//  Buy.h
//  EvaluatorForIPad
//
//  Created by Joseph caxton-Idowu on 15/02/2011.
//  Copyright 2011 caxtonidowu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import <StoreKit/StoreKit.h>
#import "AppDelegate.h"
#import "CustomStoreObserver.h"
#import "AppDelegate.h"


@interface Buy : UITableViewController <SKProductsRequestDelegate>{

	
	NSArray *ProductFromIstore;
	NSMutableArray *ProductsToIstore;
	NSArray *ProductsToIStoreInArray;
	NSArray *SortedDisplayProducts;
	CustomStoreObserver *observer;
}

@property (nonatomic, retain) NSArray *ProductFromIstore;
@property (nonatomic, retain) NSMutableArray *ProductsToIstore;
@property (nonatomic, retain) NSArray *ProductsToIStoreInArray;
@property (nonatomic, retain) NSArray *SortedDisplayProducts;
@property (nonatomic, retain) CustomStoreObserver *observer;

- (void)AddProgress;
- (BOOL)isDataSourceAvailable;
- (void) requestProductData;

@end
