//
//  AdminDashBoard.m
//  VideoStreamer
//
//  Created by Joseph caxton-Idowu on 13/03/2012.
//  Copyright (c) 2012 caxtonidowu. All rights reserved.
//

#import "AdminDashBoard.h"
#import "AppDelegate.h"

@implementation AdminDashBoard

//@synthesize Files;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
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
- (void)viewDidLoad{
    [super viewDidLoad];
    
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    
    NSString *Dir = [appDelegate.applicationDocumentsDirectory stringByAppendingPathComponent:@"/videosToEncode"];
   
    
    NSArray *dirContents = [[NSFileManager defaultManager] directoryContentsAtPath:Dir];
    
    for (NSString *tString in dirContents) {
        
        
    }

    
} */
/*

// Simple export to ATV making sure original source movie is using clean aperture dimensions
-(OSStatus) ExportATVMovieToDesktop(Movie inMovie, Boolean inUseCleanApertureMode)
{
    MovieExportComponent theExportComponent = 0;
    
    Handle dataRef = NULL;;
    OSType dataRefType = 0;
    
    OSType savedApertureMode = kQTApertureMode_Classic;
    
    OSStatus status = paramErr;
    
    if (NULL == inMovie) return status;
    
    // create a data reference for the output file
    status = QTNewDataReferenceFromFullPathCFString(
                                                    CFSTR("/Volumes/MacOSX/Users/ed/Desktop/ATVMovie.m4v"),
                                                    kQTNativeDefaultPathStyle,
                                                    0,
                                                    &dataRef,
                                                    &dataRefType);
    if (status) goto bail;
    
    // find and open the ATV export component
    status = OpenADefaultComponent(MovieExportType, 'M4VH', &theExportComponent);
    if (status) goto bail;
    
    // set the aperture mode to clean -- this may change the size of the movie box
    // therefore we do this before anything else
    if (true == inUseCleanApertureMode) {
        status = SetMovieCleanApertureMode(inMovie, &savedApertureMode);
        if (status) goto bail;
    }
    
    // export to .m4v
    status = MovieExportToDataRef(theExportComponent,           // export component instance
                                  dataRef,                      // destination data reference
                                  dataRefType,                  // destination data reference type
                                  inMovie,                      // movie to export
                                  0,                            // export specific track?
                                  0,                            // start time
                                  GetMovieDuration(inMovie)); // duration
    
    // restore original aperture mode
    if (true == inUseCleanApertureMode) {
        QTSetMovieProperty(inMovie,
                           kQTPropertyClass_Visual,
                           kQTVisualPropertyID_ApertureMode,
                           sizeof(savedApertureMode),
                           &savedApertureMode);
    }
    
bail:
    // always remember to close the component when you're done
    if (theExportComponent) CloseComponent(theExportComponent);
    
    // dispose the data reference handle when you're done with it
    if (dataRef) DisposeHandle(dataRef);
    
    return status;
}
*/
- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
	return YES;
}

@end
