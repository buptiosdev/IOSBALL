//
//  CandyCache.h
//  ShootEmUp
//
//  Created by Steffen Itterheim on 20.08.10.
//  Copyright 2010 Steffen Itterheim. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "Box2D.h"

typedef enum
{
	ParticleTypeExplosion = 0,
	ParticleTypeFire,
	ParticleTypeFireworks,
	ParticleTypeFlower,
	ParticleTypeGalaxy,
	ParticleTypeMeteor,
	ParticleTypeRain,
	ParticleTypeSmoke,
	ParticleTypeSnow,
	ParticleTypeSpiral,
	ParticleTypeSun,
	
	ParticleTypes_MAX,
} ParticleTypes;

@interface CandyCache : CCNode 
{
	CCArray* candies;
    CCArray* candyBank;
	int cacheNum;
    int candyCount;
	int updateCount;
    int maxVisibalNum;
    CCLabelBMFont* remainBallLabel;
}
+(id)cache:(b2World *)world;
@property (assign, nonatomic)BOOL isFinish;
@property (assign, nonatomic)int aliveCandy;

@end
