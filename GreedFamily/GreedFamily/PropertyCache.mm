//
//  propertyCache.m
//  GreedFamily
//
//  Created by 赵 苹果 on 12-5-3.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import "PropertyCache.h"
#import "PropertyEntity.h"
#import "GameMainScene.h"

@interface PropertyCache() 
-(id)initWithWorld:(b2World *)world;
-(void)initPropsFrequency;
@end

@implementation PropertyCache

+(id) propCache:(b2World *)world
{
	return [[[self alloc] initWithWorld:world] autorelease];
}


-(id)initWithWorld:(b2World *)world 
{
	if ((self = [super init]))
	{
        gameWorld = world;
		
		//[self preInitPropWithWorld:world];
        [self initPropsFrequency];
	}
	
	return self;    
}

-(void)createBombTimes
{
    [self schedule:@selector(bombFrequency:) interval:60];
}

-(void)createCrystalTimes
{
    [self schedule:@selector(crystalFrequency:) interval:60];
}
-(void)initPropsFrequency
{
    int bombFrequency = [GameMainScene sharedMainScene].mainscenParam.bombFrequency;
    int crystalFrequency = [GameMainScene sharedMainScene].mainscenParam.crystalFrequency;

    bombNum = 0;
    crystalNum = 0;
    
    switch (bombFrequency) 
    {
        case NoTime:
            break;
        case OneTime:
            bombNum = 1;
            [self createBombTimes];
            break;
        case TwoTime:
            bombNum = 2;
            [self createBombTimes];
            break;
        case FiveTime:
            bombNum = 5;
            [self createBombTimes];
            break;    
        case OneTimePer5s:
            bombNum = 5;
            [self schedule:@selector(bombFrequency:) interval:5];
            break;
        case OneTimePer10s:
            bombNum = 5;
            [self schedule:@selector(bombFrequency:) interval:10];
            break;
        case OneTimePer20s:
            bombNum = 5;
            [self schedule:@selector(bombFrequency:) interval:20];
            break;
        case OneTimePer30s:
            bombNum = 5;
            [self schedule:@selector(bombFrequency:) interval:30];
            break;
        default:
            break;
    }
    
    switch (crystalFrequency) 
    {
        case NoTime:
            break;
        case OneTime:
            crystalNum = 1;
            [self createCrystalTimes];
            break;
        case TwoTime:
            crystalNum = 2;
            [self createCrystalTimes];
            break;
        case FiveTime:
            crystalNum = 5;
            [self createCrystalTimes];
            break;    
        case OneTimePer5s:
            crystalNum = 5;
            [self schedule:@selector(crystalFrequency:) interval:5];
            break;
        case OneTimePer10s:
            crystalNum = 5;
            [self schedule:@selector(crystalFrequency:) interval:10];
            break;
        case OneTimePer20s:
            crystalNum = 5;
            [self schedule:@selector(crystalFrequency:) interval:20];
            break;
        case OneTimePer30s:
            crystalNum = 5;
            [self schedule:@selector(crystalFrequency:) interval:30];
            break;
        default:
            break;
    }


}

-(void)addOneProToArr:(NSInteger)type World:(b2World *)world  Array:(CCArray *)array Tag:(int)taget 
{
    PropertyEntity* cache = [PropertyEntity createProperty:type World:world];
    [self addChild:cache z:1 tag:taget];
    [array addObject:cache];
}



-(void)addOneProperty:(NSInteger)type World:(b2World *)world Tag:(int)taget 
{
    PropertyEntity* cache = [PropertyEntity createProperty:type World:world];
    [self addChild:cache z:1 tag:taget];
    int enterPosition = random() % 5;
    [cache spawn:enterPosition]; 
    
}




-(void)bombFrequency:(ccTime)delta
{
    if (bombCount < bombNum || bombNum == 0) 
    {
        [self addOneProperty:1 World:gameWorld Tag:1];
        bombCount++;
    }
     
    return;
}

-(void)crystalFrequency:(ccTime)delta
{
    if (crystalCount < crystalNum || bombNum == 0) 
    {
        [self addOneProperty:0 World:gameWorld Tag:0];
        crystalCount++;
    }
    
    return;
}



//-(void)preInitPropWithWorld:(b2World *)world 
//{
//	// create the enemies array containing further arrays for each type
//	props = [[CCArray alloc] initWithCapacity:PropType_MAX];
//	
//	// create the arrays for each type
//	for (int i = 0; i < PropType_MAX; i++)
//	{
//		// depending on enemy type the array capacity is set to hold the desired number of enemies
//		int capacity;
//		switch (i)
//		{
//			case PropTypeBlackBomb:
//				capacity = [GameMainScene sharedMainScene].mainscenParam.bombFrequency;
//				break;
//			case PropTypeCrystalBall:
//				capacity = [GameMainScene sharedMainScene].mainscenParam.crystalFrequency;
//				break;
//			case PropTypeWhiteBomb:
//				capacity = 0;
//				break;
//				
//			default:
//				[NSException exceptionWithName:@"EnemyCache Exception" reason:@"unhandled enemy type" userInfo:nil];
//				break;
//		}
//		
//		// no alloc needed since the enemies array will retain anything added to it
//		CCArray* enemiesOfType = [CCArray arrayWithCapacity:capacity];
//		[props addObject:enemiesOfType];
//	}
//	
//	for (int i = 0; i < PropType_MAX; i++)
//	{
//		CCArray* enemiesOfType = [props objectAtIndex:i];
//		int numEnemiesOfType = [enemiesOfType capacity];
//		
//		for (int j = 0; j < numEnemiesOfType; j++)
//		{
//            [self addOneProToArr:i World:world Array:enemiesOfType Tag:i];
//		}
//	}
//}


//-(void) update:(ccTime)delta
//{
//	updateCount++;
//    
//	for (int i = PropType_MAX - 1; i >= 0; i--)
//	{
//		int spawnFrequency = [PropertyEntity getSpawnFrequencyForType:i];
//		
//		if (updateCount % spawnFrequency == 0)
//		{
//			[self spawnEnemyOfType:i];
//			break;
//		}
//	}
//}

-(void) dealloc
{
	[props release];
    
	[super dealloc];
}
@end
