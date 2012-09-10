//
//  RoleScene.m
//  GreedFamily
//
//  Created by MagicStudio on 12-8-19.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import "RoleScene.h"
#import "CCRadioMenu.h"
#import "NavigationScene.h"
#import "LevelScene.h"

@implementation RoleScene

//角色选择回调函数，把角色类型写入文件
- (void)button1Tapped:(id)sender 
{
    NSString *strName = [NSString stringWithFormat:@"RoleType"];
    [[NSUserDefaults standardUserDefaults] setInteger:1 forKey:strName];
}
- (void)button2Tapped:(id)sender 
{
    NSString *strName = [NSString stringWithFormat:@"RoleType"];
    [[NSUserDefaults standardUserDefaults] setInteger:2 forKey:strName];
}

- (void) chooseRole:(CCMenuItemImage *)btn
{
    int role=btn.tag;
    NSString *strName = [NSString stringWithFormat:@"RoleType"];
    [[NSUserDefaults standardUserDefaults] setInteger:role forKey:strName];
}

-(void)returnMain
{
    [[NSUserDefaults standardUserDefaults] synchronize];
    [[CCDirector sharedDirector] replaceScene:[NavigationScene scene]];
}

-(void)levelScene
{
    //数据提交
        CCLOG(@"role type: %d", [[NSUserDefaults standardUserDefaults]  integerForKey:@"RoleType"]);
    
        [[NSUserDefaults standardUserDefaults] synchronize];
    	[[CCDirector sharedDirector] replaceScene:[LevelScene scene]];    
}

-(id)initWithRoleScene
{
    if ((self = [super init])) {
		self.isTouchEnabled = YES;
        CCSpriteFrameCache* frameCache = [CCSpriteFrameCache sharedSpriteFrameCache];
        [frameCache addSpriteFramesWithFile:@"levlescene_default_default.plist"];
        CGSize screenSize = [[CCDirector sharedDirector] winSize];
        //set the background pic
		CCSprite * background = [CCSprite spriteWithFile:@"background_begin.jpg"];
        background.scaleX=(screenSize.width)/[background contentSize].width; //按照像素定制图片宽高是控制像素的。
        background.scaleY=(screenSize.height)/[background contentSize].height;
        NSAssert( background != nil, @"background must be non-nil");
		[background setPosition:ccp(screenSize.width / 2, screenSize.height/2)];
		[self addChild:background];
        //角色选择：0:总得分 1：小鸟 2：小猪 3：待定 
        CCMenuItem *menuItem1 = [CCMenuItemImage itemFromNormalImage:@"easy_dis.png"
                                                       selectedImage:@"easy_dwn.png" target:self selector:@selector(chooseRole:)];
        CCMenuItem *menuItem2 = [CCMenuItemImage itemFromNormalImage:@"normal_dis.png"
                                                       selectedImage:@"normal_dwn.png" target:self selector:@selector(chooseRole:)];
        CCMenuItem *menuItem3 = [CCMenuItemImage itemFromNormalImage:@"extreme_dis.png"
                                                       selectedImage:@"extreme_dwn.png" target:self selector:@selector(chooseRole:)];
        
        //CCRadioMenu *radioMenu =[CCRadioMenu menuWithItems:menuItem1, menuItem2, menuItem3, nil];
        CCRadioMenu *radioMenu =[CCRadioMenu menuWithItems:menuItem1, menuItem2, nil];
        [radioMenu alignItemsHorizontally];
        //[radioMenu alignItemsVerticallyWithPadding:10];
        [menuItem1 setTag:1];
        [menuItem2 setTag:2];
        [menuItem3 setTag:3];
        
        //默认要写一次文件，设置为小鸟
        NSString *strName = [NSString stringWithFormat:@"RoleType"];
        int roleType = [[NSUserDefaults standardUserDefaults]  integerForKey:strName];
        if (roleType > 3 || roleType < 1) 
        {
            roleType = 1;
            [[NSUserDefaults standardUserDefaults] setInteger:roleType forKey:strName];
        }
        
        if (1 == roleType) 
        {
            [radioMenu setSelectedItem_:menuItem1];
            [menuItem1 selected];
        }
        else if (2 == roleType)
        {
            [radioMenu setSelectedItem_:menuItem2];
            [menuItem2 selected];
        }
        else if (3 == roleType)
        {
            [radioMenu setSelectedItem_:menuItem3];
            [menuItem3 selected];
        }
        [self addChild:radioMenu];
//delete by lyp 20120910
//        CCLabelTTF *returnLabel=[CCLabelTTF labelWithString:@"Return" fontName:@"Marker Felt" fontSize:25];
//        [returnLabel setColor:ccRED];
//        CCMenuItemLabel * returnBtn = [CCMenuItemLabel itemWithLabel:returnLabel target:self selector:@selector(returnMain)];
//        CCMenu * returnMenu = [CCMenu menuWithItems:returnBtn, nil];
//        [returnMenu alignItemsHorizontallyWithPadding:0];
//        [returnMenu setPosition:ccp((screenSize.width)*0.1f,(screenSize.height)*0.125)];
//        [self addChild:returnMenu];
        //set return in the left-down corner
        float returnscale=0.3f;
        float clickreturnscale=0.35f;
        CCSprite *returnBtn = [CCSprite spriteWithSpriteFrameName:@"return.png"];
        returnBtn.scaleX=returnscale;
        returnBtn.scaleY=returnscale;
        CCSprite *returnBtn1 = [CCSprite spriteWithSpriteFrameName:@"return.png"];
        returnBtn1.scaleX=clickreturnscale;
        returnBtn1.scaleY=clickreturnscale;
        CCMenuItemSprite *returnItem = [CCMenuItemSprite itemFromNormalSprite:returnBtn 
                                                               selectedSprite:returnBtn1 
                                                                       target:self 
                                                                     selector:@selector(returnMain)];
        
        CCMenu * returnmenu = [CCMenu menuWithItems:returnItem, nil];
        [returnmenu setPosition:ccp([returnBtn contentSize].width/2,[returnBtn contentSize].height/2)];
        [self addChild:returnmenu];
        
        CCLabelTTF *nextLabel=[CCLabelTTF labelWithString:@"Next" fontName:@"Marker Felt" fontSize:25];
        [nextLabel setColor:ccRED];
        CCMenuItemLabel * nextBtn = [CCMenuItemLabel itemWithLabel:nextLabel target:self selector:@selector(levelScene)];
        CCMenu * nextMenu = [CCMenu menuWithItems:nextBtn, nil];
        [nextMenu alignItemsHorizontallyWithPadding:0];
        [nextMenu setPosition:ccp((screenSize.width)*0.9f,(screenSize.height)*0.1)];
        [self addChild:nextMenu];
    }
    return self;
}

+(id)scene
{
    //order = order;
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	RoleScene *roleScene = [RoleScene sceneWithRoleScene];
	
	// add layer as a child to scene
	[scene addChild: roleScene];
    
	return scene;
    
}

+(id)sceneWithRoleScene
{
    return [[[self alloc] initWithRoleScene] autorelease];
}

@end
