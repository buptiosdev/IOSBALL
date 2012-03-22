//
//  Bullet.m
//  SpriteBatches
//
//  Created by Steffen Itterheim on 04.08.10.
//  Copyright 2010 Steffen Itterheim. All rights reserved.
//

#import "Bullet.h"
#import "MainScene.h"
#import "TableSetup.h"

@interface Bullet (PrivateMethods)
-(id) initWithBulletImage;
@end


@implementation Bullet

@synthesize velocity;
@synthesize isPlayerBullet;

+(id) bullet
{
	return [[[self alloc] initWithBulletImage] autorelease];
}

-(id) initWithBulletImage
{
	// Uses the Texture Atlas now.
	if ((self = [super initWithSpriteFrameName:@"bullet.png"]))
	{
	}
	
	return self;
}

// Re-Uses the bullet
-(void) shootBulletAt:(CGPoint)startPosition velocity:(CGPoint)vel frameName:(NSString*)frameName isPlayerBullet:(bool)playerBullet
{
	self.velocity = vel;
	self.position = startPosition;
	self.visible = YES;
	self.isPlayerBullet = playerBullet;

	// change the bullet's texture by setting a different SpriteFrame to be displayed
	CCSpriteFrame *frame = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:frameName];
	[self setDisplayFrame:frame];
	
	[self scheduleUpdate];
	
	CCRotateBy* rotate = [CCRotateBy actionWithDuration:1 angle:-360];
	CCRepeatForever* repeat = [CCRepeatForever actionWithAction:rotate];
	[self runAction:repeat];
}

-(void) update:(ccTime)delta
{
	self.position = ccpAdd(self.position, velocity);
	
	// When the bullet leaves the screen, make it invisible
	if (CGRectIntersectsRect([self boundingBox], [TableSetup screenRect]) == NO)
	{
		self.visible = NO;
		[self stopAllActions];
		[self unscheduleAllSelectors];
	}
}

@end
