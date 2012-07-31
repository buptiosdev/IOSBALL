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

#define ROLE_TYPE_COUNT 3     //角色种类,最后一个为总得分
#define PTM_RATIO 32

typedef enum
{
    TileMapNode = 1,
    BoxNode,
}MainScenNodeTags;

typedef enum
{   
    BatchTag= 1,
    AnimationTag,
    TouchCatchLayerTag,
    ObjectsLayerTag,
    BackGroundLayerTag,
    
}MainSceneLayerTags;


typedef enum
{   
    NoTime = 0,
    OneTime,
    TwoTime,
    ThreeTime,
    FourTime,
    FiveTime,
    
}PropertyFrequency;


struct SceneParam 
{
    BOOL landCompetitorExist;
    BOOL pend;
    int candyCount;
    int candyType;
    int candyFrequency;
    int bombFrequency;
    int pepperFrequency;
    int iceFrequency;
    int crystalFrequency;
    int invisibaleNum;
    int maxVisibaleNum;
    int order;
    float landCompetSpeed;
    float landAnimalSpeed;
};



@interface GameMainScene : CCLayer 
{
    
}
+(id)createMainLayer:(int)order;
+(GameMainScene*) sharedMainScene;
+(CCScene *) scene:(int)order;
@property (nonatomic) int sceneNum;
@property (nonatomic) int roleType;
@property (nonatomic) BOOL isGameOver;
@property (nonatomic) BOOL isGamePass;
@property (nonatomic) SceneParam mainscenParam;
-(void)pauseGame;
-(void)resumeGame;
@end
