//
//  GameShopScene.m
//  GreedFamily
//
//  Created by 赵 苹果 on 12-7-31.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import "GameShopScene.h"
#import "NavigationScene.h"
#import "TouchSwallowLayer.h"
//#import "LevelScene.h"
#import "CommonLayer.h"
#import "SelectScene.h"

//BEGIN item scale  默认为相对于X的比例
float logoshoplabelscaleY=0.15;
float shoprolescale=0.20;
float shopitemscale=0.15;
//END

@implementation GameShopScene

@synthesize buyedList = _buyedList;

+(CCScene *) gameShopScene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	GameShopScene *layer = [GameShopScene createGameShopScene];
	
	// add layer as a child to scene
	[scene addChild: layer];
    
	return scene;
}

+(id)createGameShopScene
{
    return [[[GameShopScene alloc] init] autorelease];
}


-(void)checkAchievement:(int)roleType BuyList:(int)buyList
{
    NSString *landSpeedFast=nil;
    NSString *flySpeedFast=nil;
    NSString *storageLagest=nil;
    NSString *storageSenior=nil;
    
    if (1 == roalType)
    {
        landSpeedFast = [NSString stringWithFormat:@"PandaLandSpeedFast"];
        flySpeedFast = [NSString stringWithFormat:@"PandaFlySpeedFast"];
        storageLagest = [NSString stringWithFormat:@"PandaStorageLagest"];
        storageSenior = [NSString stringWithFormat:@"PandaStorageSenior"];
    }
    else if (2 == roalType)
    {
        landSpeedFast = [NSString stringWithFormat:@"PigLandSpeedFast"];
        flySpeedFast = [NSString stringWithFormat:@"PigFlySpeedFast"];
        storageLagest = [NSString stringWithFormat:@"PigStorageLagest"];
        storageSenior = [NSString stringWithFormat:@"PigStorageSenior"];
    }
    else if (3 == roalType)
    {
        landSpeedFast = [NSString stringWithFormat:@"BirdLandSpeedFast"];
        flySpeedFast = [NSString stringWithFormat:@"BirdFlySpeedFast"];
        storageLagest = [NSString stringWithFormat:@"BirdStorageLagest"];
        storageSenior = [NSString stringWithFormat:@"BirdStorageSenior"];
    }
    
    
    //个位代表陆地动物速度
    if (_buyedList%10 > 2) 
    {
        GameKitHelper* gkHelper = [GameKitHelper sharedGameKitHelper];
        GKAchievement* achievement = [gkHelper getAchievementByID:landSpeedFast];
        if (achievement.completed == NO)
        {
            float percent = achievement.percentComplete + 100;
            [gkHelper reportAchievementWithID:landSpeedFast percentComplete:percent];
        }
    }    
    //十位代表仓库
    if ((_buyedList/10)%10 > 2) 
    {
        GameKitHelper* gkHelper = [GameKitHelper sharedGameKitHelper];
        GKAchievement* achievement = [gkHelper getAchievementByID:storageLagest];
        if (achievement.completed == NO)
        {
            float percent = achievement.percentComplete + 100;
            [gkHelper reportAchievementWithID:storageLagest percentComplete:percent];
        }
    } 
    //百位代表空中速度
    if ((_buyedList/100)%10 > 2) 
    {
        GameKitHelper* gkHelper = [GameKitHelper sharedGameKitHelper];
        GKAchievement* achievement = [gkHelper getAchievementByID:flySpeedFast];
        if (achievement.completed == NO)
        {
            float percent = achievement.percentComplete + 100;
            [gkHelper reportAchievementWithID:flySpeedFast percentComplete:percent];
        }
    } 
    //千位代表仓库种类
    if ((_buyedList/1000)%10 > 1) 
    {
        GameKitHelper* gkHelper = [GameKitHelper sharedGameKitHelper];
        GKAchievement* achievement = [gkHelper getAchievementByID:storageSenior];
        if (achievement.completed == NO)
        {
            float percent = achievement.percentComplete + 100;
            [gkHelper reportAchievementWithID:storageSenior percentComplete:percent];
        }
    } 

}

-(void)initRoleAndScore
{
    NSString *strName = [NSString stringWithFormat:@"RoleType"];
    roalType = [[NSUserDefaults standardUserDefaults]  integerForKey:strName];
    CGSize size = [[CCDirector sharedDirector] winSize];
    //角色
    CCSpriteFrameCache* frameCache = [CCSpriteFrameCache sharedSpriteFrameCache];
    [frameCache addSpriteFramesWithFile:@"gamemain01_default.plist"];
    // batch node for all dynamic elements
    batch = [CCSpriteBatchNode batchNodeWithFile:@"gamemain01_default.png" capacity:100];
    [self addChild:batch z:0 tag:1];
    NSString *strTotalScore = nil;
    NSString *strBuyedList = nil;
    CCSprite *roleSprite = nil;
    float rolesizeX=(size.width)*shoprolescale;
    if (1 == roalType)
    {
        strTotalScore = [NSString stringWithFormat:@"Totalscore_Panda"];
        strBuyedList = [NSString stringWithFormat:@"Buyedlist_Panda"];
        roleSprite = [CCSprite spriteWithSpriteFrameName:@"pandaboy_3_1.png"];
        //按照像素设定图片大小
        roleSprite.scale=rolesizeX/[roleSprite contentSize].width; //按照像素定制图片宽高
    }
    else if (2 == roalType)
    {
        strTotalScore = [NSString stringWithFormat:@"Totalscore_Pig"];
        strBuyedList = [NSString stringWithFormat:@"Buyedlist_Pig"];
        roleSprite = [CCSprite spriteWithSpriteFrameName:@"boypig_3_1.png"];
        //按照像素设定图片大小
        roleSprite.scale=rolesizeX/[roleSprite contentSize].width; //按照像素定制图片宽高
    }
    else if (3 == roalType)
    {
        strTotalScore = [NSString stringWithFormat:@"Totalscore_Bird"];
        strBuyedList = [NSString stringWithFormat:@"Buyedlist_Bird"];
        roleSprite = [CCSprite spriteWithSpriteFrameName:@"boybird_3_1.png"];
        //按照像素设定图片大小
        roleSprite.scale=rolesizeX/[roleSprite contentSize].width; //按照像素定制图片宽高
    }
    roleSprite.position = CGPointMake(screenSize.width*0.4, screenSize.height * 3 /4);
    [batch addChild:roleSprite z:-1 tag:2]; 
    int  totalRoleScore = [[NSUserDefaults standardUserDefaults] integerForKey:strTotalScore]; 
    _buyedList = [[NSUserDefaults standardUserDefaults] integerForKey:strBuyedList];
    
    //成就
    [self checkAchievement:roalType BuyList:_buyedList];
    //得分
    CCLabelBMFont*  getTotalScore = [CCLabelBMFont labelWithString:@"0" fntFile:@"bitmapNum.fnt"];
    [getTotalScore setString:[NSString stringWithFormat:@"x  %i", totalRoleScore]];
    getTotalScore.position = CGPointMake(screenSize.width*0.6, screenSize.height * 3 /4);
    //getTotalScore.anchorPoint = CGPointMake(0.5f, 1.0f);
    //getTotalScore.scale = 1.2;
    [self addChild:getTotalScore z:-2 tag:3];
    
}

-(void)initShopList
{
    CCLabelTTF *Labelnum1;
    CCLabelTTF *LabelSpend1;
    CCMenuItemSprite *addLandSpeeMenu;
    CCLabelTTF *Labelnum2;
    CCLabelTTF *LabelSpend2;
    CCMenuItemSprite *addStorageMenu;
    CCLabelTTF *Labelnum3;
    CCLabelTTF *LabelSpend3;
    CCMenuItemSprite *addAirSpeedMenu;
    CCLabelTTF *Labelnum4;
    CCLabelTTF *LabelSpend4;
    CCMenuItemSprite *addAirSencitMenu;
    
    //个位代表陆地动物速度
    switch (_buyedList%10) 
    {
            
        case 0:
        {
            CCSprite *addSpeedOnce1 = [CCSprite spriteWithSpriteFrameName:@"landspeed1.png"];
            CCSprite *addSpeedOnce2 = [CCSprite spriteWithSpriteFrameName:@"landspeed1.png"];
            addSpeedOnce2.scale=1.1;
            addLandSpeeMenu = [CCMenuItemSprite itemFromNormalSprite:addSpeedOnce1 
                                                  selectedSprite:addSpeedOnce2 
                                                          target:self 
                                                        selector:@selector(verifyAdd:)];
            [addLandSpeeMenu setTag:1];
            Labelnum1=[CCLabelTTF labelWithString:[NSString stringWithFormat:@"陆地速度升级"] 
                                         fontName:@"Marker Felt" fontSize:30];
            LabelSpend1=[CCLabelTTF labelWithString:[NSString stringWithFormat:@"%d分",LANDSPEED1] 
                                           fontName:@"Marker Felt" fontSize:30];
            
            break;
        }
        case 1:
        {
            CCSprite *addSpeedOnce1 = [CCSprite spriteWithSpriteFrameName:@"landspeed2.png"];
            CCSprite *addSpeedOnce2 = [CCSprite spriteWithSpriteFrameName:@"landspeed2.png"];
            addSpeedOnce2.scale=1.1;
            addLandSpeeMenu = [CCMenuItemSprite itemFromNormalSprite:addSpeedOnce1 
                                                  selectedSprite:addSpeedOnce2 
                                                          target:self 
                                                        selector:@selector(verifyAdd:)];
            [addLandSpeeMenu setTag:2];
            Labelnum1=[CCLabelTTF labelWithString:[NSString stringWithFormat:@"陆地速度升级"] 
                                         fontName:@"Marker Felt" fontSize:30];
            LabelSpend1=[CCLabelTTF labelWithString:[NSString stringWithFormat:@"%d分",LANDSPEED2] 
                                           fontName:@"Marker Felt" fontSize:30];
            
            break;
        }
        case 2:
        {
            CCSprite *addSpeedOnce1 = [CCSprite spriteWithSpriteFrameName:@"landspeed3.png"];
            CCSprite *addSpeedOnce2 = [CCSprite spriteWithSpriteFrameName:@"landspeed3.png"];
            addSpeedOnce2.scale=1.1;
            addLandSpeeMenu = [CCMenuItemSprite itemFromNormalSprite:addSpeedOnce1 
                                                  selectedSprite:addSpeedOnce2 
                                                          target:self 
                                                        selector:@selector(verifyAdd:)];
            [addLandSpeeMenu setTag:3];
            Labelnum1=[CCLabelTTF labelWithString:[NSString stringWithFormat:@"陆地速度升级"] 
                                         fontName:@"Marker Felt" fontSize:30];
            LabelSpend1=[CCLabelTTF labelWithString:[NSString stringWithFormat:@"%d分",LANDSPEED3] 
                                           fontName:@"Marker Felt" fontSize:30];
            
            break;
        }
        default:
        {
            CCSprite *addSpeedOnce1 = [CCSprite spriteWithSpriteFrameName:@"landspeed4.png"];
            CCSprite *addSpeedOnce2 = [CCSprite spriteWithSpriteFrameName:@"landspeed4.png"];
            addSpeedOnce2.scale=1.1;
            addLandSpeeMenu = [CCMenuItemSprite itemFromNormalSprite:addSpeedOnce1 
                                                      selectedSprite:addSpeedOnce2 
                                                              target:self 
                                                            selector:@selector(saleout:)];
  
            Labelnum1=[CCLabelTTF labelWithString:[NSString stringWithFormat:@"已售完"] 
                                         fontName:@"Marker Felt" fontSize:30];
            LabelSpend1=[CCLabelTTF labelWithString:[NSString stringWithFormat:@"最高级",LANDSPEED1] 
                                           fontName:@"Marker Felt" fontSize:30];
            
       
            break;    
        }
    }
    
    //十位代表仓库
    switch ((_buyedList/10)%10) {
        case 0:
        {
            CCSprite *addStorage1 = [CCSprite spriteWithSpriteFrameName:@"storagenum1.png"];
            CCSprite *addStorage2 = [CCSprite spriteWithSpriteFrameName:@"storagenum1.png"];
            addStorage2.scale=1.1;
            addStorageMenu = [CCMenuItemSprite itemFromNormalSprite:addStorage1 
                                                            selectedSprite:addStorage2 
                                                                target:self 
                                                            selector:@selector(verifyAdd:)];
            [addStorageMenu setTag:4];
            Labelnum2=[CCLabelTTF labelWithString:[NSString stringWithFormat:@"仓库容量升级"] 
                                                     fontName:@"Marker Felt" fontSize:30];
            LabelSpend2=[CCLabelTTF labelWithString:[NSString stringWithFormat:@"%d分",STORAGE1] 
                                                       fontName:@"Marker Felt" fontSize:30];
                        break;
        } 
        case 1:
        {
            CCSprite *addStorage1 = [CCSprite spriteWithSpriteFrameName:@"storagenum2.png"];
            CCSprite *addStorage2 = [CCSprite spriteWithSpriteFrameName:@"storagenum2.png"];
            addStorage2.scale=1.1;
            addStorageMenu = [CCMenuItemSprite itemFromNormalSprite:addStorage1 
                                                     selectedSprite:addStorage2 
                                                             target:self 
                                                           selector:@selector(verifyAdd:)];
            [addStorageMenu setTag:5];
            Labelnum2=[CCLabelTTF labelWithString:[NSString stringWithFormat:@"仓库容量升级"] 
                                         fontName:@"Marker Felt" fontSize:30];
            LabelSpend2=[CCLabelTTF labelWithString:[NSString stringWithFormat:@"%d分",STORAGE2] 
                                           fontName:@"Marker Felt" fontSize:30];
            break;
        } 
        case 2:
        {
            CCSprite *addStorage1 = [CCSprite spriteWithSpriteFrameName:@"storagenum3.png"];
            CCSprite *addStorage2 = [CCSprite spriteWithSpriteFrameName:@"storagenum3.png"];
            addStorage2.scale=1.1;
            addStorageMenu = [CCMenuItemSprite itemFromNormalSprite:addStorage1 
                                                     selectedSprite:addStorage2 
                                                             target:self 
                                                           selector:@selector(verifyAdd:)];
            [addStorageMenu setTag:6];
            Labelnum2=[CCLabelTTF labelWithString:[NSString stringWithFormat:@"仓库容量升级"] 
                                         fontName:@"Marker Felt" fontSize:30];
            LabelSpend2=[CCLabelTTF labelWithString:[NSString stringWithFormat:@"%d分",STORAGE3] 
                                           fontName:@"Marker Felt" fontSize:30];
            break;
        } 
        default:
        {
            CCSprite *addStorage1 = [CCSprite spriteWithSpriteFrameName:@"storagenum4.png"];
            CCSprite *addStorage2 = [CCSprite spriteWithSpriteFrameName:@"storagenum4.png"];
            addStorage2.scale=1.1;
            addStorageMenu = [CCMenuItemSprite itemFromNormalSprite:addStorage1 
                                                      selectedSprite:addStorage2 
                                                              target:self 
                                                            selector:@selector(saleout:)];

            Labelnum2=[CCLabelTTF labelWithString:[NSString stringWithFormat:@"已售完"] 
                                         fontName:@"Marker Felt" fontSize:30];
            LabelSpend2=[CCLabelTTF labelWithString:[NSString stringWithFormat:@"最高级",LANDSPEED1] 
                                           fontName:@"Marker Felt" fontSize:30];
            
            
            break;    
        }
    }
    
    //百位代表空中速度
    switch ((_buyedList/100)%10) {
        case 0:
        {
            CCSprite *addAirSpeed1 = [CCSprite spriteWithSpriteFrameName:@"airspeed1.png"];
            CCSprite *addAirSpeed2 = [CCSprite spriteWithSpriteFrameName:@"airspeed1.png"];
            addAirSpeed2.scale=1.1;
            addAirSpeedMenu = [CCMenuItemSprite itemFromNormalSprite:addAirSpeed1 
                                                     selectedSprite:addAirSpeed2
                                                             target:self 
                                                           selector:@selector(verifyAdd:)];
            [addAirSpeedMenu setTag:7];
            Labelnum3=[CCLabelTTF labelWithString:[NSString stringWithFormat:@"飞行速度升级"] 
                                         fontName:@"Marker Felt" fontSize:30];
            LabelSpend3=[CCLabelTTF labelWithString:[NSString stringWithFormat:@"%d分",AIRSPEED1] 
                                           fontName:@"Marker Felt" fontSize:30];
            break;
        } 
        case 1:
        {
            CCSprite *addAirSpeed1 = [CCSprite spriteWithSpriteFrameName:@"airspeed2.png"];
            CCSprite *addAirSpeed2 = [CCSprite spriteWithSpriteFrameName:@"airspeed2.png"];
            addAirSpeed2.scale=1.1;
            addAirSpeedMenu = [CCMenuItemSprite itemFromNormalSprite:addAirSpeed1 
                                                      selectedSprite:addAirSpeed2
                                                              target:self 
                                                            selector:@selector(verifyAdd:)];
            [addAirSpeedMenu setTag:8];
            Labelnum3=[CCLabelTTF labelWithString:[NSString stringWithFormat:@"飞行速度升级"] 
                                         fontName:@"Marker Felt" fontSize:30];
            LabelSpend3=[CCLabelTTF labelWithString:[NSString stringWithFormat:@"%d分",AIRSPEED2] 
                                           fontName:@"Marker Felt" fontSize:30];
            break;
        } 
        case 2:
        {
            CCSprite *addAirSpeed1 = [CCSprite spriteWithSpriteFrameName:@"airspeed3.png"];
            CCSprite *addAirSpeed2 = [CCSprite spriteWithSpriteFrameName:@"airspeed3.png"];
            addAirSpeed2.scale=1.1;
            addAirSpeedMenu = [CCMenuItemSprite itemFromNormalSprite:addAirSpeed1 
                                                      selectedSprite:addAirSpeed2
                                                              target:self 
                                                            selector:@selector(verifyAdd:)];
            [addAirSpeedMenu setTag:9];
            Labelnum3=[CCLabelTTF labelWithString:[NSString stringWithFormat:@"飞行速度升级"] 
                                         fontName:@"Marker Felt" fontSize:30];
            LabelSpend3=[CCLabelTTF labelWithString:[NSString stringWithFormat:@"%d分",AIRSPEED3] 
                                           fontName:@"Marker Felt" fontSize:30];
            break;
        } 
        default:
        {
            CCSprite *addAirSpeed1 = [CCSprite spriteWithSpriteFrameName:@"airspeed4.png"];
            CCSprite *addAirSpeed2 = [CCSprite spriteWithSpriteFrameName:@"airspeed4.png"];
            addAirSpeed2.scale=1.1;
            addAirSpeedMenu = [CCMenuItemSprite itemFromNormalSprite:addAirSpeed1 
                                                      selectedSprite:addAirSpeed2 
                                                              target:self 
                                                            selector:@selector(saleout:)];

            Labelnum3=[CCLabelTTF labelWithString:[NSString stringWithFormat:@"已售完"] 
                                         fontName:@"Marker Felt" fontSize:30];
            LabelSpend3=[CCLabelTTF labelWithString:[NSString stringWithFormat:@"最高级",LANDSPEED1] 
                                           fontName:@"Marker Felt" fontSize:30];
            break;    
        }
    }
    
    //千位代表仓库种类
    switch ((_buyedList/1000)%10) {
        case 0:
        {
            CCSprite *addAirSpeed1 = [CCSprite spriteWithSpriteFrameName:@"storagetype1.png"];
            CCSprite *addAirSpeed2 = [CCSprite spriteWithSpriteFrameName:@"storagetype1.png"];
            addAirSpeed2.scale=1.1;
            addAirSencitMenu = [CCMenuItemSprite itemFromNormalSprite:addAirSpeed1 
                                                      selectedSprite:addAirSpeed2
                                                              target:self 
                                                            selector:@selector(verifyAdd:)];
            [addAirSencitMenu setTag:10];
            Labelnum4=[CCLabelTTF labelWithString:[NSString stringWithFormat:@"仓库功能升级"] 
                                         fontName:@"Marker Felt" fontSize:30];
            LabelSpend4=[CCLabelTTF labelWithString:[NSString stringWithFormat:@"%d分",STORAGETYPE1] 
                                           fontName:@"Marker Felt" fontSize:30];
            break;
        } 
        case 1:
        {
            CCSprite *addAirSpeed1 = [CCSprite spriteWithSpriteFrameName:@"storagetype2.png"];
            CCSprite *addAirSpeed2 = [CCSprite spriteWithSpriteFrameName:@"storagetype2.png"];
            addAirSpeed2.scale=1.1;
            addAirSencitMenu = [CCMenuItemSprite itemFromNormalSprite:addAirSpeed1 
                                                      selectedSprite:addAirSpeed2
                                                              target:self 
                                                            selector:@selector(verifyAdd:)];
            [addAirSencitMenu setTag:11];
            Labelnum4=[CCLabelTTF labelWithString:[NSString stringWithFormat:@"仓库功能升级"] 
                                         fontName:@"Marker Felt" fontSize:30];
            LabelSpend4=[CCLabelTTF labelWithString:[NSString stringWithFormat:@"%d分",STORAGETYPE2] 
                                           fontName:@"Marker Felt" fontSize:30];
            break;
        } 
        default:
        {
            CCSprite *addAirSpeed1 = [CCSprite spriteWithSpriteFrameName:@"storagetype3.png"];
            CCSprite *addAirSpeed2 = [CCSprite spriteWithSpriteFrameName:@"storagetype3.png"];
            addAirSpeed2.scale=1.1;
            addAirSencitMenu = [CCMenuItemSprite itemFromNormalSprite:addAirSpeed1 
                                                      selectedSprite:addAirSpeed2 
                                                              target:self 
                                                            selector:@selector(saleout:)];

            Labelnum4=[CCLabelTTF labelWithString:[NSString stringWithFormat:@"已售完"] 
                                         fontName:@"Marker Felt" fontSize:30];
            LabelSpend4=[CCLabelTTF labelWithString:[NSString stringWithFormat:@"最高级",LANDSPEED1] 
                                           fontName:@"Marker Felt" fontSize:30];
            
            
            break;    
        }
    }

    CGSize size = [[CCDirector sharedDirector] winSize];

    [Labelnum1 setColor:ccRED];
    [LabelSpend1 setColor:ccRED];
    [addLandSpeeMenu addChild:Labelnum1];
    [addLandSpeeMenu addChild:LabelSpend1];
    LabelSpend1.anchorPoint=CGPointMake(0, 2);
    Labelnum1.anchorPoint=CGPointMake(0, 1);
    addLandSpeeMenu.scale=size.width*shopitemscale/[addLandSpeeMenu contentSize].width;

    [Labelnum2 setColor:ccRED];
    [LabelSpend2 setColor:ccRED];
    [addStorageMenu addChild:LabelSpend2];
    [addStorageMenu addChild:Labelnum2];
    LabelSpend2.anchorPoint=CGPointMake(0, 2);
    Labelnum2.anchorPoint=CGPointMake(0, 1);
    addStorageMenu.scale=size.width*shopitemscale/[addStorageMenu contentSize].width;

    [Labelnum3 setColor:ccRED];
    [LabelSpend3 setColor:ccRED];
    [addAirSpeedMenu addChild:LabelSpend3];
    [addAirSpeedMenu addChild:Labelnum3];
    LabelSpend3.anchorPoint=CGPointMake(0, 2);
    Labelnum3.anchorPoint=CGPointMake(0, 1);
    addAirSpeedMenu.scale=size.width*shopitemscale/[addAirSpeedMenu contentSize].width;

    [Labelnum4 setColor:ccRED];
    [LabelSpend4 setColor:ccRED];
    [addAirSencitMenu addChild:LabelSpend4];
    [addAirSencitMenu addChild:Labelnum4];
    LabelSpend4.anchorPoint=CGPointMake(0, 2);
    Labelnum4.anchorPoint=CGPointMake(0, 1);
    addAirSencitMenu.scale=size.width*shopitemscale/[addAirSencitMenu contentSize].width;

    CCMenu *menu = [CCMenu menuWithItems: addLandSpeeMenu, addStorageMenu, addAirSpeedMenu, addAirSencitMenu, nil];
    [menu setPosition:ccp(size.width * 0.5 , size.height * 0.45)];
    [menu alignItemsHorizontallyWithPadding:size.width*shopitemscale/2];
    [self addChild:menu z: -2 tag:4];

}

- (id) init {
    if ((self = [super init])) 
    {
		self.isTouchEnabled = YES;
        
        screenSize = [[CCDirector sharedDirector] winSize];
        //set the background pic
		CCSprite * background = [CCSprite spriteWithFile:@"background_begin.jpg"];
        background.scaleX=(screenSize.width)/[background contentSize].width; //按照像素定制图片宽高是控制像素的。
        background.scaleY=(screenSize.height)/[background contentSize].height;
        NSAssert( background != nil, @"background must be non-nil");
		[background setPosition:ccp(screenSize.width / 2, screenSize.height/2)];
		[self addChild:background z:-3];
        CCSpriteFrameCache* frameCache = [CCSpriteFrameCache sharedSpriteFrameCache];
        [frameCache addSpriteFramesWithFile:@"levlescene_default_default.plist"];
        
        CCSprite *returnBtn = [CCSprite spriteWithSpriteFrameName:@"return.png"];
        CCSprite *returnBtn1 = [CCSprite spriteWithSpriteFrameName:@"return.png"];
        returnBtn1.scale=1.1;
        CCMenuItemSprite *returnItem = [CCMenuItemSprite itemFromNormalSprite:returnBtn 
                                                               selectedSprite:returnBtn1 
                                                                       target:self 
                                                                     selector:@selector(returnMain)];
        float optscale=(screenSize.height*logoshoplabelscaleY)/[returnBtn contentSize].height;
        returnItem.scale=optscale; //按照像素定制图片宽高
        CCMenu * returnmenu = [CCMenu menuWithItems:returnItem, nil];
        [returnmenu setPosition:ccp([returnBtn contentSize].width * returnItem.scale * 0.5,
                                    [returnBtn contentSize].height * returnItem.scale * 0.5)];
        
        [self addChild:returnmenu];
        [self initRoleAndScore];
        [self initShopList];
    }   
    return self;
}


-(void)saleout:(CCMenuItemSprite *)sender
{
    /*none*/
    [CommonLayer playAudio:SelectNo];
}
-(void)verifyAdd:(CCMenuItemSprite *)sender
{
    int count = sender.tag;
    [CommonLayer playAudio:SelectOK];
    TouchSwallowLayer *myTouchSwallowLayer = [TouchSwallowLayer createTouchSwallowLayer:count RoleType:roalType];
    [self addChild:myTouchSwallowLayer];
}


-(void)returnMain
{
//    [[CCDirector sharedDirector] replaceScene:[LevelScene scene]];  
    [[CCDirector sharedDirector] replaceScene:[SelectScene scene]];
}

-(void)updateScore
{
    NSString *strTotalScore = nil;
    NSString *strBuyedList = nil;
    if (1 == roalType) 
    {
        strBuyedList = [NSString stringWithFormat:@"Buyedlist_Panda"];
        strTotalScore = [NSString stringWithFormat:@"Totalscore_Panda"];
    }
    else if (2 == roalType) 
    {
        strBuyedList = [NSString stringWithFormat:@"Buyedlist_Pig"];
        strTotalScore = [NSString stringWithFormat:@"Totalscore_Pig"];
    }
    else 
    {
        strBuyedList = [NSString stringWithFormat:@"Buyedlist_Bird"];
        strTotalScore = [NSString stringWithFormat:@"Totalscore_Bird"];
    }
    int  totalRoleScore = [[NSUserDefaults standardUserDefaults] integerForKey:strTotalScore]; 
    
     [[NSUserDefaults standardUserDefaults] setInteger:_buyedList forKey:strBuyedList];
    
    CCNode* node = [self getChildByTag:3];
    CCLabelBMFont *getTotalScore = (CCLabelBMFont *)node;
    [getTotalScore setString:[NSString stringWithFormat:@"x%i", totalRoleScore]];
}

@end
