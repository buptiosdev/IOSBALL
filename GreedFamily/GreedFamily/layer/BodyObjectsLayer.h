//
//  BodyObjectsLayer.h
//  GreedFamily
//
//  Created by 赵 苹果 on 12-4-19.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "Box2D.h"
#import "ContactListener.h"
#import "FlyEntity.h"
#import "PropertyCache.h"
#import "CandyCache.h"
#import "LandCandyCache.h"

typedef enum
{   
    CandyCacheTag = 1,
    FlyEntityTag,
    FlyEntityPlay2Tag,
    PropCacheTag,

    
}BodyObjectsLayerTags;
@interface BodyObjectsLayer : CCLayer 
{
    //b2World* world;
    ContactListener* contactListener;
    int contact_flag;
    
}

@property (nonatomic) b2World* world;
@property (nonatomic) int curEnterPosition;
+(id)CreateBodyObjectsLayer;
+(CGRect) screenRect;
+(BodyObjectsLayer *)sharedBodyObjectsLayer;
-(FlyEntity*) flyAnimal;
-(FlyEntity*) flyAnimalPlay2;
-(PropertyCache*) getPropertyCache;
-(CandyCache*) getCandyCache;
@end
