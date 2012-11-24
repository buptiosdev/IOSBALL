//
//  DeveloperInfo.m
//  GreedFamily
//
//  Created by 赵 苹果 on 12-9-5.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "DeveloperInfo.h"
#import "NavigationScene.h"

@implementation DeveloperInfo
@synthesize goBack;
@synthesize scrollView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        //teach
//        CCSprite *close = [CCSprite spriteWithSpriteFrameName:@"close.png"];
//        CCSprite *close2 = [CCSprite spriteWithSpriteFrameName:@"close.png"];
//        close2.scaleX = 1.1;
//        close2.scaleY = 1.1;
//        CCMenuItemSprite *closeItem = [CCMenuItemSprite itemFromNormalSprite:close 
//                                           selectedSprite:close2 
//                                                   target:self 
//                                                 selector:@selector(goBack:)];
//        closeItem.scaleX=(40)/[close contentSize].width; //按照像素定制图片宽高是控制像素的。
//        closeItem.scaleY=(40)/[close contentSize].height;
//        
//        CCMenu *closeMenu = [CCMenu menuWithItems: closeItem, nil];
//        
//        CGSize screenSize = [[CCDirector sharedDirector] winSize];
//        [closeMenu setPosition:ccp(screenSize.width * 0.9 , screenSize.height * 0.8)];
//        
//        [self addChild:closeMenu];
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
