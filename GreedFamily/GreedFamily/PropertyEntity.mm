//
//  PropertyEntity.m
//  GreedFamily
//
//  Created by 赵 苹果 on 12-5-3.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import "PropertyEntity.h"
#import "GameBackgroundLayer.h"


@interface PropertyEntity (PrivateMethods)
-(id)initProperty:(NSInteger)propertyType World:(b2World *)world;
@end
@implementation PropertyEntity


@synthesize sprite = _sprite;

static CCArray* spawnFrequency;
-(void) initSpawnFrequency
{
	// initialize how frequent the enemies will spawn
	if (spawnFrequency == nil)
	{
		spawnFrequency = [[CCArray alloc] initWithCapacity:PropType_MAX];
		[spawnFrequency insertObject:[NSNumber numberWithInt:80] atIndex:PropTypeCrystalBall];
		[spawnFrequency insertObject:[NSNumber numberWithInt:260] atIndex:PropTypeWhiteBomb];
		[spawnFrequency insertObject:[NSNumber numberWithInt:1500] atIndex:PropTypeBlackBomb];
		
		// spawn one enemy immediately
		//[self spawn];
	}
}

+(int) getSpawnFrequencyForType:(NSInteger)type
{
	NSAssert(type < PropType_MAX, @"invalid type");
	NSNumber* number = [spawnFrequency objectAtIndex:type];
	return [number intValue];
}

-(void)moveCrystalBall:(CGPoint)curPosition forceOut:(b2Vec2 *)force
{
    CGPoint velocity = CGPointMake(CCRANDOM_MINUS1_1()*0.1, CCRANDOM_MINUS1_1() * 0.1);	
    if (curPosition.x < 50)
    {
        velocity.x = 10;
    }
    else if (curPosition.x > 430)
    {
        velocity.x = -10;
    }
    
    if (curPosition.y < 50)
    {
        velocity.y = 10;
    }
    else if (curPosition.y > 270)
    {
        velocity.y = -10;
    }
    
    CGPoint positionNew = ccpAdd(curPosition, velocity);
    
    b2Vec2 fingerPos = [Helper toMeters:positionNew];
    b2Vec2 bodyPos = [Helper toMeters:curPosition];
	
    b2Vec2 bodyToFinger = fingerPos - bodyPos;
    
    *force = 20 * bodyToFinger;
    
}

-(void)moveBlackBomb:(CGPoint)curPosition forceOut:(b2Vec2 *)force
{
    CGPoint velocity = CGPointMake(CCRANDOM_MINUS1_1()*0.1, CCRANDOM_MINUS1_1() * 0.1);	
    if (curPosition.x < 50)
    {
        velocity.x = 10;
    }
    else if (curPosition.x > 430)
    {
        velocity.x = -10;
    }
    
    if (curPosition.y < 50)
    {
        velocity.y = 10;
    }
    else if (curPosition.y > 270)
    {
        velocity.y = -10;
    }
    
    CGPoint positionNew = ccpAdd(curPosition, velocity);
    
    b2Vec2 fingerPos = [Helper toMeters:positionNew];
    b2Vec2 bodyPos = [Helper toMeters:curPosition];
	
    b2Vec2 bodyToFinger = fingerPos - bodyPos;
    
    *force = 20 * bodyToFinger;
    
}

-(void)moveWhiteBomb:(CGPoint)curPosition forceOut:(b2Vec2 *)force
{
    CGPoint velocity = CGPointMake(CCRANDOM_MINUS1_1()*0.1, CCRANDOM_MINUS1_1() * 0.1);	
    if (curPosition.x < 50)
    {
        velocity.x = 10;
    }
    else if (curPosition.x > 430)
    {
        velocity.x = -10;
    }
    
    if (curPosition.y < 50)
    {
        velocity.y = 10;
    }
    else if (curPosition.y > 270)
    {
        velocity.y = -10;
    }
    
    CGPoint positionNew = ccpAdd(curPosition, velocity);
    
    b2Vec2 fingerPos = [Helper toMeters:positionNew];
    b2Vec2 bodyPos = [Helper toMeters:curPosition];
	
    b2Vec2 bodyToFinger = fingerPos - bodyPos;
    
    *force = 20 * bodyToFinger;
    
}

-(void) moveProperty
{
    static int i = 0;
    i += CCRANDOM_0_1()*100;
    int vector1 = i % 30;
    i += CCRANDOM_0_1()*100;
    int vector2 = i % 30;
    CGPoint vector = CGPointMake(vector1, vector2);
    b2Vec2 force = [Helper toMeters:vector];
    self.body->ApplyForce(force, self.body->GetWorldCenter());
}

-(void) update:(ccTime)delta
{
    if (self.sprite.visible)
	{
        b2Vec2 bodyPos = self.body->GetWorldCenter();
        CGPoint bodyPosition = [Helper toPixels:bodyPos];
        b2Vec2 force;
        //函数指针
        //void(*getForchFunc)(id, SEL, CGPoint);
        
        //IMP getForchFunc = [self methodForSelector:ballMove];
        //getForchFunc(self, ballMove, bodyPosition, &force);
        
        //  SEL a = @selector(moveTheBallRandom: forceOut:);
        IMP getForchFunc = [self methodForSelector:ballMove];
        getForchFunc(self, ballMove, bodyPosition, &force); 
        
        self.body->ApplyForce(force, self.body->GetWorldCenter());
        
	}    
}

+(id)createProperty:(NSInteger)propertyType World:(b2World *)world
{
	return [[[self alloc] initProperty:propertyType World:world] autorelease];
}

-(void)initCrystalBall
{
    ballMove = @selector(moveCrystalBall:forceOut:);
    propertyParamDef.startPos = CGPointMake(200, 200);/*random?*/
    propertyParamDef.isDynamicBody = YES;
    propertyParamDef.ballType = PropTypeCrystalBall;
    propertyParamDef.spriteFrameName = @"pic_2.png";
    propertyParamDef.density = 0.5;
    propertyParamDef.restitution = 1.5;
    propertyParamDef.linearDamping = 0.2;
    propertyParamDef.angularDamping = 0.1;
    propertyParamDef.friction = 0.5;
    propertyParamDef.radius = 0.5;
    propertyParamDef.initialHitPoints = 1;
    
}

-(void)initWhiteBomb
{
    ballMove = @selector(moveWhiteBomb:forceOut:);
    propertyParamDef.startPos = CGPointMake(200, 100);/*random?*/
    propertyParamDef.isDynamicBody = YES;
    propertyParamDef.ballType = PropTypeCrystalBall;
    propertyParamDef.spriteFrameName = @"pic_4.png";
    propertyParamDef.density = 0.2;
    propertyParamDef.restitution = 1.5;
    propertyParamDef.linearDamping = 0.2;
    propertyParamDef.angularDamping = 0.1;
    propertyParamDef.friction = 0.5;
    propertyParamDef.radius = 0.5;
    propertyParamDef.initialHitPoints = 1;
    
}

-(void)initBlackBomb
{
    ballMove = @selector(moveBlackBomb:forceOut:);
    propertyParamDef.startPos = CGPointMake(100, 200);/*random?*/
    propertyParamDef.isDynamicBody = YES;
    propertyParamDef.ballType = PropTypeBlackBomb;
    propertyParamDef.spriteFrameName = @"pic_3.png";
    propertyParamDef.density = 0.7;
    propertyParamDef.restitution = 0.7;
    propertyParamDef.linearDamping = 0.2;
    propertyParamDef.angularDamping = 0.1;
    propertyParamDef.friction = 0.2;
    propertyParamDef.radius = 0.5;
    propertyParamDef.initialHitPoints = 1;
    
}



-(void)initPropertyMove:(NSInteger)propertyType
{
    switch (propertyType) {
        case PropTypeCrystalBall:
            [self initCrystalBall];
            break;
        case PropTypeBlackBomb:
            [self initBlackBomb];
            break;
        case PropTypeWhiteBomb:
            [self initWhiteBomb];
            break;
        default:
            break;
    }
}

-(id)initProperty:(NSInteger)propertyType World:(b2World *)world
{
    if ((self = [super init]))
    {
        [self initPropertyMove:propertyType];
        
        CCSpriteBatchNode* batch = [[GameBackgroundLayer sharedGameBackgroundLayer] getSpriteBatch];
        self.sprite = [CCSprite spriteWithSpriteFrameName:propertyParamDef.spriteFrameName];
        [batch addChild:self.sprite];       
        
        hitPoints = propertyParamDef.initialHitPoints;
        initialHitPoints = propertyParamDef.initialHitPoints;
        
        b2BodyDef bodyDef;
        bodyDef.position = [Helper toMeters:propertyParamDef.startPos];
        
        if (propertyParamDef.isDynamicBody)
        {
            bodyDef.type = b2_dynamicBody;
        }
        //阻力
        bodyDef.angularDamping = propertyParamDef.angularDamping;
        bodyDef.linearDamping = propertyParamDef.linearDamping;
        
        b2CircleShape circleShape;
        float radiusInMeters = (self.sprite.contentSize.width / PTM_RATIO) * 0.5f;
        circleShape.m_radius = radiusInMeters;
        
        // Define the dynamic body fixture.
        b2FixtureDef fixtureDef;
        fixtureDef.shape = &circleShape;
        fixtureDef.density = propertyParamDef.density;
        fixtureDef.friction = propertyParamDef.friction;
        fixtureDef.restitution = propertyParamDef.restitution;
        
        [super createBodyInWorld:world 
                         bodyDef:&bodyDef 
                      fixtureDef:&fixtureDef]; 
        self.sprite.position = propertyParamDef.startPos;
        [self scheduleUpdate];
    }
    
    return self;
}

-(void) dealloc
{
	[spawnFrequency release];
	spawnFrequency = nil;
	[super dealloc];
}



@end
