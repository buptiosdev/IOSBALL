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
    
    firstEnemyParam.initialHitPoints = 4;

    firstEnemyParam.startPos=CGPoint(startPos);

    firstEnemyParam.isDynamicBody = isDynamicBody;

    firstEnemyParam.ballType = ballType;
    
    EnemyEntity* enemy = [EnemyEntity enemyWithParam:firstEnemyParam World:world];
    [self addChild:enemy z:0 tag:taget];
    [enemies addObject:enemy];
}





-(void)initFstSceneEnemy:(b2World *)world
{
    enemyNum = 1;
    enemies = [[CCArray alloc] initWithCapacity:enemyNum];
	CGRect screenRect = [TableSetup screenRect];

    CGPoint startPos1=CGPointMake(screenRect.size.width / 2, screenRect.size.height / 4);
    [self defineBall:world Type:BallTypeRandomBall Pos:startPos1 Dynamic:YES Tag:1];

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
    
    
}

-(void)initThrdSceneEnemy:(b2World *)world
{
    enemyNum = 5;
    enemies = [[CCArray alloc] initWithCapacity:enemyNum];
	CGRect screenRect = [TableSetup screenRect];
    
    CGPoint startPos1=CGPointMake(screenRect.size.width / 2, screenRect.size.height / 2);
    [self defineBall:world Type:BallTypeRandomBall Pos:startPos1 Dynamic:YES Tag:1];
    
    CGPoint startPos2=CGPointMake(screenRect.size.width / 4 * 3, screenRect.size.height / 4 * 3);
    [self defineBall:world Type:BallTypeKillerBall Pos:startPos2 Dynamic:YES Tag:2];
    
    CGPoint startPos3=CGPointMake(screenRect.size.width / 4, screenRect.size.height / 4);
    [self defineBall:world Type:BallTypeRandomBall Pos:startPos3 Dynamic:YES Tag:3];   
    
    CGPoint startPos4=CGPointMake(screenRect.size.width / 4 * 3, screenRect.size.height / 4);
    [self defineBall:world Type:BallTypeKillerBall Pos:startPos4 Dynamic:YES Tag:4];
    
    CGPoint startPos5=CGPointMake(screenRect.size.width / 4 * 3, screenRect.size.height / 4 * 3);
    [self defineBall:world Type:BallTypeBalloom Pos:startPos5 Dynamic:YES Tag:5];
    
    /*
    enemyNum = 5;
    enemies = [[CCArray alloc] initWithCapacity:enemyNum];
    
    EnemyParam firstEnemyParam;
    EnemyParam secondEnemyParam;
    EnemyParam EnemyParam3;
    EnemyParam EnemyParam4;
    EnemyParam EnemyParam5;    
	CGRect screenRect = [TableSetup screenRect];
    
    firstEnemyParam.initialHitPoints = 5;
    //firstEnemyParam.radius = 1;
    firstEnemyParam.startPos=CGPointMake(screenRect.size.width / 3, screenRect.size.height / 5*3);
    firstEnemyParam.friction = 0.5f;
    firstEnemyParam.restitution = 0.3f;
    firstEnemyParam.restitution = 0.9f;
    firstEnemyParam.density = 0.9f;
    firstEnemyParam.isDynamicBody = YES;
    firstEnemyParam.spriteFrameName = @"pic_3.png";
    
    EnemyEntity* enemy1 = [EnemyEntity enemyWithParam:firstEnemyParam World:world];
    [self addChild:enemy1 z:0 tag:12];    
    [enemies addObject:enemy1];
    
    //###############################################################
    secondEnemyParam.initialHitPoints = 7;
    //firstEnemyParam.radius = 1;
    secondEnemyParam.startPos=CGPointMake(screenRect.size.width / 5, screenRect.size.height / 4 *2);
    secondEnemyParam.friction = 0.8f;
    secondEnemyParam.restitution = 0.9f;
    secondEnemyParam.restitution = 0.9f;
    secondEnemyParam.density = 0.7f;
    secondEnemyParam.isDynamicBody = YES;
    secondEnemyParam.spriteFrameName = @"pic_2.png";
    
    EnemyEntity* enemy2 = [EnemyEntity enemyWithParam:secondEnemyParam World:world];
    [self addChild:enemy2 z:0 tag:12];    
    [enemies addObject:enemy2];
    
    
    //###############################################################    
    EnemyParam3.initialHitPoints = 4;
    //firstEnemyParam.radius = 1;
    EnemyParam3.startPos=CGPointMake(screenRect.size.width / 5, screenRect.size.height / 7 * 3);
    EnemyParam3.friction = 0.8f;
    EnemyParam3.restitution = 0.9f;
    EnemyParam3.restitution = 0.9f;
    EnemyParam3.density = 0.7f;
    EnemyParam3.isDynamicBody = YES;
    EnemyParam3.spriteFrameName = @"pic_2.png";
    
    EnemyEntity* enemy3 = [EnemyEntity enemyWithParam:EnemyParam3 World:world];
    [self addChild:enemy3 z:0 tag:12];    
    [enemies addObject:enemy3];
    
    
    //###############################################################   
    EnemyParam4.initialHitPoints = 6;
    //firstEnemyParam.radius = 1;
    EnemyParam4.startPos=CGPointMake(screenRect.size.width / 2, screenRect.size.height / 9 * 4);
    EnemyParam4.friction = 0.8f;
    EnemyParam4.restitution = 0.9f;
    EnemyParam4.restitution = 0.9f;
    EnemyParam4.density = 0.7f;
    EnemyParam4.isDynamicBody = YES;
    EnemyParam4.spriteFrameName = @"pic_4.png";    
    
    EnemyEntity* enemy4 = [EnemyEntity enemyWithParam:EnemyParam4 World:world];
    [self addChild:enemy4 z:0 tag:12];    
    [enemies addObject:enemy4];    
    
    //###############################################################  
    
    
    EnemyParam5.initialHitPoints = 3;
    //firstEnemyParam.radius = 1;
    EnemyParam5.startPos=CGPointMake(screenRect.size.width / 4, screenRect.size.height / 9 * 7);
    EnemyParam5.friction = 0.8f;
    EnemyParam5.restitution = 0.9f;
    EnemyParam5.restitution = 0.9f;
    EnemyParam5.density = 0.7f;
    EnemyParam5.isDynamicBody = YES;
    EnemyParam5.spriteFrameName = @"pic_2.png";
    
    EnemyEntity* enemy5 = [EnemyEntity enemyWithParam:EnemyParam5 World:world];
    [self addChild:enemy5 z:0 tag:12];    
    [enemies addObject:enemy5];    
    */
}

-(void) dealloc
{
	[enemies release];
	[super dealloc];
}


@end
