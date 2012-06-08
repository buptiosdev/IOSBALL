//
//  CandyEntity.m
//  ShootEmUp
//
//  Created by Steffen Itterheim on 20.08.10.
//  Copyright 2010 Steffen Itterheim. All rights reserved.
//

#import "CandyEntity.h"
#import "GameBackgroundLayer.h"
#import "BodyObjectsLayer.h"

@interface CandyEntity (PrivateMethods)
//-(void) initSpawnFrequency;
-(id)initCandyWithParam:(CandyParam)candyParam World:(b2World *)world;
@end

@implementation CandyEntity
@synthesize sprite = _sprite;
@synthesize candyType = _candyType;

-(void) dealloc
{
	//[[CCTouchDispatcher sharedDispatcher] removeDelegate:self];
	[super dealloc];
}


-(void)moveTheBallRandom:(CGPoint)curPosition forceOut:(b2Vec2 *)force
{
    CGPoint velocity = CGPointMake(CCRANDOM_MINUS1_1(), CCRANDOM_MINUS1_1());
//    srandom(time(NULL));
    if (curPosition.x < 50)
    {
        velocity.x = 2;
    }
    else if (curPosition.x > 410)
    {
        velocity.x = -2;
    }
    
    if (curPosition.y < 70)
    {
        velocity.y = 2;
    }
    else if (curPosition.y > 270)
    {
        velocity.y = -2;
    }
    candyVelocity = ccpAdd(velocity, candyVelocity);
    
    b2Vec2 fingerPos = [Helper toMeters:velocity];
    
    *force = 3 * fingerPos;
    
}

-(void)moveTheKillerBall:(CGPoint)curPosition forceOut:(b2Vec2 *)force
{
    CGPoint velocity = CGPointMake(CCRANDOM_MINUS1_1(), CCRANDOM_MINUS1_1());
//    srandom(time(NULL));

    if (curPosition.y < 70)
    {
        velocity.y = 3;
    }

    candyVelocity = ccpAdd(velocity, candyVelocity);

    b2Vec2 fingerPos = [Helper toMeters:velocity];

    *force = 5 * fingerPos;
    
}


-(void)moveBalloom:(CGPoint)curPosition forceOut:(b2Vec2 *)force
{
    CGPoint velocity = CGPointMake(CCRANDOM_MINUS1_1() * 3, CCRANDOM_MINUS1_1() * 4);	

    if (curPosition.y < 70)
    {
        velocity.y = 1;
    }

    
    candyVelocity = ccpAdd(velocity, candyVelocity);
    
    
    b2Vec2 fingerPos = [Helper toMeters:velocity];


    
    *force = 4 * fingerPos;
    
}

-(void)addDownForth:(CGPoint)curPosition forceOut:(b2Vec2 *)force
{
    CGPoint positionNew = CGPointMake(0, -10);
    
    b2Vec2 bodyPos = [Helper toMeters:positionNew];
    
    *force = bodyPos;
    
}

-(void)changeTheForth
{
    ballMove = @selector(addDownForth:forceOut:);
}

-(void) update:(ccTime)delta
{
//    if (self.sprite.visible)
//	{
//        b2Vec2 bodyPos = self.body->GetWorldCenter();
//        CGPoint bodyPosition = [Helper toPixels:bodyPos];
//        b2Vec2 force;
//        //函数指针
//        //void(*getForchFunc)(id, SEL, CGPoint);
//
//        //IMP getForchFunc = [self methodForSelector:ballMove];
//        //getForchFunc(self, ballMove, bodyPosition, &force);
//
//        //  SEL a = @selector(moveTheBallRandom: forceOut:);
//        IMP getForchFunc = [self methodForSelector:ballMove];
//        getForchFunc(self, ballMove, bodyPosition, &force); 
//        
//        self.body->ApplyForce(force, self.body->GetWorldCenter());
//        
//	}    
    if (self.sprite.visible)
    {
        float mass = self.body->GetMass();  
        float density = 0;  
        density = self.body->GetFixtureList()->GetDensity();  

        float volumn = mass / density;  
        
        // mass = rho * volumn，水的密度是1.0，  

        self.body->ApplyForce(b2Vec2(CCRANDOM_MINUS1_1() * volumn, CCRANDOM_MINUS1_1() * volumn), self.body->GetWorldCenter());    
    }
}




+(id)CandyWithParam:(CandyParam)candyParam World:(b2World *)world
{
	return [[[self alloc] initCandyWithParam:candyParam World:world] autorelease];
}

//定义几种球的属性 
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
    candyParamDef.initialHitPoints = (0 == param.initialHitPoints) ? 1 : param.initialHitPoints;

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
    candyParamDef.linearDamping = (0 == param.restitution) ? 0.1 : param.linearDamping;
    candyParamDef.angularDamping = (0 == param.restitution) ? 0.1 : param.angularDamping;
    candyParamDef.friction = (0 == param.friction) ? 0.2 : param.friction;
    candyParamDef.radius = (0 == param.density) ? 0.5 : param.radius;
    candyParamDef.initialHitPoints = (0 == param.initialHitPoints) ? 1 : param.initialHitPoints;
    
}

-(void)initBalloom:(CandyParam)param
{
    ballMove = @selector(moveBalloom:forceOut:);
    candyParamDef.startPos = param.startPos;
    candyParamDef.isDynamicBody = param.isDynamicBody;
    candyParamDef.ballType = param.ballType;
    candyParamDef.spriteFrameName = @"cake3.png";
    candyParamDef.density = (0 == param.density) ? 0.2 : param.density;
    candyParamDef.restitution = (0 == param.restitution) ? 0.5 : param.restitution;
    candyParamDef.linearDamping = (0 == param.restitution) ? 0.2 : param.linearDamping;
    candyParamDef.angularDamping = (0 == param.restitution) ? 0.3 : param.angularDamping;
    candyParamDef.friction = (0 == param.friction) ? 0.2 : param.friction;
    candyParamDef.radius = (0 == param.density) ? 0.5 : param.radius;
    candyParamDef.initialHitPoints = (0 == param.initialHitPoints) ? 1 : param.initialHitPoints;

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

//糖果进入游戏
-(void)spawn:(int)enterPosition
{
    CGPoint appearPosition;
    CGPoint positionNew;
    b2Vec2 enterForce;
//    srandom(time(NULL));
    self.hitPoints = self.initialHitPoints;
    switch (enterPosition) 
    {
        case PositionOne:
            appearPosition = CGPointMake(30, 200);
            self.sprite.position = CGPoint(appearPosition);
            self.sprite.visible = YES;
            self.body->SetTransform([Helper toMeters:appearPosition], 0);
            positionNew = CGPointMake(5 * CCRANDOM_0_1(), CCRANDOM_MINUS1_1()*5);
            enterForce = [Helper toMeters:positionNew];
            self.body->ApplyForce(enterForce, self.body->GetWorldCenter());
            break;
            
        case PositionTwo:
            appearPosition = CGPointMake(120, 320);
            self.sprite.position = CGPoint(appearPosition);
            self.sprite.visible = YES;
            self.body->SetTransform([Helper toMeters:appearPosition], 0);
            positionNew = CGPointMake(CCRANDOM_MINUS1_1()*5, -5 * CCRANDOM_0_1());
            enterForce = [Helper toMeters:positionNew];
            self.body->ApplyForce(enterForce, self.body->GetWorldCenter());
            break;
            
        case PositionThree:
            appearPosition = CGPointMake(220, 320);
            self.sprite.position = CGPoint(appearPosition);
            self.sprite.visible = YES;
            self.body->SetTransform([Helper toMeters:appearPosition], 0);
            positionNew = CGPointMake(CCRANDOM_MINUS1_1()*2, -2 * CCRANDOM_0_1());
            enterForce = [Helper toMeters:positionNew];
            self.body->ApplyForce(enterForce, self.body->GetWorldCenter());
            break;
            
        case PositionFour:
            appearPosition = CGPointMake(320, 320);
            self.sprite.position = CGPoint(appearPosition);
            self.sprite.visible = YES;
            self.body->SetTransform([Helper toMeters:appearPosition], 0);
            positionNew = CGPointMake(CCRANDOM_MINUS1_1()*3, -3 * CCRANDOM_0_1());
            enterForce = [Helper toMeters:positionNew];
            self.body->ApplyForce(enterForce, self.body->GetWorldCenter());
            break;
            
        case PositionFive:
            appearPosition = CGPointMake(420, 200);
            self.sprite.position = CGPoint(appearPosition);
            self.sprite.visible = YES;
            self.body->SetTransform([Helper toMeters:appearPosition], 0);
            positionNew = CGPointMake(-3 * CCRANDOM_0_1(), CCRANDOM_MINUS1_1()*3);
            enterForce = [Helper toMeters:positionNew];
            self.body->ApplyForce(enterForce, self.body->GetWorldCenter());
            break;
            
        default:
            break;
    }
}

//传入结构体 初始化糖果
-(id)initCandyWithParam:(CandyParam)CandyParam World:(b2World *)world
{
    if ((self = [super init]))
    {
        srandom(time(NULL));
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
        
        //刚体形状 
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
        
        //添加到world
        [super createBodyInWorld:world 
                         bodyDef:&bodyDef 
                      fixtureDef:&fixtureDef]; 
        self.sprite.position = candyParamDef.startPos;
        self.candyType = candyParamDef.ballType;
        
        [self scheduleUpdate];
    }
    
    return self;
}


@end
