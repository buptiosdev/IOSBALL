//
//  LevelScene.h
//  GreedFamily
//
//  Created by MagicStudio on 12-6-7.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface LevelScene : CCLayer {
    int mapType;
    
}
+(id)sceneWithLevelScene:(int)type;
+(id)scene:(int)type;
@end
