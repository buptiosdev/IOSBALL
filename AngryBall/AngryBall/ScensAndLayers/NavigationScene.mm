//
//  NavigationScene.m
//  Box2d_test
//
//  Created by 赵 苹果 on 12-3-25.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//
#import "NavigationScene.h"
#import "Helper.h"
//#import "MainScene.h"
#import "LoadingScene.h"

@interface Navigation

//-(id)sceneWithNavigationScene;
@end


@implementation NavigationScene



-(id)initWithNavigationScene
{
    if (self = [super init])
    {
        self.isTouchEnabled = YES;
        
        [[CCTouchDispatcher sharedDispatcher] addTargetedDelegate:self priority:0 swallowsTouches:NO];
        
       //CGRect labelRect1 = CGRectMake(20, 20, 50, 30);
            
        label1 = [CCLabelTTF labelWithString:@"关卡：1" fontName:@"Marker Felt" fontSize:64];
        CGSize size = [[CCDirector sharedDirector] winSize]; 
        label1.position = CGPointMake(size.width / 2, size.height - 30);
        //[label1 drawTextInRect:labelRect1];
        [self addChild:label1];
        
        label2 = [CCLabelTTF labelWithString:@"关卡：2" fontName:@"Marker Felt" fontSize:64];
        label2.position = CGPointMake(size.width / 2, size.height / 2);
        [self addChild:label2];
        
        label3 = [CCLabelTTF labelWithString:@"关卡：3" fontName:@"Marker Felt" fontSize:64];
        label3.position = CGPointMake(size.width / 2, 30);
        [self addChild:label3];
        
               
        sleep(2);
        
        [self scheduleUpdate];
    }
    
    
    
    return self;
}

+(id)scene
{
    //order = order;
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	NavigationScene *navigationScene = [NavigationScene sceneWithNavigationScene];
	
	// add layer as a child to scene
	[scene addChild: navigationScene];

	return scene;

}

+(id)sceneWithNavigationScene
{
    return [[[self alloc] initWithNavigationScene] autorelease];
    
    
}

-(CGPoint) locationFromTouch:(UITouch*)touch
{
	CGPoint touchLocation = [touch locationInView: [touch view]];
	return [[CCDirector sharedDirector] convertToGL:touchLocation];
}

-(BOOL) ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event
{
	fingerLocation = [self locationFromTouch:touch];
    isTouch = YES;
	return YES;
    
}

-(void) ccTouchEnded:(UITouch *)touch withEvent:(UIEvent *)event
{
    //isTouch = NO;
}

-(void)update:(ccTime)delta
{
    if (isTouch)
    {
        //CGSize size = [[CCDirector sharedDirector] winSize]; 
    
        //CGRect rect1 =  CGRectMake(size.width / 2, size.height - 30.0f, 100.0f, 100.0f);
        //CGRect rect2 =  CGRectMake(size.width / 2, size.height / 2, 100.0f, 100.0f); 
        //CGRect rect3 =  CGRectMake(size.width / 2, 30.0f, 100.0f, 100.0f); 
        if (CGRectContainsPoint([label1 boundingBox], fingerLocation))
        {
        
            CCLOG(@"11111111%@\n", label1.textureRect);
            label1.color = ccWHITE;
            //CCTransitionShrinkGrow* transition = [CCTransitionShrinkGrow transitionWithDuration:3 scene:[MainScene scene:1]];
        
            //[[CCDirector sharedDirector] replaceScene:transition];
        
            [[CCDirector sharedDirector] replaceScene:[LoadingScene sceneWithTargetScene:TargetSceneFstScene]];

            //[[CCDirector sharedDirector] replaceScene:[MainScene scene:1]];
        }
        else if (CGRectContainsPoint([label2 boundingBox], fingerLocation))
        {
            CCLOG(@"22222222\n");
            label2.color = ccWHITE;
            [[CCDirector sharedDirector] replaceScene:[LoadingScene sceneWithTargetScene:TargetSceneScdScene]];
        }
        else if (CGRectContainsPoint([label3 boundingBox], fingerLocation))
        {
            CCLOG(@"333333\n");
            label2.color = ccWHITE;
        
            //[[CCDirector sharedDirector] replaceScene:[LoadingScene sceneWithTargetScene:TargetSceneThrdScene]];
                
            CCTransitionSlideInB* transition = [CCTransitionSlideInB transitionWithDuration:3 
                                            scene:[LoadingScene sceneWithTargetScene:TargetSceneThrdScene]];
            [[CCDirector sharedDirector] replaceScene:transition];
        }
        isTouch = NO;
        self.isTouchEnabled = NO;
    }
    
}

@end
