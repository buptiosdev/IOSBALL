//
//  MainScene.m
//  Box2d_test
//
//  Created by 赵 苹果 on 12-3-18.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import "MainScene.h"
#import "TileMapLayer.h"
//#import "SneakyButtonLayer.h"
//#import "Bullet.h"
#import "EnemyCache.h"
#import "ShipEntity.h"
#import "TableSetup.h"
#import "Entity.h"
#import "ContactListener.h"
#import "LoadingScene.h"
#import "SimpleAudioEngine.h"

@interface MainScene (PrivateMethods)
-(void) initBox2dWorld;
-(void) enableBox2dDebugDrawing;
-initWithOrder:(int)order;
+(id)createMainLayer:(int)order;
@end

@implementation MainScene



/*创造一个半单例，让其他类可以很方便访问scene*/
static MainScene *instanceOfMainScene;
+(MainScene *)sharedMainScene
{
    NSAssert(nil != instanceOfMainScene, @"MainScene instance not yet initialized!");
    
    return instanceOfMainScene;
}

+(CCScene *) scene:(int)order
{
    //order = order;
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	MainScene *layer = [MainScene createMainLayer:order];
	
	// add layer as a child to scene
	[scene addChild: layer];
    
    //加载手柄
    //SneakyButtonLayer *sneakyButtonLayer = [SneakyButtonLayer node]; 
    //这里z必须大于等于1才可以显示出来，不知道为什么
    //[scene addChild:sneakyButtonLayer z:2 tag:SneakyButtonTag];
	
	// return the scene
	return scene;
}

+(id)createMainLayer:(int)order
{
    return [[[MainScene alloc] initWithOrder:order] autorelease];
}
-initWithOrder:(int)order
{
    if (self = [super init]) 
    {
        //self.isAccelerometerEnabled = YES;
        //初始化一开始，给半单例赋值
        instanceOfMainScene = self;
        sceneNum=order;
        //添加重力加速
        //self.isAccelerometerEnabled = YES;
        //[[UIAccelerometer sharedAccelerometer] setUpdateInterval:(1.0 / kAccelerometerFrequency)];
        //[[UIAccelerometer sharedAccelerometer] setDelegate:self];
        
        [self initBox2dWorld];
		//[self enableBox2dDebugDrawing];
        
        //加载所有的图片列表
		CCSpriteFrameCache* frameCache = [CCSpriteFrameCache sharedSpriteFrameCache];
		[frameCache addSpriteFramesWithFile:@"magicball_default.plist"];
        
        // batch node for all dynamic elements
		CCSpriteBatchNode* batch = [CCSpriteBatchNode batchNodeWithFile:@"magicball_default.png" capacity:100];
		[self addChild:batch z:-2 tag:BatchTag];
        
        // a bright background is desireable for this pinball table
		//CCColorLayer* colorLayer = [CCColorLayer layerWithColor:ccc4(0, 0, 255, 200)];
		//[self addChild:colorLayer z:-3];
        
        CGSize screenSize = [[CCDirector sharedDirector] winSize];
        // IMPORTANT: filenames are case sensitive on iOS devices!
		CCSprite* background = [CCSprite spriteWithSpriteFrameName:@"background.png"];
		background.position = CGPointMake(screenSize.width / 2, screenSize.height / 2);
        //设置透明度
        //background.opacity = 127;
		// scaling the image beyond recognition here
		//background.scaleX = 30;
		//background.scaleY = 3;
		[self addChild:background z:-3];
        
        // Play the background music in an endless loop.
		[[SimpleAudioEngine sharedEngine] playBackgroundMusic:@"blues.mp3" loop:YES];
        [[SimpleAudioEngine sharedEngine] preloadEffect:@"hit.caf"];    
        //加载瓷砖地图层
        //TileMapLayer *tileMapLayer = [TileMapLayer node];
        //[self addChild:tileMapLayer z:-2 tag:TileMapLayerTag];

        //加载刚体游戏层
		TableSetup* tableSetup = [TableSetup setupTableWithWorld:world Order:order];
		[self addChild:tableSetup z:-1];
        
        
        [self scheduleUpdate];

    }
    
    return self;
}

-(void) dealloc
{
	[super dealloc];
    delete world;
	world = NULL;
    
    delete contactListener;
	contactListener = NULL;
    instanceOfMainScene = nil; 
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

-(CCSpriteBatchNode*) getSpriteBatch
{
	return (CCSpriteBatchNode*)[self getChildByTag:BatchTag];
}


-(void) update:(ccTime)delta
{
	// The number of iterations influence the accuracy of the physics simulation. With higher values the
	// body's velocity and position are more accurately tracked but at the cost of speed.
	// Usually for games only 1 position iteration is necessary to achieve good results.
	float timeStep = 0.03f;
	int32 velocityIterations = 8;
	int32 positionIterations = 1;
	world->Step(timeStep, velocityIterations, positionIterations);
	
	// for each body, get its assigned BodyNode and update the sprite's position
    int bodysize=0;
    int deadenemycnt=0;
	for (b2Body* body = world->GetBodyList(); body != nil; body = body->GetNext())
	{
        bodysize++;
		Entity* bodyNode = (Entity *)body->GetUserData();
		if (bodyNode != NULL && bodyNode.sprite != nil)
		{
			// update the sprite's position to where their physics bodies are
            //bodysize++;
			bodyNode.sprite.position = [Helper toPixels:body->GetPosition()];
			float angle = body->GetAngle();
			bodyNode.sprite.rotation = -(CC_RADIANS_TO_DEGREES(angle));
       
            if (bodyNode.hitPoints <= 0)
            {
                if([bodyNode isKindOfClass:[ShipEntity class]])
                {
                    // add the labels shown during game over
                    CGSize screenSize = [[CCDirector sharedDirector] winSize];
                    
                    CCLabelTTF *gameOver = [CCLabelTTF labelWithString:@"GAME OVER!" fontName:@"Marker Felt" fontSize:60];
                    gameOver.position = CGPointMake(screenSize.width / 2, screenSize.height / 3);
                    [self addChild:gameOver z:100 tag:100];
                    sleep(2);
                    [[CCDirector sharedDirector] replaceScene:[LoadingScene sceneWithTargetScene:TargetNavigationScen]];
                    
                    return;
                }else
                {
                    deadenemycnt++;
                }
                CGPoint positionNew = CGPointMake(-100, -100);
                bodyNode.body->SetTransform([Helper toMeters:positionNew], 0);
                CCLOG(@"die!!!\n");
                bodyNode.sprite.visible = NO;
                
            } 
		}
	}
    if(deadenemycnt>=bodysize-2){
        sceneNum++;
        sleep(2);
        [[CCDirector sharedDirector] replaceScene:[LoadingScene sceneWithTargetScene:(TargetScenes)sceneNum]];
    }

}
@end
