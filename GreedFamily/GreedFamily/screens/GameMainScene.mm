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
-(void)preloadParticleEffect;
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
        [self preloadParticleEffect];
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

-(void) preloadParticleEffects:(NSString*)particleFile
{
	[ARCH_OPTIMAL_PARTICLE_SYSTEM particleWithFile:particleFile];
}

-(void)preloadParticleEffect
{
    // To preload the textures, play each effect once off-screen
    [self preloadParticleEffects:@"bublle_break.plist"];
    [self preloadParticleEffects:@"drop_start.plist"];
    [self preloadParticleEffects:@"land_crystal.plist"];
    [self preloadParticleEffects:@"land_ice.plist"];
    [self preloadParticleEffects:@"land_poison.plist"];
    [self preloadParticleEffects:@"land_bomb.plist"];
}


-(void)initSceneParam:(int)order
{
    switch (order) {
        case TargetScene1stScene:
            _mainscenParam.maxVisibaleNum = 3;
            _mainscenParam.candyCount = 3;
            _mainscenParam.candyType = 1;
            _mainscenParam.candyFrequency = 5;
            _mainscenParam.landCompetitorExist = NO;
            _mainscenParam.landCompetSpeed = 0.5f;
            _mainscenParam.landAnimalSpeed = 0.5f;
            _mainscenParam.bombFrequency = NoTime;
            _mainscenParam.crystalFrequency = NoTime;
            _mainscenParam.pepperFrequency = NoTime;
            _mainscenParam.iceFrequency = NoTime;
            break;
            
        case TargetScene2ndScene:
            _mainscenParam.maxVisibaleNum = 3;
            _mainscenParam.candyCount = 7;
            _mainscenParam.candyType = 2;
            _mainscenParam.candyFrequency = 5;
            _mainscenParam.landCompetitorExist = NO;
            _mainscenParam.landCompetSpeed = 0.5f;
            _mainscenParam.landAnimalSpeed = 0.5f;
            _mainscenParam.bombFrequency = NoTime;
            _mainscenParam.crystalFrequency = NoTime;
            _mainscenParam.pepperFrequency = NoTime;
            _mainscenParam.iceFrequency = NoTime;
            break;
            
        case TargetScene3rdScene:
            _mainscenParam.maxVisibaleNum = 3;
            _mainscenParam.candyCount = 10;
            _mainscenParam.candyType = 3;
            _mainscenParam.candyFrequency = 5;
            _mainscenParam.landCompetitorExist = NO;
            _mainscenParam.landCompetSpeed = 0.5f;
            _mainscenParam.landAnimalSpeed = 0.5f;
            _mainscenParam.bombFrequency = NoTime;
            _mainscenParam.crystalFrequency = NoTime;
            _mainscenParam.pepperFrequency = NoTime;
            _mainscenParam.iceFrequency = NoTime;
            break;
            
        case TargetScene4thScene:
            _mainscenParam.maxVisibaleNum = 3;
            _mainscenParam.candyCount = 15;
            _mainscenParam.candyType = 3;
            _mainscenParam.candyFrequency = 5;
            _mainscenParam.landCompetitorExist = NO;
            _mainscenParam.landCompetSpeed = 0.5f;
            _mainscenParam.landAnimalSpeed = 0.5f;
            _mainscenParam.bombFrequency = NoTime;
            _mainscenParam.crystalFrequency = OneTime;
            _mainscenParam.pepperFrequency = NoTime;
            _mainscenParam.iceFrequency = NoTime;
            break;
        case TargetScene5thScene:
            _mainscenParam.maxVisibaleNum = 3;
            _mainscenParam.candyCount = 15;
            _mainscenParam.candyType = 3;
            _mainscenParam.candyFrequency = 5;
            _mainscenParam.landCompetitorExist = NO;
            _mainscenParam.landCompetSpeed = 0.5f;
            _mainscenParam.landAnimalSpeed = 0.5f;
            _mainscenParam.bombFrequency = OneTime;
            _mainscenParam.crystalFrequency = OneTime;
            _mainscenParam.pepperFrequency = NoTime;
            _mainscenParam.iceFrequency = NoTime;
            break;
        case TargetScene6thScene:
            _mainscenParam.maxVisibaleNum = 4;
            _mainscenParam.candyCount = 5;
            _mainscenParam.candyType = 1;
            _mainscenParam.candyFrequency = 5;
            _mainscenParam.landCompetitorExist = YES;
            _mainscenParam.landCompetSpeed = 0.3f;
            _mainscenParam.landAnimalSpeed = 0.5f;
            _mainscenParam.bombFrequency = NoTime;
            _mainscenParam.crystalFrequency = NoTime;
            _mainscenParam.pepperFrequency = NoTime;
            _mainscenParam.iceFrequency = NoTime;
            break;
        case TargetScene7thScene:
            _mainscenParam.maxVisibaleNum = 4;
            _mainscenParam.candyCount = 10;
            _mainscenParam.candyType = 2;
            _mainscenParam.candyFrequency = 5;
            _mainscenParam.landCompetitorExist = YES;
            _mainscenParam.landCompetSpeed = 0.3f;
            _mainscenParam.landAnimalSpeed = 0.5f;
            _mainscenParam.bombFrequency = NoTime;
            _mainscenParam.crystalFrequency = NoTime;
            _mainscenParam.pepperFrequency = NoTime;
            _mainscenParam.iceFrequency = NoTime;
            break;
        case TargetScene8thScene:
            _mainscenParam.maxVisibaleNum = 4;
            _mainscenParam.candyCount = 13;
            _mainscenParam.candyType = 3;
            _mainscenParam.candyFrequency = 5;
            _mainscenParam.landCompetitorExist = YES;
            _mainscenParam.landCompetSpeed = 0.3f;
            _mainscenParam.landAnimalSpeed = 0.5f;
            _mainscenParam.bombFrequency = NoTime;
            _mainscenParam.crystalFrequency = NoTime;
            _mainscenParam.pepperFrequency = NoTime;
            _mainscenParam.iceFrequency = NoTime;
            break;
        case TargetScene9thScene:
            _mainscenParam.maxVisibaleNum = 4;
            _mainscenParam.candyCount = 18;
            _mainscenParam.candyType = 3;
            _mainscenParam.candyFrequency = 5;
            _mainscenParam.landCompetitorExist = YES;
            _mainscenParam.landCompetSpeed = 0.3f;
            _mainscenParam.landAnimalSpeed = 0.5f;
            _mainscenParam.bombFrequency = NoTime;
            _mainscenParam.crystalFrequency = OneTime;
            _mainscenParam.pepperFrequency = NoTime;
            _mainscenParam.iceFrequency = NoTime;
            break;
        case TargetScene10thScene:
            _mainscenParam.maxVisibaleNum = 4;
            _mainscenParam.candyCount = 20;
            _mainscenParam.candyType = 3;
            _mainscenParam.candyFrequency = 5;
            _mainscenParam.landCompetitorExist = YES;
            _mainscenParam.landCompetSpeed = 0.3f;
            _mainscenParam.landAnimalSpeed = 0.5f;
            _mainscenParam.bombFrequency = OneTime;
            _mainscenParam.crystalFrequency = OneTime;
            _mainscenParam.pepperFrequency = NoTime;
            _mainscenParam.iceFrequency = NoTime;
            break;
        case TargetScene11thScene:
            _mainscenParam.maxVisibaleNum = 5;
            _mainscenParam.candyCount = 20;
            _mainscenParam.candyType = 3;
            _mainscenParam.candyFrequency = 5;
            _mainscenParam.landCompetitorExist = YES;
            _mainscenParam.landCompetSpeed = 0.5f;
            _mainscenParam.landAnimalSpeed = 0.5f;
            _mainscenParam.bombFrequency = NoTime;
            _mainscenParam.crystalFrequency = OneTime;
            _mainscenParam.pepperFrequency = OneTime;
            _mainscenParam.iceFrequency = OneTime;
            _mainscenParam.invisibaleNum = 1;
            break;
        case TargetScene12thScene:
            _mainscenParam.maxVisibaleNum = 5;
            _mainscenParam.candyCount = 20;
            _mainscenParam.candyType = 3;
            _mainscenParam.candyFrequency = 5;
            _mainscenParam.landCompetitorExist = YES;
            _mainscenParam.landCompetSpeed = 0.5f;
            _mainscenParam.landAnimalSpeed = 0.5f;
            _mainscenParam.bombFrequency = TwoTime;
            _mainscenParam.crystalFrequency = OneTime;
            _mainscenParam.pepperFrequency = OneTime;
            _mainscenParam.iceFrequency = TwoTime;
            _mainscenParam.invisibaleNum = 1;
            break;
        case TargetScene13thScene:
            _mainscenParam.maxVisibaleNum = 5;
            _mainscenParam.candyCount = 30;
            _mainscenParam.candyType = 3;
            _mainscenParam.candyFrequency = 5;
            _mainscenParam.landCompetitorExist = YES;
            _mainscenParam.landCompetSpeed = 0.5f;
            _mainscenParam.landAnimalSpeed = 0.5f;
            _mainscenParam.bombFrequency = TwoTime;
            _mainscenParam.crystalFrequency = OneTime;
            _mainscenParam.pepperFrequency = OneTime;
            _mainscenParam.iceFrequency = TwoTime;
            _mainscenParam.invisibaleNum = 1;
            break;
        case TargetScene14thScene:
            _mainscenParam.maxVisibaleNum = 5;
            _mainscenParam.candyCount = 35;
            _mainscenParam.candyType = 3;
            _mainscenParam.candyFrequency = 5;
            _mainscenParam.landCompetitorExist = YES;
            _mainscenParam.landCompetSpeed = 0.5f;
            _mainscenParam.landAnimalSpeed = 0.5f;
            _mainscenParam.bombFrequency = TwoTime;
            _mainscenParam.crystalFrequency = OneTime;
            _mainscenParam.pepperFrequency = TwoTime;
            _mainscenParam.iceFrequency = TwoTime;
            _mainscenParam.invisibaleNum = 2;
            break;
        case TargetScene15thScene:
            _mainscenParam.maxVisibaleNum = 5;
            _mainscenParam.candyCount = 35;
            _mainscenParam.candyType = 3;
            _mainscenParam.candyFrequency = 5;
            _mainscenParam.landCompetitorExist = YES;
            _mainscenParam.landCompetSpeed = 0.5f;
            _mainscenParam.landAnimalSpeed = 0.5f;
            _mainscenParam.bombFrequency = TwoTime;
            _mainscenParam.crystalFrequency = NoTime;
            _mainscenParam.pepperFrequency = TwoTime;
            _mainscenParam.iceFrequency = ThreeTime;
            _mainscenParam.invisibaleNum = 2;
            break;
        case TargetScene16thScene:
            _mainscenParam.maxVisibaleNum = 6;
            _mainscenParam.candyCount = 40;
            _mainscenParam.candyType = 3;
            _mainscenParam.candyFrequency = 5;
            _mainscenParam.landCompetitorExist = YES;
            _mainscenParam.landCompetSpeed = 0.6f;
            _mainscenParam.landAnimalSpeed = 0.5f;
            _mainscenParam.bombFrequency = NoTime;
            _mainscenParam.crystalFrequency = OneTime;
            _mainscenParam.pepperFrequency = OneTime;
            _mainscenParam.iceFrequency = FourTime;
            _mainscenParam.invisibaleNum = 3;
            break;
        case TargetScene17thScene:
            _mainscenParam.maxVisibaleNum = 6;
            _mainscenParam.candyCount = 45;
            _mainscenParam.candyType = 3;
            _mainscenParam.candyFrequency = 5;
            _mainscenParam.landCompetitorExist = YES;
            _mainscenParam.landCompetSpeed = 0.6f;
            _mainscenParam.landAnimalSpeed = 0.5f;
            _mainscenParam.bombFrequency = ThreeTime;
            _mainscenParam.crystalFrequency = OneTime;
            _mainscenParam.pepperFrequency = TwoTime;
            _mainscenParam.iceFrequency = ThreeTime;
            _mainscenParam.invisibaleNum = 3;
            break;
        case TargetScene18thScene:
            _mainscenParam.maxVisibaleNum = 6;
            _mainscenParam.candyCount = 45;
            _mainscenParam.candyType = 3;
            _mainscenParam.candyFrequency = 3;
            _mainscenParam.landCompetitorExist = YES;
            _mainscenParam.landCompetSpeed = 0.6f;
            _mainscenParam.landAnimalSpeed = 0.5f;
            _mainscenParam.bombFrequency = TwoTime;
            _mainscenParam.crystalFrequency = OneTime;
            _mainscenParam.pepperFrequency = TwoTime;
            _mainscenParam.iceFrequency = ThreeTime;
            _mainscenParam.invisibaleNum = 4;
            break;
        case TargetScene19thScene:
            _mainscenParam.maxVisibaleNum = 6;
            _mainscenParam.candyCount = 50;
            _mainscenParam.candyType = 3;
            _mainscenParam.candyFrequency = 3;
            _mainscenParam.landCompetitorExist = YES;
            _mainscenParam.landCompetSpeed = 1.0f;
            _mainscenParam.landAnimalSpeed = 0.5f;
            _mainscenParam.bombFrequency = ThreeTime;
            _mainscenParam.crystalFrequency = OneTime;
            _mainscenParam.pepperFrequency = ThreeTime;
            _mainscenParam.iceFrequency = FourTime;
            _mainscenParam.invisibaleNum = 4;
            break;
        case TargetScene20thScene:
            _mainscenParam.maxVisibaleNum = 7;
            _mainscenParam.candyCount = 50;
            _mainscenParam.candyType = 3;
            _mainscenParam.candyFrequency = 3;
            _mainscenParam.landCompetitorExist = YES;
            _mainscenParam.landCompetSpeed = 1.0f;
            _mainscenParam.landAnimalSpeed = 0.5f;
            _mainscenParam.bombFrequency = FiveTime;
            _mainscenParam.crystalFrequency = OneTime;
            _mainscenParam.pepperFrequency = ThreeTime;
            _mainscenParam.iceFrequency = FiveTime;
            _mainscenParam.invisibaleNum = 5;
            break;
        default:
            break;
    }
}

-(void)endGame
{
    //1.调用一次消球接口 
    Storage *storage = [[TouchCatchLayer sharedTouchCatchLayer] getStorage];
    [storage doMyCombineFood];
    //2.调用算分接口
    CCArray * levelscore=[storage getScoreByLevel:(int)_sceneNum];
    //int score=[levelscore indexOfObject:0];
    //int addscore=[levelscore indexOfObject:0];


    
    id temp1 = [levelscore objectAtIndex:1];
    int addscore = [temp1 intValue];    
    
    id temp2 = [levelscore objectAtIndex:0];
    int score = [temp2 intValue];    
    
    CCLOG(@"score is %d",score);
    
    CCLOG(@"addscore is %d",addscore);
    
    //3.生成关卡结束显示层
    ccColor4B c = {255,255,0,100};
    ResultLayer *p=[ResultLayer createResultLayer:c Level:(int)_sceneNum Score:(int)score AddScore:(int)addscore];
    [self.parent addChild:p z:10]; 
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
    
    BOOL finish=[ObjectsLayer sharedObjectsLayer].isGameFinish;
    if(finish)
    {
        //防止多次调用
        [self unscheduleAllSelectors];
        [self endGame];
    }
}



-(void) dealloc
{
    instanceOfMainScene = nil; 
	
    [super dealloc];
}

@end
