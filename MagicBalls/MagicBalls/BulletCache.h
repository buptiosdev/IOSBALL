//
//  BulletCache.h
//  ShootEmUp
//
//  Created by Steffen Itterheim on 18.08.10.
//  Copyright 2010 Steffen Itterheim. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface BulletCache : CCNode 
{
	CCSpriteBatchNode* batch;
	int nextInactiveBullet;
}

-(void) shootBulletFrom:(CGPoint)startPosition velocity:(CGPoint)velocity frameName:(NSString*)frameName isPlayerBullet:(bool)isPlayerBullet;
-(bool) isPlayerBulletCollidingWithRect:(CGRect)rect;
-(bool) isEnemyBulletCollidingWithRect:(CGRect)rect;

@end
