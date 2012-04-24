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
#import "PauseLayer.h"
#import "AppDelegate.h"

@interface GameMainScene (PrivateMethods)
-(void) enableBox2dDebugDrawing;
-initWithOrder:(int)order;
+(id)createMainLayer:(int)order;
@end

@implementation GameMainScene
@synthesize sceneNum = _sceneNum;
@synthesize isGameOver = _isGameOver;
@synthesize isGamePass = _isGamePass;


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
        _isGameOver = NO;
        _isGamePass = NO;

        GameBackgroundLayer *gameBackgroundLayer = [GameBackgroundLayer CreateGameBackgroundLayer];
        [self addChild:gameBackgroundLayer z:-1 tag:BackGroundLayerTag];
        
//        CCSprite* background = [CCSprite spriteWithSpriteFrameName:@"background.png"];
//        CGSize screenSize = [[CCDirector sharedDirector] winSize];
//        background.position = CGPointMake(screenSize.width / 2, screenSize.height / 2);
//        [self addChild:background z:100];
        
        ObjectsLayer *objectsLayer = [ObjectsLayer CreateObjectsLayer];
        [self addChild:objectsLayer z:1 tag:ObjectsLayerTag];
        
        TouchCatchLayer *touchCatchLayer = [TouchCatchLayer CreateTouchCatchLayer];
        [self addChild:touchCatchLayer z:1 tag:TouchCatchLayerTag];
        
        [self scheduleUpdate];
    }
    
    return self;
}

//add lyp test for pause
- (void) onPauseExit
{
	if(![AppDelegate get].paused)
	{
		[AppDelegate get].paused = YES;
		[super onExit];
	}
} 

-(void)pauseGame
{
	ccColor4B c = {100,100,0,100};
	//PauseLayer * p = [[[PauseLayer alloc]initWithColor:c]autorelease];
	//PauseLayer * p = [[[PauseLayer alloc]initWithColor:c]autorelease];
    PauseLayer * p = [PauseLayer createPauseLayer:c];
    [self.parent addChild:p z:10];
    //[[GameMainScene sharedMainScene] addChild:p z:10];
	[self onPauseExit];
}



- (void) resume
{
	if(![AppDelegate get].paused)
	{
		return;
	}
	[AppDelegate get].paused =NO;
	[self onEnter];
}

-(void) update:(ccTime)delta
{
    if (_isGameOver)
    {
        [[CCDirector sharedDirector] replaceScene:[LoadingScene sceneWithTargetScene:TargetNavigationScen]];
    }
    
    if (_isGamePass)
    {
        _sceneNum++;
        sleep(2);
        [[CCDirector sharedDirector] replaceScene:[LoadingScene sceneWithTargetScene:(TargetScenes)_sceneNum]];
    }
}

-(void) dealloc
{
	[super dealloc];
    
    instanceOfMainScene = nil; 
}

@end
