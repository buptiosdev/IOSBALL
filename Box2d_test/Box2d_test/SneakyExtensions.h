//
//  SneakyExtensions.h
//  Box2d_test
//
//  Created by 赵 苹果 on 12-3-18.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "SneakyButtonSkinnedBase.h"
#import "SneakyButton.h"
#import "SneakyJoystickSkinnedBase.h"
#import "SneakyJoystick.h"

@interface SneakyButton (Extension)
+(id) button;
+(id) buttonWithRect:(CGRect)rect;
@end

@interface SneakyButtonSkinnedBase (Extension)
+(id) skinnedButton;
@end

@interface SneakyJoystick (Extension)
+(id) joystickWithRect:(CGRect)rect;
@end

@interface SneakyJoystickSkinnedBase (Extension)
+(id) skinnedJoystick;
@end