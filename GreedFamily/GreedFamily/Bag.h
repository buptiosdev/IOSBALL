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
@interface Bag : CCNode 
{
    int pepperNum;
    int crystalNum;
    CCProgressTimer *timeTmp;
    CCLabelBMFont *pepperLabel;
    CCLabelBMFont *crystalLabel;
    CCMenu *crystalMenu;
    CCMenu *pepperMenu;
}
@property (readonly, nonatomic) CCSprite* sprite;

-(void)addCrystal;
-(void)addPepper;

@end
