//
//  BulletCache.m
//  ShootEmUp
//
//  Created by Steffen Itterheim on 18.08.10.
//  Copyright 2010 Steffen Itterheim. All rights reserved.
//

#import "BulletCache.h"
#import "Bullet.h"

@interface BulletCache (PrivateMethods)
-(bool) isBulletCollidingWithRect:(CGRect)rect usePlayerBullets:(bool)usePlayerBullets;
@end


@implementation BulletCache

-(id) init
{
	if ((self = [super init]))
	{
		// get any bullet image from the Texture Atlas we're using
		CCSpriteFrame* bulletFrame = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"bullet.png"];
		// use the bullet's texture (which will be the Texture Atlas used by the game)
		batch = [CCSpriteBatchNode batchNodeWithTexture:bulletFrame.texture];
		[self addChild:batch];
		
		// Create a number of bullets up front and re-use them whenever necessary.
		for (int i = 0; i < 200; i++)
		{
			Bullet* bullet = [Bullet bullet];
			bullet.visible = NO;
			[batch addChild:bullet];
		}
        
        //[self scheduleUpdate];
	}
	
	return self;
}

-(void) shootBulletFrom:(CGPoint)startPosition velocity:(CGPoint)velocity frameName:(NSString*)frameName isPlayerBullet:(bool)isPlayerBullet
{
	CCArray* bullets = [batch children];
	CCNode* node = [bullets objectAtIndex:nextInactiveBullet];
	NSAssert([node isKindOfClass:[Bullet class]], @"not a Bullet!");
	
	Bullet* bullet = (Bullet*)node;
	[bullet shootBulletAt:startPosition velocity:velocity frameName:frameName isPlayerBullet:isPlayerBullet];
	
	nextInactiveBullet++;
	if (nextInactiveBullet >= [bullets count])
	{
		nextInactiveBullet = 0;
	}
}

-(bool) isPlayerBulletCollidingWithRect:(CGRect)rect
{
	return [self isBulletCollidingWithRect:rect usePlayerBullets:YES];
}

-(bool) isEnemyBulletCollidingWithRect:(CGRect)rect
{
	return [self isBulletCollidingWithRect:rect usePlayerBullets:YES];
}

-(bool) isBulletCollidingWithRect:(CGRect)rect usePlayerBullets:(bool)usePlayerBullets
{
	bool isColliding = NO;
	
	Bullet* bullet;
	CCARRAY_FOREACH([batch children], bullet)
	{
		if (bullet.visible && usePlayerBullets == bullet.isPlayerBullet)
		{
			if (CGRectIntersectsRect([bullet boundingBox], rect))
			{
				isColliding = YES;
				
				// remove the bullet
				bullet.visible = NO;
				break;
			}
		}
	}
	
	return isColliding;
}

@end
