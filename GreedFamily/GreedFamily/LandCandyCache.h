//
//  LandCandyCache.h
//  GreedFamily
//
//  Created by MagicStudio on 12-5-19.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "LandCandyEntity.h"
@interface LandCandyCache : CCNode {
    CCArray * landcandies;
    CCArray * controlCandies;
    }

@property (readonly, nonatomic) int landnum;
@property (readonly, nonatomic) int airnum;


+(id)initLandCache;
//+(id) CreateLandCandy:(int)balltype Pos:(CGPoint)position;
+(LandCandyCache *)sharedLandCandyCache;
-(int)CheckforCandyCollision:(CCSprite *)landanimal Type:(int)landtype;
-(void) CreateLandCandy:(int)balltype Pos:(CGPoint)position BodyVelocity:(CGPoint)bodyVelocity;
-(void)addToLandCandies:(LandCandyEntity *)landCandy;
-(int)getCurDirection:(CCSprite *)landanimal;
@end
