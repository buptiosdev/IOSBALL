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

+(id)CreateTouchCatchLayer
{
	return [[[self alloc] init] autorelease];
}

-(id)init
{
    if ((self = [super init]))
    {
        /*开启触事件监测*/
        self.isTouchEnabled = YES;
        
        //[self registerWithTouchDispatcher];
        
        /*传递触摸事件给FlyEntity*/
        GameSky *gameSky = [GameSky node];
        [self addChild:gameSky z:-1 tag:GameSkyTag];
        
        GamePause *gamePause = [GamePause node];
        [self addChild:gamePause z:-1 tag:GamePauseTag];
        

        
        Storage *storage = [Storage node];
        [self addChild:storage z:1 tag:StorageTag];
        
        Bag *bag = [Bag node];
        [self addChild:bag z:1 tag:BagTag];
    
    }
    return self;
}
-(void) dealloc
{
	[super dealloc];
}


@end
