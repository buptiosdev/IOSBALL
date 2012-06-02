//
//  PropertyEntity.h
//  GreedFamily
//
//  Created by 赵 苹果 on 12-5-3.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "Entity.h"


typedef enum
{
	PropTypeCrystalBall = 0,
    PropTypeBlackBomb,
    PropTypeWhiteBomb,
	PropType_MAX,
} PropType;

struct ProParam {
    
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
    
    float32 linearDamping;
    
    float32 angularDamping;
    
};

@interface PropertyEntity : Entity
{
    SEL ballMove;
    ProParam propertyParamDef;
    
}
+(id)createProperty:(NSInteger)propertyType World:(b2World *)world;
+(int) getSpawnFrequencyForType:(NSInteger)type;
-(void) moveProperty;
@property (assign, nonatomic) int propertyType;
@property (assign, nonatomic) CCSprite* sprite;
//+(int) getSpawnFrequencyForCandyType:(CandyTypes)CandyType;
//
//-(void) spawn;
//
//-(void) gotHit;
//
//-(void) updateForCache;
@end
