//
//  GameShopScene.h
//  GreedFamily
//
//  Created by 赵 苹果 on 12-7-31.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface GameShopScene : CCLayer 
{
    CCSpriteBatchNode* batch;    
    CGSize screenSize;
}
+(id)createGameShopScene;
+(CCScene *) gameShopScene;
@end
