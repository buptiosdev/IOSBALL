//
//  NavigationScene.h
//  Box2d_test
//
//  Created by 赵 苹果 on 12-3-25.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "GameKitHelper.h"
#import "DeveloperInfo.h"

@interface NavigationScene : CCLayer <GameKitHelperProtocol>
{
    /*
    CGPoint fingerLocation;
    CCLabelTTF *label1;
    CCLabelTTF *label2;
    CCLabelTTF *label3;
    BOOL isTouch;
     */
    DeveloperInfo *view;
    UIActivityIndicatorView *activityIndicatorView;
    BOOL isCreateIndicatorView;
}
+(id)sceneWithNavigationScene;
+(id)scene;
@property (nonatomic, readonly) int viewType; //0:leaderbroad  1:achievements
@end
