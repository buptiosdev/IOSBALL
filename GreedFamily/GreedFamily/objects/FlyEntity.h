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
@interface FlyEntity : Entity  
{
    bool moveToFinger;
	CGPoint fingerLocation;
    CGPoint fingerLocationBegin;
    CGPoint fingerLocationEnd;
    CGPoint playerVelocity;
    NSMutableArray *_flyActionArray;
    int directionBefore;
    int directionCurrent;
    double time1;
    double time2;

}

+(id) flyAnimal:(b2World*)world;
-(BOOL) ccTouchBeganForSky:(UITouch *)touch withEvent:(UIEvent *)event;
-(void) ccTouchMovedForSky:(UITouch *)touch withEvent:(UIEvent *)event;
-(void) ccTouchEndedForSky:(UITouch *)touch withEvent:(UIEvent *)event;
-(CGPoint)getFlySpeed;

@property (assign, nonatomic) CCSprite* sprite;
@property (nonatomic, retain) NSMutableArray *flyActionArray;
@property (assign, nonatomic)  CCAction *flyAction;
@end
