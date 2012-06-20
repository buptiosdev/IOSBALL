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
#import "ResultLayer.h"

@interface GameMainScene (PrivateMethods)
-(void) enableBox2dDebugDrawing;
-initWithOrder:(int)order;
+(id)createMainLayer:(int)order;
-(void)initSceneParam:(int)order;
@end

@implementation GameMainScene
@synthesize sceneNum = _sceneNum;
@synthesize isGameOver = _isGameOver;
@synthesize isGamePass = _isGamePass;
@synthesize mainscenParam = _mainscenParam;

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
        [self initSceneParam:order];
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


-(void)initSceneParam:(int)order
{
    switch (order) {
        case TargetScene1stScene:
            _mainscenParam.candyCount = 10;
            _mainscenParam.candyType = 1;
            _mainscenParam.candyFrequency = 5;
            _mainscenParam.landCompetitorExist = NO;
            _mainscenParam.landCompetSpeed = 0.5f;
            _mainscenParam.landAnimalSpeed = 0.5f;
            _mainscenParam.bombFrequency = NoTime;
            _mainscenParam.crystalFrequency = NoTime;
            break;
        case TargetScene2ndScene:
            _mainscenParam.candyCount = 15;
            _mainscenParam.candyType = 2;
            _mainscenParam.candyFrequency = 5;
            _mainscenParam.landCompetitorExist = NO;
            _mainscenParam.landCompetSpeed = 0.5f;
            _mainscenParam.landAnimalSpeed = 0.5f;
            _mainscenParam.bombFrequency = NoTime;
            _mainscenParam.crystalFrequency = NoTime;
            break;
        case TargetScene3rdScene:
            _mainscenParam.candyCount = 20;
            _mainscenParam.candyType = 2;
            _mainscenParam.candyFrequency = 5;
            _mainscenParam.landCompetitorExist = NO;
            _mainscenParam.landCompetSpeed = 0.5f;
            _mainscenParam.landAnimalSpeed = 0.5f;
            _mainscenParam.bombFrequency = NoTime;
            _mainscenParam.crystalFrequency = TwoTime;
            break;
        case TargetScene4thScene:
            _mainscenParam.candyCount = 20;
            _mainscenParam.candyType = 2;
            _mainscenParam.candyFrequency = 5;
            _mainscenParam.landCompetitorExist = NO;
            _mainscenParam.landCompetSpeed = 0.5f;
            _mainscenParam.landAnimalSpeed = 0.5f;
            _mainscenParam.bombFrequency = OneTime;
            _mainscenParam.crystalFrequency = OneTime;
            break;
        case TargetScene5thScene:
            _mainscenParam.candyCount = 25;
            _mainscenParam.candyType = 3;
            _mainscenParam.candyFrequency = 5;
            _mainscenParam.landCompetitorExist = NO;
            _mainscenParam.landCompetSpeed = 0.5f;
            _mainscenParam.landAnimalSpeed = 0.5f;
            _mainscenParam.bombFrequency = OneTime;
            _mainscenParam.crystalFrequency = OneTime;
            break;
        case TargetScene6thScene:
            _mainscenParam.candyCount = 25;
            _mainscenParam.candyType = 3;
            _mainscenParam.candyFrequency = 5;
            _mainscenParam.landCompetitorExist = NO;
            _mainscenParam.landCompetSpeed = 0.5f;
            _mainscenParam.landAnimalSpeed = 0.5f;
            _mainscenParam.bombFrequency = NoTime;
            _mainscenParam.crystalFrequency = OneTimePer20s;
            break;
        case TargetScene7thScene:
            _mainscenParam.candyCount = 25;
            _mainscenParam.candyType = 3;
            _mainscenParam.candyFrequency = 5;
            _mainscenParam.landCompetitorExist = NO;
            _mainscenParam.landCompetSpeed = 0.5f;
            _mainscenParam.landAnimalSpeed = 0.5f;
            _mainscenParam.bombFrequency = OneTime;
            _mainscenParam.crystalFrequency = OneTime;
            break;
        case TargetScene8thScene:
            _mainscenParam.candyCount = 30;
            _mainscenParam.candyType = 3;
            _mainscenParam.candyFrequency = 5;
            _mainscenParam.landCompetitorExist = NO;
            _mainscenParam.landCompetSpeed = 0.5f;
            _mainscenParam.landAnimalSpeed = 0.5f;
            _mainscenParam.bombFrequency = OneTimePer20s;
            _mainscenParam.crystalFrequency = OneTime;
            break;
        case TargetScene9thScene:
            _mainscenParam.candyCount = 30;
            _mainscenParam.candyType = 3;
            _mainscenParam.candyFrequency = 5;
            _mainscenParam.landCompetitorExist = NO;
            _mainscenParam.landCompetSpeed = 0.5f;
            _mainscenParam.landAnimalSpeed = 0.5f;
            _mainscenParam.bombFrequency = OneTimePer30s;
            _mainscenParam.crystalFrequency = OneTime;
            break;
        case TargetScene10thScene:
            _mainscenParam.candyCount = 30;
            _mainscenParam.candyType = 3;
            _mainscenParam.candyFrequency = 5;
            _mainscenParam.landCompetitorExist = YES;
            _mainscenParam.landCompetSpeed = 0.5f;
            _mainscenParam.landAnimalSpeed = 0.3f;
            _mainscenParam.bombFrequency = OneTimePer30s;
            _mainscenParam.crystalFrequency = OneTime;
            break;
        case TargetScene11thScene:
            _mainscenParam.candyCount = 30;
            _mainscenParam.candyType = 3;
            _mainscenParam.candyFrequency = 5;
            _mainscenParam.landCompetitorExist = YES;
            _mainscenParam.landCompetSpeed = 0.5f;
            _mainscenParam.landAnimalSpeed = 0.3f;
            _mainscenParam.bombFrequency = OneTimePer30s;
            _mainscenParam.crystalFrequency = OneTimePer20s;
            break;
        case TargetScene12thScene:
            _mainscenParam.candyCount = 30;
            _mainscenParam.candyType = 3;
            _mainscenParam.candyFrequency = 5;
            _mainscenParam.landCompetitorExist = YES;
            _mainscenParam.landCompetSpeed = 0.5f;
            _mainscenParam.landAnimalSpeed = 0.4f;
            _mainscenParam.bombFrequency = OneTimePer30s;
            _mainscenParam.crystalFrequency = OneTime;
            break;
        case TargetScene13thScene:
            _mainscenParam.candyCount = 40;
            _mainscenParam.candyType = 3;
            _mainscenParam.candyFrequency = 5;
            _mainscenParam.landCompetitorExist = YES;
            _mainscenParam.landCompetSpeed = 0.5f;
            _mainscenParam.landAnimalSpeed = 0.4f;
            _mainscenParam.bombFrequency = OneTimePer30s;
            _mainscenParam.crystalFrequency = OneTime;
            break;
        case TargetScene14thScene:
            _mainscenParam.candyCount = 40;
            _mainscenParam.candyType = 3;
            _mainscenParam.candyFrequency = 5;
            _mainscenParam.landCompetitorExist = YES;
            _mainscenParam.landCompetSpeed = 0.5f;
            _mainscenParam.landAnimalSpeed = 0.4f;
            _mainscenParam.bombFrequency = OneTimePer20s;
            _mainscenParam.crystalFrequency = OneTime;
            break;
        case TargetScene15thScene:
            _mainscenParam.candyCount = 40;
            _mainscenParam.candyType = 3;
            _mainscenParam.candyFrequency = 5;
            _mainscenParam.landCompetitorExist = YES;
            _mainscenParam.landCompetSpeed = 0.5f;
            _mainscenParam.landAnimalSpeed = 0.5f;
            _mainscenParam.bombFrequency = OneTimePer30s;
            _mainscenParam.crystalFrequency = NoTime;
            break;
        case TargetScene16thScene:
            _mainscenParam.candyCount = 40;
            _mainscenParam.candyType = 3;
            _mainscenParam.candyFrequency = 5;
            _mainscenParam.landCompetitorExist = YES;
            _mainscenParam.landCompetSpeed = 0.5f;
            _mainscenParam.landAnimalSpeed = 0.5f;
            _mainscenParam.bombFrequency = NoTime;
            _mainscenParam.crystalFrequency = OneTimePer20s;
            break;
        case TargetScene17thScene:
            _mainscenParam.candyCount = 45;
            _mainscenParam.candyType = 3;
            _mainscenParam.candyFrequency = 5;
            _mainscenParam.landCompetitorExist = YES;
            _mainscenParam.landCompetSpeed = 0.5f;
            _mainscenParam.landAnimalSpeed = 0.6f;
            _mainscenParam.bombFrequency = OneTimePer30s;
            _mainscenParam.crystalFrequency = TwoTime;
            break;
        case TargetScene18thScene:
            _mainscenParam.candyCount = 45;
            _mainscenParam.candyType = 3;
            _mainscenParam.candyFrequency = 3;
            _mainscenParam.landCompetitorExist = YES;
            _mainscenParam.landCompetSpeed = 0.5f;
            _mainscenParam.landAnimalSpeed = 0.6f;
            _mainscenParam.bombFrequency = OneTimePer30s;
            _mainscenParam.crystalFrequency = TwoTime;
            break;
        case TargetScene19thScene:
            _mainscenParam.candyCount = 50;
            _mainscenParam.candyType = 3;
            _mainscenParam.candyFrequency = 3;
            _mainscenParam.landCompetitorExist = YES;
            _mainscenParam.landCompetSpeed = 0.5f;
            _mainscenParam.landAnimalSpeed = 0.6f;
            _mainscenParam.bombFrequency = OneTimePer20s;
            _mainscenParam.crystalFrequency = TwoTime;
            break;
        case TargetScene20thScene:
            _mainscenParam.candyCount = 50;
            _mainscenParam.candyType = 3;
            _mainscenParam.candyFrequency = 5;
            _mainscenParam.landCompetitorExist = YES;
            _mainscenParam.landCompetSpeed = 0.5f;
            _mainscenParam.landAnimalSpeed = 1.0f;
            _mainscenParam.bombFrequency = OneTimePer30s;
            _mainscenParam.crystalFrequency = TwoTime;
            break;
        default:
            break;
    }
}







- (void) onPauseExit
{
	if(![AppDelegate getAppDelegate].paused)
	{
		[AppDelegate getAppDelegate].paused = YES;
		[super onExit];
	}
} 

-(void)pauseGame
{
	ccColor4B c = {100,100,0,100};
    PauseLayer * p = [PauseLayer createPauseLayer:c];
    [self.parent addChild:p z:10]; 
	[self onPauseExit];
//   test for resultlayer    
//    ResultLayer *p=[ResultLayer createResultLayer:c Level:(int)_sceneNum Score:(int)100 AddScore:(int)50];
//    [self.parent addChild:p z:10]; 
}


- (void) resumeGame
{
	if(![AppDelegate getAppDelegate].paused)
	{
		return;
	}
	[AppDelegate getAppDelegate].paused = NO;
	[super onEnter];
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
    instanceOfMainScene = nil; 
	
    [super dealloc];
}

@end
