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

@interface PropertyCache : CCNode 
{
  	//CCSpriteBatchNode* batch;
	CCArray* props;
	int cacheNum;
    int bombNum;
    int crystalNum;
    int bombCount;
    int crystalCount;
	int updateCount;  
    int maxVisibalNum;
    b2World *gameWorld;
}

+(id)propCache:(b2World *)world;
-(void)addOneProperty:(NSInteger)type World:(b2World *)world Tag:(int)taget;
@end
