//
//  NoBodyObjectsLayer.h
//  GreedFamily
//
//  Created by 赵 苹果 on 12-4-19.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "LandCandyCache.h"

typedef enum
{   
    LandAnimalTag = 1,
    CompetitorTag,
    LandCandyTag
    
}NoBodyObjectsLayerTags;

typedef enum
{
	IceType = 50,   
    PepperType,              
	BombType,            
    CrystalType,
    SpeedfastType
    
} ParticleType;

@interface NoBodyObjectsLayer : CCLayer {
    
}
+(id)CreateNoBodyObjectsLayer;
+(NoBodyObjectsLayer *)sharedNoBodyObjectsLayer;
-(LandCandyCache*) getLandCandyCache;
@end
