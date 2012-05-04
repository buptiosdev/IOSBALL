//
//  propertyCache.m
//  GreedFamily
//
//  Created by 赵 苹果 on 12-5-3.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import "PropertyCache.h"
#import "PropertyEntity.h"

@interface PropertyCache() 
-(id)initWithWorld:(b2World *)world;
-(void)preInitPropWithWorld:(b2World *)world;
-(void)addOneProperty:(NSInteger)type World:(b2World *)world  Array:(CCArray *)array Tag:(int)taget;
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
		
		//[self preInitPropWithWorld:world];
        
	}
	
	return self;    
}

-(void)preInitPropWithWorld:(b2World *)world 
{
	// create the enemies array containing further arrays for each type
	props = [[CCArray alloc] initWithCapacity:PropType_MAX];
	
	// create the arrays for each type
	for (int i = 0; i < PropType_MAX; i++)
	{
		// depending on enemy type the array capacity is set to hold the desired number of enemies
		int capacity;
		switch (i)
		{
			case PropTypeBlackBomb:
				capacity = 1;
				break;
			case PropTypeCrystalBall:
				capacity = 1;
				break;
			case PropTypeWhiteBomb:
				capacity = 1;
				break;
				
			default:
				[NSException exceptionWithName:@"EnemyCache Exception" reason:@"unhandled enemy type" userInfo:nil];
				break;
		}
		
		// no alloc needed since the enemies array will retain anything added to it
		CCArray* enemiesOfType = [CCArray arrayWithCapacity:capacity];
		[props addObject:enemiesOfType];
	}
	
	for (int i = 0; i < PropType_MAX; i++)
	{
		CCArray* enemiesOfType = [props objectAtIndex:i];
		int numEnemiesOfType = [enemiesOfType capacity];
		
		for (int j = 0; j < numEnemiesOfType; j++)
		{
            [self addOneProperty:i World:world Array:enemiesOfType Tag:i];
		}
	}
}

-(void)addOneProperty:(NSInteger)type World:(b2World *)world  Array:(CCArray *)array Tag:(int)taget 
{
    PropertyEntity* cache = [PropertyEntity createProperty:type World:world];
    [batch addChild:cache z:1 tag:taget];
    [array addObject:cache];
}

-(void)addOneProperty:(NSInteger)type World:(b2World *)world Tag:(int)taget 
{
    PropertyEntity* cache = [PropertyEntity createProperty:type World:world];
    [batch addChild:cache z:1 tag:taget];
    [cache moveProperty];
    
}

-(void) update:(ccTime)delta
{
//	updateCount++;
    
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
}

-(void) dealloc
{
	[props release];
    
	[super dealloc];
}
@end
