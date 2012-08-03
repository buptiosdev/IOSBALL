//
//  LandAnimalSprite.h
//  GreedFamily
//
//  Created by 赵 苹果 on 12-4-19.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#define PATICLE_NUM



@interface LandAnimal : CCNode 
{
    BOOL isIce;
    BOOL isPepper;
    BOOL isCrystal;
    BOOL isSpeedfast;
    float speed;
    int waitinterval;
    int directionBefore;
    int directionCurrent;
}
//@property (readonly, nonatomic) CCSprite* sprite;
@property (assign, nonatomic) CCSprite* sprite;
@property (nonatomic, retain) NSMutableArray *landAnimalActionArray;
@property (assign, nonatomic)  CCAction *moveAction;
+(id)CreateLandAnimal;
+(LandAnimal *)sharedLandAnimal;
-(void)decreaseSpeed;
-(void)increaseSpeed;
-(void)bombed;
-(void)eatAction;
-(void)getCrystal;
-(void)reverseDirection;
-(void)setCurDirection;
@end
