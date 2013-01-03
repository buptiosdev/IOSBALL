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
#import "TeachGameLayer.h"
#import "CommonLayer.h"
@interface GameMainScene (PrivateMethods)
-(void) enableBox2dDebugDrawing;
-initWithOrder:(int)order;
+(id)createMainLayer:(int)order;
-(void)initSceneParam:(int)order;
-(void)preloadParticleEffect;
-(void)initPointParam;
-(void)initPairSceneParam:(int)order;
-(void)initPairPointParam;
@end

@implementation GameMainScene
@synthesize sceneNum = _sceneNum;
@synthesize isGameOver = _isGameOver;
@synthesize isGamePass = _isGamePass;
@synthesize mainscenParam = _mainscenParam;
@synthesize roleType = _roleType;
@synthesize acceleration = _acceleration;
@synthesize accelerationPlay2 = _accelerationPlay2;
@synthesize initPos = _initPos;
@synthesize remainBallPos = _remainBallPos;
@synthesize remainBallLabelPos = _remainBallLabelPos;
@synthesize pepperMenuPos = _pepperMenuPos;
@synthesize pepperMenuPlay2Pos = _pepperMenuPlay2Pos;
@synthesize initMenuPos = _initMenuPos;
@synthesize appear1stPos = _appear1stPos;
@synthesize appear2ndPos = _appear2ndPos;
@synthesize appear3rdPos = _appear3rdPos;
@synthesize appear4thPos = _appear4thPos;
@synthesize appear5thPos = _appear5thPos;
@synthesize backgroundPos = _backgroundPos;
@synthesize storagePos = _storagePos;
@synthesize scorePos = _scorePos;
@synthesize scorePlay2Pos = _scorePlay2Pos;
@synthesize isPairPlay = _isPairPlay;


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

-(void)initNomalGame:(int)order
{
    _isPairPlay = NO;
    NSString *strName = [NSString stringWithFormat:@"RoleType"];
    _roleType = [[NSUserDefaults standardUserDefaults]  integerForKey:strName];
    NSString *strName2 = nil;
    if (3 == _roleType) 
    {
        strName2 = [NSString stringWithFormat:@"Acceleration_Bird"];
    }
    else if (2 == _roleType) 
    {
        strName2 = [NSString stringWithFormat:@"Acceleration_Pig"];
    }
    else if (1 == _roleType) 
    {
        strName2 = [NSString stringWithFormat:@"Acceleration_Panda"];
    }
    _acceleration = [[NSUserDefaults standardUserDefaults]  integerForKey:strName2];
    if (_acceleration > 50 || _acceleration < 10) 
    {
        _acceleration = 10;
    }
    _isGameOver = NO;
    _isGamePass = NO;
    [self preloadParticleEffect];
    [self initSceneParam:order];
    [self initPointParam];
}

-(void)initPairGame:(int)order
{
    _isPairPlay = YES;

    NSString *strNamePlay1 = [NSString stringWithFormat:@"Acceleration_Bird"];
    NSString *strNamePlay2 = [NSString stringWithFormat:@"Acceleration_Pig"];
    _acceleration = [[NSUserDefaults standardUserDefaults]  integerForKey:strNamePlay1];
    if (_acceleration > 50 || _acceleration < 10) 
    {
        _acceleration = 10;
    }
    _accelerationPlay2 = [[NSUserDefaults standardUserDefaults]  integerForKey:strNamePlay2];
    if (_accelerationPlay2 > 50 || _accelerationPlay2 < 10) 
    {
        _accelerationPlay2 = 10;
    }
    
    _isGameOver = NO;
    _isGamePass = NO;
    [self preloadParticleEffect];
    [self initPairSceneParam:order];
    [self initPairPointParam];
}

-(id)initWithOrder:(int)order
{
    if (self = [super init]) 
    {   
        //self.isAccelerometerEnabled = YES;
        //初始化一开始，给半单例赋值
        instanceOfMainScene = self;
        _sceneNum = order;

        //双人游戏 order为0
        if (0 >= order) 
        {
            [self initPairGame:order];
        }
        else
        {
            [self initNomalGame:order];
        }
        
        GameBackgroundLayer *gameBackgroundLayer = [GameBackgroundLayer CreateGameBackgroundLayer];
        [self addChild:gameBackgroundLayer z:1 tag:BackGroundLayerTag];
        
//        CCSprite* background = [CCSprite spriteWithSpriteFrameName:@"background.png"];
//        CGSize screenSize = [[CCDirector sharedDirector] winSize];
//        background.position = CGPointMake(screenSize.width / 2, screenSize.height / 2);
//        [self addChild:background z:100];
        
        ObjectsLayer *objectsLayer = [ObjectsLayer CreateObjectsLayer];
        [self addChild:objectsLayer z:1 tag:ObjectsLayerTag];
        
        TouchCatchLayer *touchCatchLayer = [TouchCatchLayer CreateTouchCatchLayer];
        [self addChild:touchCatchLayer z:1 tag:TouchCatchLayerTag];
        
        //[[GameMainScene sharedMainScene] addTeacheGame];
//        [self schedule:@selector(sleepForTeach:) interval:0.1];
        
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
    [self preloadParticleEffects:@"drop_star.plist"];
    [self preloadParticleEffects:@"land_crystal.plist"];
    [self preloadParticleEffects:@"land_ice.plist"];
    [self preloadParticleEffects:@"land_poison.plist"];
    [self preloadParticleEffects:@"land_bomb.plist"];
    [self preloadParticleEffects:@"landspeedfast.plist"];
    [self preloadParticleEffects:@"redscore.plist"];
    [self preloadParticleEffects:@"speedfast2.plist"];
    [self preloadParticleEffects:@"bublle_break2.plist"];
    [self preloadParticleEffects:@"shootingstars.plist"];
    [self preloadParticleEffects:@"smoke2.plist"];
    [self preloadParticleEffects:@"besmoked.plist"];
    [self preloadParticleEffects:@"star.plist"];
    [self preloadParticleEffects:@"scoreblue.plist"];
    [self preloadParticleEffects:@"get_score_02.plist"];
}


-(void)initPairSceneParam:(int)order
{
    _mainscenParam.order = order;
    switch (order) {
        case TargetScenesPairEasy:
            _mainscenParam.maxVisibaleNum = 4;
            _mainscenParam.candyCount = 30;
            _mainscenParam.candyType = 3;
            _mainscenParam.candyFrequency = 5;
            _mainscenParam.landCompetitorExist = NO;
            _mainscenParam.landCompetSpeed = 0.5f;
            _mainscenParam.landAnimalSpeed = 0.5f;
            _mainscenParam.landAnimalSpeedPlay2 = 0.5f;
            _mainscenParam.bombFrequency = ThreeTime;
            _mainscenParam.crystalFrequency = ThreeTime;
            _mainscenParam.pepperFrequency = ThreeTime;
            _mainscenParam.iceFrequency = ThreeTime;
            _mainscenParam.smokeFrequency = ThreeTime;
            break;
        case TargetScenesPairHard:
            _mainscenParam.maxVisibaleNum = 5;
            _mainscenParam.candyCount = 40;
            _mainscenParam.candyType = 3;
            _mainscenParam.candyFrequency = 5;
            _mainscenParam.landCompetitorExist = NO;
            _mainscenParam.landCompetSpeed = 0.5f;
            _mainscenParam.landAnimalSpeed = 0.5f;
            _mainscenParam.landAnimalSpeedPlay2 = 0.5f;
            _mainscenParam.bombFrequency = FiveTime;
            _mainscenParam.crystalFrequency = FiveTime;
            _mainscenParam.pepperFrequency = FiveTime;
            _mainscenParam.iceFrequency = FiveTime;
            _mainscenParam.smokeFrequency = FiveTime;
            _mainscenParam.invisibaleNum = 5;
            break;
    }
    //根据角色不同速度不同，暂时双人只能角色1 和 角色2    
    _mainscenParam.landAnimalSpeed = [[CommonLayer sharedCommonLayer] getRoleParam:1 ParamType:ROLELANDSPEED];
    _mainscenParam.landAnimalSpeedPlay2 = [[CommonLayer sharedCommonLayer] getRoleParam:2 ParamType:ROLELANDSPEED];
    
}

-(void)initPairPointParam
{
    CGSize screenSize = [[CCDirector sharedDirector] winSize];
    
    _initPos = CGPointMake(-100, -100);
    _remainBallPos = CGPointMake(screenSize.width * 0.5, screenSize.height - 20);
    _remainBallLabelPos = CGPointMake(screenSize.width * 0.5 + 25, screenSize.height - 5);
    _pepperMenuPlay2Pos = CGPointMake(screenSize.width - 120, 25);
    _pepperMenuPos = CGPointMake(screenSize.width * 0.5 - 120, 25);
    _initMenuPos = CGPointMake(screenSize.width + 40, 15);
    _appear1stPos = CGPointMake(20, screenSize.height * 0.5);
    _appear2ndPos = CGPointMake(screenSize.width * 0.25, screenSize.height - 20);
    _appear3rdPos = CGPointMake(screenSize.width * 0.5, screenSize.height - 20);
    _appear4thPos = CGPointMake(screenSize.width * 0.75, screenSize.height - 20);
    _appear5thPos = CGPointMake(screenSize.width - 20, screenSize.height * 0.5);
    _backgroundPos = CGPointMake(screenSize.width / 2, screenSize.height / 2 );
    _storagePos = CGPointMake(175, 25);
    _scorePos = CGPointMake(25, screenSize.height - 16);
    _scorePlay2Pos = CGPointMake(600 + 25, screenSize.height - 16);
}

-(void)initPointParam
{
    CGSize screenSize = [[CCDirector sharedDirector] winSize];
    
    _initPos = CGPointMake(-100, -100);
    _remainBallPos = CGPointMake(screenSize.width * 0.5, screenSize.height - 20);
    _remainBallLabelPos = CGPointMake(screenSize.width * 0.5 + 25, screenSize.height - 5);
    _pepperMenuPos = CGPointMake(screenSize.width - 210, 40);
    //_crystalMenuPos = CGPointMake(screenSize.width - 60, 25);
    _initMenuPos = CGPointMake(screenSize.width + 40, 15);
    _appear1stPos = CGPointMake(20, screenSize.height * 0.5);
    _appear2ndPos = CGPointMake(screenSize.width * 0.25, screenSize.height - 20);
    _appear3rdPos = CGPointMake(screenSize.width * 0.5, screenSize.height - 20);
    _appear4thPos = CGPointMake(screenSize.width * 0.75, screenSize.height - 20);
    _appear5thPos = CGPointMake(screenSize.width - 20, screenSize.height * 0.5);
    _backgroundPos = CGPointMake(screenSize.width / 2, screenSize.height / 2);
    _storagePos = CGPointMake(25, 40);
    _scorePos = CGPointMake(25, screenSize.height - 16);
}

-(void)initSceneParam:(int)order
{
    _mainscenParam.order = order;
    switch (order) {
        case TargetScene1stScene:
            _mainscenParam.maxVisibaleNum = 3;
            _mainscenParam.candyCount = 3;
            _mainscenParam.candyType = 1;
            _mainscenParam.candyFrequency = 4;
            _mainscenParam.landCompetitorExist = NO;
            _mainscenParam.landCompetSpeed = 0.8f;
            _mainscenParam.landAnimalSpeed = 0.5f;
            _mainscenParam.bombFrequency = NoTime;
            _mainscenParam.crystalFrequency = NoTime;
            _mainscenParam.pepperFrequency = NoTime;
            _mainscenParam.iceFrequency = NoTime;
            _mainscenParam.smokeFrequency = NoTime;
            break;
            
        case TargetScene2ndScene:
            _mainscenParam.maxVisibaleNum = 3;
            _mainscenParam.candyCount = 7;
            _mainscenParam.candyType = 2;
            _mainscenParam.candyFrequency = 4;
            _mainscenParam.landCompetitorExist = NO;
            _mainscenParam.landCompetSpeed = 0.5f;
            _mainscenParam.landAnimalSpeed = 0.5f;
            _mainscenParam.bombFrequency = NoTime;
            _mainscenParam.crystalFrequency = NoTime;
            _mainscenParam.pepperFrequency = NoTime;
            _mainscenParam.iceFrequency = NoTime;
            _mainscenParam.smokeFrequency = NoTime;
            break;
            
        case TargetScene3rdScene:
            _mainscenParam.maxVisibaleNum = 3;
            _mainscenParam.candyCount = 10;
            _mainscenParam.candyType = 3;
            _mainscenParam.candyFrequency = 4;
            _mainscenParam.landCompetitorExist = NO;
            _mainscenParam.landCompetSpeed = 0.5f;
            _mainscenParam.landAnimalSpeed = 0.5f;
            _mainscenParam.bombFrequency = NoTime;
            _mainscenParam.crystalFrequency = NoTime;
            _mainscenParam.pepperFrequency = NoTime;
            _mainscenParam.iceFrequency = NoTime;
            _mainscenParam.smokeFrequency = NoTime;
            break;
            
        case TargetScene4thScene:
            _mainscenParam.maxVisibaleNum = 3;
            _mainscenParam.candyCount = 13;
            _mainscenParam.candyType = 3;
            _mainscenParam.candyFrequency = 4;
            _mainscenParam.landCompetitorExist = NO;
            _mainscenParam.landCompetSpeed = 0.5f;
            _mainscenParam.landAnimalSpeed = 0.5f;
            _mainscenParam.bombFrequency = NoTime;
            _mainscenParam.crystalFrequency = NoTime;
            _mainscenParam.pepperFrequency = NoTime;
            _mainscenParam.iceFrequency = NoTime;
            _mainscenParam.smokeFrequency = NoTime;
            break;
        case TargetScene5thScene:
            _mainscenParam.maxVisibaleNum = 3;
            _mainscenParam.candyCount = 15;
            _mainscenParam.candyType = 3;
            _mainscenParam.candyFrequency = 4;
            _mainscenParam.landCompetitorExist = NO;
            _mainscenParam.landCompetSpeed = 0.5f;
            _mainscenParam.landAnimalSpeed = 0.5f;
            _mainscenParam.bombFrequency = OneTime;
            _mainscenParam.crystalFrequency = NoTime;
            _mainscenParam.pepperFrequency = NoTime;
            _mainscenParam.iceFrequency = NoTime;
            _mainscenParam.smokeFrequency = NoTime;
            break;
        case TargetScene6thScene:
            _mainscenParam.maxVisibaleNum = 3;
            _mainscenParam.candyCount = 8;
            _mainscenParam.candyType = 1;
            _mainscenParam.candyFrequency = 3;
            _mainscenParam.landCompetitorExist = YES;
            _mainscenParam.landCompetSpeed = 0.5f;
            _mainscenParam.landAnimalSpeed = 0.5f;
            _mainscenParam.bombFrequency = OneTime;
            _mainscenParam.crystalFrequency = NoTime;
            _mainscenParam.pepperFrequency = NoTime;
            _mainscenParam.iceFrequency = NoTime;
            _mainscenParam.smokeFrequency = NoTime;
            break;
        case TargetScene7thScene:
            _mainscenParam.maxVisibaleNum = 3;
            _mainscenParam.candyCount = 10;
            _mainscenParam.candyType = 2;
            _mainscenParam.candyFrequency = 3;
            _mainscenParam.landCompetitorExist = YES;
            _mainscenParam.landCompetSpeed = 0.6f;
            _mainscenParam.landAnimalSpeed = 0.5f;
            _mainscenParam.bombFrequency = OneTime;
            _mainscenParam.crystalFrequency = NoTime;
            _mainscenParam.pepperFrequency = NoTime;
            _mainscenParam.iceFrequency = NoTime;
            _mainscenParam.smokeFrequency = NoTime;
            break;
        case TargetScene8thScene:
            _mainscenParam.maxVisibaleNum = 3;
            _mainscenParam.candyCount = 15;
            _mainscenParam.candyType = 3;
            _mainscenParam.candyFrequency = 3;
            _mainscenParam.landCompetitorExist = YES;
            _mainscenParam.landCompetSpeed = 0.6f;
            _mainscenParam.landAnimalSpeed = 0.5f;
            _mainscenParam.bombFrequency = OneTime;
            _mainscenParam.crystalFrequency = OneTime;
            _mainscenParam.pepperFrequency = NoTime;
            _mainscenParam.iceFrequency = NoTime;
            _mainscenParam.smokeFrequency = NoTime;
            break;
        case TargetScene9thScene:
            _mainscenParam.maxVisibaleNum = 3;
            _mainscenParam.candyCount = 18;
            _mainscenParam.candyType = 3;
            _mainscenParam.candyFrequency = 3;
            _mainscenParam.landCompetitorExist = YES;
            _mainscenParam.landCompetSpeed = 0.7f;
            _mainscenParam.landAnimalSpeed = 0.5f;
            _mainscenParam.bombFrequency = TwoTime;
            _mainscenParam.crystalFrequency = OneTime;
            _mainscenParam.pepperFrequency = NoTime;
            _mainscenParam.iceFrequency = NoTime;
            _mainscenParam.smokeFrequency = NoTime;
            break;
        case TargetScene10thScene:
            _mainscenParam.maxVisibaleNum = 3;
            _mainscenParam.candyCount = 20;
            _mainscenParam.candyType = 3;
            _mainscenParam.candyFrequency = 3;
            _mainscenParam.landCompetitorExist = YES;
            _mainscenParam.landCompetSpeed = 0.7f;
            _mainscenParam.landAnimalSpeed = 0.5f;
            _mainscenParam.bombFrequency = ThreeTime;
            _mainscenParam.crystalFrequency = OneTime;
            _mainscenParam.pepperFrequency = NoTime;
            _mainscenParam.iceFrequency = NoTime;
            _mainscenParam.smokeFrequency = NoTime;
            break;
        case TargetScene11thScene:
            _mainscenParam.maxVisibaleNum = 4;
            _mainscenParam.candyCount = 20;
            _mainscenParam.candyType = 3;
            _mainscenParam.candyFrequency = 3;
            _mainscenParam.landCompetitorExist = YES;
            _mainscenParam.landCompetSpeed = 0.8f;
            _mainscenParam.landAnimalSpeed = 0.5f;
            _mainscenParam.bombFrequency = TwoTime;
            _mainscenParam.crystalFrequency = OneTime;
            _mainscenParam.pepperFrequency = NoTime;
            _mainscenParam.iceFrequency = TwoTime;
            //_mainscenParam.invisibaleNum = 1;
            _mainscenParam.smokeFrequency = NoTime;
            break;
        case TargetScene12thScene:
            _mainscenParam.maxVisibaleNum = 4;
            _mainscenParam.candyCount = 20;
            _mainscenParam.candyType = 3;
            _mainscenParam.candyFrequency = 3;
            _mainscenParam.landCompetitorExist = YES;
            _mainscenParam.landCompetSpeed = 0.8f;
            _mainscenParam.landAnimalSpeed = 0.5f;
            _mainscenParam.bombFrequency = TwoTime;
            _mainscenParam.crystalFrequency = OneTime;
            _mainscenParam.pepperFrequency = NoTime;
            _mainscenParam.iceFrequency = TwoTime;
            //_mainscenParam.invisibaleNum = 1;
            _mainscenParam.smokeFrequency = NoTime;
            break;
        case TargetScene13thScene:
            _mainscenParam.maxVisibaleNum = 4;
            _mainscenParam.candyCount = 25;
            _mainscenParam.candyType = 3;
            _mainscenParam.candyFrequency = 3;
            _mainscenParam.landCompetitorExist = YES;
            _mainscenParam.landCompetSpeed = 0.9f;
            _mainscenParam.landAnimalSpeed = 0.5f;
            _mainscenParam.bombFrequency = TwoTime;
            _mainscenParam.crystalFrequency = OneTime;
            _mainscenParam.pepperFrequency = TwoTime;
            _mainscenParam.iceFrequency = TwoTime;
            //_mainscenParam.invisibaleNum = 1;
            _mainscenParam.smokeFrequency = NoTime;
            break;
        case TargetScene14thScene:
            _mainscenParam.maxVisibaleNum = 4;
            _mainscenParam.candyCount = 25;
            _mainscenParam.candyType = 3;
            _mainscenParam.candyFrequency = 3;
            _mainscenParam.landCompetitorExist = YES;
            _mainscenParam.landCompetSpeed = 0.9f;
            _mainscenParam.landAnimalSpeed = 0.5f;
            _mainscenParam.bombFrequency = TwoTime;
            _mainscenParam.crystalFrequency = OneTime;
            _mainscenParam.pepperFrequency = TwoTime;
            _mainscenParam.iceFrequency = TwoTime;
            //_mainscenParam.invisibaleNum = 1;
            _mainscenParam.smokeFrequency = TwoTime;
            break;
        case TargetScene15thScene:
            _mainscenParam.maxVisibaleNum = 4;
            _mainscenParam.candyCount = 30;
            _mainscenParam.candyType = 3;
            _mainscenParam.candyFrequency = 3;
            _mainscenParam.landCompetitorExist = YES;
            _mainscenParam.landCompetSpeed = 1.0f;
            _mainscenParam.landAnimalSpeed = 0.5f;
            _mainscenParam.bombFrequency = TwoTime;
            _mainscenParam.crystalFrequency = NoTime;
            _mainscenParam.pepperFrequency = TwoTime;
            _mainscenParam.iceFrequency = ThreeTime;
            _mainscenParam.smokeFrequency = TwoTime;
            //_mainscenParam.invisibaleNum = 1;
            break;
        case TargetScene16thScene:
            _mainscenParam.maxVisibaleNum = 4;
            _mainscenParam.candyCount = 30;
            _mainscenParam.candyType = 3;
            _mainscenParam.candyFrequency = 3;
            _mainscenParam.landCompetitorExist = YES;
            _mainscenParam.landCompetSpeed = 1.0f;
            _mainscenParam.landAnimalSpeed = 0.5f;
            _mainscenParam.bombFrequency = NoTime;
            _mainscenParam.crystalFrequency = OneTime;
            _mainscenParam.pepperFrequency = OneTime;
            _mainscenParam.iceFrequency = FourTime;
            _mainscenParam.smokeFrequency = ThreeTime;
            _mainscenParam.invisibaleNum = 1;
            break;
        case TargetScene17thScene:
            _mainscenParam.maxVisibaleNum = 4;
            _mainscenParam.candyCount = 30;
            _mainscenParam.candyType = 3;
            _mainscenParam.candyFrequency = 3;
            _mainscenParam.landCompetitorExist = YES;
            _mainscenParam.landCompetSpeed = 1.1f;
            _mainscenParam.landAnimalSpeed = 0.5f;
            _mainscenParam.bombFrequency = ThreeTime;
            _mainscenParam.crystalFrequency = OneTime;
            _mainscenParam.pepperFrequency = TwoTime;
            _mainscenParam.iceFrequency = ThreeTime;
            _mainscenParam.smokeFrequency = ThreeTime;
            _mainscenParam.invisibaleNum = 2;
            break;
        case TargetScene18thScene:
            _mainscenParam.maxVisibaleNum = 4;
            _mainscenParam.candyCount = 35;
            _mainscenParam.candyType = 3;
            _mainscenParam.candyFrequency = 3;
            _mainscenParam.landCompetitorExist = YES;
            _mainscenParam.landCompetSpeed = 1.1f;
            _mainscenParam.landAnimalSpeed = 0.5f;
            _mainscenParam.bombFrequency = TwoTime;
            _mainscenParam.crystalFrequency = OneTime;
            _mainscenParam.pepperFrequency = TwoTime;
            _mainscenParam.iceFrequency = ThreeTime;
            _mainscenParam.smokeFrequency = ThreeTime;
            _mainscenParam.invisibaleNum = 3;
            break;
        case TargetScene19thScene:
            _mainscenParam.maxVisibaleNum = 4;
            _mainscenParam.candyCount = 35;
            _mainscenParam.candyType = 3;
            _mainscenParam.candyFrequency = 3;
            _mainscenParam.landCompetitorExist = YES;
            _mainscenParam.landCompetSpeed = 1.2f;
            _mainscenParam.landAnimalSpeed = 0.5f;
            _mainscenParam.bombFrequency = ThreeTime;
            _mainscenParam.crystalFrequency = OneTime;
            _mainscenParam.pepperFrequency = ThreeTime;
            _mainscenParam.iceFrequency = FourTime;
            _mainscenParam.smokeFrequency = ThreeTime;
            _mainscenParam.invisibaleNum = 4;
            break;
        case TargetScene20thScene:
            _mainscenParam.maxVisibaleNum = 5;
            _mainscenParam.candyCount = 40;
            _mainscenParam.candyType = 3;
            _mainscenParam.candyFrequency = 2;
            _mainscenParam.landCompetitorExist = YES;
            _mainscenParam.landCompetSpeed = 1.5f;
            _mainscenParam.landAnimalSpeed = 0.5f;
            _mainscenParam.bombFrequency = FiveTime;
            _mainscenParam.crystalFrequency = OneTime;
            _mainscenParam.pepperFrequency = ThreeTime;
            _mainscenParam.iceFrequency = FiveTime;
            _mainscenParam.smokeFrequency = ThreeTime;
            _mainscenParam.invisibaleNum = 5;
            break;
        default:
            break;
    }
    //不同动物，初始速度不同    
    _mainscenParam.landAnimalSpeed = [[CommonLayer sharedCommonLayer] getRoleParam:_roleType ParamType:ROLELANDSPEED];


}

-(void)endGame
{
    //1.调用一次消球接口 
    Storage *storage = [[TouchCatchLayer sharedTouchCatchLayer] getStorage];
    //[storage doMyCombineFood];
    //[storage combineBallNew];
    
    //2.调用算分接口
    CCArray * levelscore=[storage getScoreByLevel:(int)_sceneNum];
    //int score=[levelscore indexOfObject:0];
    //int addscore=[levelscore indexOfObject:0];


    
    id temp1 = [levelscore objectAtIndex:1];
    int addscore = [temp1 intValue];    
    
    id temp2 = [levelscore objectAtIndex:0];
    int score = [temp2 intValue];    

    id temp3 = [levelscore objectAtIndex:2];
    int starNum = [temp3 intValue];
    
    id temp4 = [levelscore objectAtIndex:3];
    int isnewrecord=[temp4 intValue];
    

    //3.生成关卡结束显示层
    ResultLayer *p=[ResultLayer createResultLayer:(int)_sceneNum Score:(int)score AddScore:(int)addscore StarNum:(int)starNum Newrecord:(int)isnewrecord];
    [self addChild:p z:1]; 
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
	ccColor4B c = {166,166,166,166};
    
    PauseLayer * p = [PauseLayer createPauseLayer:c Level:_sceneNum];
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


-(void)sleepForEndGame: (ccTime) dt
{
    [self unschedule:@selector(sleepForEndGame:)]; 
    [self endGame];
}

-(void)sleepForCombine: (ccTime) dt
{
    [self unschedule:@selector(sleepForCombine:)];
    //1.调用一次消球接口 
    Storage *storage = [[TouchCatchLayer sharedTouchCatchLayer] getStorage];
    //[storage doMyCombineFood];
    [storage combineBallNew];
    [self schedule:@selector(sleepForEndGame:) interval:5];
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
        [self schedule:@selector(sleepForCombine:) interval:2];
    }
}



-(void) dealloc
{
    instanceOfMainScene = nil; 
	
    [super dealloc];
}

@end
