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

//-(CCSprite *)sprite
//{
//    if (!_sprite) 
//    {
//        _sprite = [[[CCSprite alloc] init] autorelease];
//    }
//    
//    return _sprite;
//}

-(void)initSprite:(NSString*)spriteFrameName
{

    CCSpriteBatchNode* batch = [[GameBackgroundLayer sharedGameBackgroundLayer] getSpriteBatch];
    self.sprite = [CCSprite spriteWithSpriteFrameName:spriteFrameName];
    [batch addChild:self.sprite];

    
}

-(void) createBodyInWorld:(b2World*)world bodyDef:(b2BodyDef*)bodyDef fixtureDef:(b2FixtureDef*)fixtureDef  spriteFrameName:(NSString*)spriteFrameName
{
	NSAssert(world != NULL, @"world is null!");
	NSAssert(bodyDef != NULL, @"bodyDef is null!");
	NSAssert(spriteFrameName != nil, @"spriteFrameName is nil!");
	
    //可以先暂时去掉，看看什么效果，但是要考虑内存释放的问题
	[self removeSprite];
	[self removeBody];
	
    CCSpriteBatchNode* batch = [[GameBackgroundLayer sharedGameBackgroundLayer] getSpriteBatch];
	self.sprite = [CCSprite spriteWithSpriteFrameName:spriteFrameName];
	[batch addChild:self.sprite];
	
	self.body = world->CreateBody(bodyDef);
	self.body->SetUserData(self);
	
	if (fixtureDef != NULL)
	{
		self.body->CreateFixture(fixtureDef);
	}
}

-(void) createBodyInWorld:(b2World*)world bodyDef:(b2BodyDef*)bodyDef fixtureDef:(b2FixtureDef*)fixtureDef  
{
	NSAssert(world != NULL, @"world is null!");
	NSAssert(bodyDef != NULL, @"bodyDef is null!");
	
    //可以先暂时去掉，看看什么效果，但是要考虑内存释放的问题
	[self removeSprite];
	[self removeBody];
	

	
	self.body = world->CreateBody(bodyDef);
	self.body->SetUserData(self);
	
	if (fixtureDef != NULL)
	{
		self.body->CreateFixture(fixtureDef);
	}
    
}

/*通过这个函数改变精灵的位置*/
-(void) updateBadyPosition:(CGPoint)positionNew
{
	b2Vec2 bodyPos = self.body->GetWorldCenter();
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
    
	self.body->ApplyForce(force, self.body->GetWorldCenter());
    
    //sprite.position = [Helper toPixels:body->GetPosition()];
//    bodyPos = body->GetWorldCenter();
//    bodyPosition = [Helper toPixels:bodyPos];
}

-(void) removeSprite
{
	CCSpriteBatchNode* batch = [[GameBackgroundLayer sharedGameBackgroundLayer] getSpriteBatch];
	if (self.sprite != nil && [batch.children containsObject:self.sprite])
	{
		[batch.children removeObject:self.sprite];
		_sprite = nil;
	}
}

-(void) removeBody
{
	if (self.body != NULL)
	{
		self.body->GetWorld()->DestroyBody(self.body);
		_body = NULL;
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
