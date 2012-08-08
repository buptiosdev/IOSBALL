//
//  TouchCatch.h
//  GreedFamily
//
//  Created by 赵 苹果 on 12-4-19.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "Storage.h"
#import "Bag.h"
typedef enum
{   
    GameSkyTag = 1,
    GamePauseTag,
    BagTag,
    StorageTag,
    GameScoreTag
    
}TouchCatchTags;

@interface TouchCatchLayer : CCLayer {
    
}
+(id)CreateTouchCatchLayer;
+(TouchCatchLayer *)sharedTouchCatchLayer;
-(Storage*) getStorage;
-(Bag*) getBag;
@end
