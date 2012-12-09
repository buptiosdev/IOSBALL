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
#import "GameMainScene.h"
@interface CandyEntity (PrivateMethods)
//-(void) initSpawnFrequency;
-(id)initCandyWithParam:(CandyParam)candyParam World:(b2World *)world;
@end

@implementation CandyEntity
@synthesize sprite = _sprite;
//@synthesize cover = _cover;
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
    //同步壳的位置
    self.cover.position = self.sprite.position;
    
    if (self.hitPoints != -1)
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
    candyParamDef.spriteFrameName = @"apple+.png";
    candyParamDef.density = (0 == param.density) ? 0.5 : param.density;
    candyParamDef.restitution = (0 == param.restitution) ? 0.8 : param.restitution;
    candyParamDef.linearDamping = (0 == param.linearDamping) ? 0.2 : param.linearDamping;
    candyParamDef.angularDamping = (0 == param.angularDamping) ? 0.1 : param.angularDamping;
    candyParamDef.friction = (0 == param.friction) ? 0.5 : param.friction;
    candyParamDef.radius = (0 == param.radius) ? 0.5 : param.radius;
    candyParamDef.initialHitPoints = (0 == param.initialHitPoints) ? 1 : param.initialHitPoints;

}

-(void)initkillerBall:(CandyParam)param
{
    ballMove = @selector(moveTheKillerBall:forceOut:);
    candyParamDef.startPos = param.startPos;
    candyParamDef.isDynamicBody = param.isDynamicBody;
    candyParamDef.ballType = param.ballType;
    candyParamDef.spriteFrameName = @"cheese+.png";
    candyParamDef.density = (0 == param.density) ? 0.6 : param.density;
    candyParamDef.restitution = (0 == param.restitution) ? 0.8 : param.restitution;
    candyParamDef.linearDamping = (0 == param.linearDamping) ? 0.1 : param.linearDamping;
    candyParamDef.angularDamping = (0 == param.angularDamping) ? 0.1 : param.angularDamping;
    candyParamDef.friction = (0 == param.friction) ? 0.2 : param.friction;
    candyParamDef.radius = (0 == param.radius) ? 0.5 : param.radius;
    candyParamDef.initialHitPoints = (0 == param.initialHitPoints) ? 1 : param.initialHitPoints;
    
}

-(void)initBalloom:(CandyParam)param
{
    ballMove = @selector(moveBalloom:forceOut:);
    candyParamDef.startPos = param.startPos;
    candyParamDef.isDynamicBody = param.isDynamicBody;
    candyParamDef.ballType = param.ballType;
    candyParamDef.spriteFrameName = @"candy+.png";
    candyParamDef.density = (0 == param.density) ? 0.2 : param.density;
    candyParamDef.restitution = (0 == param.restitution) ? 0.3 : param.restitution;
    candyParamDef.linearDamping = (0 == param.linearDamping) ? 0.2 : param.linearDamping;
    candyParamDef.angularDamping = (0 == param.angularDamping) ? 0.3 : param.angularDamping;
    candyParamDef.friction = (0 == param.friction) ? 0.2 : param.friction;
    candyParamDef.radius = (0 == param.radius) ? 0.5 : param.radius;
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
            //change size by diff version
            appearPosition = [GameMainScene sharedMainScene].appear1stPos;
            self.sprite.position = CGPoint(appearPosition);
            self.cover.position = CGPoint(appearPosition);
            if (2 == self.initialHitPoints)
            {
                self.cover.visible = YES;
            }
            else
            {
                self.sprite.visible = YES;
            }
            self.body->SetTransform([Helper toMeters:appearPosition], 0);
            positionNew = CGPointMake(5 * CCRANDOM_0_1(), CCRANDOM_MINUS1_1()*5);
            enterForce = [Helper toMeters:positionNew];
            self.body->ApplyForce(enterForce, self.body->GetWorldCenter());
            break;
            
        case PositionTwo:
            //change size by diff version
            appearPosition = [GameMainScene sharedMainScene].appear2ndPos;
            self.cover.position = CGPoint(appearPosition);
            self.sprite.position = CGPoint(appearPosition);
            if (2 == self.initialHitPoints)
            {
                self.cover.visible = YES;
            }
            else
            {
                self.sprite.visible = YES;
            }
            self.body->SetTransform([Helper toMeters:appearPosition], 0);
            positionNew = CGPointMake(CCRANDOM_MINUS1_1()*5, -5 * CCRANDOM_0_1());
            enterForce = [Helper toMeters:positionNew];
            self.body->ApplyForce(enterForce, self.body->GetWorldCenter());
            break;
            
        case PositionThree:
            //change size by diff version
            appearPosition = [GameMainScene sharedMainScene].appear3rdPos;
            self.cover.position = CGPoint(appearPosition);
            self.sprite.position = CGPoint(appearPosition);
            if (2 == self.initialHitPoints)
            {
                self.cover.visible = YES;
            }
            else
            {
                self.sprite.visible = YES;
            }
            self.body->SetTransform([Helper toMeters:appearPosition], 0);
            positionNew = CGPointMake(CCRANDOM_MINUS1_1()*2, -2 * CCRANDOM_0_1());
            enterForce = [Helper toMeters:positionNew];
            self.body->ApplyForce(enterForce, self.body->GetWorldCenter());
            break;
            
        case PositionFour:
            //change size by diff version
            appearPosition = [GameMainScene sharedMainScene].appear4thPos;
            self.cover.position = CGPoint(appearPosition);
            self.sprite.position = CGPoint(appearPosition);
            if (2 == self.initialHitPoints)
            {
                self.cover.visible = YES;
            }
            else
            {
                self.sprite.visible = YES;
            }
            self.body->SetTransform([Helper toMeters:appearPosition], 0);
            positionNew = CGPointMake(CCRANDOM_MINUS1_1()*3, -3 * CCRANDOM_0_1());
            enterForce = [Helper toMeters:positionNew];
            self.body->ApplyForce(enterForce, self.body->GetWorldCenter());
            break;
            
        case PositionFive:
            //change size by diff version
            appearPosition = [GameMainScene sharedMainScene].appear5thPos;
            self.cover.position = CGPoint(appearPosition);
            self.sprite.position = CGPoint(appearPosition);
            if (2 == self.initialHitPoints)
            {
                self.cover.visible = YES;
            }
            else
            {
                self.sprite.visible = YES;
            }
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

        //按照像素设定图片大小
        self.sprite.scaleX=(35)/[self.sprite contentSize].width; //按照像素定制图片宽高
        self.sprite.scaleY=(35)/[self.sprite contentSize].height;
        [batch addChild:self.sprite];       
        

        self.cover = [CCSprite spriteWithSpriteFrameName:@"pack.png"];
        //按照像素设定图片大小
        self.cover.scaleX=(35)/[self.cover contentSize].width; //按照像素定制图片宽高
        self.cover.scaleY=(35)/[self.cover contentSize].height;
        self.cover.visible = NO;
        [batch addChild:self.cover z:2]; 
        self.sprite.position = candyParamDef.startPos;
        
        self.candyType = candyParamDef.ballType;
        
        //初始化为-1，spawn会赋值
        hitPoints = -1;
        initialHitPoints = candyParamDef.initialHitPoints;
        if (initialHitPoints == 2)
        {
            self.cover.position = self.sprite.position;
            self.cover.visible = YES;
            self.sprite.visible = NO;
        }

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
        float radiusInMeters = (self.sprite.contentSize.width * self.sprite.scaleX / PTM_RATIO) * 0.5f;
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


        
        [self scheduleUpdate];
    }
    
    return self;
}


@end
