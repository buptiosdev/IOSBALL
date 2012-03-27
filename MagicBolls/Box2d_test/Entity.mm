//
//  Entity.m
//  ShootEmUp
//
//  Created by Steffen Itterheim on 18.08.10.
//  Copyright 2010 Steffen Itterheim. All rights reserved.
//

#import "Entity.h"
#import "MainScene.h"

@implementation Entity
@synthesize body;
@synthesize sprite;
@synthesize initialHitPoints;
@synthesize hitPoints;

-(CCSprite *)sprite
{
    if (!sprite) 
    {
        sprite = [[CCSprite alloc] init];
    }
    
    return sprite;
}
-(void) createBodyInWorld:(b2World*)world bodyDef:(b2BodyDef*)bodyDef fixtureDef:(b2FixtureDef*)fixtureDef spriteFrameName:(NSString*)spriteFrameName
{
	NSAssert(world != NULL, @"world is null!");
	NSAssert(bodyDef != NULL, @"bodyDef is null!");
	NSAssert(spriteFrameName != nil, @"spriteFrameName is nil!");
	
    //可以先暂时去掉，看看什么效果，但是要考虑内存释放的问题
	[self removeSprite];
	[self removeBody];
	
	CCSpriteBatchNode* batch = [[MainScene sharedMainScene] getSpriteBatch];
	sprite = [CCSprite spriteWithSpriteFrameName:spriteFrameName];
	[batch addChild:sprite];
	
	body = world->CreateBody(bodyDef);
	body->SetUserData(self);
	
	if (fixtureDef != NULL)
	{
		body->CreateFixture(fixtureDef);
	}
}


/*通过这个函数改变精灵的位置*/
-(void) updateBadyPosition:(CGPoint)positionNew
{
	b2Vec2 bodyPos = body->GetWorldCenter();
    CGPoint bodyPosition = [Helper toPixels:bodyPos];
	b2Vec2 fingerPos = [Helper toMeters:positionNew];
	
	b2Vec2 bodyToFinger = fingerPos - bodyPos;
    
    // "Real" gravity falls off by the square over distance. Feel free to try it this way:
    //float distance = bodyToFinger.Normalize();
	//float distanceSquared = distance * distance;
	//b2Vec2 force = ((1.0f / distanceSquared) * 20.0f) * bodyToFinger;
	
	b2Vec2 force = 6.0f * bodyToFinger;
    //body->SetTransform([Helper toMeters:positionNew], 0);
    
	body->ApplyForce(force, body->GetWorldCenter());
    
    //sprite.position = [Helper toPixels:body->GetPosition()];
    bodyPos = body->GetWorldCenter();
    bodyPosition = [Helper toPixels:bodyPos];
}

-(void) removeSprite
{
	CCSpriteBatchNode* batch = [[MainScene sharedMainScene] getSpriteBatch];
	if (sprite != nil && [batch.children containsObject:sprite])
	{
		[batch.children removeObject:sprite];
		sprite = nil;
	}
}

-(void) removeBody
{
	if (body != NULL)
	{
		body->GetWorld()->DestroyBody(body);
		body = NULL;
	}
}

-(void) dealloc
{
    
	[self removeSprite];
    //走进去会断错，暂去掉
	//[self removeBody];
	
	[super dealloc];
}

@end
