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

#define PROPS_TYPE_COUNT 5
#define DELAY_TIME 15

@interface PropertyCache : CCNode 
{
  	//CCSpriteBatchNode* batch;
	CCArray* props;
	int cacheNum;
    int propNum[PROPS_TYPE_COUNT];//4种属性球：0：水晶球 1：毒蘑菇  2：冰块  3：辣椒 4:烟雾
    int propCount[PROPS_TYPE_COUNT];
	int updateCount;  
    int maxVisibalNum;
    b2World *gameWorld;
}

+(id)propCache:(b2World *)world;
-(void)addOneProperty:(NSInteger)type World:(b2World *)world Tag:(int)taget;
@end
