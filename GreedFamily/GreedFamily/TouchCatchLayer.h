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
    BagPlay2Tag,
    BagTag,
    StoragePlay2Tag,
    StorageTag,
    GameScoreTag
    
}TouchCatchTags;

@interface TouchCatchLayer : CCLayer {
    
}
+(id)CreateTouchCatchLayer;
+(TouchCatchLayer *)sharedTouchCatchLayer;
-(Storage*) getStorage;
-(Storage*) getStoragePlay2;
-(Bag*) getBag;
-(Bag*) getBagPlay2;
@end
