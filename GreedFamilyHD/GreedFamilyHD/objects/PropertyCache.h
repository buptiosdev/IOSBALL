//
//  propertyCache.h
//  GreedFamily
//
//  Created by 赵 苹果 on 12-5-3.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "Box2D.h"

#define PROPS_TYPE_COUNT 8
#define DELAY_TIME 5
#define MAX_PROP_NUM 2
@interface PropertyCache : CCNode 
{
  	//CCSpriteBatchNode* batch;
	CCArray* props;
	int cacheNum;
    int propNum[PROPS_TYPE_COUNT];//4种属性球：0：水晶球 1：炸弹  2：冰块  3：辣椒 4:烟雾 5:空中炸弹 6:兴奋剂 7:脏水
    int propCount[PROPS_TYPE_COUNT];
	int updateCount;  
    int maxVisibalNum;
    b2World *gameWorld;
}

+(id)propCache:(b2World *)world;
-(void)addOneProperty:(NSInteger)type World:(b2World *)world Tag:(int)taget;

@property (assign, nonatomic)int aliveProp;
@end
