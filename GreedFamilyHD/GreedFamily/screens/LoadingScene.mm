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
		CGSize size = [[CCDirector sharedDirector] winSize];
		label.position = CGPointMake(size.width / 2, size.height / 2);
		[self addChild:label];
		
		// Must wait one frame before loading the target scene!
		// Two reasons: first, it would crash if not. Second, the Loading label wouldn't be displayed.
		[self scheduleUpdate];
	}
	
	return self;
}

-(void) update:(ccTime)delta
{
	// It's not strictly necessary, as we're changing the scene anyway. But just to be safe.
	[self unscheduleAllSelectors];
	
	// Decide which scene to load based on the TargetScenes enum.
	// You could also use TargetScene to load the same with using a variety of transitions.
//	switch (targetScene_)
//	{
//        case TargetNavigationScen:
//            //[[CCDirector sharedDirector] replaceScene:[NavigationScene sceneWithNavigationScene]];
//            [[CCDirector sharedDirector] replaceScene:[NavigationScene scene]];
//            break;
//            
//		case TargetScene1stScene:
//		case TargetScene2ndScene:
//        case TargetScene3rdScene:
//			//[[CCDirector sharedDirector] replaceScene:[GameMainScene createMainLayer:targetScene_]];
//            [[CCDirector sharedDirector] replaceScene:[GameMainScene scene:targetScene_]];
//			break;
//
//			
//		default:
//			// Always warn if an unspecified enum value was used. It's a reminder for yourself to update the switch
//			// whenever you add more enum values.
//			NSAssert2(nil, @"%@: unsupported TargetScene %i", NSStringFromSelector(_cmd), targetScene_);
//            [[CCDirector sharedDirector] replaceScene:[NavigationScene scene]];
//			break;
//	}
    if(targetScene_>=TargetNavigationScen||targetScene_<=TargetSceneINVALID)
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
