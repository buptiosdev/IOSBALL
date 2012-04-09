//
//  StaticTable.m
//  PhysicsBox2d
//
//  Created by Steffen Itterheim on 22.09.10.
//  Copyright 2010 Steffen Itterheim. All rights reserved.
//

#import "TableSetup.h"
#import "Helper.h"
//#import "Bumper.h"
#import "ShipEntity.h"
#import "EnemyCache.h"
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

-(id) initTableWithWorld:(b2World*)world Order:(int)order
{
	if ((self = [super init]))
	{
        instanceOfTable = self;
		
        screenSize = [[CCDirector sharedDirector] winSize];
        screenRect = CGRectMake(0, 0, screenSize.width, screenSize.height);
        
        //加载一些云作为背景 
        //[self addCloud];

        //加载角色层
        ShipEntity* ship = [ShipEntity ship:world];
        [self addChild:ship z:-1 tag:ShipTag];
		
        //加载敌人集中管理层
        EnemyCache* enemyCache = [EnemyCache cache:world Order:order];
        [self addChild:enemyCache z:-1 tag:EnemyCacheTag];
        
        // Add some bumpers 弹簧体
        //[self addBumperAt:CGPointMake(30, 30)];
        //[self addBumperAt:CGPointMake(30, screenSize.height - 30)];
        //[self addBumperAt:CGPointMake(screenSize.width - 30, 30)];
        //[self addBumperAt:CGPointMake(screenSize.width - 30, screenSize.height - 30)];

        //[self scheduleUpdate];	
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

+(id)setupTableWithWorld:(b2World*)world Order:(int)order
{
	return [[[self alloc] initTableWithWorld:world Order:order] autorelease];
}

//-(void) addBumperAt:(CGPoint)pos
//{
//    Bumper* bumper = [Bumper bumperWithWorld:world_ position:pos];
//	[self addChild:bumper];
//}

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
