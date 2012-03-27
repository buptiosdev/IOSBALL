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


@implementation NavigationScene



-(id)initWithNavigationScene
{
    if (self = [super init])
    {
        //self.isTouchEnabled = YES;
        
        [[CCTouchDispatcher sharedDispatcher] addTargetedDelegate:self priority:0 swallowsTouches:NO];
        
        label1 = [CCLabelTTF labelWithString:@"关卡：1" fontName:@"Marker Felt" fontSize:64];
        CGSize size = [[CCDirector sharedDirector] winSize]; 
        label1.position = CGPointMake(size.width / 2, size.height - 30);
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
	return YES;
    
}

-(void)update:(ccTime)delta
{
    CGSize size = [[CCDirector sharedDirector] winSize]; 
    
    CGRect rect1 =  CGRectMake(10, 10, size.width / 2, size.height - 30);
    CGRect rect2 =  CGRectMake(10, 10, size.width / 2, size.height / 2); 
    CGRect rect3 =  CGRectMake(10, 10, size.width / 2, 30); 
    if (CGRectContainsPoint(rect1, fingerLocation))
    {
        
        CCLOG(@"11111111%@\n", label1.textureRect);
        //CCTransitionShrinkGrow* transition = [CCTransitionShrinkGrow transitionWithDuration:3 scene:[MainScene scene:1]];
        
        //[[CCDirector sharedDirector] replaceScene:transition];
        
        [[CCDirector sharedDirector] replaceScene:[LoadingScene sceneWithTargetScene:TargetSceneFstScene]];

        //[[CCDirector sharedDirector] replaceScene:[MainScene scene:1]];
    }
    else if (CGRectContainsPoint(rect2, fingerLocation))
    {
         
         CCLOG(@"22222222\n");
        //[[CCDirector sharedDirector] replaceScene:[MainScene scene:2]];
    }
    else if (CGRectContainsPoint(rect3, fingerLocation))
    {
         
 
         CCLOG(@"333333\n");
        //[[CCDirector sharedDirector] replaceScene:[MainScene scene:3]];
        
        //CCSlideInBTransition* transition = [CCSlideInBTransition transitionWithDuration:3 scene:[MainScene scene:3]];
        //[[CCDirector sharedDirector] replaceScene:transition];
    }
    
    
}

@end
