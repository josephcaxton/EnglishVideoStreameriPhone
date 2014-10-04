//
//  LearnersCloudSamplesVideos.m
//  VideoStreamer
//
//  Created by Joseph caxton-Idowu on 13/03/2012.
//  Copyright (c) 2012 caxtonidowu. All rights reserved.
//

#import "LearnersCloudSamplesVideos.h"
#import "TrailerPlayer.h"


@implementation LearnersCloudSamplesVideos

@synthesize listofItems,ImageNames,LCButton,FirstTable,FirstViewframe,PromoImageView;
#define SCREEN_WIDTH  320
#define SCREEN_HEIGHT 470
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)




- (void)viewDidLoad {
    [super viewDidLoad];
	
    self.navigationItem.title = @"GCSE Sample Videos";
    
    
    NSString *HeaderLocation = [[NSBundle mainBundle] pathForResource:@"header_bar" ofType:@"png"];
    UIImage *HeaderBackImage = [[UIImage alloc] initWithContentsOfFile:HeaderLocation];
    [self.navigationController.navigationBar setBackgroundImage:HeaderBackImage forBarMetrics:UIBarMetricsDefault];
    
    
    NSString *BackImagePath = [[NSBundle mainBundle] pathForResource:@"back320x450" ofType:@"png"];
	UIImage *BackImage = [[UIImage alloc] initWithContentsOfFile:BackImagePath];
    self.view.backgroundColor = [UIColor colorWithPatternImage:BackImage];
    
    
	
    
    
	listofItems = [[NSMutableArray alloc] init];
	ImageNames = [[NSMutableArray alloc] init];
	// Add items to the array this is hardcoded for now .. may need to be migrated to the database
	[listofItems addObject:@"   Maths - Trailer"];
	[ImageNames addObject:@"Maths.png"];
	[listofItems addObject:@"   English - Trailer"];
	[ImageNames addObject:@"English.png"];
	[listofItems addObject:@"   Physics - Trailer"];
	[ImageNames addObject:@"Physics.png"];
	[listofItems addObject:@"   Chemistry - Trailer"];
	[ImageNames addObject:@"Chemistry.png"];
    [listofItems addObject:@"    Biology - Trailer"];
    [ImageNames addObject:@"Biology.png"];
    [listofItems addObject:@"    Hear from Students"];
    [ImageNames addObject:@"Testimonial.png"];
    //	[listofItems addObject:@"The Ruined Maid"];
    //	[ImageNames addObject:@"Ruined_maid.png"];
    //	[listofItems addObject:@"Les Grand Seigneurs"];
    //	[ImageNames addObject:@"LesGrandSeignors.png"];
    //	[listofItems addObject:@"Horse Whisperer"];
    //	[ImageNames addObject:@"HorseWhisperer.png"];
    //	[listofItems addObject:@"Hunchback in the Park"];
    //	[ImageNames addObject:@"Hunchback.png"];
    //	[listofItems addObject:@"The Clown Punk"];
    //	[ImageNames addObject:@"ClownPunk.png"];
    //	[listofItems addObject:@"Concave Convex Rap"];
    //	[ImageNames addObject:@"Convexrap.png"];
    
    FirstViewframe = CGRectMake(0 ,0, SCREEN_WIDTH, SCREEN_HEIGHT);
    self.FirstTable = [[UITableView alloc] initWithFrame:FirstViewframe style:UITableViewStyleGrouped];
    FirstTable.delegate = self;
	FirstTable.dataSource = self;
    FirstTable.backgroundColor = [UIColor clearColor];
    FirstTable.backgroundView = nil;
    [self.view addSubview:FirstTable];
    
	
	
	
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
	
	[self willAnimateRotationToInterfaceOrientation:self.interfaceOrientation duration:2];
	
}


#pragma mark -
#pragma mark Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 2;
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
	if (section == 0) {
		
		return [listofItems count];
	}
	else {
        
		return 1;
	}
    
    
    
	
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.section == 1 && indexPath.row == 0  ) {
        return  295;
    }
    
    else
        return 50;
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
	
    
	
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
    }
    
    if (indexPath.section == 0) {
		
        
        // Configure the cell...
        
        NSString *cellValue = [[NSString alloc] initWithFormat:@"%@",[listofItems objectAtIndex:indexPath.row]];
        NSString *PicLocation = [[NSString alloc] initWithFormat:@"%@",[ImageNames objectAtIndex:indexPath.row]];
        UILabel *Title = [[UILabel alloc] initWithFrame:CGRectMake(100.0,0.0,240,50)];
        Title.backgroundColor = [UIColor clearColor];
        Title.text = cellValue;
        [cell.contentView addSubview:Title];
        
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
        UIImage* theImage = [UIImage imageNamed:PicLocation];
        cell.imageView.image = theImage;
        
		
		
		
	}
	
	else if (indexPath.section == 1) {
        
        cell.backgroundView =  [[UIImageView alloc] initWithImage:[ [UIImage imageNamed:@"back320x450.png"] stretchableImageWithLeftCapWidth:0.0 topCapHeight:5.0]];
        
        UIView *PromoView = [[UIView alloc] init];
        NSString *PromoImagePath = [[NSBundle mainBundle] pathForResource:@"website_promo" ofType:@"png"];
        UIImage *PromoImage = [[UIImage alloc] initWithContentsOfFile:PromoImagePath];
        PromoImageView = [[UIImageView alloc] initWithImage:PromoImage];
        //To fix ios7 extending edges
        if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0")){
            
            PromoImageView.frame = CGRectMake(10, 10.0, 300, 250);
        }
        else{
            PromoImageView.frame = CGRectMake(0, 10.0, 300, 250);
        }

        [PromoView addSubview:PromoImageView];
        [cell.contentView addSubview:PromoView];
        
        
        cell.accessoryType = UITableViewCellAccessoryNone;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        
        
        ///// LC image
        
        NSString *LCImageLocation = [[NSBundle mainBundle] pathForResource:@"web_promo_btn" ofType:@"png"];
        
        UIImage *LCImage = [[UIImage alloc] initWithContentsOfFile:LCImageLocation];
        
        
        LCButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [LCButton setImage:LCImage forState:UIControlStateNormal];
        LCButton.frame = CGRectMake(35, 200, 250, 50);
        [LCButton addTarget:self action:@selector(WebsitebuttonPressed) forControlEvents:UIControlEventTouchUpInside];
        [cell.contentView addSubview:LCButton];
        
        
		
	}
    
	
    
	[self willAnimateRotationToInterfaceOrientation:self.interfaceOrientation duration:1];
	
	return cell;
	
}

#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    int index = indexPath.row;
    
    if (indexPath.section == 0) {
        
        switch (index) {
                
            case 0:
            {
                TrailerPlayer *VP1 = [[TrailerPlayer alloc] initWithNibName:nil bundle:nil];
                VP1.VideoFileName =@"MathsTtrailerv6";
                VP1.ServerLocation = @"https://www.learnerscloud.com/iosStreamv2/maths/";
                //VP1.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:VP1 animated:YES];
            }
                break;
                
            case 1:
            {
                TrailerPlayer *VP2 = [[TrailerPlayer	alloc] initWithNibName:nil bundle:nil];
                VP2.VideoFileName =@"EnglishTrailerv5";
                VP2.ServerLocation = @"https://www.learnerscloud.com/iosStreamv2/english/";
                //VP2.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:VP2 animated:YES];
            }
                break;
                
            case 2:
            {
                
               TrailerPlayer *VP3 = [[TrailerPlayer	alloc] initWithNibName:nil bundle:nil];
                VP3.VideoFileName =@"PhysicsTrailerV5";
                VP3.ServerLocation =@"https://www.learnerscloud.com/iosStreamv2/Physics/";
                //VP3.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:VP3 animated:YES];
            }
                break;
                
            case 3:
            {
                TrailerPlayer *VP4 = [[TrailerPlayer	alloc] initWithNibName:nil bundle:nil];
                VP4.VideoFileName =@"ChemistryPromoFINAL";
                VP4.ServerLocation = @"https://www.learnerscloud.com/iosStreamv2/Chemistry/";
                //VP4.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:VP4 animated:YES];
                
            }
                
                break;
                
            case 4:
            {
                TrailerPlayer *VP5 = [[TrailerPlayer	alloc] initWithNibName:nil bundle:nil];
                VP5.VideoFileName =@"BIO-Trailer";
                VP5.ServerLocation = @"https://www.learnerscloud.com/iosStreamv2/Biology/";
                //VP5.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:VP5 animated:YES];
            }
                
                
                
                break;
            case 5:
            {
                TrailerPlayer *VP6 = [[TrailerPlayer	alloc] initWithNibName:nil bundle:nil];
                VP6.VideoFileName =@"TESTIMONIALSTUDENTS";
                VP6.ServerLocation = @"https://www.learnerscloud.com/iosStreamv2/Trailers/";
                //VP6.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:VP6 animated:YES];
            }
                
                
                
                break;

                
        }
        
    }
}

- (void)WebsitebuttonPressed {
    
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString: @"http://www.learnerscloud.com"]];
    
}



- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Overriden to allow any orientation.
    return YES;
}

- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation duration:(NSTimeInterval)duration{
	
	    
	
    
}

#pragma mark -
#pragma mark Memory management


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

