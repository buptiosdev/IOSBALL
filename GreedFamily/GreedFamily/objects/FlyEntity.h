//
//  FlyEntity.h
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
@interface FlyEntity : Entity <CCTargetedTouchDelegate> 
{
    bool moveToFinger;
	CGPoint fingerLocation;
    CGPoint playerVelocity;
    CCLayer *a;
}

+(id) flyAnimal:(b2World*)world;

@end
