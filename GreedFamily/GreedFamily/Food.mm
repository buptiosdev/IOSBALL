//
//  Food.m
//  GreedFamily
//
//  Created by 赵 苹果 on 12-4-28.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import "Food.h"
#import "GameBackgroundLayer.h"
#import "GameMainScene.h"

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
        //float  contentSize  = [_mySprite contentSize].width; //得到图片的宽高
        //按照像素设定图片大小
        _mySprite.scaleX=(25)/[_mySprite contentSize].width; //按照像素定制图片宽高
        _mySprite.scaleY=(25)/[_mySprite contentSize].height;
        float widthPer = [_mySprite contentSize].width * _mySprite.scaleX;
        float highPer = [_mySprite contentSize].height * _mySprite.scaleY;
        NSString *strCapacity = nil;
        if (1 == [[GameMainScene sharedMainScene] roleType]) 
        {
            strCapacity = [NSString stringWithFormat:@"Capacity_Bird"];
        }
        else if (2 == [[GameMainScene sharedMainScene] roleType]) 
        {
            strCapacity = [NSString stringWithFormat:@"Capacity_Pig"];
        }
        int temCapacity = [[NSUserDefaults standardUserDefaults] integerForKey:strCapacity]; 
        if (temCapacity > 12 || temCapacity < 8) 
        {
            temCapacity = 8;
        }
        CGPoint initPosition = CGPointMake((widthPer * temCapacity + widthPer * 0.5), highPer * 0.5);
        CGPoint moveToPosition = CGPointMake(count * widthPer + widthPer * 0.5, highPer * 0.5);
        _mySprite.position = initPosition;

//        CCAction *moveAction = [CCSequence actions:
//                                [CCMoveTo actionWithDuration:2 position:moveToPosition],
//                                nil
//                                ];
//        
//        [self runAction:moveAction];
        CCMoveTo* move = [CCMoveTo actionWithDuration:3 position:moveToPosition]; 
        CCEaseInOut* ease = [CCEaseInOut actionWithAction:move rate:4];
        [_mySprite runAction:ease];

        
        //_mySprite.position = moveToPosition;
		[batch addChild:_mySprite];
	}
	
	return (self);
}

-(NSString *) getFoodSpriteName:(int)foodType
{
    NSString *foodSpriteName;
    switch (foodType) 
    {
            //case FoodTypePuding:
        case FoodTypeApple:            
            foodSpriteName = @"apple-.png";
            break;
            //case FoodTypeChocolate:
        case FoodTypeCheese:            
            foodSpriteName = @"cheese-.png";
            break;
            //case FoodTypeCake:
        case FoodTypeCandy:        
            foodSpriteName = @"candy-.png";
            break;
        default:
            break;
    }
    return foodSpriteName;
}

-(void) dealloc
{

	[super dealloc];
}

@end