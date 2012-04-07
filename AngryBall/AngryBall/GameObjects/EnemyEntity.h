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
	BallTypeRandomBall = 0,
	BallTyBalloom,
	BallTypeKillerBall,
	BallType_MAX,
} BallType;

struct EnemyParam {
    
    CGPoint startPos;
    //b2CircleShape circleShape;
    
    float radius;
    
    //CGFloat y;
    /// The friction coefficient, usually in the range [0,1].
	float32 friction;
    
	/// The restitution (elasticity) usually in the range [0,1].
	float32 restitution;
    
	/// The density, usually in kg/m^2.
	float32 density;
    
    BOOL isDynamicBody;
    
    NSString *spriteFrameName;
    
    int	initialHitPoints;
    
    int ballType;
    
};

@interface EnemyEntity : Entity
{
    SEL ballMove;
    EnemyParam enemyParamDef;

}


//+(id) enemyWithType:(EnemyTypes)enemyType World:(b2World *)world;
+(id) enemyWithParam:(EnemyParam)firstEnemyParam World:(b2World *)world;

//+(int) getSpawnFrequencyForEnemyType:(EnemyTypes)enemyType;
//
//-(void) spawn;
//
//-(void) gotHit;
//
//-(void) updateForCache;

@end
