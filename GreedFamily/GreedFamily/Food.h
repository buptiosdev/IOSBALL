//
//  Food.h
//  GreedFamily
//
//  Created by 赵 苹果 on 12-4-28.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "Storage.h"
typedef enum
{
	FoodTypeCake = 0,
	FoodTypeChocolate,
	FoodTypePuding,
} BallType;
@interface Food : CCNode 
{
    
}
@property(assign, nonatomic) CCSprite * mySprite;
@property(assign, nonatomic) Storage * theStorage;
@property(assign, nonatomic) int foodType;

-(id) initWithStorage:(Storage*)storage Type:(int)foodType Count:(int)count;
@end
