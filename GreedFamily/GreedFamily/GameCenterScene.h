//
//  GameCenterScene.h
//  GreedFamily
//
//  Created by 赵 苹果 on 12-7-9.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "GCHelper.h"

@interface GameCenterScene : CCLayer <GCHelperDelegate>
{
    
}
+(id)createGameCenterScene;
+(CCScene *) gamecenterScene;
@end
