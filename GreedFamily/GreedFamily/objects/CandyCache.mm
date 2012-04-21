//
//  CandyCache.m
//  ShootEmUp
//
//  Created by Steffen Itterheim on 20.08.10.
//  Copyright 2010 Steffen Itterheim. All rights reserved.
//

#import "CandyCache.h"
#import "CandyEntity.h"
#import "Box2D.h"
#import "LoadingScene.h"
#import "GameMainScene.h"
#import "BodyObjectsLayer.h"

@interface CandyCache (PrivateMethods)
-(void)initEnemiesWithWorld:(b2World *)world;
-(id)initWithWorld:(b2World *)world;
-(void)initFstScenecache:(b2World *)world;
-(void)initScdScenecache:(b2World *)world;
-(void)initThrdScenecache:(b2World *)world;
@end


@implementation CandyCache

+(id) cache:(b2World *)world
{
	return [[[self alloc] initWithWorld:world] autorelease];
}


-(id)initWithWorld:(b2World *)world 
{
	if ((self = [super init]))
	{
		// get any image from the Texture Atlas we're using
		//CCSpriteFrame* frame = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"monster-a.png"];
		//batch = [CCSpriteBatchNode batchNodeWithTexture:frame.texture];
		//[self addChild:batch];
		
		[self initEnemiesWithWorld:world];

	}
	
	return self;    
}


-(void) initEnemiesWithWorld:(b2World *)world 
{
    /*获取关卡号*/
    int order = [GameMainScene sharedMainScene].sceneNum;
    
    switch (order) {
        case TargetSceneFstScene:
            [self initFstScenecache:world];
            break;
        case TargetSceneScdScene:
            [self initScdScenecache:world];
            break;
        case TargetSceneThrdScene:
            [self initThrdScenecache:world];
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
    CandyParam cacheParam = {0};
    
    //firstcacheParam.initialHitPoints = 4;

    cacheParam.startPos=CGPoint(startPos);

    cacheParam.isDynamicBody = isDynamicBody;

    cacheParam.ballType = ballType;
    
    CandyEntity* cache = [CandyEntity CandyWithParam:cacheParam World:world];
    [self addChild:cache z:1 tag:taget];
    [candies addObject:cache];
}





-(void)initFstScenecache:(b2World *)world
{
    cacheNum = 1;
    candies = [[CCArray alloc] initWithCapacity:cacheNum];
	CGRect screenRect = [BodyObjectsLayer screenRect];

    CGPoint startPos1=CGPointMake(screenRect.size.width / 2, screenRect.size.height / 4);
    [self defineBall:world Type:BallTypeRandomBall Pos:startPos1 Dynamic:YES Tag:1];

    //添加场景的粒子效果
	// remove any previous particle FX
    [self removeChildByTag:1 cleanup:YES];    
    
    CCParticleSystem* system;    
    system = [CCParticleRain node];    
    
    [self addChild:system z:1 tag:15];       
    
}




-(void)initScdScenecache:(b2World *)world
{
    
    cacheNum = 2;
    candies = [[CCArray alloc] initWithCapacity:cacheNum];
	CGRect screenRect = [BodyObjectsLayer screenRect];
    
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

-(void)initThrdScenecache:(b2World *)world
{
    cacheNum = 5;
    candies = [[CCArray alloc] initWithCapacity:cacheNum];
	CGRect screenRect = [BodyObjectsLayer screenRect];
    
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
	[candies release];
	[super dealloc];
}


@end
