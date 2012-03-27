//
//  Bumper.m
//  PhysicsBox2d
//
//  Created by Steffen Itterheim on 22.09.10.
//  Copyright 2010 Steffen Itterheim. All rights reserved.
//

#import "Bumper.h"
#import "MainScene.h"

@implementation Bumper

-(id) initWithWorld:(b2World*)world position:(CGPoint)pos
{
	if ((self = [super init]))
	{
		//CGSize screenSize = [[CCDirector sharedDirector] winSize];
		
		// Create a body definition, it's a static body (bumpers don't move)
		b2BodyDef bodyDef;
		bodyDef.position = [Helper toMeters:pos];
		
        //先暂时随便用一个图片代替
		NSString* spriteFrameName = @"button-disabled.png";
		CCSprite* tempSprite = [CCSprite spriteWithSpriteFrameName:spriteFrameName];

		b2CircleShape circleShape;
		float radiusInMeters = (tempSprite.contentSize.width / PTM_RATIO) * 0.25f ;
		circleShape.m_radius = radiusInMeters;
		
		// Define the dynamic body fixture.
		b2FixtureDef fixtureDef;
		fixtureDef.shape = &circleShape;
		fixtureDef.density = 2.0f;
		fixtureDef.friction = 0.8f;
		
		// restitution > 1 makes objects bounce off faster than they hit
		fixtureDef.restitution = 1.5f;
		
		[super createBodyInWorld:world bodyDef:&bodyDef fixtureDef:&fixtureDef spriteFrameName:spriteFrameName];
		
		sprite.color = ccORANGE;
	}
	return self;
}

+(id) bumperWithWorld:(b2World*)world position:(CGPoint)pos
{
	return [[[self alloc] initWithWorld:world position:pos] autorelease];
}

@end
