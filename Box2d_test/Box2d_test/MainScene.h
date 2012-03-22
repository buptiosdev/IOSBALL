//
//  MainScene.h
//  Box2d_test
//
//  Created by 赵 苹果 on 12-3-18.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "ShipEntity.h"
#import "BulletCache.h"
#import "Box2D.h"
#import "ContactListener.h"


#define PTM_RATIO 32

typedef enum
{
    TileMapNode = 1,
    BoxNode,
}MainScenNodeTags;

typedef enum
{   
    TileMapLayerTag = 1,
    BoxLayerTag,
    SneakyButtonTag,
    ShipTag,
    BulletCacheTag,
    EnemyCacheTag,
    BatchTag,
    
}MainSceneLayerTags;

@interface MainScene : CCLayer 
{
    b2World* world;
    ContactListener* contactListener;
    
}
+(CCScene *) scene;
+(MainScene*) sharedMainScene;

//-(ShipEntity*) defaultShip;

//@property (readonly, nonatomic) BulletCache* bulletCache;

//+(CGRect) screenRect;
-(CCSpriteBatchNode*) getSpriteBatch;
@end
