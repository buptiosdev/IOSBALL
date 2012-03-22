//
//  EnemyEntity.h
//  ShootEmUp
//
//  Created by Steffen Itterheim on 20.08.10.
//  Copyright 2010 Steffen Itterheim. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Entity.h"

typedef enum
{
	EnemyTypeBreadman = 0,
	EnemyTypeSnake,
	EnemyTypeBoss,
	
	EnemyType_MAX,
} EnemyTypes;


@interface EnemyEntity : Entity
{
	EnemyTypes type;

}



+(id) enemyWithType:(EnemyTypes)enemyType World:(b2World *)world;

+(int) getSpawnFrequencyForEnemyType:(EnemyTypes)enemyType;

-(void) spawn;

-(void) gotHit;

-(void) updateForCache;

@end
