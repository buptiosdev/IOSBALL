//
//  OptionsScene.h
//  AerialGun
//
//  Created by Pablo Ruiz on 6/15/10.
//  Copyright 2010 Infinix Software. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface OptionsScene : CCScene {
	
}

@end


@interface OptionsLayer : CCLayer {
    CCMenuItemSprite *teachInfoMenu;
    int teachPicCount;
    CCSprite *teachSprite;
	
}

@end