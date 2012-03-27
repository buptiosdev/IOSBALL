//
//  EnemyCache.h
//  ShootEmUp
//
//  Created by Steffen Itterheim on 20.08.10.
//  Copyright 2010 Steffen Itterheim. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "Box2D.h"

@interface EnemyCache : CCNode 
{
	CCSpriteBatchNode* batch;
	CCArray* enemies;
	int enemyNum;
    
	int updateCount;
}
+(id)cache:(b2World *)world Order:(int)order;
@end
