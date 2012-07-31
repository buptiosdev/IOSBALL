//
//  GameShopScene.m
//  GreedFamily
//
//  Created by 赵 苹果 on 12-7-31.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import "GameShopScene.h"
#import "NavigationScene.h"

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
    int roalType = [[NSUserDefaults standardUserDefaults]  integerForKey:@"RoleType"];
    NSString *strTotalScore = nil;
    if (1 == roalType) 
    {
        strTotalScore = [NSString stringWithFormat:@"%d",@"Totalscore_Bird"];
    }
    else 
    {
        strTotalScore = [NSString stringWithFormat:@"%d",@"Totalscore_Pig"];
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
        roleSprite.scaleX=(50)/[roleSprite contentSize].width; //按照像素定制图片宽高
        roleSprite.scaleY=(50)/[roleSprite contentSize].height;
    }
    else if (2 == roalType)
    {
        roleSprite = [CCSprite spriteWithSpriteFrameName:@"boypig_3_1.png"];
        //按照像素设定图片大小
        roleSprite.scaleX=(70)/[roleSprite contentSize].width; //按照像素定制图片宽高
        roleSprite.scaleY=(70)/[roleSprite contentSize].height;
    }
    roleSprite.position = CGPointMake(20, screenSize.height - 100);
    [batch addChild:roleSprite z:-1 tag:2]; 
    
    //得分
    CCLabelBMFont*  getTotalScore = [CCLabelBMFont bitmapFontAtlasWithString:@"x0" fntFile:@"bitmapfont.fnt"];
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
    CCLabelTTF *Labelnum1=[CCLabelTTF labelWithString:[NSString stringWithFormat:@"加速10％\n100Points"] 
                                            fontName:@"Marker Felt" fontSize:10];
    [addSpeedOnceMenu addChild:Labelnum1];
    
    
    CCSprite *addSpeedTwice1 = [CCSprite spriteWithSpriteFrameName:@"blackbomb.png"];
    CCSprite *addSpeedTwice2 = [CCSprite spriteWithSpriteFrameName:@"blackbomb.png"];    
    CCMenuItemSprite *addSpeedTwiceMenu = [CCMenuItemSprite itemFromNormalSprite:addSpeedTwice1 
                                                         selectedSprite:addSpeedTwice2 
                                                                 target:self 
                                                               selector:@selector(verifyAddSpeedTwice:)];
    CCLabelTTF *Labelnum2=[CCLabelTTF labelWithString:[NSString stringWithFormat:@"加速20％\n500Points"] 
                                             fontName:@"Marker Felt" fontSize:10];
    [addSpeedTwiceMenu addChild:Labelnum2];
    
    CCSprite *addSpeedThird1 = [CCSprite spriteWithSpriteFrameName:@"ice+.png"];
    CCSprite *addSpeedThird2 = [CCSprite spriteWithSpriteFrameName:@"ice+.png"];
    CCMenuItemSprite *addSpeedThirdMenu = [CCMenuItemSprite itemFromNormalSprite:addSpeedThird1 
                                                         selectedSprite:addSpeedThird2 
                                                                 target:self 
                                                               selector:@selector(verifyAddSpeedThird:)];
    CCLabelTTF *Labelnum3=[CCLabelTTF labelWithString:[NSString stringWithFormat:@"加速30％\n1000Points"] 
                                             fontName:@"Marker Felt" fontSize:10];
    [addSpeedThirdMenu addChild:Labelnum3];
    
    CCSprite *addStorageOnce1 = [CCSprite spriteWithSpriteFrameName:@"pepper+.png"];
    CCSprite *addStorageOnce2 = [CCSprite spriteWithSpriteFrameName:@"pepper+.png"];
    CCMenuItemSprite *addStorageOnceMenu = [CCMenuItemSprite itemFromNormalSprite:addStorageOnce1 
                                                                  selectedSprite:addStorageOnce2 
                                                                          target:self 
                                                                        selector:@selector(verifyAddStorageOnce:)];
    CCLabelTTF *Labelnum4=[CCLabelTTF labelWithString:[NSString stringWithFormat:@"仓库加1\n300Points"] 
                                             fontName:@"Marker Felt" fontSize:10];
    [addStorageOnceMenu addChild:Labelnum4];
    
    
    //CCMenu *menu = [CCMenu menuWithItems:starts, bombs, fruits, crystals, nil];
    CCMenu *menu = [CCMenu menuWithItems:addSpeedOnceMenu, addSpeedTwiceMenu, addSpeedThirdMenu, addStorageOnceMenu, nil];
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

-(void)noOption:(id)sender
{
    [self removeChildByTag:100 cleanup:YES];
}

-(void)yesAddSpeedOnce:(id)sender
{
    [self removeChildByTag:100 cleanup:YES];
}
-(void)yesAddSpeedTwice:(id)sender
{
    [self removeChildByTag:100 cleanup:YES];
}

-(void)yesAddSpeedThird:(id)sender
{
    [self removeChildByTag:100 cleanup:YES];
}

-(void)yesAddStorageOnce:(id)sender
{
    [self removeChildByTag:100 cleanup:YES];
}

-(void)verifyAddSpeedOnce:(id)sender
{
    CCLabelTTF *yesLable =[CCLabelTTF labelWithString:@"Yes" fontName:@"Marker Felt" fontSize:30];
    CCLabelTTF *noLable =[CCLabelTTF labelWithString:@"No" fontName:@"Marker Felt" fontSize:30];
    CCMenuItemLabel * yesMenu = [CCMenuItemLabel itemWithLabel:yesLable target:self selector:@selector(yesAddSpeedOnce:)];
    CCMenuItemLabel * noMenu = [CCMenuItemLabel itemWithLabel:noLable target:self selector:@selector(noOption:)];
    
    CCMenu * menu = [CCMenu menuWithItems:yesMenu,noMenu,nil];
    [menu alignItemsVerticallyWithPadding:10];

    [menu setPosition:ccp(screenSize.width/2,screenSize.height/2)];
    [menu alignItemsHorizontallyWithPadding:50];
    [self addChild:menu z:1 tag:100];
}
-(void)verifyAddSpeedTwice:(id)sender
{
    CCLabelTTF *yesLable =[CCLabelTTF labelWithString:@"Yes" fontName:@"Marker Felt" fontSize:30];
    CCLabelTTF *noLable =[CCLabelTTF labelWithString:@"No" fontName:@"Marker Felt" fontSize:30];
    CCMenuItemLabel * yesMenu = [CCMenuItemLabel itemWithLabel:yesLable target:self selector:@selector(yesAddSpeedTwice:)];
    CCMenuItemLabel * noMenu = [CCMenuItemLabel itemWithLabel:noLable target:self selector:@selector(noOption:)];
    
    CCMenu * menu = [CCMenu menuWithItems:yesMenu,noMenu,nil];
    [menu alignItemsHorizontallyWithPadding:50];

    [menu setPosition:ccp(screenSize.width/2,screenSize.height/2)];
    //[menu alignItemsHorizontally];
    [self addChild:menu z:1 tag:100];
}
-(void)verifyAddSpeedThird:(id)sender
{
    CCLayer *touchLayer = [[[CCLayer alloc] init] autorelease];
    CCLabelTTF *yesLable =[CCLabelTTF labelWithString:@"Yes" fontName:@"Marker Felt" fontSize:30];
    CCLabelTTF *noLable =[CCLabelTTF labelWithString:@"No" fontName:@"Marker Felt" fontSize:30];
    CCMenuItemLabel * yesMenu = [CCMenuItemLabel itemWithLabel:yesLable target:self selector:@selector(yesAddSpeedThird:)];
    CCMenuItemLabel * noMenu = [CCMenuItemLabel itemWithLabel:noLable target:self selector:@selector(noOption:)];
    
    CCMenu * menu = [CCMenu menuWithItems:yesMenu,noMenu,nil];
    [menu alignItemsVerticallyWithPadding:10];

    [menu setPosition:ccp(screenSize.width/2,screenSize.height/2)];
    [menu alignItemsHorizontallyWithPadding:50];
    
    
    [[CCTouchDispatcher sharedDispatcher] addTargetedDelegate:touchLayer priority:100 swallowsTouches:NO];
    
    [touchLayer addChild:menu];
    
    [self addChild:touchLayer z:1 tag:100];
}
-(void)verifyAddStorageOnce:(id)sender
{
    CCLabelTTF *yesLable =[CCLabelTTF labelWithString:@"Yes" fontName:@"Marker Felt" fontSize:30];
    CCLabelTTF *noLable =[CCLabelTTF labelWithString:@"No" fontName:@"Marker Felt" fontSize:30];
    CCMenuItemLabel * yesMenu = [CCMenuItemLabel itemWithLabel:yesLable target:self selector:@selector(yesAddStorageOnce:)];
    CCMenuItemLabel * noMenu = [CCMenuItemLabel itemWithLabel:noLable target:self selector:@selector(noOption:)];
    
    CCMenu * menu = [CCMenu menuWithItems:yesMenu,noMenu,nil];
    [menu alignItemsHorizontallyWithPadding:50];

    [menu setPosition:ccp(screenSize.width/2,screenSize.height/2)];
    //[menu alignItemsHorizontally];
    [self addChild:menu z:1 tag:100];
}

-(void)goBack:(id)sender
{
    [[CCDirector sharedDirector] replaceScene:[NavigationScene scene]];
}

@end
