//
//  NavigationScene.h
//  Box2d_test
//
//  Created by 赵 苹果 on 12-3-25.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface NavigationScene : CCLayer <CCTargetedTouchDelegate>
{
    CGPoint fingerLocation;
    CCLabelTTF *label1;
    CCLabelTTF *label2;
    CCLabelTTF *label3;
    BOOL isTouch;
    
}
+(id)sceneWithNavigationScene;
+(id)scene;

@end
