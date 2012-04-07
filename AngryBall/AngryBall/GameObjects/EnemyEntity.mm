//
//  EnemyEntity.m
//  ShootEmUp
//
//  Created by Steffen Itterheim on 20.08.10.
//  Copyright 2010 Steffen Itterheim. All rights reserved.
//

#import "EnemyEntity.h"
#import "MainScene.h"

#import "TableSetup.h"

@interface EnemyEntity (PrivateMethods)
//-(void) initSpawnFrequency;
-(id)initenemyWithParam:(EnemyParam)enemyParam World:(b2World *)world;
@end

@implementation EnemyEntity



-(void) dealloc
{
	[[CCTouchDispatcher sharedDispatcher] removeDelegate:self];
	[super dealloc];
}


-(void)moveTheBallRandom:(CGPoint)curPosition forceOut:(b2Vec2 *)force
{
    CGPoint velocity = CGPointMake(CCRANDOM_MINUS1_1()*0.1, CCRANDOM_MINUS1_1() * 0.1);	
    CGPoint positionNew = ccpAdd(curPosition, velocity);
    
    b2Vec2 fingerPos = [Helper toMeters:positionNew];
    b2Vec2 bodyPos = [Helper toMeters:curPosition];
	
    b2Vec2 bodyToFinger = fingerPos - bodyPos;
    
    *force = 20 * bodyToFinger;
    
}

-(void)moveTheKillerBall:(CGPoint)curPosition forceOut:(b2Vec2 *)force
{
    CGPoint velocity = CGPointMake(CCRANDOM_MINUS1_1()*0.1, CCRANDOM_MINUS1_1() * 0.1);	
    CGPoint positionNew = ccpAdd(curPosition, velocity);
    
    b2Vec2 fingerPos = [Helper toMeters:positionNew];
    b2Vec2 bodyPos = [Helper toMeters:curPosition];
	
    b2Vec2 bodyToFinger = fingerPos - bodyPos;
    
    *force =  CCRANDOM_MINUS1_1() * 1000 * bodyToFinger;
    
}


-(void)moveBalloom:(CGPoint)curPosition forceOut:(b2Vec2 *)force
{
    CGPoint velocity = CGPointMake(CCRANDOM_MINUS1_1()*0.1, CCRANDOM_MINUS1_1() * 0.1);	
    CGPoint positionNew = ccpAdd(curPosition, velocity);
    
    b2Vec2 fingerPos = [Helper toMeters:positionNew];
    b2Vec2 bodyPos = [Helper toMeters:curPosition];
	
    b2Vec2 bodyToFinger = fingerPos - bodyPos;
    
    *force = 20 * bodyToFinger;
    
}

-(void) update:(ccTime)delta
{
    CCLOG(@"hello\n");
    if (self.sprite.visible)
	{
        b2Vec2 bodyPos = body->GetWorldCenter();
        CGPoint bodyPosition = [Helper toPixels:bodyPos];
        b2Vec2 force;
        //函数指针
        //void(*getForchFunc)(id, SEL, CGPoint);

        //IMP getForchFunc = [self methodForSelector:ballMove];
        //getForchFunc(self, ballMove, bodyPosition, &force);

        //  SEL a = @selector(moveTheBallRandom: forceOut:);
        IMP getForchFunc = [self methodForSelector:ballMove];
        getForchFunc(self, ballMove, bodyPosition, &force); 
        
        body->ApplyForce(force, body->GetWorldCenter());
        
	}    
}

+(id)enemyWithParam:(EnemyParam)firstEnemyParam World:(b2World *)world
{
	return [[[self alloc] initenemyWithParam:firstEnemyParam World:world] autorelease];
}

-(void)initRandomBall:(EnemyParam)param
{
    ballMove = @selector(moveTheBallRandom:forceOut:);
    enemyParamDef.startPos = param.startPos;
    enemyParamDef.isDynamicBody = param.isDynamicBody;
    enemyParamDef.ballType = param.ballType;
    enemyParamDef.spriteFrameName = @"pic_4.png";
    enemyParamDef.density = (0 == param.density) ? 0.5 : param.density;
    enemyParamDef.restitution = (0 == param.restitution) ? 0.5 : param.restitution;
    enemyParamDef.friction = (0 == param.friction) ? 0.5 : param.friction;
    enemyParamDef.radius = (0 == param.density) ? 0.5 : param.radius;
    enemyParamDef.initialHitPoints = (0 == param.initialHitPoints) ? 5 : param.initialHitPoints;

}

-(void)initkillerBall:(EnemyParam)param
{
    ballMove = @selector(moveTheKillerBall:forceOut:);
    enemyParamDef.startPos = param.startPos;
    enemyParamDef.isDynamicBody = param.isDynamicBody;
    enemyParamDef.ballType = param.ballType;
    enemyParamDef.spriteFrameName = @"pic_3.png";
    enemyParamDef.density = (0 == param.density) ? 0.8 : param.density;
    enemyParamDef.restitution = (0 == param.restitution) ? 0.8 : param.restitution;
    enemyParamDef.friction = (0 == param.friction) ? 0.2 : param.friction;
    enemyParamDef.radius = (0 == param.density) ? 0.5 : param.radius;
    enemyParamDef.initialHitPoints = (0 == param.initialHitPoints) ? 8 : param.initialHitPoints;
    
}

-(void)initBalloom:(EnemyParam)param
{
    ballMove = @selector(moveBalloom:forceOut:);
    enemyParamDef.startPos = param.startPos;
    enemyParamDef.isDynamicBody = param.isDynamicBody;
    enemyParamDef.ballType = param.ballType;
    enemyParamDef.spriteFrameName = @"pic_2.png";
    enemyParamDef.density = (0 == param.density) ? 0.1 : param.density;
    enemyParamDef.restitution = (0 == param.restitution) ? 0.5 : param.restitution;
    enemyParamDef.friction = (0 == param.friction) ? 0.2 : param.friction;
    enemyParamDef.radius = (0 == param.density) ? 0.5 : param.radius;
    enemyParamDef.initialHitPoints = (0 == param.initialHitPoints) ? 8 : param.initialHitPoints;
    
}

-(void)initBallMove:(EnemyParam)param
{
    switch (param.ballType) {
        case BallTypeRandomBall:
            [self initRandomBall:param];
            break;
        case BallTypeKillerBall:
            [self initkillerBall:param];
            break;
        case BallTyBalloom:
            [self initBalloom:param];
            break;
        default:
            break;
    }
}

-(id)initenemyWithParam:(EnemyParam)enemyParam World:(b2World *)world
{
    if ((self = [super init]))
    {
        [self initBallMove:enemyParam];
        
        CCSprite* tempSprite = [CCSprite spriteWithSpriteFrameName:enemyParamDef.spriteFrameName];
        hitPoints = enemyParamDef.initialHitPoints;
        initialHitPoints = enemyParamDef.initialHitPoints;

        b2BodyDef bodyDef;
        bodyDef.position = [Helper toMeters:enemyParamDef.startPos];
        
        if (enemyParamDef.isDynamicBody)
        {
            bodyDef.type = b2_dynamicBody;
        }
        bodyDef.angularDamping = 0.5f;
        
        
        b2CircleShape circleShape;
        float radiusInMeters = (tempSprite.contentSize.width / PTM_RATIO) * 0.5f;
        circleShape.m_radius = radiusInMeters;
        
        // Define the dynamic body fixture.
        b2FixtureDef fixtureDef;
        fixtureDef.shape = &circleShape;
        fixtureDef.density = enemyParamDef.density;
        fixtureDef.friction = enemyParamDef.friction;
        fixtureDef.restitution = enemyParamDef.restitution;
        
        [super createBodyInWorld:world 
                         bodyDef:&bodyDef 
                      fixtureDef:&fixtureDef 
                 spriteFrameName:enemyParamDef.spriteFrameName]; 
        sprite.position = enemyParamDef.startPos;
        [self scheduleUpdate];
    }
    
    return self;
}




@end
