//
//  TouchCatch.h
//  GreedFamily
//
//  Created by 赵 苹果 on 12-4-19.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

typedef enum
{   
    GameSkyTag = 1,
    GamePauseTag,
    BagTag,
    StorageTag,
    
    
}TouchCatchTags;

@interface TouchCatchLayer : CCLayer {
    
}
+(id)CreateTouchCatchLayer;

@end
