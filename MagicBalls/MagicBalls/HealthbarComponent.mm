//
//  HealthbarComponent.m
//  ShootEmUp
//
//  Created by Steffen Itterheim on 21.08.10.
//  Copyright 2010 Steffen Itterheim. All rights reserved.
//

#import "HealthbarComponent.h"
#import "EnemyEntity.h"
#import "Entity.h"
#import "ShipEntity.h"

@implementation HealthbarComponent

-(id) init
{
	if ((self = [super init]))
	{
		self.visible = NO;
		[self scheduleUpdate];
	}
	
	return self;
}

-(void) reset
{
    Entity* parentEntity = (Entity*)self.parent;
	float parentHeight = parentEntity.sprite.contentSize.height;
	float selfHeight = self.contentSize.height;

    self.position = CGPointMake(parentEntity.sprite.anchorPointInPixels.x, parentHeight + selfHeight);
	self.scaleX = 1;
	self.visible = YES;
}

-(void) update:(ccTime)delta
{
	if (self.parent.visible)
	{
		NSAssert([self.parent isKindOfClass:[Entity class]], @"not a EnemyEntity");
		Entity* parentEntity = (Entity*)self.parent;
		self.scaleX = parentEntity.hitPoints / (float)parentEntity.initialHitPoints;
	}
	else if (self.visible)
	{
		self.visible = NO;  
	}
}

@end
