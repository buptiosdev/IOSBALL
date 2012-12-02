//
//  BodyObjectsLayer.m
//  GreedFamily
//
//  Created by 赵 苹果 on 12-4-19.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import "BodyObjectsLayer.h"
#import "Helper.h"
#import "FlyEntity.h"
#import "CandyCache.h"
#import "CandyEntity.h"
#import "GameMainScene.h"
#import "PropertyCache.h"
#import "LandCandyCache.h"
#import "PropertyEntity.h"
#import "CommonLayer.h"

@interface BodyObjectsLayer (PrivateMethods)
-(void) initBox2dWorld;

@end

@implementation BodyObjectsLayer
@synthesize world = _world;
@synthesize curEnterPosition = _curEnterPosition;
/*屏幕尺寸*/
static CGRect screenRect;

/*创造一个半单例，让其他类可以很方便访问scene*/
static BodyObjectsLayer *instanceOfBodyObjectsLayer;
+(BodyObjectsLayer *)sharedBodyObjectsLayer
{
    NSAssert(nil != instanceOfBodyObjectsLayer, @"BodyObjectsLayer instance not yet initialized!");
    
    return instanceOfBodyObjectsLayer;
}

+(id)CreateBodyObjectsLayer
{
	return [[[self alloc] init] autorelease];
}

-(id)init
{
    if ((self = [super init]))
    {
        instanceOfBodyObjectsLayer = self;
        _curEnterPosition = 0;
        CGSize screenSize = [[CCDirector sharedDirector] winSize];
        screenRect = CGRectMake(0, 0, screenSize.width, screenSize.height);
        
        [self initBox2dWorld];
        
        //单人游戏
        if (NO == [GameMainScene sharedMainScene].isPairPlay) {
            int familyType = [[GameMainScene sharedMainScene] roleType];
            FlyEntity* flyAnimal = [FlyEntity flyAnimal:self.world RoleType:familyType];
            [self addChild:flyAnimal z:-1 tag:FlyEntityTag];
        }
        //双人游戏
        else
        {
            FlyEntity* flyAnimal = [FlyEntity flyAnimal:self.world RoleType:1];
            [self addChild:flyAnimal z:-1 tag:FlyEntityTag];
            FlyEntity* flyAnimalPlay2 = [FlyEntity flyAnimal:self.world RoleType:2];
            [self addChild:flyAnimalPlay2 z:-1 tag:FlyEntityPlay2Tag];
        }


        CandyCache* candyCache = [CandyCache cache:self.world];
        [self addChild:candyCache z:-1 tag:CandyCacheTag];
        
        PropertyCache* propertyCache = [PropertyCache propCache:self.world];
        [self addChild:propertyCache z:-1 tag:PropCacheTag];
        
        [self scheduleUpdate];
    }
    
    return self;
}

//初始化四个边框
//还需要完善底部
-(void) initBox2dWorld
{
	// Construct a world object, which will hold and simulate the rigid bodies.
    //这里不需要加重力
	b2Vec2 gravity = b2Vec2(0.0f, 0.0f);
	bool allowBodiesToSleep = true;
	_world = new b2World(gravity, allowBodiesToSleep);
    
    contactListener = new ContactListener();
	_world->SetContactListener(contactListener);
    
	// Define the static container body, which will provide the collisions at screen borders.
	b2BodyDef containerBodyDef;
	b2Body* containerBody = self.world->CreateBody(&containerBodyDef);
	
	// for the ground body we'll need these values
	CGSize screenSize = [CCDirector sharedDirector].winSize;
	float widthInMeters = (screenSize.width) / PTM_RATIO;
	float heightInMeters = screenSize.height / PTM_RATIO;
    //change size by diff version query
	b2Vec2 lowerLeftCorner = b2Vec2(0, 60/PTM_RATIO);
	b2Vec2 lowerRightCorner = b2Vec2(widthInMeters, 60/PTM_RATIO);
	b2Vec2 upperLeftCorner = b2Vec2(0, heightInMeters);
	b2Vec2 upperRightCorner = b2Vec2(widthInMeters, heightInMeters);
	
	// Create the screen box' sides by using a polygon assigning each side individually.
	b2PolygonShape screenBoxShape;
	int density = 1;
    b2FixtureDef fixtureDef;
    //fixtureDef.shape = &dynamicBox;
    fixtureDef.density = 0.3; //密度 
    fixtureDef.friction = 0.6    ; //摩擦力
    fixtureDef.restitution = 0.5 ;  //弹性系数 复原
	    
    // bottom
    screenBoxShape.SetAsEdge(lowerLeftCorner, lowerRightCorner);
    containerBody->CreateFixture(&screenBoxShape, density);
    //containerBody->CreateFixture(&fixtureDef);
    
    // top
    screenBoxShape.SetAsEdge(upperLeftCorner, upperRightCorner);
    containerBody->CreateFixture(&screenBoxShape, density);
    
    // left side
    screenBoxShape.SetAsEdge(upperLeftCorner, lowerLeftCorner);
    containerBody->CreateFixture(&screenBoxShape, density);
    
    // right side
    screenBoxShape.SetAsEdge(upperRightCorner, lowerRightCorner);
    containerBody->CreateFixture(&screenBoxShape, density);
    
}

+(CGRect) screenRect
{
	return screenRect;
}

-(FlyEntity*) flyAnimal
{
	CCNode* node = [self getChildByTag:FlyEntityTag];
	NSAssert([node isKindOfClass:[FlyEntity class]], @"node is not a FlyEntity!");
	return (FlyEntity*)node;
}

-(FlyEntity*) flyAnimalPlay2
{
	CCNode* node = [self getChildByTag:FlyEntityPlay2Tag];
	NSAssert([node isKindOfClass:[FlyEntity class]], @"node is not a FlyEntity!");
	return (FlyEntity*)node;
}

-(CGPoint) getFlySpeedPlay2
{
	CCNode* node = [self getChildByTag:FlyEntityPlay2Tag];
	NSAssert([node isKindOfClass:[FlyEntity class]], @"node is not a FlyEntity!");
    FlyEntity *flyAnimal = (FlyEntity*)node;
	return [flyAnimal getFlySpeed];
}

-(CGPoint) getFlySpeed
{
	CCNode* node = [self getChildByTag:FlyEntityTag];
	NSAssert([node isKindOfClass:[FlyEntity class]], @"node is not a FlyEntity!");
    FlyEntity *flyAnimal = (FlyEntity*)node;
	return [flyAnimal getFlySpeed];
}


-(PropertyCache*) getPropertyCache
{
	CCNode* node = [self getChildByTag:PropCacheTag];
	NSAssert([node isKindOfClass:[PropertyCache class]], @"node is not a PropertyCache!");
	return (PropertyCache *)node;
}


-(CandyCache*) getCandyCache
{
	CCNode* node = [self getChildByTag:CandyCacheTag];
	NSAssert([node isKindOfClass:[CandyCache class]], @"node is not a CandyCache!");
	return (CandyCache *)node;
}

+(void)addDownForth:(CGPoint)curPosition forceOut:(b2Vec2 *)force
{
    CGPoint positionNew = CGPointMake(0, -10);
    
    b2Vec2 bodyPos = [Helper toMeters:positionNew];
    
    *force = bodyPos;
    
}

//判断游戏是否结束  
-(void) update:(ccTime)delta
{
	// The number of iterations influence the accuracy of the physics simulation. With higher values the
	// body's velocity and position are more accurately tracked but at the cost of speed.
	// Usually for games only 1 position iteration is necessary to achieve good results.
    //CCLOG(@"int哦 here");
	float timeStep = 0.03f;
    //float timeStep = 1/60.0;
    //float timeStep = 0.1f;
	int32 velocityIterations = 8;
	int32 positionIterations = 1;
	self.world->Step(timeStep, velocityIterations, positionIterations);
	
    //int deadenemycnt=0;
	for (b2Body* body = self.world->GetBodyList(); body != nil; body = body->GetNext())
	{
		Entity* bodyNode = (Entity *)body->GetUserData();
		if (bodyNode != NULL && bodyNode.sprite != nil && -1 < bodyNode.hitPoints)
		{
			bodyNode.sprite.position = [Helper toPixels:body->GetPosition()];
			float angle = body->GetAngle();
			bodyNode.sprite.rotation = -(CC_RADIANS_TO_DEGREES(angle));
            
            if (([bodyNode isKindOfClass:[CandyEntity class]] || [bodyNode isKindOfClass:[PropertyEntity class]]) 
                && 1 == bodyNode.hitPoints)
            {
                Entity* candyNode = (CandyEntity*)bodyNode;
                candyNode.sprite.visible = YES;
                candyNode.cover.visible = NO;
            }
            
            if (bodyNode.hitPoints == 0)
            {
                if([bodyNode isKindOfClass:[FlyEntity class]])
                {
                    CCLOG(@"haha");
                    // add the labels shown during game over
                    /*    
                    CGSize screenSize = [[CCDirector sharedDirector] winSize];
                    
                    CCLabelTTF *gameOver = [CCLabelTTF labelWithString:@"GAME OVER!" fontName:@"Marker Felt" fontSize:60];
                    gameOver.position = CGPointMake(screenSize.width / 2, screenSize.height / 3);
                    [self addChild:gameOver z:100 tag:100];
                    [GameMainScene sharedMainScene].isGameOver = YES;
                    
                    return;
                     */
                }
                //add by jin at 5.27
                else if ([bodyNode isKindOfClass:[CandyEntity class]])
                {
                    //持续的给Candy加向下的力
                    
                    CCLOG(@"Into here ！糖果的血为0");

                    CCLOG(@"调用精灵切换");
                    //气泡破裂特效
                    CCParticleSystem* system;
                    system = [ARCH_OPTIMAL_PARTICLE_SYSTEM particleWithFile:@"bublle_break.plist"];
                    system.positionType = kCCPositionTypeFree;
                    system.autoRemoveOnFinish = YES;
                    system.position = bodyNode.sprite.position;
                    [self addChild:system];
                    
                    CandyEntity* candyNode = (CandyEntity*)bodyNode;
                    CGPoint bodyVelocity = [Helper toPixels:bodyNode.body->GetLinearVelocity()];
                    
                    //CGPoint flyVelocity = [self getFlySpeed];
//                    int a = bodyNode.flyFamilyType;
                    float hitEffect = [[CommonLayer sharedCommonLayer] getRoleParam:bodyNode.flyFamilyType ParamType:ROLEHITEFFECT];
                    CGPoint flyVelocity = ccpMult(bodyNode.otherLineSpeed, hitEffect);
                    bodyVelocity = ccpMult(bodyVelocity, 0.1);
                    
                    bodyVelocity = ccpAdd(bodyVelocity, flyVelocity);
                    
                    LandCandyCache *instanceOfLandCandyCache=[LandCandyCache sharedLandCandyCache];
                    //[instanceOfLandCandyCache CreateLandCandy:(int)balltype Pos:(CGPoint)position]
                    [instanceOfLandCandyCache CreateLandCandy:candyNode.candyType Pos:bodyNode.sprite.position 
                                                 BodyVelocity:bodyVelocity];
                    
                    //消失
                    //change size by diff version
                    CGPoint positionNew = [GameMainScene sharedMainScene].initPos;
                    bodyNode.body->SetTransform([Helper toMeters:positionNew], 0);
                    bodyNode.sprite.visible = NO;
                    bodyNode.hitPoints = -1;
                    
                    
                    CandyCache* candyCache = (CandyCache *)[self getChildByTag:CandyCacheTag];
                    if (candyCache != NULL)
                    {
                        candyCache.aliveCandy--;
                    }
                    
                }   
                
                else if([bodyNode isKindOfClass:[PropertyEntity class]])
                {
                    int typeChange = 3;
                    CCLOG(@"属性球");
                    
                    //气泡破裂特效
                    CCParticleSystem* system;
                    system = [ARCH_OPTIMAL_PARTICLE_SYSTEM particleWithFile:@"bublle_break2.plist"];
                    system.positionType = kCCPositionTypeFree;
                    system.autoRemoveOnFinish = YES;
                    system.position = bodyNode.sprite.position;
                    [self addChild:system];
                    
                    PropertyEntity* PropertyNode = (PropertyEntity *)bodyNode;
                    //CGPoint flyVelocity = [self getFlySpeed];
                    float hitEffect = [[CommonLayer sharedCommonLayer] getRoleParam:bodyNode.flyFamilyType ParamType:ROLEHITEFFECT];                    
                    CGPoint flyVelocity = ccpMult(bodyNode.otherLineSpeed, hitEffect);
                    CGPoint bodyVelocity = [Helper toPixels:bodyNode.body->GetLinearVelocity()];
                    bodyVelocity = ccpMult(bodyVelocity, 0.1);
                    
                    bodyVelocity = ccpAdd(bodyVelocity, flyVelocity);
                    LandCandyCache *instanceOfLandCandyCache=[LandCandyCache sharedLandCandyCache];
                    //[instanceOfLandCandyCache CreateLandCandy:(int)balltype Pos:(CGPoint)position]
    
                    [instanceOfLandCandyCache CreateLandCandy:(PropertyNode.propertyType + typeChange) Pos:bodyNode.sprite.position BodyVelocity:bodyVelocity];
                    
                    //消失
                    //change size by diff version
                    CGPoint positionNew = [GameMainScene sharedMainScene].initPos;
                    bodyNode.body->SetTransform([Helper toMeters:positionNew], 0);
                    bodyNode.sprite.visible = NO;
                    bodyNode.hitPoints = -1;
                
                    CandyCache* candyCache = (CandyCache *)[self getChildByTag:CandyCacheTag];
                    PropertyCache* propCache = (PropertyCache *)[self getChildByTag:PropCacheTag];
                    if (candyCache != NULL)
                    {
                        candyCache.aliveCandy--;
                        propCache.aliveProp--;
                    }
                    
                }

            } 
		}
	}
}
-(void) dealloc
{
	//delete self.world;
	//world = NULL;
	
    delete contactListener;
	contactListener = nil;
    
    instanceOfBodyObjectsLayer = nil;   
    
    [super dealloc];
}

@end
