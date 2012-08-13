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

typedef enum
{
    SpeedTag0 = 0,
    SpeedTag1,
	TagType_MAX,
} TagType;

// Re-implementation of the Ship class using Components
@interface FlyEntity : Entity  
{
    bool moveToFinger;
	CGPoint fingerLocation;
    CGPoint fingerLocationBegin;
    CGPoint fingerLocationEnd;
    CGPoint playerVelocity;
    //NSMutableArray *_flyActionArray;
    int directionBefore;
    int directionCurrent;
    int familyType; /*1.小鸟 2.小猪*/
    double time1;
    double time2;

}

+(id) flyAnimal:(b2World *)world RoleType:(int)roleType;
-(BOOL) ccTouchBeganForSky:(UITouch *)touch withEvent:(UIEvent *)event;
-(void) ccTouchMovedForSky:(UITouch *)touch withEvent:(UIEvent *)event;
-(void) ccTouchEndedForSky:(UITouch *)touch withEvent:(UIEvent *)event;
-(void) ccTouchBeganForSky2:(UITouch *)touch withEvent:(UIEvent *)event;
-(CGPoint)getFlySpeed;

@property (assign, nonatomic) CCSprite* sprite;
@property (nonatomic, retain) NSMutableArray *flyActionArray;
@property (assign, nonatomic)  CCSpeed *flyAction;
@end
