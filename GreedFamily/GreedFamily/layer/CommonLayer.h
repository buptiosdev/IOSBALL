//
//  CommonLayer.h
//  GreedFamily
//
//  Created by 赵 苹果 on 12-11-24.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#define ROLE_TYPE_COUNT 3     //角色种类,最后一个为总得分
//#define LANDSPEED1 100
//#define LANDSPEED2 500
//#define LANDSPEED3 1000
//#define STORAGE1 200
//#define STORAGE2 400
//#define STORAGE3 1000
//
//#define AIRSPEED1 100
//#define AIRSPEED2 500
//#define AIRSPEED3 1000
//
//#define SENSIT1 200
//#define SENSIT2 400
//#define SENSIT3 1000

#define LANDSPEED1 1
#define LANDSPEED2 2
#define LANDSPEED3 3
#define STORAGE1 1
#define STORAGE2 2
#define STORAGE3 4

#define AIRSPEED1 1
#define AIRSPEED2 2
#define AIRSPEED3 5

#define SENSIT1 1
#define SENSIT2 2
#define SENSIT3 6
typedef enum
{   
    NeedTouch= 1,
    GetScore,
    EatCandy,
    EatGood,
    EatBad,
    Droping,
    BubbleBreak,
    BubbleHit,
    SelectOK,
    SelectNo,
    Bombing,
    NewHighScore,
    Laugh1,
    Laugh2,
    Speedup
    
}AudioType;

typedef enum
{   
    UnGameMusic1= 1,
    UnGameMusic2,
    UnGameMusic3,
    GameMusic1,
    GameMusic2,
    GameMusic3,
    GameMusic4,
    GameMusic5,
    GameMusic6,
    StopGameMusic,
}MusicType;


typedef enum
{   
    ROLELANDSPEED= 1,
    ROLESTORAGECAPACITY,
    ROLEAIRSPEED,
    ROLEAIRSENSIT,
    ROLELINEARDAMP,
    ROLEDENSITY,
    ROLEFRICION,
    ROLERESTITUTION,
    ROLEHITEFFECT,
}RoleParamType;

struct RoleParam {
    float density;
    float restitution;
    float friction;
    float linearDamping;
    float sensitivity;
    float airspeed;
    float hitEffect;
    float landSpeed;
    float storageCapacity;
};

@interface CommonLayer : CCLayer {
    
}
@property (nonatomic) struct RoleParam *roleParamArray;
+(CommonLayer *)sharedCommonLayer;
+(void)playAudio:(int)audioType;

+(void)playBackMusic:(int)musicType;

+(void)preloadAudio;

-(float)getRoleParam:(int)roleType ParamType:(int)paramType;
@end
