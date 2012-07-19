//
//  TouchCatch.m
//  GreedFamily
//
//  Created by 赵 苹果 on 12-4-19.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import "TouchCatchLayer.h"
#import "Storage.h"
#import "GameSky.h"
#import "GamePause.h"
#import "Bag.h"


@implementation TouchCatchLayer

/*创造一个半单例，让其他类可以很方便访问scene*/
static TouchCatchLayer *instanceOfTouchCatchLayer;
+(TouchCatchLayer *)sharedTouchCatchLayer
{
    NSAssert(nil != instanceOfTouchCatchLayer, @"TouchCatchLayer instance not yet initialized!");
    
    return instanceOfTouchCatchLayer;
}

+(id)CreateTouchCatchLayer
{
	return [[[self alloc] init] autorelease];
}

-(id)init
{
    if ((self = [super init]))
    {
        instanceOfTouchCatchLayer = self;
        
        /*开启触事件监测*/
        self.isTouchEnabled = YES;
        
        //[self registerWithTouchDispatcher];
        
        /*传递触摸事件给FlyEntity*/
        GameSky *gameSky = [GameSky node];
        [self addChild:gameSky z:-1 tag:GameSkyTag];
        
        GamePause *gamePause = [GamePause node];
        [self addChild:gamePause z:2 tag:GamePauseTag];
        
        Storage *storage = [Storage createStorage:10];
        [self addChild:storage z:-3 tag:StorageTag];
        
        //先不考虑
        Bag *bag = [Bag node];
        [self addChild:bag z:1 tag:BagTag];
        
    }
    return self;
}

-(Storage*) getStorage
{
	CCNode* node = [self getChildByTag:StorageTag];
	NSAssert([node isKindOfClass:[Storage class]], @"node is not a storage!");
	return (Storage*)node;
}

-(Bag*) getBag
{
	CCNode* node = [self getChildByTag:BagTag];
	NSAssert([node isKindOfClass:[Bag class]], @"node is not a bag!");
	return (Bag*)node;
}

-(void) dealloc
{
	[super dealloc];
}


@end
