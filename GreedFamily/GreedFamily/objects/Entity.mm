//
//  Entity.m
//  ShootEmUp
//
//  Created by Steffen Itterheim on 18.08.10.
//  Copyright 2010 Steffen Itterheim. All rights reserved.
//

#import "Entity.h"
#import "GameBackgroundLayer.h"

@implementation Entity
@synthesize body = _body;
@synthesize sprite = _sprite;
@synthesize initialHitPoints;
@synthesize hitPoints;

-(CCSprite *)sprite
{
    if (!_sprite) 
    {
        _sprite = [[CCSprite alloc] init];
    }
    
    return _sprite;
}

-(void) createBodyInWorld:(b2World*)world bodyDef:(b2BodyDef*)bodyDef fixtureDef:(b2FixtureDef*)fixtureDef spriteFrameName:(NSString*)spriteFrameName
{
	NSAssert(world != NULL, @"world is null!");
	NSAssert(bodyDef != NULL, @"bodyDef is null!");
	NSAssert(spriteFrameName != nil, @"spriteFrameName is nil!");
	
    //可以先暂时去掉，看看什么效果，但是要考虑内存释放的问题
	//[self removeSprite];
	//[self removeBody];
	
    CCSpriteBatchNode* batch = [[GameBackgroundLayer sharedGameBackgroundLayer] getSpriteBatch];
	_sprite = [CCSprite spriteWithSpriteFrameName:spriteFrameName];
	[batch addChild:_sprite];
	
	_body = world->CreateBody(bodyDef);
	_body->SetUserData(self);
	
	if (fixtureDef != NULL)
	{
		_body->CreateFixture(fixtureDef);
	}
}


/*通过这个函数改变精灵的位置*/
-(void) updateBadyPosition:(CGPoint)positionNew
{
	b2Vec2 bodyPos = _body->GetWorldCenter();
    //CGPoint bodyPosition = [Helper toPixels:bodyPos];
	b2Vec2 fingerPos = [Helper toMeters:positionNew];
	
	b2Vec2 bodyToFinger = fingerPos - bodyPos;
    //b2Vec2 bodyToFinger = fingerPos;

    
    // "Real" gravity falls off by the square over distance. Feel free to try it this way:
    //float distance = bodyToFinger.Normalize();
	//float distanceSquared = distance * distance;
	//b2Vec2 force = ((1.0f / distanceSquared) * 20.0f) * bodyToFinger;
	
	b2Vec2 force = 20.0f * bodyToFinger;
    //body->SetTransform([Helper toMeters:positionNew], 0);
    
	_body->ApplyForce(force, _body->GetWorldCenter());
    
    //sprite.position = [Helper toPixels:body->GetPosition()];
//    bodyPos = body->GetWorldCenter();
//    bodyPosition = [Helper toPixels:bodyPos];
}

-(void) removeSprite
{
	CCSpriteBatchNode* batch = [[GameBackgroundLayer sharedGameBackgroundLayer] getSpriteBatch];
	if (_sprite != nil && [batch.children containsObject:_sprite])
	{
		[batch.children removeObject:_sprite];
		_sprite = nil;
	}
}

-(void) removeBody
{
	if (_body != NULL)
	{
		_body->GetWorld()->DestroyBody(_body);
		_body = NULL;
	}
}

-(void) dealloc
{
    
	[self removeSprite];
    //走进去会断错，暂去掉
	[self removeBody];
	
	[super dealloc];
}

@end
