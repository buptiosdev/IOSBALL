//
//  SneakyButtonLayer.m
//  Box2d_test
//
//  Created by 赵 苹果 on 12-3-18.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//
#import "MainScene.h"
#import "SneakyButtonLayer.h"
#import "SneakyExtensions.h"

// SneakyInput 头文件 
#import "ColoredCircleSprite.h" 
#import "SneakyButton.h" 
#import "SneakyButtonSkinnedBase.h" 
#import "SneakyJoystick.h" 
#import "SneakyJoystickSkinnedBase.h"
#import "TableSetup.h"

@interface SneakyButton (PrivateMethods)
-(void)addFireButton;
@end


@implementation SneakyButtonLayer


-(void)addFireButton
{
	float buttonRadius = 50;
	CGSize screenSize = [[CCDirector sharedDirector] winSize];
    
	fireButton = [SneakyButton button];
	fireButton.isHoldable = YES;
    
	SneakyButtonSkinnedBase* skinFireButton = [SneakyButtonSkinnedBase skinnedButton];
	skinFireButton.position = CGPointMake(screenSize.width - buttonRadius * 1.5f, buttonRadius * 1.5f);
	skinFireButton.defaultSprite = [CCSprite spriteWithSpriteFrameName:@"button-default.png"];
	skinFireButton.pressSprite = [CCSprite spriteWithSpriteFrameName:@"button-pressed.png"];
	skinFireButton.button = fireButton;
	[self addChild:skinFireButton];
}


-(void) addJoystick
{
	float stickRadius = 50;
    
	joystick = [SneakyJoystick joystickWithRect:CGRectMake(0, 0, stickRadius, stickRadius)];
	joystick.autoCenter = YES;
	joystick.hasDeadzone = YES;
	joystick.deadRadius = 10;
	
	SneakyJoystickSkinnedBase* skinStick = [SneakyJoystickSkinnedBase skinnedJoystick];
	skinStick.position = CGPointMake(stickRadius * 1.5f, stickRadius * 1.5f);
	skinStick.backgroundSprite = [CCSprite spriteWithSpriteFrameName:@"button-disabled.png"];
	skinStick.backgroundSprite.color = ccMAGENTA;
	skinStick.thumbSprite = [CCSprite spriteWithSpriteFrameName:@"button-disabled.png"];
	skinStick.thumbSprite.scale = 0.5f;
	skinStick.joystick = joystick;
	[self addChild:skinStick];
}

-(id) init
{
	if ((self = [super init]))
	{
		[self addFireButton];
        
        [self addJoystick];
		
		[self scheduleUpdate];
	}
	
	return self;
}



-(void) update:(ccTime)delta
{
	totalTime += delta;
    
	// Continuous fire
	if (fireButton.active && totalTime > nextShotTime)
	{
		nextShotTime = totalTime + 0.5f;
        
		TableSetup *table = [TableSetup sharedTable];
		ShipEntity *ship = [table defaultShip];
		BulletCache *bulletCache = [table bulletCache];
        
		// Set the position, velocity and spriteframe before shooting
		CGPoint shotPos = CGPointMake(ship.sprite.position.x + [ship contentSize].width * 0.5f, 
                                      ship.sprite.position.y);
		float spread = (CCRANDOM_0_1() - 0.5f) * 0.5f;
		CGPoint velocity = CGPointMake(4, spread);
		[bulletCache shootBulletFrom:shotPos velocity:velocity frameName:@"bullet.png" isPlayerBullet:YES];
	}
	
	// Allow faster shooting by quickly tapping the fire button.
	if (fireButton.active == NO)
	{
		nextShotTime = 0;
	}
	
	// Moving the ship with the thumbstick.

    TableSetup *table = [TableSetup sharedTable];
    ShipEntity *ship = [table defaultShip];
	
	CGPoint velocity = ccpMult(joystick.velocity, 200);
	if (velocity.x != 0 && velocity.y != 0)
	{
        /*CCLOG(@"1.\nposition is (%f, %f)\nshould be (%f, %f)\nspead is (%f, %f)\ndelte is %f",
              ship.sprite.position.x, ship.sprite.position.y,
              ship.sprite.position.x + velocity.x * delta, 
              ship.sprite.position.y + velocity.y * delta,
              velocity.x, velocity.y, delta);*/
		//CGPoint positionNew = CGPointMake(ship.sprite.position.x + velocity.x * delta, 
        //                                   ship.sprite.position.y + velocity.y * delta);
        CGPoint positionNew = CGPointMake(ship.sprite.position.x + velocity.x, 
                                          ship.sprite.position.y + velocity.y);
        [ship updateBadyPosition:positionNew];
        //这里需要把位置变化同步到body how？？
        //ship.body->SetTransform([Helper toMeters:ship.sprite.position], 0);

	}
}

-(void) dealloc
{
	[super dealloc];
}

@end
