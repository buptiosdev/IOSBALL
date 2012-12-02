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
#import "LevelScene.h"
#import "CommonLayer.h"

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


-(void)initRoleAndScore
{
    NSString *strName = [NSString stringWithFormat:@"RoleType"];
    roalType = [[NSUserDefaults standardUserDefaults]  integerForKey:strName];
    
    //角色
    CCSpriteFrameCache* frameCache = [CCSpriteFrameCache sharedSpriteFrameCache];
    [frameCache addSpriteFramesWithFile:@"gamemain01_default.plist"];
    // batch node for all dynamic elements
    batch = [CCSpriteBatchNode batchNodeWithFile:@"gamemain01_default.png" capacity:100];
    [self addChild:batch z:0 tag:1];
    NSString *strTotalScore = nil;
    NSString *strBuyedList = nil;
    CCSprite *roleSprite = nil;
    if (1 == roalType)
    {
        strTotalScore = [NSString stringWithFormat:@"Totalscore_Panda"];
        strBuyedList = [NSString stringWithFormat:@"Buyedlist_Panda"];
        roleSprite = [CCSprite spriteWithSpriteFrameName:@"pandaboy_3_1.png"];
        //按照像素设定图片大小
        roleSprite.scaleX=(70)/[roleSprite contentSize].width; //按照像素定制图片宽高
        roleSprite.scaleY=(70)/[roleSprite contentSize].height;
    }
    else if (2 == roalType)
    {
        strTotalScore = [NSString stringWithFormat:@"Totalscore_Pig"];
        strBuyedList = [NSString stringWithFormat:@"Buyedlist_Pig"];
        roleSprite = [CCSprite spriteWithSpriteFrameName:@"boypig_3_1.png"];
        //按照像素设定图片大小
        roleSprite.scaleX=(70)/[roleSprite contentSize].width; //按照像素定制图片宽高
        roleSprite.scaleY=(70)/[roleSprite contentSize].height;
    }
    else if (3 == roalType)
    {
        strTotalScore = [NSString stringWithFormat:@"Totalscore_Bird"];
        strBuyedList = [NSString stringWithFormat:@"Buyedlist_Bird"];
        roleSprite = [CCSprite spriteWithSpriteFrameName:@"boybird_3_1.png"];
        //按照像素设定图片大小
        roleSprite.scaleX=(50)/[roleSprite contentSize].width; //按照像素定制图片宽高
        roleSprite.scaleY=(50)/[roleSprite contentSize].height;
    }
    roleSprite.position = CGPointMake(20, screenSize.height - 100);
    [batch addChild:roleSprite z:-1 tag:2]; 
    int  totalRoleScore = [[NSUserDefaults standardUserDefaults] integerForKey:strTotalScore]; 
    _buyedList = [[NSUserDefaults standardUserDefaults] integerForKey:strBuyedList];
    //得分
    CCLabelBMFont*  getTotalScore = [CCLabelBMFont labelWithString:@"0" fntFile:@"bitmapNum.fnt"];
    [getTotalScore setString:[NSString stringWithFormat:@"%i", totalRoleScore]];
    getTotalScore.position = CGPointMake(30, screenSize.height - 150);
    getTotalScore.anchorPoint = CGPointMake(0.5f, 1.0f);
    getTotalScore.scale = 1.2;
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
    
//    BOOL isOver1 = NO;
//    BOOL isOver2 = NO;
//    BOOL isOver3 = NO;
//    BOOL isOver4 = NO;
    
    //个位代表陆地动物速度
    switch (_buyedList%10) 
    {
            
        case 0:
        {
            CCSprite *addSpeedOnce1 = [CCSprite spriteWithSpriteFrameName:@"magic-.png"];
            CCSprite *addSpeedOnce2 = [CCSprite spriteWithSpriteFrameName:@"magic-.png"];
            addLandSpeeMenu = [CCMenuItemSprite itemFromNormalSprite:addSpeedOnce1 
                                                  selectedSprite:addSpeedOnce2 
                                                          target:self 
                                                        selector:@selector(verifyAdd:)];
            [addLandSpeeMenu setTag:1];
            Labelnum1=[CCLabelTTF labelWithString:[NSString stringWithFormat:@"行走加速10％"] 
                                         fontName:@"Marker Felt" fontSize:15];
            LabelSpend1=[CCLabelTTF labelWithString:[NSString stringWithFormat:@"%d分",LANDSPEED1] 
                                           fontName:@"Marker Felt" fontSize:15];
            
            break;
        }
        case 1:
        {
            CCSprite *addSpeedOnce1 = [CCSprite spriteWithSpriteFrameName:@"magic+.png"];
            CCSprite *addSpeedOnce2 = [CCSprite spriteWithSpriteFrameName:@"magic+.png"];
            addLandSpeeMenu = [CCMenuItemSprite itemFromNormalSprite:addSpeedOnce1 
                                                  selectedSprite:addSpeedOnce2 
                                                          target:self 
                                                        selector:@selector(verifyAdd:)];
            [addLandSpeeMenu setTag:2];
            Labelnum1=[CCLabelTTF labelWithString:[NSString stringWithFormat:@"行走加速20％"] 
                                         fontName:@"Marker Felt" fontSize:15];
            LabelSpend1=[CCLabelTTF labelWithString:[NSString stringWithFormat:@"%d分",LANDSPEED2] 
                                           fontName:@"Marker Felt" fontSize:15];
            
            break;
        }
        case 2:
        {
            CCSprite *addSpeedOnce1 = [CCSprite spriteWithSpriteFrameName:@"magic-.png"];
            CCSprite *addSpeedOnce2 = [CCSprite spriteWithSpriteFrameName:@"magic-.png"];
            addLandSpeeMenu = [CCMenuItemSprite itemFromNormalSprite:addSpeedOnce1 
                                                  selectedSprite:addSpeedOnce2 
                                                          target:self 
                                                        selector:@selector(verifyAdd:)];
            [addLandSpeeMenu setTag:3];
            Labelnum1=[CCLabelTTF labelWithString:[NSString stringWithFormat:@"加速30％"] 
                                         fontName:@"Marker Felt" fontSize:15];
            LabelSpend1=[CCLabelTTF labelWithString:[NSString stringWithFormat:@"%d分",LANDSPEED3] 
                                           fontName:@"Marker Felt" fontSize:15];
            
            break;
        }
        default:
        {
            CCSprite *addSpeedOnce1 = [CCSprite spriteWithSpriteFrameName:@"bomb-.png"];
            CCSprite *addSpeedOnce2 = [CCSprite spriteWithSpriteFrameName:@"bomb-.png"];
            addLandSpeeMenu = [CCMenuItemSprite itemFromNormalSprite:addSpeedOnce1 
                                                      selectedSprite:addSpeedOnce2 
                                                              target:self 
                                                            selector:@selector(saleout:)];
  
            Labelnum1=[CCLabelTTF labelWithString:[NSString stringWithFormat:@"已售完"] 
                                         fontName:@"Marker Felt" fontSize:15];
            LabelSpend1=[CCLabelTTF labelWithString:[NSString stringWithFormat:@"最高级",LANDSPEED1] 
                                           fontName:@"Marker Felt" fontSize:15];
            
       
            break;    
        }
    }
    
    //十位代表仓库
    switch ((_buyedList/10)%10) {
        case 0:
        {
            CCSprite *addStorage1 = [CCSprite spriteWithSpriteFrameName:@"pepper-.png"];
            CCSprite *addStorage2 = [CCSprite spriteWithSpriteFrameName:@"pepper-.png"];
            addStorageMenu = [CCMenuItemSprite itemFromNormalSprite:addStorage1 
                                                            selectedSprite:addStorage2 
                                                                target:self 
                                                            selector:@selector(verifyAdd:)];
            [addStorageMenu setTag:4];
            Labelnum2=[CCLabelTTF labelWithString:[NSString stringWithFormat:@"仓库加1"] 
                                                     fontName:@"Marker Felt" fontSize:15];
            LabelSpend2=[CCLabelTTF labelWithString:[NSString stringWithFormat:@"%d分",STORAGE1] 
                                                       fontName:@"Marker Felt" fontSize:15];
                        break;
        } 
        case 1:
        {
            CCSprite *addStorage1 = [CCSprite spriteWithSpriteFrameName:@"pepper+.png"];
            CCSprite *addStorage2 = [CCSprite spriteWithSpriteFrameName:@"pepper+.png"];
            addStorageMenu = [CCMenuItemSprite itemFromNormalSprite:addStorage1 
                                                     selectedSprite:addStorage2 
                                                             target:self 
                                                           selector:@selector(verifyAdd:)];
            [addStorageMenu setTag:5];
            Labelnum2=[CCLabelTTF labelWithString:[NSString stringWithFormat:@"仓库加2"] 
                                         fontName:@"Marker Felt" fontSize:15];
            LabelSpend2=[CCLabelTTF labelWithString:[NSString stringWithFormat:@"%d分",STORAGE2] 
                                           fontName:@"Marker Felt" fontSize:15];
            break;
        } 
        case 2:
        {
            CCSprite *addStorage1 = [CCSprite spriteWithSpriteFrameName:@"pepper-.png"];
            CCSprite *addStorage2 = [CCSprite spriteWithSpriteFrameName:@"pepper-.png"];
            addStorageMenu = [CCMenuItemSprite itemFromNormalSprite:addStorage1 
                                                     selectedSprite:addStorage2 
                                                             target:self 
                                                           selector:@selector(verifyAdd:)];
            [addStorageMenu setTag:6];
            Labelnum2=[CCLabelTTF labelWithString:[NSString stringWithFormat:@"仓库加3"] 
                                         fontName:@"Marker Felt" fontSize:15];
            LabelSpend2=[CCLabelTTF labelWithString:[NSString stringWithFormat:@"%d分",STORAGE3] 
                                           fontName:@"Marker Felt" fontSize:15];
            break;
        } 
        default:
        {
            CCSprite *addSpeedOnce1 = [CCSprite spriteWithSpriteFrameName:@"bomb-.png"];
            CCSprite *addSpeedOnce2 = [CCSprite spriteWithSpriteFrameName:@"bomb-.png"];
            addStorageMenu = [CCMenuItemSprite itemFromNormalSprite:addSpeedOnce1 
                                                      selectedSprite:addSpeedOnce2 
                                                              target:self 
                                                            selector:@selector(saleout:)];

            Labelnum2=[CCLabelTTF labelWithString:[NSString stringWithFormat:@"已售完"] 
                                         fontName:@"Marker Felt" fontSize:15];
            LabelSpend2=[CCLabelTTF labelWithString:[NSString stringWithFormat:@"最高级",LANDSPEED1] 
                                           fontName:@"Marker Felt" fontSize:15];
            
            
            break;    
        }
    }
    
    //百位代表空中速度
    switch ((_buyedList/100)%10) {
        case 0:
        {
            CCSprite *addAirSpeed1 = [CCSprite spriteWithSpriteFrameName:@"ice-.png"];
            CCSprite *addAirSpeed2 = [CCSprite spriteWithSpriteFrameName:@"ice-.png"];
            addAirSpeedMenu = [CCMenuItemSprite itemFromNormalSprite:addAirSpeed1 
                                                     selectedSprite:addAirSpeed2
                                                             target:self 
                                                           selector:@selector(verifyAdd:)];
            [addAirSpeedMenu setTag:7];
            Labelnum3=[CCLabelTTF labelWithString:[NSString stringWithFormat:@"飞行速度加10％"] 
                                         fontName:@"Marker Felt" fontSize:15];
            LabelSpend3=[CCLabelTTF labelWithString:[NSString stringWithFormat:@"%d分",AIRSPEED1] 
                                           fontName:@"Marker Felt" fontSize:15];
            break;
        } 
        case 1:
        {
            CCSprite *addAirSpeed1 = [CCSprite spriteWithSpriteFrameName:@"ice+.png"];
            CCSprite *addAirSpeed2 = [CCSprite spriteWithSpriteFrameName:@"ice+.png"];
            addAirSpeedMenu = [CCMenuItemSprite itemFromNormalSprite:addAirSpeed1 
                                                      selectedSprite:addAirSpeed2
                                                              target:self 
                                                            selector:@selector(verifyAdd:)];
            [addAirSpeedMenu setTag:8];
            Labelnum3=[CCLabelTTF labelWithString:[NSString stringWithFormat:@"飞行速度加20％"] 
                                         fontName:@"Marker Felt" fontSize:15];
            LabelSpend3=[CCLabelTTF labelWithString:[NSString stringWithFormat:@"%d分",AIRSPEED2] 
                                           fontName:@"Marker Felt" fontSize:15];
            break;
        } 
        case 2:
        {
            CCSprite *addAirSpeed1 = [CCSprite spriteWithSpriteFrameName:@"ice-.png"];
            CCSprite *addAirSpeed2 = [CCSprite spriteWithSpriteFrameName:@"ice-.png"];
            addAirSpeedMenu = [CCMenuItemSprite itemFromNormalSprite:addAirSpeed1 
                                                      selectedSprite:addAirSpeed2
                                                              target:self 
                                                            selector:@selector(verifyAdd:)];
            [addAirSpeedMenu setTag:9];
            Labelnum3=[CCLabelTTF labelWithString:[NSString stringWithFormat:@"飞行速度加30％"] 
                                         fontName:@"Marker Felt" fontSize:15];
            LabelSpend3=[CCLabelTTF labelWithString:[NSString stringWithFormat:@"%d分",AIRSPEED3] 
                                           fontName:@"Marker Felt" fontSize:15];
            break;
        } 
        default:
        {
            CCSprite *addSpeedOnce1 = [CCSprite spriteWithSpriteFrameName:@"bomb-.png"];
            CCSprite *addSpeedOnce2 = [CCSprite spriteWithSpriteFrameName:@"bomb-.png"];
            addAirSpeedMenu = [CCMenuItemSprite itemFromNormalSprite:addSpeedOnce1 
                                                      selectedSprite:addSpeedOnce2 
                                                              target:self 
                                                            selector:@selector(saleout:)];

            Labelnum3=[CCLabelTTF labelWithString:[NSString stringWithFormat:@"已售完"] 
                                         fontName:@"Marker Felt" fontSize:15];
            LabelSpend3=[CCLabelTTF labelWithString:[NSString stringWithFormat:@"最高级",LANDSPEED1] 
                                           fontName:@"Marker Felt" fontSize:15];
            
            
            break;    
        }
    }
    
    //千位代表仓库种类
    switch ((_buyedList/1000)%10) {
        case 0:
        {
            CCSprite *addAirSpeed1 = [CCSprite spriteWithSpriteFrameName:@"garlic-.png"];
            CCSprite *addAirSpeed2 = [CCSprite spriteWithSpriteFrameName:@"garlic-.png"];
            addAirSencitMenu = [CCMenuItemSprite itemFromNormalSprite:addAirSpeed1 
                                                      selectedSprite:addAirSpeed2
                                                              target:self 
                                                            selector:@selector(verifyAdd:)];
            [addAirSencitMenu setTag:10];
            Labelnum4=[CCLabelTTF labelWithString:[NSString stringWithFormat:@"标准仓库"] 
                                         fontName:@"Marker Felt" fontSize:15];
            LabelSpend4=[CCLabelTTF labelWithString:[NSString stringWithFormat:@"%d分",STORAGETYPE1] 
                                           fontName:@"Marker Felt" fontSize:15];
            break;
        } 
        case 1:
        {
            CCSprite *addAirSpeed1 = [CCSprite spriteWithSpriteFrameName:@"garlic+.png"];
            CCSprite *addAirSpeed2 = [CCSprite spriteWithSpriteFrameName:@"garlic+.png"];
            addAirSencitMenu = [CCMenuItemSprite itemFromNormalSprite:addAirSpeed1 
                                                      selectedSprite:addAirSpeed2
                                                              target:self 
                                                            selector:@selector(verifyAdd:)];
            [addAirSencitMenu setTag:11];
            Labelnum4=[CCLabelTTF labelWithString:[NSString stringWithFormat:@"困难仓库"] 
                                         fontName:@"Marker Felt" fontSize:15];
            LabelSpend4=[CCLabelTTF labelWithString:[NSString stringWithFormat:@"%d分",STORAGETYPE2] 
                                           fontName:@"Marker Felt" fontSize:15];
            break;
        } 
        default:
        {
            CCSprite *addSpeedOnce1 = [CCSprite spriteWithSpriteFrameName:@"bomb-.png"];
            CCSprite *addSpeedOnce2 = [CCSprite spriteWithSpriteFrameName:@"bomb-.png"];
            addAirSencitMenu = [CCMenuItemSprite itemFromNormalSprite:addSpeedOnce1 
                                                      selectedSprite:addSpeedOnce2 
                                                              target:self 
                                                            selector:@selector(saleout:)];

            Labelnum4=[CCLabelTTF labelWithString:[NSString stringWithFormat:@"升级完成"] 
                                         fontName:@"Marker Felt" fontSize:15];
            LabelSpend4=[CCLabelTTF labelWithString:[NSString stringWithFormat:@"最高级",LANDSPEED1] 
                                           fontName:@"Marker Felt" fontSize:15];
            
            
            break;    
        }
    }

    

    [Labelnum1 setColor:ccRED];
    [LabelSpend1 setColor:ccRED];
    [addLandSpeeMenu addChild:Labelnum1];
    [addLandSpeeMenu addChild:LabelSpend1];
    LabelSpend1.anchorPoint=CGPointMake(0, 2);
    Labelnum1.anchorPoint=CGPointMake(0, 1);



    [Labelnum2 setColor:ccRED];
    [LabelSpend2 setColor:ccRED];
    [addStorageMenu addChild:LabelSpend2];
    [addStorageMenu addChild:Labelnum2];
    LabelSpend2.anchorPoint=CGPointMake(0, 2);
    Labelnum2.anchorPoint=CGPointMake(0, 1);



    [Labelnum3 setColor:ccRED];
    [LabelSpend3 setColor:ccRED];
    [addAirSpeedMenu addChild:LabelSpend3];
    [addAirSpeedMenu addChild:Labelnum3];
    LabelSpend3.anchorPoint=CGPointMake(0, 2);
    Labelnum3.anchorPoint=CGPointMake(0, 1);



    [Labelnum4 setColor:ccRED];
    [LabelSpend4 setColor:ccRED];
    [addAirSencitMenu addChild:LabelSpend4];
    [addAirSencitMenu addChild:Labelnum4];
    LabelSpend4.anchorPoint=CGPointMake(0, 2);
    Labelnum4.anchorPoint=CGPointMake(0, 1);

    
    
    CCMenu *menu = [CCMenu menuWithItems: addLandSpeeMenu, addStorageMenu, addAirSpeedMenu, addAirSencitMenu, nil];
    [menu setPosition:ccp(screenSize.width * 0.5 , screenSize.height * 0.5)];
    [menu alignItemsHorizontallyWithPadding:10];
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
        
//        CCLabelTTF *returnLabel=[CCLabelTTF labelWithString:@"GO Back" fontName:@"Marker Felt" fontSize:25];
//        [returnLabel setColor:ccRED];
//        CCMenuItemLabel * returnBtn = [CCMenuItemLabel itemWithLabel:returnLabel target:self selector:@selector(goBack:)];
//        [returnBtn setPosition:ccp((screenSize.width)/2,(screenSize.height)/4)];
//        CCMenu * menu = [CCMenu menuWithItems:returnBtn,nil];
//		[self addChild:menu];
//		[menu setPosition:ccp(0,0)];
        
        CCSprite *returnBtn = [CCSprite spriteWithSpriteFrameName:@"return.png"];
        CCSprite *returnBtn1 = [CCSprite spriteWithSpriteFrameName:@"return.png"];
        returnBtn1.scale=1.1;
        CCMenuItemSprite *returnItem = [CCMenuItemSprite itemFromNormalSprite:returnBtn 
                                                               selectedSprite:returnBtn1 
                                                                       target:self 
                                                                     selector:@selector(returnMain)];
        returnItem.scale=(45)/[returnBtn contentSize].width; //按照像素定制图片宽高
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





//-(void)verifyAddSpeedOnce:(id)sender
//{
//    [CommonLayer playAudio:SelectOK];
//    TouchSwallowLayer *myTouchSwallowLayer = [TouchSwallowLayer createTouchSwallowLayer:1 RoleType:roalType];
//    [self addChild:myTouchSwallowLayer];
//}
//-(void)verifyAddSpeedTwice:(id)sender
//{
//    [CommonLayer playAudio:SelectOK];
//    TouchSwallowLayer *myTouchSwallowLayer = [TouchSwallowLayer createTouchSwallowLayer:2 RoleType:roalType];
//    [self addChild:myTouchSwallowLayer];
//}
//-(void)verifyAddSpeedThird:(id)sender
//{
//    [CommonLayer playAudio:SelectOK];
//    TouchSwallowLayer *myTouchSwallowLayer = [TouchSwallowLayer createTouchSwallowLayer:3 RoleType:roalType];
//    [self addChild:myTouchSwallowLayer];
//}
//-(void)verifyAddStorageOnce:(id)sender
//{
//    [CommonLayer playAudio:SelectOK];
//    TouchSwallowLayer *myTouchSwallowLayer = [TouchSwallowLayer createTouchSwallowLayer:4 RoleType:roalType];
//    [self addChild:myTouchSwallowLayer];
//}
//-(void)verifyAddStorageTwice:(id)sender
//{
//    [CommonLayer playAudio:SelectOK];
//    TouchSwallowLayer *myTouchSwallowLayer = [TouchSwallowLayer createTouchSwallowLayer:5 RoleType:roalType];
//    [self addChild:myTouchSwallowLayer];
//}
//
//-(void)verifyAddStorageThird:(id)sender
//{
//    [CommonLayer playAudio:SelectOK];
//    TouchSwallowLayer *myTouchSwallowLayer = [TouchSwallowLayer createTouchSwallowLayer:6 RoleType:roalType];
//    [self addChild:myTouchSwallowLayer];
//}

-(void)returnMain
{
    //[[CCDirector sharedDirector] replaceScene:[NavigationScene scene]];
    [[CCDirector sharedDirector] replaceScene:[LevelScene scene]];  
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