//
//  LoadingScene.m
//  ScenesAndLayers
//
//  Created by Steffen Itterheim on 27.07.10.
//  Copyright 2010 Steffen Itterheim. All rights reserved.
//

#import "LoadingScene.h"
#import "GameMainScene.h"
#import "NavigationScene.h"
#import "AppDelegate.h"
#import "TeachGameLayer.h"
@interface LoadingScene (PrivateMethods)
-(void) update:(ccTime)delta;
@end

@implementation LoadingScene

+(id) sceneWithTargetScene:(TargetScenes)targetScene;
{
	CCLOG(@"===========================================");
	CCLOG(@"%@: %@", NSStringFromSelector(_cmd), self);
    
	// This creates an autorelease object of self (the current class: LoadingScene)
	return [[[self alloc] initWithTargetScene:targetScene] autorelease];
	
	// Note: this does the exact same, it only replaced self with LoadingScene. The above is much more common.
	//return [[[LoadingScene alloc] initWithTargetScene:targetScene] autorelease];
}

-(id) initWithTargetScene:(TargetScenes)targetScene
{
	if ((self = [super init]))
	{
		targetScene_ = targetScene;
        
		CCLabelTTF* label = [CCLabelTTF labelWithString:@"Loading ..." fontName:@"Marker Felt" fontSize:64];
        label.scale = 0.4;
		CGSize size = [[CCDirector sharedDirector] winSize];
		label.position = CGPointMake(size.width * 0.8, size.height * 0.2);
		[self addChild:label z:-2 tag:100];
        
        
        activityIndicatorView = [[[UIActivityIndicatorView alloc]   
                                               initWithActivityIndicatorStyle:   
                                               UIActivityIndicatorViewStyleWhiteLarge] autorelease];  
                
        activityIndicatorView.center = CGPointMake(190,240);  
                
        [activityIndicatorView startAnimating]; 
        //activityIndicatorView.activityIndicatorViewStyle= UIActivityIndicatorViewStyleGray;
        //[self.view addSubview:activityIndicatorView ];   
		AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;  
        [delegate.window addSubview:activityIndicatorView];
//		// Must wait one frame before loading the target scene!
//		// Two reasons: first, it would crash if not. Second, the Loading label wouldn't be displayed.
        //广告或说明 
        TeachGameLayer *p = [TeachGameLayer createTeachGameLayer:targetScene_];
        [self addChild:p];
        
//        [self schedule:<#(SEL)#> interval:<#(ccTime)#>];
        int waitTime = 3;
        if (1 == targetScene) {
            waitTime = 12;
        }
        [self schedule:@selector(waitAWhile:) interval:waitTime];
        
        
        // Add the UIActivityIndicatorView (in UIKit universe)  
        
//        activityIndicatorView = [[[UIActivityIndicatorView alloc]   
//                                       initWithActivityIndicatorStyle:   
//                                       UIActivityIndicatorViewStyleWhiteLarge] autorelease];  
//        
//        activityIndicatorView.center = ccp(190,240);  
//        
//        [activityIndicatorView startAnimating];  
        
        //[[self battleView] addSubview: activityIndicatorView]; 
        //[[[CCDirector sharedDirector] openGLView] addSubview:activityIndicatorView];
        
        //[[AppDelegate getAppDelegate].window  addSubview:activityIndicatorView];
        
	}
	
	return self;
}

-(void) waitAWhile:(ccTime)delta
{
	// It's not strictly necessary, as we're changing the scene anyway. But just to be safe.
	[self unscheduleAllSelectors];
	[activityIndicatorView stopAnimating ];  //停止  
	// Decide which scene to load based on the TargetScenes enum.
	// You could also use TargetScene to load the same with using a variety of transitions.
    if(targetScene_>=TargetNavigationScen)
    {
        [[CCDirector sharedDirector] replaceScene:[NavigationScene scene]];
    }
    else
    {
        [[CCDirector sharedDirector] replaceScene:[GameMainScene scene:targetScene_]];
    }
     
	
}


 

-(void) dealloc
{
	CCLOG(@"%@: %@", NSStringFromSelector(_cmd), self);
	
	// don't forget to call "super dealloc"
	[super dealloc];
}

@end
