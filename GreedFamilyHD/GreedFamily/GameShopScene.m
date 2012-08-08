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

@implementation GameShopScene

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
    NSString *strTotalScore = nil;
    if (1 == roalType) 
    {
        strTotalScore = [NSString stringWithFormat:@"Totalscore_Bird"];
    }
    else 
    {
        strTotalScore = [NSString stringWithFormat:@"Totalscore_Pig"];
    }
    int  totalRoleScore = [[NSUserDefaults standardUserDefaults] integerForKey:strTotalScore]; 
    
    
    //[[NSUserDefaults standardUserDefaults] setInteger:totalRoleScore forKey:strTotalScore]; 

    //角色
    CCSpriteFrameCache* frameCache = [CCSpriteFrameCache sharedSpriteFrameCache];
    [frameCache addSpriteFramesWithFile:@"elements_default.plist"];
    // batch node for all dynamic elements
    batch = [CCSpriteBatchNode batchNodeWithFile:@"elements_default.png" capacity:100];
    [self addChild:batch z:0 tag:1];
    
    CCSprite *roleSprite = nil;
    if (1 == roalType)
    {
        roleSprite = [CCSprite spriteWithSpriteFrameName:@"boybird_3_1.png"];
        //按照像素设定图片大小
        //change size by diff version manual
        roleSprite.scaleX=(50)/[roleSprite contentSize].width; //按照像素定制图片宽高
        roleSprite.scaleY=(50)/[roleSprite contentSize].height;
    }
    else if (2 == roalType)
    {
        roleSprite = [CCSprite spriteWithSpriteFrameName:@"boypig_3_1.png"];
        //按照像素设定图片大小
        //change size by diff version manual
        roleSprite.scaleX=(70)/[roleSprite contentSize].width; //按照像素定制图片宽高
        roleSprite.scaleY=(70)/[roleSprite contentSize].height;
    }
    roleSprite.position = CGPointMake(20, screenSize.height - 100);
    [batch addChild:roleSprite z:-1 tag:2]; 
    
    //得分
    CCLabelBMFont*  getTotalScore = [CCLabelBMFont labelWithString:@"x0" fntFile:@"bitmapfont.fnt"];
    [getTotalScore setString:[NSString stringWithFormat:@"x%i", totalRoleScore]];
    getTotalScore.position = CGPointMake(20, screenSize.height - 200);
    getTotalScore.anchorPoint = CGPointMake(0.5f, 1.0f);
    getTotalScore.scale = 0.4;
    [self addChild:getTotalScore z:-2 tag:3];
    
}

-(void)initShopList
{
    
    CCSprite *addSpeedOnce1 = [CCSprite spriteWithSpriteFrameName:@"crystallball.png"];
    CCSprite *addSpeedOnce2 = [CCSprite spriteWithSpriteFrameName:@"crystallball.png"];
    CCMenuItemSprite *addSpeedOnceMenu = [CCMenuItemSprite itemFromNormalSprite:addSpeedOnce1 
                                                       selectedSprite:addSpeedOnce2 
                                                               target:self 
                                                             selector:@selector(verifyAddSpeedOnce:)];
    CCLabelTTF *Labelnum1=[CCLabelTTF labelWithString:[NSString stringWithFormat:@"加速10％"] 
                                            fontName:@"Marker Felt" fontSize:10];
    CCLabelTTF *LabelSpend1=[CCLabelTTF labelWithString:[NSString stringWithFormat:@"%d分",SPEED1] 
                                             fontName:@"Marker Felt" fontSize:10];
    [addSpeedOnceMenu addChild:Labelnum1];
    [addSpeedOnceMenu addChild:LabelSpend1];
    LabelSpend1.anchorPoint=CGPointMake(0, 2);
    Labelnum1.anchorPoint=CGPointMake(0, 1);
    
    CCSprite *addSpeedTwice1 = [CCSprite spriteWithSpriteFrameName:@"blackbomb.png"];
    CCSprite *addSpeedTwice2 = [CCSprite spriteWithSpriteFrameName:@"blackbomb.png"];    
    CCMenuItemSprite *addSpeedTwiceMenu = [CCMenuItemSprite itemFromNormalSprite:addSpeedTwice1 
                                                         selectedSprite:addSpeedTwice2 
                                                                 target:self 
                                                               selector:@selector(verifyAddSpeedTwice:)];
    CCLabelTTF *Labelnum2=[CCLabelTTF labelWithString:[NSString stringWithFormat:@"加速20％"] 
                                             fontName:@"Marker Felt" fontSize:10];
    CCLabelTTF *LabelSpend2=[CCLabelTTF labelWithString:[NSString stringWithFormat:@"%d分",SPEED2] 
                                               fontName:@"Marker Felt" fontSize:10];
    [addSpeedTwiceMenu addChild:LabelSpend2];
    [addSpeedTwiceMenu addChild:Labelnum2];
    LabelSpend2.anchorPoint=CGPointMake(0, 2);
    Labelnum2.anchorPoint=CGPointMake(0, 1);
    
    CCSprite *addSpeedThird1 = [CCSprite spriteWithSpriteFrameName:@"ice+.png"];
    CCSprite *addSpeedThird2 = [CCSprite spriteWithSpriteFrameName:@"ice+.png"];
    CCMenuItemSprite *addSpeedThirdMenu = [CCMenuItemSprite itemFromNormalSprite:addSpeedThird1 
                                                         selectedSprite:addSpeedThird2 
                                                                 target:self 
                                                               selector:@selector(verifyAddSpeedThird:)];
    CCLabelTTF *Labelnum3=[CCLabelTTF labelWithString:[NSString stringWithFormat:@"加速30％"] 
                                             fontName:@"Marker Felt" fontSize:10];
    CCLabelTTF *LabelSpend3=[CCLabelTTF labelWithString:[NSString stringWithFormat:@"%d分",SPEED3] 
                                               fontName:@"Marker Felt" fontSize:10];
    [addSpeedThirdMenu addChild:LabelSpend3];
    [addSpeedThirdMenu addChild:Labelnum3];
    LabelSpend3.anchorPoint=CGPointMake(0, 2);
    Labelnum3.anchorPoint=CGPointMake(0, 1);
    
    CCSprite *addStorageOnce1 = [CCSprite spriteWithSpriteFrameName:@"pepper+.png"];
    CCSprite *addStorageOnce2 = [CCSprite spriteWithSpriteFrameName:@"pepper+.png"];
    CCMenuItemSprite *addStorageOnceMenu = [CCMenuItemSprite itemFromNormalSprite:addStorageOnce1 
                                                                  selectedSprite:addStorageOnce2 
                                                                          target:self 
                                                                        selector:@selector(verifyAddStorageOnce:)];
    CCLabelTTF *Labelnum4=[CCLabelTTF labelWithString:[NSString stringWithFormat:@"仓库加1"] 
                                             fontName:@"Marker Felt" fontSize:10];
    CCLabelTTF *LabelSpend4=[CCLabelTTF labelWithString:[NSString stringWithFormat:@"%d",STORAGE1] 
                                               fontName:@"Marker Felt" fontSize:10];
    [addStorageOnceMenu addChild:LabelSpend4];
    [addStorageOnceMenu addChild:Labelnum4];
    LabelSpend4.anchorPoint=CGPointMake(0, 2);
    Labelnum4.anchorPoint=CGPointMake(0, 1);
    
    
    CCSprite *addStorageTwice1 = [CCSprite spriteWithSpriteFrameName:@"pepper-.png"];
    CCSprite *addStorageTwice2 = [CCSprite spriteWithSpriteFrameName:@"pepper-.png"];
    CCMenuItemSprite *addStorageTwiceMenu = [CCMenuItemSprite itemFromNormalSprite:addStorageTwice1 
                                                                   selectedSprite:addStorageTwice2 
                                                                           target:self 
                                                                         selector:@selector(verifyAddStorageTwice:)];
    CCLabelTTF *Labelnum5=[CCLabelTTF labelWithString:[NSString stringWithFormat:@"仓库加2"] 
                                             fontName:@"Marker Felt" fontSize:10];
    CCLabelTTF *LabelSpend5=[CCLabelTTF labelWithString:[NSString stringWithFormat:@"%d",STORAGE2] 
                                               fontName:@"Marker Felt" fontSize:10]; 
    [addStorageTwiceMenu addChild:LabelSpend5];
    [addStorageTwiceMenu addChild:Labelnum5];
    LabelSpend5.anchorPoint=CGPointMake(0, 2);
    Labelnum5.anchorPoint=CGPointMake(0, 1);
    
    
    //CCMenu *menu = [CCMenu menuWithItems:starts, bombs, fruits, crystals, nil];
    CCMenu *menu = [CCMenu menuWithItems:addSpeedOnceMenu, addSpeedTwiceMenu, addSpeedThirdMenu, addStorageOnceMenu,                addStorageTwiceMenu, nil];
    [menu setPosition:ccp(screenSize.width * 0.6 , screenSize.height * 0.5)];
    [menu alignItemsHorizontallyWithPadding:30];
    [self addChild:menu z: -2 tag:4];
}

- (id) init {
    if ((self = [super init])) 
    {
		self.isTouchEnabled = YES;
        
        screenSize = [[CCDirector sharedDirector] winSize];
        
        CCLabelTTF *returnLabel=[CCLabelTTF labelWithString:@"GO Back" fontName:@"Marker Felt" fontSize:25];
        [returnLabel setColor:ccRED];
        CCMenuItemLabel * returnBtn = [CCMenuItemLabel itemWithLabel:returnLabel target:self selector:@selector(goBack:)];
        [returnBtn setPosition:ccp((screenSize.width)/2,(screenSize.height)/4)];
        CCMenu * menu = [CCMenu menuWithItems:returnBtn,nil];
		[self addChild:menu];
		[menu setPosition:ccp(0,0)];
        
        [self initRoleAndScore];
        [self initShopList];
        
    }   
    
    return self;
}



-(void)verifyAddSpeedOnce:(id)sender
{
    TouchSwallowLayer *myTouchSwallowLayer = [TouchSwallowLayer createTouchSwallowLayer:1 RoleType:roalType];
    [self addChild:myTouchSwallowLayer];
}
-(void)verifyAddSpeedTwice:(id)sender
{
    TouchSwallowLayer *myTouchSwallowLayer = [TouchSwallowLayer createTouchSwallowLayer:2 RoleType:roalType];
    [self addChild:myTouchSwallowLayer];
}
-(void)verifyAddSpeedThird:(id)sender
{
    TouchSwallowLayer *myTouchSwallowLayer = [TouchSwallowLayer createTouchSwallowLayer:3 RoleType:roalType];
    [self addChild:myTouchSwallowLayer];
}
-(void)verifyAddStorageOnce:(id)sender
{
    TouchSwallowLayer *myTouchSwallowLayer = [TouchSwallowLayer createTouchSwallowLayer:4 RoleType:roalType];
    [self addChild:myTouchSwallowLayer];
}
-(void)verifyAddStorageTwice:(id)sender
{
    TouchSwallowLayer *myTouchSwallowLayer = [TouchSwallowLayer createTouchSwallowLayer:5 RoleType:roalType];
    [self addChild:myTouchSwallowLayer];
}

-(void)goBack:(id)sender
{
    [[CCDirector sharedDirector] replaceScene:[NavigationScene scene]];
}

-(void)updateScore
{
    NSString *strTotalScore = nil;
    if (1 == roalType) 
    {
        strTotalScore = [NSString stringWithFormat:@"Totalscore_Bird"];
    }
    else 
    {
        strTotalScore = [NSString stringWithFormat:@"Totalscore_Pig"];
    }
    int  totalRoleScore = [[NSUserDefaults standardUserDefaults] integerForKey:strTotalScore]; 
    
    CCNode* node = [self getChildByTag:3];
    CCLabelBMFont *getTotalScore = (CCLabelBMFont *)node;
    [getTotalScore setString:[NSString stringWithFormat:@"x%i", totalRoleScore]];
}

@end
