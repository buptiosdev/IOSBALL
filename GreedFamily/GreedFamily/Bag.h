//
//  Bag.h
//  GreedFamily
//
//  Created by 赵 苹果 on 12-4-20.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

//@interface Bag : CCNode <CCTargetedTouchDelegate>
typedef enum  {
	crystalTimeTag = 13,
	pepperTimeTag = 12,
    smokeTimeTag = 11
} BagChildTag;
@interface Bag : CCNode 
{
    int pepperNum;
    int crystalNum;
    int smokeNum;
    CCLabelBMFont *pepperLabel;
    CCLabelBMFont *crystalLabel;
    CCLabelBMFont *smokeLabel;
    CCMenu *crystalMenu;
    CCMenu *pepperMenu;
    CCMenu *smokeMenu;
    CCMenuItemSprite *smokePropMenu;
    CCMenuItemSprite *pepperPropMenu;
    CCMenuItemSprite *crystalPropMenu;
    }
@property (readonly, nonatomic) CCSprite* sprite;

-(void)addCrystal;
-(void)addPepper;
-(void)addSmoke;
@end
