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
typedef enum
{   
    CandyCacheTag = 1,
    FlyEntityTag,

    
}BodyObjectsLayerTags;
@interface BodyObjectsLayer : CCLayer 
{
    b2World* world;
    ContactListener* contactListener;
    
}
+(id)CreateBodyObjectsLayer;
+(CGRect) screenRect;
@end
