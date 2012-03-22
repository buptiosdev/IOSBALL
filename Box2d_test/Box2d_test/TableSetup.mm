//
//  StaticTable.m
//  PhysicsBox2d
//
//  Created by Steffen Itterheim on 22.09.10.
//  Copyright 2010 Steffen Itterheim. All rights reserved.
//

#import "TableSetup.h"
#import "Helper.h"
#import "Bumper.h"
#import "ShipEntity.h"
#import "EnemyCache.h"
#import "BulletCache.h"
#import "MainScene.h"
#import "TileMapLayer.h"

@interface TableSetup (PrivateMethods)
-(void) addBumperAt:(CGPoint)pos;
-(void) createTableTopBody;
-(void) createTableBottomLeftBody;
-(void) createTableBottomRightBody;
-(void) createLanes;
-(void)addCloud;
@end


@implementation TableSetup

/*创造一个半单例，让其他类可以很方便访问scene*/
static TableSetup *instanceOfTable;
+(TableSetup *)sharedTable
{
    NSAssert(nil != instanceOfTable, @"MainScene instance not yet initialized!");
    
    return instanceOfTable;
}

/*屏幕尺寸*/
static CGRect screenRect;

-(id) initTableWithWorld:(b2World*)world
{
	if ((self = [super init]))
	{
        instanceOfTable = self;
        // weak reference to world for convenience
        world_ = world;
		
        screenSize = [[CCDirector sharedDirector] winSize];
        screenRect = CGRectMake(0, 0, screenSize.width, screenSize.height);
        
        //加载一些云作为背景 
        [self addCloud];

        
        //加载角色层
        ShipEntity* ship = [ShipEntity ship:world];
        
        [self addChild:ship z:-1 tag:ShipTag];
		

        //加载敌人集中管理层
        EnemyCache* enemyCache = [EnemyCache cache:world];
        [self addChild:enemyCache z:-1 tag:EnemyCacheTag];
        
        //加载子弹集中管理层
        BulletCache* bulletCache = [BulletCache node];
        [self addChild:bulletCache z:-2 tag:BulletCacheTag];
        
        // Add some bumpers 弹簧体
        //[self addBumperAt:CGPointMake(150, 330)];
        //[self addBumperAt:CGPointMake(100, 390)];
        //[self addBumperAt:CGPointMake(230, 380)];
        //[self addBumperAt:CGPointMake(40, 350)];
        //[self addBumperAt:CGPointMake(280, 300)];
        //[self addBumperAt:CGPointMake(70, 280)];
        [self addBumperAt:CGPointMake(30, 30)];
        [self addBumperAt:CGPointMake(30, screenSize.height - 30)];
        [self addBumperAt:CGPointMake(screenSize.width - 30, 30)];
        [self addBumperAt:CGPointMake(screenSize.width - 30, screenSize.height - 30)];

        //Ball* ball = [Ball ballWithWorld:world];
        //[self addChild:ball z:-1];
        
        [self scheduleUpdate];	
        // world is no longer needed after init:
        world_ = NULL;

	}
	
	return self;
}

-(void)addCloud
{
    batch = [CCSpriteBatchNode batchNodeWithFile:@"game-art.png"];
    [self addChild:batch z:-3];
    
    CCSprite* tableBottom = [CCSprite spriteWithSpriteFrameName:@"bg5.png"];
    tableBottom.anchorPoint = CGPointMake(0, 0.5f);
    tableBottom.position = CGPointMake(0, screenSize.height / 2);
    [batch addChild:tableBottom z:1];
    
    CCSprite* tableBottom2 = [CCSprite spriteWithSpriteFrameName:@"bg5.png"];
    tableBottom2.anchorPoint = CGPointMake(0, 0.5f);
    tableBottom2.position = CGPointMake(screenSize.width - 1, screenSize.height / 2);
    tableBottom2.flipX = YES;
    [batch addChild:tableBottom2 z:1];
    
    
    CCSprite* tableTop = [CCSprite spriteWithSpriteFrameName:@"bg6.png"];
    tableTop.anchorPoint = CGPointMake(0, 0.5f);
    tableTop.position = CGPointMake(0, screenSize.height / 2);
    [batch addChild:tableTop z:2];
    
    CCSprite* tableTop2 = [CCSprite spriteWithSpriteFrameName:@"bg6.png"];
    tableTop2.anchorPoint = CGPointMake(0, 0.5f);
    tableTop2.position = CGPointMake(screenSize.width - 1, screenSize.height / 2);
    tableTop2.flipX = YES;
    [batch addChild:tableTop2 z:2];
    
    return;
}

+(id) setupTableWithWorld:(b2World*)world
{
	return [[[self alloc] initTableWithWorld:world] autorelease];
}

-(void) addBumperAt:(CGPoint)pos
{
    Bumper* bumper = [Bumper bumperWithWorld:world_ position:pos];
	[self addChild:bumper];
}

//暂时没用到
-(void) createStaticBodyWithVertices:(b2Vec2[])vertices numVertices:(int)numVertices
{
	// Create a body definition 
	b2BodyDef bodyDef;
	bodyDef.position = [Helper toMeters:[Helper screenCenter]];
	
	b2PolygonShape shape;
	shape.Set(vertices, numVertices);
	
	b2FixtureDef fixtureDef;
	fixtureDef.shape = &shape;
	fixtureDef.density = 1.0f;
	fixtureDef.friction = 0.2f;
	fixtureDef.restitution = 0.1f;

	b2Body* body = world_->CreateBody(&bodyDef);
	body->CreateFixture(&fixtureDef);
}
//暂时没用到
-(void) createLanes
{
	// right lane
	{
		//row 1, col 1
		int num = 5;
		b2Vec2 vertices[] = {
			b2Vec2(100.9f / PTM_RATIO, -143.9f / PTM_RATIO),
			b2Vec2(91.4f / PTM_RATIO, -145.0f / PTM_RATIO),
			b2Vec2(58.2f / PTM_RATIO, -164.4f / PTM_RATIO),
			b2Vec2(76.3f / PTM_RATIO, -185.5f / PTM_RATIO),
			b2Vec2(92.1f / PTM_RATIO, -176.1f / PTM_RATIO),
		};
		[self createStaticBodyWithVertices:vertices numVertices:num];
	}
	// left lane
	{
		//row 1, col 1
		int num = 5;
		b2Vec2 vertices[] = {
			b2Vec2(-65.6f / PTM_RATIO, -165.1f / PTM_RATIO),
			b2Vec2(-119.3f / PTM_RATIO, -125.2f / PTM_RATIO),
			b2Vec2(-126.7f / PTM_RATIO, -128.3f / PTM_RATIO),
			b2Vec2(-126.7f / PTM_RATIO, -136.1f / PTM_RATIO),
			b2Vec2(-83.3f / PTM_RATIO, -175.6f / PTM_RATIO)
		};
		[self createStaticBodyWithVertices:vertices numVertices:num];
	}
}

-(void) update:(ccTime)delta
{
	CCSprite* sprite;
	CCARRAY_FOREACH([batch children], sprite)
	{
       CGPoint pos = sprite.position;
		pos.x -= 1.0f;
		
		// Reposition stripes when they're out of bounds
		if (pos.x < -screenSize.width)
		{
			pos.x += (screenSize.width * 2) - 2;
		}
		
		sprite.position = pos;
	}
}


-(BulletCache*) bulletCache
{
	CCNode* node = [self getChildByTag:BulletCacheTag];
	NSAssert([node isKindOfClass:[BulletCache class]], @"not a BulletCache");
	return (BulletCache*)node;
}

-(ShipEntity*) defaultShip
{
	CCNode* node = [self getChildByTag:ShipTag];
	NSAssert([node isKindOfClass:[ShipEntity class]], @"node is not a ShipEntity!");
	return (ShipEntity*)node;
}

+(CGRect) screenRect
{
	return screenRect;
}

-(void) dealloc
{
	[super dealloc];
}
@end
