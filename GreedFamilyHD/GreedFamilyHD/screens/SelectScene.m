//
//  SelectScene.m
//  GreedFamilyHD
//
//  Created by 赵 苹果 on 13-1-3.
//  Copyright 2013年 __MyCompanyName__. All rights reserved.
//

#import "SelectScene.h"
#import "CommonLayer.h"
#import "NavigationScene.h"
#import "CCRadioMenu.h"
#import "LevelScene.h"
#import "GameShopScene.h"
#import "RoleScene.h"

float mapScale=0.2;
float mapDistance=0.25;
float selectReturnScale=0.15;

@implementation SelectScene

-(id)initWithSelectScene
{
    if ((self = [super init])) {
		self.isTouchEnabled = YES;
        CCSpriteFrameCache* frameCache = [CCSpriteFrameCache sharedSpriteFrameCache];
        [frameCache addSpriteFramesWithFile:@"levlescene_default_default.plist"];
        //add by liuyunpeng 20120924
        [frameCache addSpriteFramesWithFile:@"beginscene_default.plist"];
        CGSize screenSize = [[CCDirector sharedDirector] winSize];
        
        //map
        CCSprite * mapAir= [CCSprite spriteWithSpriteFrameName:@"logopanda_1.png"];
        [mapAir setColor:ccGRAY];
        CCSprite *mapAir1 = [CCSprite spriteWithSpriteFrameName:@"logopanda_1.png"];
        mapAir1.scale=1.1;
        CCSprite *mapAir2 = [CCSprite spriteWithSpriteFrameName:@"lock.png"];
        //float lockscale=screenSize.width*logorolescale/[panda2 contentSize].width;
        float lockscale=[mapAir contentSize].width/[mapAir2 contentSize].width;
        mapAir2.scale=lockscale;
        CCMenuItemSprite *menuItem1 = [CCMenuItemSprite itemFromNormalSprite:mapAir 
                                                              selectedSprite:mapAir1 
                                                              disabledSprite:mapAir2
                                                                      target:self 
                                                                    selector:@selector(chooseMap:)];
        menuItem1.scale=screenSize.width*mapScale/[mapAir contentSize].width;
        
        
        CCSprite * mapSunset= [CCSprite spriteWithSpriteFrameName:@"logopig_1.png"];
        [mapSunset setColor:ccGRAY];
        CCSprite *mapSunset1 = [CCSprite spriteWithSpriteFrameName:@"logopig_1.png"];
        mapSunset1.scale=1.1;
        CCSprite *mapSunset2 = [CCSprite spriteWithSpriteFrameName:@"lock.png"];
        mapSunset2.scale=lockscale;
        CCMenuItemSprite *menuItem2 = [CCMenuItemSprite itemFromNormalSprite:mapSunset 
                                                              selectedSprite:mapSunset1
                                                              disabledSprite:mapSunset2
                                                                      target:self 
                                                                    selector:@selector(chooseMap:)];
        menuItem2.scale=screenSize.width*mapScale/[mapSunset contentSize].width;
        
        
        
        CCSprite * mapBeach= [CCSprite spriteWithSpriteFrameName:@"logobird.png"];
        [mapBeach setColor:ccGRAY];
        CCSprite *mapBeach1 = [CCSprite spriteWithSpriteFrameName:@"logobird.png"];
        mapBeach1.scale=1.1;
        CCSprite *mapBeach2 = [CCSprite spriteWithSpriteFrameName:@"lock.png"];
        mapBeach2.scale=[mapBeach contentSize].width/[mapBeach2 contentSize].width;
        CCMenuItemSprite *menuItem3 = [CCMenuItemSprite itemFromNormalSprite:mapBeach 
                                                              selectedSprite:mapBeach1
                                                              disabledSprite:mapBeach2
                                                                      target:self 
                                                                    selector:@selector(chooseMap:)];
        
        menuItem3.scale=screenSize.width*mapScale/[mapBeach contentSize].width;
        CCRadioMenu *radioMenu =[CCRadioMenu menuWithItems: menuItem1, menuItem2, menuItem3, nil];
        [radioMenu alignItemsHorizontallyWithPadding:screenSize.width*mapDistance-[mapAir2 contentSize].width*lockscale/2];
        [radioMenu setPosition:ccp(screenSize.width/2,screenSize.height/2)];
        [menuItem1 setTag:1];
        [menuItem2 setTag:2];
        [menuItem3 setTag:3];
        
        //判断是否购买地图        
        NSUserDefaults *usrDef = [NSUserDefaults standardUserDefaults];
        BOOL mapBeachBuy = [usrDef boolForKey:@"BeachBuy"];
        if(mapBeachBuy){
            menuItem3.isEnabled=YES;
        }else{
            menuItem3.isEnabled=NO;
        }
        [self addChild:radioMenu];
        
        //role
        //set play 
        CCSprite *roleSelect = [CCSprite spriteWithSpriteFrameName:@"playpic.png"];
        //play.scaleX=1.1;
        
        CCSprite *roleSelect1 = [CCSprite spriteWithSpriteFrameName:@"playpic.png"];
        roleSelect1.scaleY=1.1;
        CCMenuItemSprite *roleItem = [CCMenuItemSprite itemFromNormalSprite:roleSelect 
                                                             selectedSprite:roleSelect1 
                                                                     target:self 
                                                                   selector:@selector(connectRole:)];
        roleItem.scale=(screenSize.width*mapScale)/[roleSelect contentSize].width;
        CCMenu * roleMenu = [CCMenu menuWithItems:roleItem, nil];
        [roleMenu setPosition:ccp(screenSize.width/2,screenSize.height*9/10)];
        [self addChild:roleMenu];
        
        //shop
        //set shop in the right-down corner
        CCSprite *shop = [CCSprite spriteWithSpriteFrameName:@"shop2.png"];
        CCSprite *shop1 = [CCSprite spriteWithSpriteFrameName:@"shop1.png"];
        shop1.scale=1.1; //按照像素定制图片宽高
        CCMenuItemSprite *shopItem = [CCMenuItemSprite itemFromNormalSprite:shop 
                                                             selectedSprite:shop1 
                                                                     target:self 
                                                                   selector:@selector(connectGameShop:)];
        shopItem.scale=(screenSize.height*selectReturnScale)/[shop contentSize].height;
        CCMenu * shopmenu = [CCMenu menuWithItems:shopItem, nil];
        //right corner=screenSize.width-[shop contentSize].width*(shopscale-0.5)
        [shopmenu setPosition:ccp(screenSize.width-[shop contentSize].width*shopItem.scaleX*0.6,
                                  [shop contentSize].height * shopItem.scaleX * 0.5)];
        [self addChild:shopmenu];
        
        //return
        CCSprite *returnBtn = [CCSprite spriteWithSpriteFrameName:@"return.png"];
        
        CCSprite *returnBtn1 = [CCSprite spriteWithSpriteFrameName:@"return.png"];
        returnBtn1.scale=1.1;
        CCMenuItemSprite *returnItem = [CCMenuItemSprite itemFromNormalSprite:returnBtn 
                                                               selectedSprite:returnBtn1 
                                                                       target:self 
                                                                     selector:@selector(returnMain)];
        returnItem.scale=(screenSize.height*selectReturnScale)/[returnBtn contentSize].height;
        CCMenu * returnmenu = [CCMenu menuWithItems:returnItem, nil];
        [returnmenu setPosition:ccp([returnBtn contentSize].width * returnItem.scaleX * 0.5,
                                    [returnBtn contentSize].height * returnItem.scaleY * 0.5)];
        [self addChild:returnmenu];
        
    }
    
    return self;
}


//角色选择回调函数，把角色类型写入文件
- (void) chooseMap:(CCMenuItemImage *)btn
{
    [CommonLayer playAudio:SelectOK];
    int map=btn.tag;
    
    [CommonLayer playAudio:SelectOK];
    [[CCDirector sharedDirector] replaceScene:[LevelScene scene:map]];    
}

-(void)returnMain
{
    [CommonLayer playAudio:SelectOK];
    [[CCDirector sharedDirector] replaceScene:[NavigationScene scene]];
}


-(void)connectGameShop:(id)sender
{
    //connect to game center
    [CommonLayer playAudio:SelectOK];
    [[CCDirector sharedDirector] replaceScene:[GameShopScene gameShopScene]];
}

-(void)connectRole:(id)sender
{
    [CommonLayer playAudio:SelectOK];
    [[CCDirector sharedDirector] replaceScene:[RoleScene scene]];
}


+(id)sceneWithSelectScene
{
    return [[[self alloc] initWithSelectScene] autorelease];
}

+(id)scene
{
    //order = order;
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	SelectScene *selectScene = [SelectScene sceneWithSelectScene];
	
	// add layer as a child to scene
	[scene addChild: selectScene];
    
	return scene;
    
}



-(void)dealloc
{
	[super dealloc];
}

@end
