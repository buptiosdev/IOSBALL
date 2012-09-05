//
//  DeveloperInfo.m
//  GreedFamily
//
//  Created by 赵 苹果 on 12-9-5.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "DeveloperInfo.h"

@implementation DeveloperInfo
@synthesize goBack;
@synthesize scrollView;

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

- (void)viewDidLoad
{
    [super viewDidLoad];
    //滚动view
    scrollView.delegate = self;
    scrollView.scrollEnabled = YES;
    scrollView.contentSize = CGSizeMake(100, 630);//设置滚动的可视区域
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [self setGoBack:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
- (IBAction)goBack:(id)sender 
{
    [self.view removeFromSuperview];

    [self.view release];
//    [[[CCDirector sharedDirector] openGLView] addSubview:view.view];
}

- (void)dealloc {
    [goBack release];
    [super dealloc];
}
@end
