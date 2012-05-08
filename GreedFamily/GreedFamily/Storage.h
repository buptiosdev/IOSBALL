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

#define StorageCount  8

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
    
    CCLabelBMFont* cakeScoreLabel;
    CCLabelBMFont* chocolateScoreLabel;
    CCLabelBMFont* pudingScoreLabel;
    //BOOL isCombine;
    BOOL canCombine;
    BOOL needUpdateScore;
    
}
@property (readonly, nonatomic) CCSprite* sprite;
+(id)createStorage:(int)storageCapacity;
-(void)addFoodToStorage:(int)foodType;
@end
