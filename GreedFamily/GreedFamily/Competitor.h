//
//  CompetitorSprite.h
//  GreedFamily
//
//  Created by 赵 苹果 on 12-4-19.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface Competitor : CCNode 
{
    BOOL isIce;
    BOOL isPepper;
    BOOL isCrystal;
    int directionBefore;
    int directionCurrent;
    float speed;
    int waitinterval;
}
@property (assign, nonatomic) CCSprite* sprite;
@property (nonatomic, retain) NSMutableArray *landCompetitorActionArray;
@property (assign, nonatomic)  CCAction *moveAction;
+(id)CreateCompetitor;
+(Competitor *)sharedCompetitor;
-(void)increaseSpeed;
-(void)decreaseSpeed;
-(void)bombed;
-(void)eatAction;
-(void)getCrystal;
@end
