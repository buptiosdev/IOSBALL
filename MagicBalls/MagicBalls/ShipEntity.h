//
//  ShipEntity.h
//  ShootEmUp
//
//  Created by Steffen Itterheim on 18.08.10.
//  Copyright 2010 Steffen Itterheim. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

#import "Entity.h"
#import "Box2D.h"

// Re-implementation of the Ship class using Components
@interface ShipEntity : Entity <CCTargetedTouchDelegate>
{
    bool moveToFinger;
	CGPoint fingerLocation;
}

+(id) ship:(b2World*)world;

@end
