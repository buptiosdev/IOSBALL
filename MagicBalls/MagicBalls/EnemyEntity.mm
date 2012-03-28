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
-(void) initSpawnFrequency;
-(id)initenemyWithParam:(EnemyParam)enemyParam World:(b2World *)world;
@end

@implementation EnemyEntity



-(void)initWithWorld:(b2World *)world  FrameName:(NSString*)frameName
{

		//CGSize screenSize = [[CCDirector sharedDirector] winSize];
        
        
		CCSprite* tempSprite = [CCSprite spriteWithSpriteFrameName:frameName];
        
       // CGPoint startPos = CGPointMake((screenSize.width - ([tempSprite contentSize].width)) * 0.5f, 
       //                                (screenSize.height ) * 0.5f);
    
    
    CGPoint startPos = CGPointMake(-100, -100);
		
		// Create a body definition, it's a static body (bumpers don't move)
		b2BodyDef bodyDef;
		bodyDef.position = [Helper toMeters:startPos];
        bodyDef.type = b2_dynamicBody;
        bodyDef.angularDamping = 0.5f;
        
        
		b2CircleShape circleShape;
		float radiusInMeters = (tempSprite.contentSize.width / PTM_RATIO) * 0.1f;
		circleShape.m_radius = radiusInMeters;
		
		// Define the dynamic body fixture.
		b2FixtureDef fixtureDef;
		fixtureDef.shape = &circleShape;
		fixtureDef.density = 0.8f;
		fixtureDef.friction = 0.7f;
		fixtureDef.restitution = 0.3f;
		
		[super createBodyInWorld:world bodyDef:&bodyDef fixtureDef:&fixtureDef spriteFrameName:frameName];
		
		//sprite.color = ccRED;

   
}

-(id) initWithType:(EnemyTypes)enemyType World:(b2World *)world
{
	type = enemyType;
	
	NSString* frameName;
	NSString* bulletFrameName;
	initialHitPoints = 1;
	
	switch (type)
	{
		case EnemyTypeBreadman:
			frameName = @"monster-a.png";
			bulletFrameName = @"candystick.png";
			break;
		case EnemyTypeSnake:
			frameName = @"monster-b.png";
			bulletFrameName = @"redcross.png";
			initialHitPoints = 3;
			break;
		case EnemyTypeBoss:
			frameName = @"monster-c.png";
			bulletFrameName = @"blackhole.png";
			initialHitPoints = 15;
			break;
			
		default:
			[NSException exceptionWithName:@"EnemyEntity Exception" reason:@"unhandled enemy type" userInfo:nil];
	}

	if ((self = [super init]))
	{
        //刚体初始化
        [self initWithWorld:world FrameName:frameName];

		self.sprite.visible = NO;

		[self initSpawnFrequency];
        
        [self scheduleUpdate];
	}
	
	return self;
}

+(id) enemyWithType:(EnemyTypes)enemyType World:(b2World *)world
{
	return [[[self alloc] initWithType:enemyType World:world] autorelease];
}

static CCArray* spawnFrequency;

-(void) initSpawnFrequency
{
	// initialize how frequent the enemies will spawn
	if (spawnFrequency == nil)
	{
		spawnFrequency = [[CCArray alloc] initWithCapacity:EnemyType_MAX];
		[spawnFrequency insertObject:[NSNumber numberWithInt:100] atIndex:EnemyTypeBreadman];
		[spawnFrequency insertObject:[NSNumber numberWithInt:260] atIndex:EnemyTypeSnake];
		[spawnFrequency insertObject:[NSNumber numberWithInt:1500] atIndex:EnemyTypeBoss];
		
		// spawn one enemy immediately
		[self spawn];
	}
}

+(int) getSpawnFrequencyForEnemyType:(EnemyTypes)enemyType
{
	NSAssert(enemyType < EnemyType_MAX, @"invalid enemy type");
	NSNumber* number = [spawnFrequency objectAtIndex:enemyType];
	return [number intValue];
}

-(void) dealloc
{
	[spawnFrequency release];
	spawnFrequency = nil;
    
	[[CCTouchDispatcher sharedDispatcher] removeDelegate:self];
	[super dealloc];
}


-(void) spawn
{
	//CCLOG(@"spawn enemy");
	
	// Select a spawn location just outside the right side of the screen, with random y position
	CGRect screenRect = [TableSetup screenRect];
	CGSize spriteSize = [self contentSize];
	float xPos = screenRect.size.width * 0.5f;
	float yPos = CCRANDOM_0_1() * (screenRect.size.height)  + spriteSize.height * 0.5f;
	self.sprite.position = CGPointMake(xPos, yPos);
	body->SetTransform([Helper toMeters:self.sprite.position], 0);
	// Finally set yourself to be visible, this also flag the enemy as "in use"
	self.sprite.visible = YES;
	
	// reset health
	hitPoints = initialHitPoints;
	
}

-(void) gotHit
{
	hitPoints--;

	if (hitPoints <= 0)
	{
        CCLOG(@"die!!!\n");
		sprite.visible = NO;
	}
}

//update 就是不进去！！！why？？
-(void) tick: (ccTime) dt
{
    CCLOG(@"hello\n");
}

-(void) update: (ccTime) dt
{
    
}

+(id)enemyWithParam:(EnemyParam)enemyParam World:(b2World *)world
{
	return [[[self alloc] initenemyWithParam:enemyParam World:world] autorelease];
}


-(id)initenemyWithParam:(EnemyParam)enemyParam World:(b2World *)world
{
    //CGSize screenSize = [[CCDirector sharedDirector] winSize];
    
    
    CCSprite* tempSprite = [CCSprite spriteWithSpriteFrameName:enemyParam.spriteFrameName];
    hitPoints = enemyParam.initialHitPoints;
    initialHitPoints = enemyParam.initialHitPoints;
    // CGPoint startPos = CGPointMake((screenSize.width - ([tempSprite contentSize].width)) * 0.5f, 
    //                                (screenSize.height ) * 0.5f);
    
    
    // Create a body definition, it's a static body (bumpers don't move)
    b2BodyDef bodyDef;
    bodyDef.position = [Helper toMeters:enemyParam.startPos];
    if (enemyParam.isDynamicBody)
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
    fixtureDef.density = enemyParam.density;
    fixtureDef.friction = enemyParam.friction;
    fixtureDef.restitution = enemyParam.restitution;
    
    [super createBodyInWorld:world 
                     bodyDef:&bodyDef 
                  fixtureDef:&fixtureDef 
             spriteFrameName:enemyParam.spriteFrameName]; 
    
    return self;
}

-(void) updateForCache
{
	if (self.sprite.visible)
	{
        CGPoint velocity = CGPointMake(CCRANDOM_MINUS1_1()*0.1, CCRANDOM_MINUS1_1() * 0.3);					
        
		//NSAssert([self.parent isKindOfClass:[Entity class]], @"node is not a Entity");
		
		//Entity* entity = (Entity*)self.parent;
		//if (sprite.position.x > [TableSetup screenRect].size.width * 0.5f)
		{
			//[sprite setPosition:ccpAdd(sprite.position, velocity)];
		}
        CGPoint positionNew = ccpAdd(sprite.position, velocity);
        [self updateBadyPosition:positionNew];
  
        /*if (sprite.position.x < 0)   
        {
            sprite.visible = NO;
        }*/
	}
}



@end
