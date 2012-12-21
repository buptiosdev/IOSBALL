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
#import "GameMainScene.h"
#import "CommonLayer.h"
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

-(void)initNomal
{
    /*传递触摸事件给FlyEntity*/
    GameSky *gameSky = [GameSky node];
    [self addChild:gameSky z:-1 tag:GameSkyTag];
    
    GamePause *gamePause = [GamePause node];
    [self addChild:gamePause z:2 tag:GamePauseTag];
    
    //修改游戏参数
//    NSString *strCapacity = nil;
//    if (1 == [[GameMainScene sharedMainScene] roleType]) 
//    {
//        strCapacity = [NSString stringWithFormat:@"Capacity_Panda"];
//    }
//    else if (2 == [[GameMainScene sharedMainScene] roleType]) 
//    {
//        strCapacity = [NSString stringWithFormat:@"Capacity_Pig"];
//    }
//    else if (3 == [[GameMainScene sharedMainScene] roleType]) 
//    {
//        strCapacity = [NSString stringWithFormat:@"Capacity_Bird"];
//    }
//    int temCapacity = [[NSUserDefaults standardUserDefaults] integerForKey:strCapacity]; 
//    if (temCapacity > 12 || temCapacity < 8) 
//    {
//        temCapacity = 8;
//    }
//    temCapacity = [[GameMainScene sharedMainScene] roleParamArray][[[GameMainScene sharedMainScene] roleType] - 1].storageCapacity + temCapacity;
    int temCapacity = [[CommonLayer sharedCommonLayer] getRoleParam:[[GameMainScene sharedMainScene]roleType] ParamType:ROLESTORAGECAPACITY];
    int storageType = [[CommonLayer sharedCommonLayer] getRoleParam:[[GameMainScene sharedMainScene]roleType] ParamType:ROLESTORAGETYPE];
    Storage *storage = [Storage createStorage:temCapacity Play:1 StorageType:storageType];
    [self addChild:storage z:-3 tag:StorageTag];
    

    Bag *bag = [Bag createBag:1];
    [self addChild:bag z:-3 tag:BagTag];

    return;
}

-(void)initPair
{
    /*传递触摸事件给FlyEntity*/
    GameSky *gameSky = [GameSky node];
    [self addChild:gameSky z:-1 tag:GameSkyTag];
    
    GamePause *gamePause = [GamePause node];
    [self addChild:gamePause z:2 tag:GamePauseTag];
    
    
//    //修改游戏参数
//    NSString *strCapacityPlay1 = [NSString stringWithFormat:@"Capacity_Bird"];
//    NSString *strCapacityPlay2 = [NSString stringWithFormat:@"Capacity_Pig"];
//
//    int temCapacityPlay1 = [[NSUserDefaults standardUserDefaults] integerForKey:strCapacityPlay1]; 
////    if (temCapacityPlay1 > 12 || temCapacityPlay1 < 8) 
////    { 
////        temCapacityPlay1 = 8;
////    }
//    int temCapacityPlay2 = [[NSUserDefaults standardUserDefaults] integerForKey:strCapacityPlay2]; 
//    if (temCapacityPlay2 > 12 || temCapacityPlay2 < 8) 
////    {
////        temCapacityPlay2 = 8;
////    }
//    temCapacityPlay1 = [[GameMainScene sharedMainScene] roleParamArray][0].storageCapacity + temCapacityPlay1;
//    temCapacityPlay2 = [[GameMainScene sharedMainScene] roleParamArray][0].storageCapacity + temCapacityPlay2;
    int temCapacityPlay1 = [[CommonLayer sharedCommonLayer] getRoleParam:1 ParamType:ROLESTORAGECAPACITY];
    int temCapacityPlay2 = [[CommonLayer sharedCommonLayer] getRoleParam:2 ParamType:ROLESTORAGECAPACITY];
    int storageType1 = [[CommonLayer sharedCommonLayer] getRoleParam:1 ParamType:ROLESTORAGETYPE];
    int storageType2 = [[CommonLayer sharedCommonLayer] getRoleParam:2 ParamType:ROLESTORAGETYPE];


    Storage *storagePlay1 = [Storage createStorage:temCapacityPlay1 Play:1 StorageType:storageType1];
    [self addChild:storagePlay1 z:-3 tag:StorageTag];
    
    Storage *storagePlay2 = [Storage createStorage:temCapacityPlay2 Play:2 StorageType:storageType2];
    [self addChild:storagePlay2 z:-3 tag:StoragePlay2Tag];
    
    
    Bag *bagPlay1 = [Bag createBag:1];
    [self addChild:bagPlay1 z:-3 tag:BagTag];
    
    Bag *bagPlay2 = [Bag createBag:2];
    [self addChild:bagPlay2 z:-3 tag:BagPlay2Tag];
    
    return;
}
-(id)init
{
    if ((self = [super init]))
    {
        instanceOfTouchCatchLayer = self;
        
        /*开启触事件监测*/
        self.isTouchEnabled = YES;
        
        if (NO == [GameMainScene sharedMainScene].isPairPlay) 
        {
            [self initNomal];
        }
        else
        {
            [self initPair];
        }
                
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

-(Storage*) getStoragePlay2
{
	CCNode* node = [self getChildByTag:StoragePlay2Tag];
	NSAssert([node isKindOfClass:[Storage class]], @"node is not a storage!");
	return (Storage*)node;
}

-(Bag*) getBagPlay2
{
	CCNode* node = [self getChildByTag:BagPlay2Tag];
	NSAssert([node isKindOfClass:[Bag class]], @"node is not a bag!");
	return (Bag*)node;
}

-(void) dealloc
{
	[super dealloc];
}


@end
