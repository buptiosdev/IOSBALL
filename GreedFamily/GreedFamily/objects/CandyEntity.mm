//
//  CandyEntity.m
//  ShootEmUp
//
//  Created by Steffen Itterheim on 20.08.10.
//  Copyright 2010 Steffen Itterheim. All rights reserved.
//

#import "CandyEntity.h"
#import "GameBackgroundLayer.h"

@interface CandyEntity (PrivateMethods)
//-(void) initSpawnFrequency;
-(id)initCandyWithParam:(CandyParam)candyParam World:(b2World *)world;
@end

@implementation CandyEntity
@synthesize sprite = _sprite;


-(void) dealloc
{
	//[[CCTouchDispatcher sharedDispatcher] removeDelegate:self];
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
    CGPoint velocity = CGPointMake(1.0f, CCRANDOM_MINUS1_1() * 0.1);
    CGPoint positionNew = ccpAdd(curPosition, velocity);
    
    b2Vec2 fingerPos = [Helper toMeters:positionNew];
    b2Vec2 bodyPos = [Helper toMeters:curPosition];
	
    b2Vec2 bodyToFinger = fingerPos - bodyPos;
    
    *force =  CCRANDOM_MINUS1_1() * 1000 * bodyToFinger;
    
}


-(void)moveBalloom:(CGPoint)curPosition forceOut:(b2Vec2 *)force
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

+(id)CandyWithParam:(CandyParam)candyParam World:(b2World *)world
{
	return [[[self alloc] initCandyWithParam:candyParam World:world] autorelease];
}

-(void)initRandomBall:(CandyParam)param
{
    ballMove = @selector(moveTheBallRandom:forceOut:);
    candyParamDef.startPos = param.startPos;
    candyParamDef.isDynamicBody = param.isDynamicBody;
    candyParamDef.ballType = param.ballType;
    candyParamDef.spriteFrameName = @"puding2.png";
    candyParamDef.density = (0 == param.density) ? 0.5 : param.density;
    candyParamDef.restitution = (0 == param.restitution) ? 1.5 : param.restitution;
    candyParamDef.linearDamping = (0 == param.restitution) ? 0.2 : param.linearDamping;
    candyParamDef.angularDamping = (0 == param.restitution) ? 0.1 : param.angularDamping;
    candyParamDef.friction = (0 == param.friction) ? 0.5 : param.friction;
    candyParamDef.radius = (0 == param.density) ? 0.5 : param.radius;
    candyParamDef.initialHitPoints = (0 == param.initialHitPoints) ? 5 : param.initialHitPoints;

}

-(void)initkillerBall:(CandyParam)param
{
    ballMove = @selector(moveTheKillerBall:forceOut:);
    candyParamDef.startPos = param.startPos;
    candyParamDef.isDynamicBody = param.isDynamicBody;
    candyParamDef.ballType = param.ballType;
    candyParamDef.spriteFrameName = @"chocolate.png";
    candyParamDef.density = (0 == param.density) ? 0.8 : param.density;
    candyParamDef.restitution = (0 == param.restitution) ? 0.8 : param.restitution;
    candyParamDef.linearDamping = (0 == param.restitution) ? 0.5 : param.linearDamping;
    candyParamDef.angularDamping = (0 == param.restitution) ? 0.5 : param.angularDamping;
    candyParamDef.friction = (0 == param.friction) ? 0.2 : param.friction;
    candyParamDef.radius = (0 == param.density) ? 0.5 : param.radius;
    candyParamDef.initialHitPoints = (0 == param.initialHitPoints) ? 8 : param.initialHitPoints;
    
}

-(void)initBalloom:(CandyParam)param
{
    ballMove = @selector(moveBalloom:forceOut:);
    candyParamDef.startPos = param.startPos;
    candyParamDef.isDynamicBody = param.isDynamicBody;
    candyParamDef.ballType = param.ballType;
    candyParamDef.spriteFrameName = @"cake3.png";
    candyParamDef.density = (0 == param.density) ? 0.1 : param.density;
    candyParamDef.restitution = (0 == param.restitution) ? 0.5 : param.restitution;
    candyParamDef.linearDamping = (0 == param.restitution) ? 0.2 : param.linearDamping;
    candyParamDef.angularDamping = (0 == param.restitution) ? 0.3 : param.angularDamping;
    candyParamDef.friction = (0 == param.friction) ? 0.2 : param.friction;
    candyParamDef.radius = (0 == param.density) ? 0.5 : param.radius;
    candyParamDef.initialHitPoints = (0 == param.initialHitPoints) ? 8 : param.initialHitPoints;

}

-(void)initBallMove:(CandyParam)param
{
    switch (param.ballType) {
        case BallTypeRandomBall:
            [self initRandomBall:param];
            break;
        case BallTypeKillerBall:
            [self initkillerBall:param];
            break;
        case BallTypeBalloom:
            [self initBalloom:param];
            break;
        default:
            break;
    }
}

-(id)initCandyWithParam:(CandyParam)CandyParam World:(b2World *)world
{
    if ((self = [super init]))
    {
        [self initBallMove:CandyParam];
        
        CCSpriteBatchNode* batch = [[GameBackgroundLayer sharedGameBackgroundLayer] getSpriteBatch];
        self.sprite = [CCSprite spriteWithSpriteFrameName:candyParamDef.spriteFrameName];
        [batch addChild:self.sprite];       
        
        hitPoints = candyParamDef.initialHitPoints;
        initialHitPoints = candyParamDef.initialHitPoints;

        b2BodyDef bodyDef;
        bodyDef.position = [Helper toMeters:candyParamDef.startPos];
        
        if (candyParamDef.isDynamicBody)
        {
            bodyDef.type = b2_dynamicBody;
        }
        //阻力
        bodyDef.angularDamping = candyParamDef.angularDamping;
        bodyDef.linearDamping = candyParamDef.linearDamping;
        
        b2CircleShape circleShape;
        float radiusInMeters = (self.sprite.contentSize.width / PTM_RATIO) * 0.5f;
        circleShape.m_radius = radiusInMeters;
        
        // Define the dynamic body fixture.
        b2FixtureDef fixtureDef;
        fixtureDef.shape = &circleShape;
        fixtureDef.density = candyParamDef.density;
        fixtureDef.friction = candyParamDef.friction;
        fixtureDef.restitution = candyParamDef.restitution;
        
//        [super initSprite:candyParamDef.spriteFrameName];
        
//        [super createBodyInWorld:world 
//                         bodyDef:&bodyDef 
//                      fixtureDef:&fixtureDef
//                      spriteFrameName:candyParamDef.spriteFrameName]; 
        
        [super createBodyInWorld:world 
                         bodyDef:&bodyDef 
                      fixtureDef:&fixtureDef]; 
        self.sprite.position = candyParamDef.startPos;
        [self scheduleUpdate];
    }
    
    return self;
}


@end
