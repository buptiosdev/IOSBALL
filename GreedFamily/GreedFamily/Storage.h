//
//  Storage.h
//  GreedFamily
//
//  Created by 赵 苹果 on 12-4-20.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

#define StorageCount  8

@interface Storage : CCNode <CCTargetedTouchDelegate>
{
    CCArray *foodArray;
    int *combinArray;
    int currentCount;
    int storageCapacity;
    
    //BOOL isCombine;
    BOOL canCombine;
    
}
@property (readonly, nonatomic) CCSprite* sprite;
+(id)createStorage:(int)storageCapacity;
-(void)addFoodToStorage:(int)foodType;
@end
