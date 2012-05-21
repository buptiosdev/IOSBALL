//
//  LandCandyCache.h
//  GreedFamily
//
//  Created by MagicStudio on 12-5-19.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface LandCandyCache : CCNode {
    CCArray * landcandies;
}
+(id)initLandCache;
//+(id) CreateLandCandy:(int)balltype Pos:(CGPoint)position;
+(LandCandyCache *)sharedLandCandyCache;
-(int)CheckforCandyCollision:(CCSprite *)landanimal;
@end
