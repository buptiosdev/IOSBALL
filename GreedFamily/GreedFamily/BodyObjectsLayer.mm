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


@interface BodyObjectsLayer (PrivateMethods)
-(void) initBox2dWorld;

@end

@implementation BodyObjectsLayer

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
    
    instanceOfBodyObjectsLayer = self;
    CGSize screenSize = [[CCDirector sharedDirector] winSize];
    screenRect = CGRectMake(0, 0, screenSize.width, screenSize.height);
    
    [self initBox2dWorld];
    
    
    FlyEntity* flyAnimal = [FlyEntity flyAnimal:world];
    [self addChild:flyAnimal z:-1 tag:FlyEntityTag];
    

    CandyCache* candyCache = [CandyCache cache:world];
    [self addChild:candyCache z:-1 tag:CandyCacheTag];
    
    return self;

}

//还需要完善底部
-(void) initBox2dWorld
{
	// Construct a world object, which will hold and simulate the rigid bodies.
    //这里不需要加重力
	b2Vec2 gravity = b2Vec2(0.0f, 0.0f);
	bool allowBodiesToSleep = true;
	world = new b2World(gravity, allowBodiesToSleep);
    
    contactListener = new ContactListener();
	world->SetContactListener(contactListener);
    
	// Define the static container body, which will provide the collisions at screen borders.
	b2BodyDef containerBodyDef;
	b2Body* containerBody = world->CreateBody(&containerBodyDef);
	
	// for the ground body we'll need these values
	CGSize screenSize = [CCDirector sharedDirector].winSize;
	float widthInMeters = screenSize.width / PTM_RATIO;
	float heightInMeters = screenSize.height / PTM_RATIO;
	b2Vec2 lowerLeftCorner = b2Vec2(0, 0);
	b2Vec2 lowerRightCorner = b2Vec2(widthInMeters, 0);
	b2Vec2 upperLeftCorner = b2Vec2(0, heightInMeters);
	b2Vec2 upperRightCorner = b2Vec2(widthInMeters, heightInMeters);
	
	// Create the screen box' sides by using a polygon assigning each side individually.
	b2PolygonShape screenBoxShape;
	int density = 1;
	
    
    // bottom
    screenBoxShape.SetAsEdge(lowerLeftCorner, lowerRightCorner);
    containerBody->CreateFixture(&screenBoxShape, density);
    
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

-(void) dealloc
{
	[super dealloc];
    delete world;
	world = NULL;
    
    delete contactListener;
	contactListener = NULL;
    instanceOfBodyObjectsLayer = nil; 
}

@end
