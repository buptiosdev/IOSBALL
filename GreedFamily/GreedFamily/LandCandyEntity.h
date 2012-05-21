//
//  LandCandyEntity.h
//  GreedFamily
//
//  Created by MagicStudio on 12-5-19.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface LandCandyEntity : CCNode {
    int Balltype;
    CGPoint position;
    CCSprite * sprite;
}
@property (assign, nonatomic) CCSprite* sprite;
@property (assign, nonatomic) int Balltype;
@property (assign, nonatomic) CGPoint position;
+(id)CreateLandCandyEntity:(int)balltype Pos:(CGPoint)position;
@end
