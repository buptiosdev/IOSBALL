//
//  MainScene.h
//  Box2d_test
//
//  Created by 赵 苹果 on 12-3-18.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "Box2D.h"


#define PTM_RATIO 32

typedef enum
{
    TileMapNode = 1,
    BoxNode,
}MainScenNodeTags;

typedef enum
{   
    BatchTag= 1,
    TouchCatchLayerTag,
    ObjectsLayerTag,
    BackGroundLayerTag,
    
}MainSceneLayerTags;

@interface GameMainScene : CCLayer 
{
}
+(id)createMainLayer:(int)order;
+(GameMainScene*) sharedMainScene;
@property (nonatomic) int sceneNum;
@property (nonatomic) BOOL isGameOver;
@property (nonatomic) BOOL isGamePass;
@end
