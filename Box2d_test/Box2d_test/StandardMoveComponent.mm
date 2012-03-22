//
//  StandardMoveComponent.m
//  ShootEmUp
//
//  Created by Steffen Itterheim on 20.08.10.
//  Copyright 2010 Steffen Itterheim. All rights reserved.
//

#import "StandardMoveComponent.h"
#import "Entity.h"
#import "MainScene.h"
#import "TableSetup.h"
@implementation StandardMoveComponent

-(id) init
{
	if ((self = [super init]))
	{
		velocity = CGPointMake(-1, 0);
		[self scheduleUpdate];
	}
	
	return self;
}

-(void) update:(ccTime)delta
{
    Entity* entity = (Entity*)self.parent;
	if (entity.sprite.visible)
	{
		NSAssert([self.parent isKindOfClass:[Entity class]], @"node is not a Entity");
		
		//Entity* entity = (Entity*)self.parent;
		if (entity.sprite.position.x > [TableSetup screenRect].size.width * 0.5f)
		{
			[entity.sprite setPosition:ccpAdd(entity.sprite.position, velocity)];
		}
	}
}

@end
