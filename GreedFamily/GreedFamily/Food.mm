//
//  Food.m
//  GreedFamily
//
//  Created by 赵 苹果 on 12-4-28.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import "Food.h"
#import "GameBackgroundLayer.h"

@interface Food (PrivateMethods)
-(NSString *) getFoodSpriteName:(int)foodType;
@end

@implementation Food
@synthesize mySprite = _mySprite;
@synthesize theStorage = _theStorage;
@synthesize foodType = _foodType;



-(id) initWithStorage:(Storage*)storage Type:(int)foodType Count:(int)count
{
	if ((self = [super init]))
	{
		self.theStorage = storage;
		
		[_theStorage addChild:self];
        _foodType = foodType;

        CCSpriteBatchNode* batch = [[GameBackgroundLayer sharedGameBackgroundLayer] getSpriteBatch];
        NSString *spriteName = [self getFoodSpriteName:foodType];
        _mySprite = [CCSprite spriteWithSpriteFrameName:spriteName];
        CGPoint initPosition = CGPointMake(16 * 32 + 16, 20);
        CGPoint moveToPosition = CGPointMake(count * 32 + 16, 20);
        _mySprite.position = initPosition;

//        CCAction *moveAction = [CCSequence actions:
//                                [CCMoveTo actionWithDuration:2 position:moveToPosition],
//                                nil
//                                ];
//        
//        [self runAction:moveAction];
        CCMoveTo* move = [CCMoveTo actionWithDuration:3 position:moveToPosition]; 
        CCEaseInOut* ease = [CCEaseInOut actionWithAction:move rate:4];
        [self runAction:ease];

        
        _mySprite.position = moveToPosition;
		[batch addChild:_mySprite];
	}
	
	return (self);
}

-(NSString *) getFoodSpriteName:(int)foodType
{
    NSString *foodSpriteName;
    switch (foodType) 
    {
        case FoodTypePuding:
            foodSpriteName = @"puding2.png";
            break;
        case FoodTypeChocolate:
            foodSpriteName = @"chocolate.png";
            break;
        case FoodTypeCake:
            foodSpriteName = @"cake3.png";
            break;
        default:
            break;
    }
    return foodSpriteName;
}

@end
