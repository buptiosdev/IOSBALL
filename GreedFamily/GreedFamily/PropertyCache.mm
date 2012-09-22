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
#import "BodyObjectsLayer.h"

@interface PropertyCache() 
-(id)initWithWorld:(b2World *)world;
-(void)propFrequency:(ccTime)delta;
-(void)initPropsFrequency;
@end

@implementation PropertyCache
@synthesize aliveProp = _aliveProp;
+(id) propCache:(b2World *)world
{
	return [[[self alloc] initWithWorld:world] autorelease];
}


-(id)initWithWorld:(b2World *)world 
{
	if ((self = [super init]))
	{
        gameWorld = world;
		maxVisibalNum = [GameMainScene sharedMainScene].mainscenParam.maxVisibaleNum;
        memset(propNum, 0, sizeof(propNum));
        memset(propCount, 0, sizeof(propCount));
        self.aliveProp = 0;
		//[self preInitPropWithWorld:world];
        [self initPropsFrequency];
	}
	
	return self;    
}

-(void)createPropTimes
{
    int totalProps = 0;
    //int gameLevel = [GameMainScene sharedMainScene].mainscenParam.order;
    
    int maxTime = [GameMainScene sharedMainScene].mainscenParam.candyCount 
        * [GameMainScene sharedMainScene].mainscenParam.candyFrequency;
    
    for (int i = 0; i < PROPS_TYPE_COUNT; i++)
    {
        totalProps += propNum[i]; 
    }
    
    if (0 >= totalProps) 
    {
        return;
    }
    
    int gapTime = random() % 5;
    int intervalTime = maxTime/(totalProps + 1) - gapTime;
    if (0 >= intervalTime) 
    {
        return;
    }
    [self schedule:@selector(propFrequency:) interval:intervalTime];
}

-(void)createBombTimes
{
    int gapTime = random() % 15;
    [self schedule:@selector(bombFrequency:) interval:60 - gapTime];
}

-(void)createCrystalTimes
{
    int gapTime = random() % 10;
    [self schedule:@selector(crystalFrequency:) interval:60 - gapTime];
}
-(void)initPropsFrequency
{
    propNum[0] = [GameMainScene sharedMainScene].mainscenParam.crystalFrequency;
    propNum[1] = [GameMainScene sharedMainScene].mainscenParam.bombFrequency;
    propNum[2] = [GameMainScene sharedMainScene].mainscenParam.iceFrequency;
    propNum[3] = [GameMainScene sharedMainScene].mainscenParam.pepperFrequency;
    propNum[4] = [GameMainScene sharedMainScene].mainscenParam.smokeFrequency;
    //propNum[4] = 2;
    [self createPropTimes];
}

-(void)addOneProToArr:(NSInteger)type World:(b2World *)world  Array:(CCArray *)array Tag:(int)taget 
{
    PropertyEntity* cache = [PropertyEntity createProperty:type World:world];
    [self addChild:cache z:1 tag:taget];
    [array addObject:cache];
}



-(void)addOneProperty:(NSInteger)type World:(b2World *)world Tag:(int)taget 
{
    int enterPosition;
    
    PropertyEntity* cache = [PropertyEntity createProperty:type World:world];
    [self addChild:cache z:1 tag:taget];
    do {
        enterPosition = random() % 5;
    } while (enterPosition == [BodyObjectsLayer sharedBodyObjectsLayer].curEnterPosition); 
    
    [BodyObjectsLayer sharedBodyObjectsLayer].curEnterPosition = enterPosition;
        
    [cache spawn:enterPosition]; 
    
}


-(void)propFrequency:(ccTime)delta
{
    int i = 0;
    int propType;
    
    static int passTime;
    passTime += delta;
    
    //属性球会过一段时间再出现
    if (passTime < DELAY_TIME) 
    {
        return;
    }
    
    CandyCache *candyCache = [[BodyObjectsLayer sharedBodyObjectsLayer] getCandyCache];
    //界面上最多存在maxVisibalNum个球
    if (candyCache.aliveCandy > maxVisibalNum || self.aliveProp > MAX_PROP_NUM)
    {
        return;
    }
    

    //随机出球种类，虽多随3次
    do 
    {
        propType = random() % 5;
        i++;
    }while (propCount[propType] >= propNum[propType] && i < 10);
    
    if (propCount[propType] >= propNum[propType])
    {
        return;
    }

    [self addOneProperty:propType World:gameWorld Tag:propType];

    propCount[propType]++;
    candyCache.aliveCandy++;
    self.aliveProp++;

    
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
