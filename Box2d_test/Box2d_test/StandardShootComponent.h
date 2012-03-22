//
//  StandardShootComponent.h
//  ShootEmUp
//
//  Created by Steffen Itterheim on 20.08.10.
//  Copyright 2010 Steffen Itterheim. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

// Why is it derived from CCSprite? Because enemies use a SpriteBatch, and CCSpriteBatchNode requires that all
// child nodes added to it are CCSprite. Under other circumstances I would use a CCNode as parent class of course, since
// the components won't have a texture and everything else that a Sprite has.
@interface StandardShootComponent : CCSprite 
{
	int updateCount;
	int shootFrequency;
	NSString* bulletFrameName;
}

@property (nonatomic) int shootFrequency;
@property (nonatomic, copy) NSString* bulletFrameName;

@end
