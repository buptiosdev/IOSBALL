//
//  PauseLayer.h
//  AerialGun
//
//  Created by Pablo Ruiz on 6/7/10.
//  Copyright 2010 Infinix Software. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
//

@interface PauseLayer : CCLayerColor {
    int teachPicCount;
    CCSprite *teachSprite;
    CCMenuItemSprite *infoMenu;
	
}
+(id)createPauseLayer:(ccColor4B)color Level:(int)sceneNum;
-(id)initWithColorLayer:(ccColor4B)color Level:(int)sceneNum;
@end