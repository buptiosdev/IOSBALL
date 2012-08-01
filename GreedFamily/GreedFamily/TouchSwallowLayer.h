//
//  TouchSwallowLayer.h
//  GreedFamily
//
//  Created by 赵 苹果 on 12-8-1.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"



@interface TouchSwallowLayer : CCLayerColor <CCTargetedTouchDelegate>
{
    CCMenu *myMenu;
    int curRoleType;
}
+(id)createTouchSwallowLayer:(int)goodsType RoleType:(int)roalType;
@end
