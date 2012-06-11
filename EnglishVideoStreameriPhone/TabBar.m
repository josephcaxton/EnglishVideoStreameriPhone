    //
//  TabBar.m
//  Evaluator
//
//  Created by Joseph caxton-Idowu on 31/12/2010.
//  Copyright 2010 caxtonidowu. All rights reserved.
//

#import "TabBar.h"
#import "VideoPlayer.h"
//#import "AppDelegate.h"

@implementation TabBar

- (void)tabBar:(UITabBar *)theTabBar didSelectItem:(UITabBarItem *)item  {
	
	NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
	NSString *activetab = [def objectForKey:@"activeTab"];
	
	AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;

	
	
	if([item.title isEqualToString:@"Results"] &&  ![activetab isEqualToString:@"Results"]){ //||[item.title isEqualToString:@"Videos"]
		
		
		appDelegate.SecondThread = [[NSThread alloc]initWithTarget:self selector:@selector(ShowActivity) object:nil];
		[appDelegate.SecondThread start];
		
		
	}
	
	[def setValue:item.title forKey:@"activeTab"];
	[def synchronize];
	
	
}


- (void)ShowActivity {
	
	
	
	ActivityIndicator *indicator = [[ActivityIndicator alloc]initWithFrame:CGRectMake(0,0,1040,720)];
	indicator.tag = 1;
	[self.view addSubview:indicator];
	
	
	
}



- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations.
    
    // Allow Orientation of only vidoe Player.
    
    if(self.selectedIndex == 0 && [[[self.viewControllers objectAtIndex:0] visibleViewController] isKindOfClass:[VideoPlayer class]]){
        
        
        return YES;


    }
        
    else
            
        {
            return NO;
        }
}


- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
}


@end
