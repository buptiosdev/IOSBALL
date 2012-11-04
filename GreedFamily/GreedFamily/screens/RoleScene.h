//
//  RoleScene.h
//  GreedFamily
//
//  Created by MagicStudio on 12-8-19.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface RoleScene : CCLayer {
    CCLabelTTF *landanimalspeed;
    CCLabelTTF *flyanimalspeed;
    CCLabelTTF *storagecapacity;
    int roleType;
}
+(id)sceneWithRoleScene;
+(id)scene;
@end
