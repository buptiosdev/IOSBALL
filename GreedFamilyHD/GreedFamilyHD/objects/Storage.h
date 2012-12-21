//
//  Storage.h
//  GreedFamily
//
//  Created by 赵 苹果 on 12-4-20.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "CandyEntity.h"
#import "gameScore.h"

#define StorageCount  8

#define timeReward 5

//struct FoodInStorage {
//    int pudingCount;
//    int chocolateCount;
//    int cakeCount;
//    
//};

@interface Storage : CCNode <CCTargetedTouchDelegate>
{
    CCArray *foodArray;
    int *combinArray;
    int currentCount;
    int storageCapacity;
    
    int timesOfOneTouch;
    int numbersOfOneTime;
    int theSameTypeNumOfOneTime;
    
    int foodInStorage[BallType_MAX];
    
    CCLabelBMFont* cheeseScoreLabel;
    CCLabelBMFont* candyScoreLabel;
    CCLabelBMFont* appleScoreLabel;

    //BOOL isCombine;
    BOOL canCombine;
    BOOL needUpdateScore;
    int continuousConbineFlag;
    
    
    int gamelevel;    
    int nowScoreTime;
    int counter;
    int lastScoreTime;
    int storageID;
    GameScore *myGameScore;
    int storageType; //3种: 1.自动消除，没有三个限制；2.手动消求，没有三个限制；3.手动消求，有三个限制
}
@property (readonly, nonatomic) CCSprite* sprite;
+(id)createStorage:(int)storageCapacity Play:(int)playID StorageType:(int)type;
-(void)addFoodToStorage:(int)foodType;
-(CCArray * )getScoreByLevel:(int)level;
//-(void)doMyCombineFood;
-(void)combinTheSameTypeNew;
-(void)combineBallNew;

@end
