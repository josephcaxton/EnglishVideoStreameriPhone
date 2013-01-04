//
//  Coverage.h
//  MathsiGCSEVideosiPad
//
//  Created by Joseph caxton-Idowu on 04/01/2013.
//  Copyright (c) 2013 caxtonidowu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Coverage : UIViewController <UITableViewDataSource, UITableViewDelegate>{
    
    NSMutableArray *listofItems;
    NSMutableArray *listofItemsFileNames;
    UITableView *FirstTable;
    CGRect FirstViewframe;
}

@property (nonatomic, retain) NSMutableArray *listofItems;
@property (nonatomic, retain) NSMutableArray *listofItemsFileNames;
@property (nonatomic, retain) UITableView *FirstTable;
@property (nonatomic, assign)  CGRect FirstViewframe;
@end
