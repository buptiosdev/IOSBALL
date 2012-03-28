//
//  SneakyButtonLayer.h
//  Box2d_test
//
//  Created by 赵 苹果 on 12-3-18.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

#import "SneakyButton.h" 
#import "SneakyJoystick.h"

@interface SneakyButtonLayer : CCLayer 
{
	SneakyButton* fireButton;
	SneakyJoystick* joystick;
	
	ccTime totalTime;
	ccTime nextShotTime;
}

@end
