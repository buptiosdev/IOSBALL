//
//  EnemyCache.m
//  ShootEmUp
//
//  Created by Steffen Itterheim on 20.08.10.
//  Copyright 2010 Steffen Itterheim. All rights reserved.
//

#import "EnemyCache.h"
#import "EnemyEntity.h"
#import "MainScene.h"
#import "TableSetup.h"
#import "Box2D.h"
#import "LoadingScene.h"

@interface EnemyCache (PrivateMethods)
-(void)initEnemiesByOrder :(b2World *)world Order:(int)order;
-(id)initWithWorld:(b2World *)world Order:(int)order;
-(void)initFstSceneEnemy:(b2World *)world;
-(void)initScdSceneEnemy:(b2World *)world;
-(void)initThrdSceneEnemy:(b2World *)world;
@end


@implementation EnemyCache

+(id) cache:(b2World *)world Order:(int)order
{
	return [[[self alloc] initWithWorld:world Order:order] autorelease];
}


-(id)initWithWorld:(b2World *)world Order:(int)order
{
	if ((self = [super init]))
	{
		// get any image from the Texture Atlas we're using
		//CCSpriteFrame* frame = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"monster-a.png"];
		//batch = [CCSpriteBatchNode batchNodeWithTexture:frame.texture];
		//[self addChild:batch];
		
		[self initEnemiesByOrder:world Order:order];

	}
	
	return self;    
}


-(void) initEnemiesByOrder:(b2World *)world Order:(int)order
{
    switch (order) {
        case TargetSceneFstScene:
            [self initFstSceneEnemy:world];
            break;
        case TargetSceneScdScene:
            [self initScdSceneEnemy:world];
            break;
        case TargetSceneThrdScene:
            [self initThrdSceneEnemy:world];
            break;
        default:
            NSAssert1(nil, @"unsupported TargetScene %i", order);
            break;
    }
}

-(void)abc:(CGPoint)curPosition forceOut:(b2Vec2 *)force
{
    //CCLOG("x=%d, y=%f\n", curPosition.x, curPosition.y);
    *force = [Helper toMeters:curPosition];
}


-(void)defineBall:(b2World *)world Type:(int)ballType Pos:(CGPoint)startPos Dynamic:(BOOL)isDynamicBody Tag:(int)taget
{
    EnemyParam firstEnemyParam = {0};
    
    //firstEnemyParam.initialHitPoints = 4;

    firstEnemyParam.startPos=CGPoint(startPos);

    firstEnemyParam.isDynamicBody = isDynamicBody;

    firstEnemyParam.ballType = ballType;
    
    EnemyEntity* enemy = [EnemyEntity enemyWithParam:firstEnemyParam World:world];
    [self addChild:enemy z:1 tag:taget];
    [enemies addObject:enemy];
}





-(void)initFstSceneEnemy:(b2World *)world
{
    enemyNum = 1;
    enemies = [[CCArray alloc] initWithCapacity:enemyNum];
	CGRect screenRect = [TableSetup screenRect];

    CGPoint startPos1=CGPointMake(screenRect.size.width / 2, screenRect.size.height / 4);
    [self defineBall:world Type:BallTypeRandomBall Pos:startPos1 Dynamic:YES Tag:1];

    //添加场景的粒子效果
	// remove any previous particle FX
    [self removeChildByTag:1 cleanup:YES];    
    
    CCParticleSystem* system;    
    system = [CCParticleRain node];    
    
    [self addChild:system z:1 tag:15];    
    
    
    
}




-(void)initScdSceneEnemy:(b2World *)world
{
    
    enemyNum = 2;
    enemies = [[CCArray alloc] initWithCapacity:enemyNum];
	CGRect screenRect = [TableSetup screenRect];
    
    CGPoint startPos1=CGPointMake(screenRect.size.width / 2, screenRect.size.height / 4);
    [self defineBall:world Type:BallTypeRandomBall Pos:startPos1 Dynamic:YES Tag:1];
    
    CGPoint startPos2=CGPointMake(screenRect.size.width / 4, screenRect.size.height / 4);
    [self defineBall:world Type:BallTypeKillerBall Pos:startPos2 Dynamic:YES Tag:2];

    //添加场景的粒子效果
	// remove any previous particle FX
    [self removeChildByTag:1 cleanup:YES];    
    
    CCParticleSystem* system;    
    system = [CCParticleSnow node];  
    
    [self addChild:system z:1 tag:15];       
    
    
    
    
}

-(void)initThrdSceneEnemy:(b2World *)world
{
    enemyNum = 5;
    enemies = [[CCArray alloc] initWithCapacity:enemyNum];
	CGRect screenRect = [TableSetup screenRect];
    
    CGPoint startPos1=CGPointMake(screenRect.size.width / 2, screenRect.size.height / 2);
    [self defineBall:world Type:BallTypeBalloom Pos:startPos1 Dynamic:YES Tag:1];
    
    CGPoint startPos2=CGPointMake(screenRect.size.width / 4 * 3, screenRect.size.height / 4 * 3);
    [self defineBall:world Type:BallTypeKillerBall Pos:startPos2 Dynamic:YES Tag:2];
    
    CGPoint startPos3=CGPointMake(screenRect.size.width / 4, screenRect.size.height / 4);
    [self defineBall:world Type:BallTypeRandomBall Pos:startPos3 Dynamic:YES Tag:3];   
    
    CGPoint startPos4=CGPointMake(screenRect.size.width / 4 * 3, screenRect.size.height / 4);
    [self defineBall:world Type:BallTypeKillerBall Pos:startPos4 Dynamic:YES Tag:4];
    
    CGPoint startPos5=CGPointMake(screenRect.size.width / 4 * 3, screenRect.size.height / 4 * 3);
    [self defineBall:world Type:BallTypeBalloom Pos:startPos5 Dynamic:YES Tag:5];
    
    //添加场景的粒子效果
	// remove any previous particle FX
    [self removeChildByTag:1 cleanup:YES];    
    
    CCParticleSystem* system;    
    system = [CCParticleGalaxy node];
    
    [self addChild:system z:1 tag:15]; 
    
    
}

-(void) dealloc
{
	[enemies release];
	[super dealloc];
}


@end
