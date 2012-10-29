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

CCLabelTTF *landanimalspeed;
CCLabelTTF *flyanimalspeed;
CCLabelTTF *storagecapacity;


//add by lyp 2012-10-23
-(void)changeParameter:(int)roletype
{
    NSString *landspeed=[NSString stringWithFormat:@"land animal speed is : %d",roletype];
    NSString *flyspeed=[NSString stringWithFormat:@"fly animal speed is : %d",roletype];
    NSString *storagesize=[NSString stringWithFormat:@"storage capacity is : %d",roletype];
    [landanimalspeed setString:landspeed];
    [flyanimalspeed setString:flyspeed];
    [storagecapacity setString:storagesize];
}

//角色选择回调函数，把角色类型写入文件
- (void) chooseRole:(CCMenuItemImage *)btn
{
    int role=btn.tag;
    [self changeParameter:role];
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
        //add by liuyunpeng 20120924
        [frameCache addSpriteFramesWithFile:@"beginscene_default.plist"];
        CGSize screenSize = [[CCDirector sharedDirector] winSize];
        //set the background pic
		CCSprite * background = [CCSprite spriteWithFile:@"background_begin.jpg"];
        background.scaleX=(screenSize.width)/[background contentSize].width; //按照像素定制图片宽高是控制像素的。
        background.scaleY=(screenSize.height)/[background contentSize].height;
        NSAssert( background != nil, @"background must be non-nil");
		[background setPosition:ccp(screenSize.width / 2, screenSize.height/2)];
		[self addChild:background];
        //角色选择：0:总得分 1：熊猫 2：小猪 3：小鸟 
//        CCMenuItem *menuItem1 = [CCMenuItemImage itemFromNormalImage:@"easy_dis.png"
//                                                       selectedImage:@"easy_dwn.png" target:self selector:@selector(chooseRole:)];
//        CCMenuItem *menuItem2 = [CCMenuItemImage itemFromNormalImage:@"normal_dis.png"
//                                                       selectedImage:@"normal_dwn.png" target:self selector:@selector(chooseRole:)];
        
        CCSprite * panda= [CCSprite spriteWithSpriteFrameName:@"logopanda.png"];
        [panda setColor:ccGRAY];
        CCSprite *panda1 = [CCSprite spriteWithSpriteFrameName:@"logopanda.png"];
        panda1.scale=1.1;
        CCMenuItemSprite *menuItem1 = [CCMenuItemSprite itemFromNormalSprite:panda 
                                                                   selectedSprite:panda1 
                                                                           target:self 
                                                                         selector:@selector(chooseRole:)];
        float spritescale=100/[panda contentSize].width;
        menuItem1.scale=spritescale;
        
        CCSprite * pig= [CCSprite spriteWithSpriteFrameName:@"logopig.png"];
        [pig setColor:ccGRAY];
        CCSprite *pig1 = [CCSprite spriteWithSpriteFrameName:@"logopig.png"];
        pig1.scale=1.1;
        CCMenuItemSprite *menuItem2 = [CCMenuItemSprite itemFromNormalSprite:pig 
                                                              selectedSprite:pig1 
                                                                      target:self 
                                                                    selector:@selector(chooseRole:)];
        menuItem2.scale=spritescale;
        
        CCSprite * bird= [CCSprite spriteWithSpriteFrameName:@"logobird.png"];
        [bird setColor:ccGRAY];
        CCSprite *bird1 = [CCSprite spriteWithSpriteFrameName:@"logobird.png"];
        bird1.scale=1.1;
        CCMenuItemSprite *menuItem3 = [CCMenuItemSprite itemFromNormalSprite:bird 
                                                              selectedSprite:bird1 
                                                                      target:self 
                                                                    selector:@selector(chooseRole:)];
        
        menuItem3.scale=spritescale;
        
        CCRadioMenu *radioMenu =[CCRadioMenu menuWithItems: menuItem1, menuItem2, menuItem3, nil];
        [radioMenu alignItemsHorizontallyWithPadding:[panda contentSize].width*spritescale];
        [radioMenu setPosition:ccp(screenSize.width/2,screenSize.height*3/4)];
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
        //add by lyp 2012-10-23
        landanimalspeed=[CCLabelTTF labelWithString:@"" fontName:@"Marker Felt" fontSize:35];
        [landanimalspeed setColor:ccRED];
        [self addChild:landanimalspeed];
        [landanimalspeed setPosition:ccp(screenSize.width/2, screenSize.height * 0.45)];
        flyanimalspeed=[CCLabelTTF labelWithString:@"" fontName:@"Marker Felt" fontSize:35];
        [flyanimalspeed setColor:ccRED];
        [self addChild:flyanimalspeed];
        [flyanimalspeed setPosition:ccp(screenSize.width/2, screenSize.height * 0.3)];
        storagecapacity=[CCLabelTTF labelWithString:@"" fontName:@"Marker Felt" fontSize:35];
        [storagecapacity setColor:ccRED];
        [self addChild:storagecapacity];
        [storagecapacity setPosition:ccp(screenSize.width/2, screenSize.height * 0.15)];
        
        [self changeParameter:roleType];

        
        
        CCSprite *returnBtn = [CCSprite spriteWithSpriteFrameName:@"return.png"];
        CCSprite *returnBtn1 = [CCSprite spriteWithSpriteFrameName:@"return.png"];
        returnBtn1.scaleX=1.1;
        returnBtn1.scaleY=1.1;
        CCMenuItemSprite *returnItem = [CCMenuItemSprite itemFromNormalSprite:returnBtn 
                                                               selectedSprite:returnBtn1 
                                                                       target:self 
                                                                     selector:@selector(returnMain)];
        returnItem.scaleX=(45)/[returnBtn contentSize].width; //按照像素定制图片宽高
        returnItem.scaleY=(45)/[returnBtn contentSize].height;
        CCMenu * returnmenu = [CCMenu menuWithItems:returnItem, nil];
        [returnmenu setPosition:ccp([returnBtn contentSize].width * returnItem.scaleX * 0.5,
                                    [returnBtn contentSize].height * returnItem.scaleY * 0.5)];

        [self addChild:returnmenu];
        
        //set shop in the right-down corner
        CCSprite *next = [CCSprite spriteWithSpriteFrameName:@"return.png"];
        CCSprite *next1 = [CCSprite spriteWithSpriteFrameName:@"return.png"];
        [next setFlipX:YES];//Y轴镜像反转
        [next1 setFlipX:YES];//Y轴镜像反转
        next1.scaleX=1.1; //按照像素定制图片宽高
        next1.scaleY=1.1;
        CCMenuItemSprite *nextItem = [CCMenuItemSprite itemFromNormalSprite:next 
                                                             selectedSprite:next1 
                                                                     target:self 
                                                                   selector:@selector(levelScene)];
        
        nextItem.scaleX=(45)/[next contentSize].width; //按照像素定制图片宽高
        nextItem.scaleY=(45)/[next contentSize].height;
        
        CCMenu * nextMenu = [CCMenu menuWithItems:nextItem, nil];
        //right corner=screenSize.width-[shop contentSize].width*(shopscale-0.5)
        [nextMenu setPosition:ccp(screenSize.width-[next contentSize].width*nextItem.scaleX*0.6,
                                  [next contentSize].height * nextItem.scaleX * 0.5)];
        [self addChild:nextMenu];
        
//        CCLabelTTF *nextLabel=[CCLabelTTF labelWithString:@"Next" fontName:@"Marker Felt" fontSize:25];
//        [nextLabel setColor:ccRED];
//        CCMenuItemLabel * nextBtn = [CCMenuItemLabel itemWithLabel:nextLabel target:self selector:@selector(levelScene)];
//        CCMenu * nextMenu = [CCMenu menuWithItems:nextBtn, nil];
//        [nextMenu alignItemsHorizontallyWithPadding:0];
//        [nextMenu setPosition:ccp((screenSize.width)*0.9f,(screenSize.height)*0.1)];
//        [self addChild:nextMenu];
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
