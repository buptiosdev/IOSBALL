//
//  CandyEntity.h
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
	BallTypeBalloom,
	BallTypeKillerBall,
	BallType_MAX,
} BallType;


struct CandyParam {
    
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
    
    int	 initialHitPoints;
    
    int ballType;
    
    float32 linearDamping;
    
    float32 angularDamping;
    
};

@interface CandyEntity : Entity
{
    SEL ballMove;
    CandyParam candyParamDef;
    CGPoint candyVelocity;

}


//+(id) CandyWithType:(CandyTypes)CandyType World:(b2World *)world;
+(id) CandyWithParam:(CandyParam)candyParam World:(b2World *)world;
-(void)changeTheForth;
-(void)spawn:(int)enterPosition;
@property (assign, nonatomic) int candyType;
@property (assign, nonatomic) CCSprite* sprite;
@property (assign, nonatomic) CCSprite* cover;
//+(int) getSpawnFrequencyForCandyType:(CandyTypes)CandyType;
//
//-(void) spawn;
//
//-(void) gotHit;
//
//-(void) updateForCache;

@end
