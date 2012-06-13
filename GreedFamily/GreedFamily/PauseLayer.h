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
	
}
+(id)createPauseLayer:(ccColor4B)color;
-(id)initWithColorLayer:(ccColor4B)color;
@end