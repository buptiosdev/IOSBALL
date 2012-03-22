//
//  EnemyCache.m
//  ShootEmUp
//
//  Created by Steffen Itterheim on 20.08.10.
//  Copyright 2010 Steffen Itterheim. All rights reserved.
//

#import "EnemyCache.h"
#import "EnemyEntity.h"
#import "MainScene.h"
#import "BulletCache.h"
#import "TableSetup.h"
#import "Box2D.h"


@interface EnemyCache (PrivateMethods)
-(void) initEnemies :(b2World *)world;
-(id)initWithWorld:(b2World *)world;
@end


@implementation EnemyCache

+(id) cache:(b2World *)world
{
	return [[[self alloc] initWithWorld:world] autorelease];
}


-(id)initWithWorld:(b2World *)world
{
	if ((self = [super init]))
	{
		// get any image from the Texture Atlas we're using
		CCSpriteFrame* frame = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"monster-a.png"];
		batch = [CCSpriteBatchNode batchNodeWithTexture:frame.texture];
		[self addChild:batch];
		
		[self initEnemies:world];
		[self scheduleUpdate];
	}
	
	return self;    
}
/*-(id) init
{
	if ((self = [super init]))
	{
		// get any image from the Texture Atlas we're using
		CCSpriteFrame* frame = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"monster-a.png"];
		batch = [CCSpriteBatchNode batchNodeWithTexture:frame.texture];
		[self addChild:batch];
		
		[self initEnemies];
		[self scheduleUpdate];
	}
	
	return self;
}*/

-(void) initEnemies:(b2World *)world
{
	// create the enemies array containing further arrays for each type
	enemies = [[CCArray alloc] initWithCapacity:EnemyType_MAX];
	
	// create the arrays for each type
	for (int i = 0; i < EnemyType_MAX; i++)
	{
		// depending on enemy type the array capacity is set to hold the desired number of enemies
		int capacity;
		switch (i)
		{
			case EnemyTypeBreadman:
				capacity = 2;
				break;
			case EnemyTypeSnake:
				capacity = 2;
				break;
			case EnemyTypeBoss:
				capacity = 1;
				break;
				
			default:
				[NSException exceptionWithName:@"EnemyCache Exception" reason:@"unhandled enemy type" userInfo:nil];
				break;
		}
		
		// no alloc needed since the enemies array will retain anything added to it
		CCArray* enemiesOfType = [CCArray arrayWithCapacity:capacity];
		[enemies addObject:enemiesOfType];
	}
	
	for (int i = 0; i < EnemyType_MAX; i++)
	{
		CCArray* enemiesOfType = [enemies objectAtIndex:i];
		int numEnemiesOfType = [enemiesOfType capacity];
		
		for (int j = 0; j < numEnemiesOfType; j++)
		{
			EnemyEntity* enemy = [EnemyEntity enemyWithType:(EnemyTypes)i World:world];
			//[batch addChild:enemy.sprite z:-1 tag:i];
			[enemiesOfType addObject:enemy];
		}
	}
}

-(void) dealloc
{
	[enemies release];
	[super dealloc];
}


-(void) spawnEnemyOfType:(EnemyTypes)enemyType
{
	CCArray* enemiesOfType = [enemies objectAtIndex:enemyType];
	
	EnemyEntity* enemy;
	CCARRAY_FOREACH(enemiesOfType, enemy)
	{
		// find the first free enemy and respawn it
		if (enemy.sprite.visible == NO)
		{
			//CCLOG(@"spawn enemy type %i", enemyType);
			[enemy spawn];
			break;
		}
	}
}

-(void) checkForBulletCollisions
{
	EnemyEntity* enemy;
    /*
	CCARRAY_FOREACH([batch children], enemy)//这里得到的时enemy.sprite所以要出错
	{
		if (enemy.visible)
		{
			BulletCache* bulletCache = [[TableSetup sharedTable] bulletCache];
			CGRect bbox = [enemy boundingBox];
			if ([bulletCache isPlayerBulletCollidingWithRect:bbox])
			{
				//这个函数要出错
				[enemy gotHit];
                CCLOG(@"GOAL!!!!\n");
			}
		}}*/
        
        for (int i = 0; i < EnemyType_MAX; i++)
        {
            CCArray* enemiesOfType = [enemies objectAtIndex:i];
            int numEnemiesOfType = [enemiesOfType capacity];
            
            for (int j = 0; j < numEnemiesOfType; j++)
            {
                enemy = [enemiesOfType objectAtIndex:j];
                if (enemy.sprite.visible)
                {
                    [enemy updateForCache];
                    BulletCache* bulletCache = [[TableSetup sharedTable] bulletCache];
                    CGRect bbox = [enemy.sprite boundingBox];
                    if ([bulletCache isPlayerBulletCollidingWithRect:bbox])
                    {
                        //这个函数要出错
                        [enemy gotHit];
                        CCLOG(@"GOAL!!!!\n");
                    }
                }

            }
        }
	
}

-(void) update:(ccTime)delta
{
	updateCount++;

	for (int i = EnemyType_MAX - 1; i >= 0; i--)
	{
		int spawnFrequency = [EnemyEntity getSpawnFrequencyForEnemyType:(EnemyTypes)i];
		
		if (updateCount % spawnFrequency == 0)
		{
			[self spawnEnemyOfType:(EnemyTypes)i];
			break;
		}
	}
	
	[self checkForBulletCollisions];
}

@end
