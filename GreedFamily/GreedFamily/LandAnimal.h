//
//  LandAnimalSprite.h
//  GreedFamily
//
//  Created by 赵 苹果 on 12-4-19.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface LandAnimal : CCNode {
    int direction;
    float speed;
    int waitinterval;
}
//@property (readonly, nonatomic) CCSprite* sprite;
@property (assign, nonatomic) CCSprite* sprite;
+(id)CreateLandAnimal;
+(LandAnimal *)sharedLandAnimal;
-(void)eatAction;
@end
