//
//  MainScene.m
//  Box2d_test
//
//  Created by 赵 苹果 on 12-3-18.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import "GameMainScene.h"
#import "LoadingScene.h"
#import "TouchCatchLayer.h"
#import "GameBackgroundLayer.h"
#import "ObjectsLayer.h"

@interface GameMainScene (PrivateMethods)
-(void) enableBox2dDebugDrawing;
-initWithOrder:(int)order;
+(id)createMainLayer:(int)order;
@end

@implementation GameMainScene
@synthesize sceneNum = _sceneNum;


/*创造一个半单例，让其他类可以很方便访问scene*/
static GameMainScene *instanceOfMainScene;
+(GameMainScene *)sharedMainScene
{
    NSAssert(nil != instanceOfMainScene, @"GameMainScene instance not yet initialized!");
    
    return instanceOfMainScene;
}

+(CCScene *) scene:(int)order
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	GameMainScene *layer = [GameMainScene createMainLayer:order];
	
	// add layer as a child to scene
	[scene addChild: layer z:0];
    
    //加载手柄
    //SneakyButtonLayer *sneakyButtonLayer = [SneakyButtonLayer node]; 
    //这里z必须大于等于1才可以显示出来，不知道为什么
    //[scene addChild:sneakyButtonLayer z:2 tag:SneakyButtonTag];
	
	// return the scene
	return scene;
}

+(id)createMainLayer:(int)order
{
    return [[[GameMainScene alloc] initWithOrder:order] autorelease];
}
-initWithOrder:(int)order
{
    if (self = [super init]) 
    {
        //self.isAccelerometerEnabled = YES;
        //初始化一开始，给半单例赋值
        instanceOfMainScene = self;
        _sceneNum = order;

        GameBackgroundLayer *gameBackgroundLayer = [GameBackgroundLayer CreateGameBackgroundLayer];
        [self addChild:gameBackgroundLayer z:-1 tag:BackGroundLayerTag];
        
//        CCSprite* background = [CCSprite spriteWithSpriteFrameName:@"background.png"];
//        CGSize screenSize = [[CCDirector sharedDirector] winSize];
//        background.position = CGPointMake(screenSize.width / 2, screenSize.height / 2);
//        [self addChild:background z:100];
        
        TouchCatchLayer *touchCatchLayer = [TouchCatchLayer CreateTouchCatchLayer];
        [self addChild:touchCatchLayer z:1 tag:TouchCatchLayerTag];
        
        ObjectsLayer *objectsLayer = [ObjectsLayer CreateObjectsLayer];
        [self addChild:objectsLayer z:1 tag:ObjectsLayerTag];

    }
    
    return self;
}

-(void) dealloc
{
	[super dealloc];
    
    instanceOfMainScene = nil; 
}

@end
