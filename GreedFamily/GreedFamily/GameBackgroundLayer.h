//
//  GameBackgroundLayer.h
//  GreedFamily
//
//  Created by 赵 苹果 on 12-4-19.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface GameBackgroundLayer : CCLayer {
    
}
+(id)CreateGameBackgroundLayer;
+(GameBackgroundLayer *)sharedGameBackgroundLayer;
-(CCSpriteBatchNode*) getSpriteBatch;
//-(CCSpriteBatchNode*) getAnimationBatch;
-(void)preloadAudio;
@end
