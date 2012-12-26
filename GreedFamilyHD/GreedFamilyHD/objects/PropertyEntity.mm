//
//  PropertyEntity.m
//  GreedFamily
//
//  Created by 赵 苹果 on 12-5-3.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import "PropertyEntity.h"
#import "GameBackgroundLayer.h"
#import "GameMainScene.h"

@interface PropertyEntity (PrivateMethods)
-(id)initProperty:(NSInteger)propertyType World:(b2World *)world;
@end
@implementation PropertyEntity


@synthesize sprite = _sprite;
@synthesize propertyType = _propertyType;

float propertyEntityScale=65.0/1024;

static CCArray* spawnFrequency;
//-(void) initSpawnFrequency
//{
//	// initialize how frequent the enemies will spawn
//	if (spawnFrequency == nil)
//	{
//		spawnFrequency = [[CCArray alloc] initWithCapacity:PropType_MAX];
//		[spawnFrequency insertObject:[NSNumber numberWithInt:80] atIndex:PropTypeCrystalBall];
//		[spawnFrequency insertObject:[NSNumber numberWithInt:260] atIndex:PropTypeWhiteBomb];
//		[spawnFrequency insertObject:[NSNumber numberWithInt:1500] atIndex:PropTypeBlackBomb];
//		
//		// spawn one enemy immediately
//		//[self spawn];
//	}
//}
//
//+(int) getSpawnFrequencyForType:(NSInteger)type
//{
//	NSAssert(type < PropType_MAX, @"invalid type");
//	NSNumber* number = [spawnFrequency objectAtIndex:type];
//	return [number intValue];
//}

-(void)moveCrystalBall:(CGPoint)curPosition forceOut:(b2Vec2 *)force
{
    CGPoint velocity = CGPointMake(CCRANDOM_MINUS1_1(), CCRANDOM_MINUS1_1());
    //    srandom(time(NULL));
    if (curPosition.x < 50)
    {
        velocity.x = 1;
    }
    else if (curPosition.x > 410)
    {
        velocity.x = -1;
    }
    
    if (curPosition.y < 70)
    {
        velocity.y = 1;
    }
    else if (curPosition.y > 270)
    {
        velocity.y = -1;
    }
    
    b2Vec2 fingerPos = [Helper toMeters:velocity];
    
    *force = 1 * fingerPos;
    
}

-(void)moveBlackBomb:(CGPoint)curPosition forceOut:(b2Vec2 *)force
{
    CGPoint velocity = CGPointMake(CCRANDOM_MINUS1_1(), CCRANDOM_MINUS1_1());
    //    srandom(time(NULL));
    if (curPosition.x < 50)
    {
        velocity.x = 3;
    }
    else if (curPosition.x > 410)
    {
        velocity.x = -3;
    }
    
    if (curPosition.y < 70)
    {
        velocity.y = 3;
    }
    else if (curPosition.y > 270)
    {
        velocity.y = -3;
    }
    
    b2Vec2 fingerPos = [Helper toMeters:velocity];
    
    *force = 3 * fingerPos;
    
}

-(void)moveWhiteBomb:(CGPoint)curPosition forceOut:(b2Vec2 *)force
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
    
    b2Vec2 fingerPos = [Helper toMeters:velocity];
    
    *force = 3 * fingerPos;
    
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
//        
//        
//	}    
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

+(id)createProperty:(NSInteger)propertyType World:(b2World *)world
{
	return [[[self alloc] initProperty:propertyType World:world] autorelease];
}

-(void)initCrystalBall
{
    ballMove = @selector(moveCrystalBall:forceOut:);
    //change size by diff version
    propertyParamDef.startPos = [GameMainScene sharedMainScene].initPos;/*random?*/
    propertyParamDef.isDynamicBody = YES;
    propertyParamDef.ballType = PropTypeCrystalBall;
    propertyParamDef.spriteFrameName = @"magic+.png";
    propertyParamDef.density = 0.5;
    propertyParamDef.restitution = 0.8;
    propertyParamDef.linearDamping = 0.2;
    propertyParamDef.angularDamping = 0.1;
    propertyParamDef.friction = 0.5;
    propertyParamDef.radius = 0.5;
    propertyParamDef.initialHitPoints = 1;
    
}

-(void)initIce
{
    ballMove = @selector(moveWhiteBomb:forceOut:);
    //change size by diff version
    propertyParamDef.startPos = [GameMainScene sharedMainScene].initPos;/*random?*/
    propertyParamDef.isDynamicBody = YES;
    propertyParamDef.ballType = PropTypeIce;
    propertyParamDef.spriteFrameName = @"ice+.png";
    propertyParamDef.density = 0.6;
    propertyParamDef.restitution = 0.2;
    propertyParamDef.linearDamping = 0.2;
    propertyParamDef.angularDamping = 0.1;
    propertyParamDef.friction = 0.5;
    propertyParamDef.radius = 0.5;
    propertyParamDef.initialHitPoints = 1;
    
}

-(void)initPepper
{
    ballMove = @selector(moveWhiteBomb:forceOut:);
    //change size by diff version
    propertyParamDef.startPos = [GameMainScene sharedMainScene].initPos;/*random?*/
    propertyParamDef.isDynamicBody = YES;
    propertyParamDef.ballType = PropTypePepper;
    propertyParamDef.spriteFrameName = @"pepper+.png";
    propertyParamDef.density = 0.1;
    propertyParamDef.restitution = 0.9;
    propertyParamDef.linearDamping = 0.2;
    propertyParamDef.angularDamping = 0.1;
    propertyParamDef.friction = 0.5;
    propertyParamDef.radius = 0.5;
    propertyParamDef.initialHitPoints = 1;
    
}

-(void)initBlackBomb
{
    ballMove = @selector(moveBlackBomb:forceOut:);
    //change size by diff version
    propertyParamDef.startPos = [GameMainScene sharedMainScene].initPos;/*random?*/
    propertyParamDef.isDynamicBody = YES;
    propertyParamDef.ballType = PropTypeBlackBomb;
    propertyParamDef.spriteFrameName = @"bomb+.png";
    propertyParamDef.density = 0.7;
    propertyParamDef.restitution = 0.7;
    propertyParamDef.linearDamping = 0.2;
    propertyParamDef.angularDamping = 0.1;
    propertyParamDef.friction = 0.2;
    propertyParamDef.radius = 0.5;
    propertyParamDef.initialHitPoints = 1;
    
}

-(void)initSmoke
{
    ballMove = @selector(moveBlackBomb:forceOut:);
    //change size by diff version
    propertyParamDef.startPos = [GameMainScene sharedMainScene].initPos;/*random?*/
    propertyParamDef.isDynamicBody = YES;
    propertyParamDef.ballType = PropSmoke;
    propertyParamDef.spriteFrameName = @"garlic+.png";
    propertyParamDef.density = 0.3;
    propertyParamDef.restitution = 0.7;
    propertyParamDef.linearDamping = 0.2;
    propertyParamDef.angularDamping = 0.1;
    propertyParamDef.friction = 0.3;
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
        case PropTypeIce:
            [self initIce];
            break;
        case PropTypePepper:
            [self initPepper];
            break;
        case PropSmoke:
            [self initSmoke];
            break;

        default:
            break;
    }
}

-(id)initProperty:(NSInteger)propertyType World:(b2World *)world
{
    if ((self = [super init]))
    {
    	CGSize size = [[CCDirector sharedDirector] winSize];
        [self initPropertyMove:propertyType];
        
        if ([GameMainScene sharedMainScene].mainscenParam.invisibaleNum == 5)
        {
            propertyParamDef.initialHitPoints = 2;
        }
            
        
        CCSpriteBatchNode* batch = [[GameBackgroundLayer sharedGameBackgroundLayer] getSpriteBatch];
        self.sprite = [CCSprite spriteWithSpriteFrameName:propertyParamDef.spriteFrameName];
        //按照像素设定图片大小
        //change size by diff version manual
        //self.sprite.scaleX=(35)/[self.sprite contentSize].width; //按照像素定制图片宽高
        //self.sprite.scaleY=(35)/[self.sprite contentSize].height;
        self.sprite.scale=size.width*propertyEntityScale/[self.sprite contentSize].width; //按照像素定制图片宽高是控制像素的。
        [batch addChild:self.sprite];       
        

        self.cover = [CCSprite spriteWithSpriteFrameName:@"pack.png"];
        //按照像素设定图片大小
        //self.cover.scaleX=(35)/[self.cover contentSize].width; //按照像素定制图片宽高
        //self.cover.scaleY=(35)/[self.cover contentSize].height;
        self.cover.scale=size.width*propertyEntityScale/[self.cover contentSize].width; //按照像素定制图片宽高是控制像素的。
        self.cover.visible = NO;
        [batch addChild:self.cover z:2];
        
        //初始化为－1
        hitPoints = -1;
        initialHitPoints = propertyParamDef.initialHitPoints;
        
        if (initialHitPoints == 2)
        {
            self.cover.position = self.sprite.position;
            self.cover.visible = YES;
            self.sprite.visible = NO;
        }
        
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
        float radiusInMeters = (self.sprite.contentSize.width * self.sprite.scaleX/ PTM_RATIO) * 0.5f;
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
        self.propertyType = propertyParamDef.ballType;
        [self scheduleUpdate];
    }
    
    return self;
}


//进入游戏
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
            positionNew = CGPointMake(CCRANDOM_MINUS1_1()*5, -5 * CCRANDOM_0_1());
            enterForce = [Helper toMeters:positionNew];
            self.body->ApplyForce(enterForce, self.body->GetWorldCenter());
            break;
            
        case PositionThree:
            //change size by diff version
            appearPosition = [GameMainScene sharedMainScene].appear3rdPos;
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
            positionNew = CGPointMake(CCRANDOM_MINUS1_1()*2, -2 * CCRANDOM_0_1());
            enterForce = [Helper toMeters:positionNew];
            self.body->ApplyForce(enterForce, self.body->GetWorldCenter());
            break;
            
        case PositionFour:
            //change size by diff version
            appearPosition = [GameMainScene sharedMainScene].appear4thPos;
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
            positionNew = CGPointMake(CCRANDOM_MINUS1_1()*3, -3 * CCRANDOM_0_1());
            enterForce = [Helper toMeters:positionNew];
            self.body->ApplyForce(enterForce, self.body->GetWorldCenter());
            break;
            
        case PositionFive:
            //change size by diff version
            appearPosition = [GameMainScene sharedMainScene].appear5thPos;
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
            positionNew = CGPointMake(-3 * CCRANDOM_0_1(), CCRANDOM_MINUS1_1()*3);
            enterForce = [Helper toMeters:positionNew];
            self.body->ApplyForce(enterForce, self.body->GetWorldCenter());
            break;
            
        default:
            break;
    }
}
-(void) dealloc
{
	[spawnFrequency release];
	spawnFrequency = nil;
	[super dealloc];
}



@end
