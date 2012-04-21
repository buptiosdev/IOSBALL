//
//  Sky.h
//  GreedFamily
//
//  Created by 赵 苹果 on 12-4-20.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "FlyEntity.h"

@interface GameSky : CCNode <CCTargetedTouchDelegate>
{
    FlyEntity *flyEntity;
}

@end
