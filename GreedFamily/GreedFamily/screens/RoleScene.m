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

#define LAND_SPEED_TAG 10
#define FLY_SPEED_TAG 11
#define STORAGE_CAPACITY_TAG 12


@implementation RoleScene


//add by lyp 2012-10-23
-(void)changeParameter:(int)roletype
{
    NSString *strSpeed=nil;
    NSString *strCapacity=nil;
    if(roletype == 1){
        strSpeed=@"Acceleration_Panda";
        strCapacity=@"Capacity_Panda";
    }else if(roletype == 2){
        strSpeed=@"Acceleration_Pig";
        strCapacity=@"Capacity_Pig";
    }else if(roletype == 3){
        strSpeed=@"Acceleration_Bird";
        strCapacity=@"Capacity_Bird";
    }else{
        return;
    }
    int landspeed= [[NSUserDefaults standardUserDefaults] integerForKey:strSpeed];
    int capacity = [[NSUserDefaults standardUserDefaults] integerForKey:strCapacity];
    if(capacity==0){
        capacity=8;
    }
    CCProgressTimer *ctlandanimal=(CCProgressTimer*)[self getChildByTag:LAND_SPEED_TAG];
    ctlandanimal.percentage=landspeed*100/12;
    CCProgressTimer *ctflyanimal=(CCProgressTimer*)[self getChildByTag:FLY_SPEED_TAG];
    ctflyanimal.percentage=roletype*100/3;
    CCProgressTimer *ctstorage=(CCProgressTimer*)[self getChildByTag:STORAGE_CAPACITY_TAG];
    ctstorage.percentage=capacity*100/10;
    
//    NSString *landspeed=[NSString stringWithFormat:@"land animal speed is : %d",speed];
//    NSString *flyspeed=[NSString stringWithFormat:@"fly animal speed is : %d",roletype];
//    NSString *storagesize=[NSString stringWithFormat:@"storage capacity is : %d",capacity];
//    [landanimalspeed setString:landspeed];
//    [flyanimalspeed setString:flyspeed];
//    [storagecapacity setString:storagesize];
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
        float spritescale=80/[panda contentSize].width;
        menuItem1.scale=spritescale;
        
        CCSprite * pig= [CCSprite spriteWithSpriteFrameName:@"logopig.png"];
        [pig setColor:ccGRAY];
        CCSprite *pig1 = [CCSprite spriteWithSpriteFrameName:@"logopig.png"];
        pig1.scale=1.1;
        CCMenuItemSprite *menuItem2 = [CCMenuItemSprite itemFromNormalSprite:pig 
                                                              selectedSprite:pig1 
                                                                      target:self 
                                                                    selector:@selector(chooseRole:)];
        menuItem2.scale=80/[pig contentSize].width;
        
        CCSprite * bird= [CCSprite spriteWithSpriteFrameName:@"logobird.png"];
        [bird setColor:ccGRAY];
        CCSprite *bird1 = [CCSprite spriteWithSpriteFrameName:@"logobird.png"];
        bird1.scale=1.1;
        CCMenuItemSprite *menuItem3 = [CCMenuItemSprite itemFromNormalSprite:bird 
                                                              selectedSprite:bird1 
                                                                      target:self 
                                                                    selector:@selector(chooseRole:)];
        
        menuItem3.scale=80/[bird contentSize].width;
        
        CCRadioMenu *radioMenu =[CCRadioMenu menuWithItems: menuItem1, menuItem2, menuItem3, nil];
        [radioMenu alignItemsHorizontallyWithPadding:100*0.75];
        [radioMenu setPosition:ccp(screenSize.width/2,screenSize.height*3/4)];
        [menuItem1 setTag:1];
        [menuItem2 setTag:2];
        [menuItem3 setTag:3];
        
        //默认要写一次文件，设置为小鸟
        NSString *strName = [NSString stringWithFormat:@"RoleType"];
        roleType = [[NSUserDefaults standardUserDefaults]  integerForKey:strName];
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
        landanimalspeed=[CCLabelTTF labelWithString:@" land-speed: " fontName:@"Marker Felt" fontSize:30];
        [landanimalspeed setColor:ccRED];
        [self addChild:landanimalspeed];
        int labelpos=landanimalspeed.contentSize.width/2;
        [landanimalspeed setPosition:ccp(labelpos, screenSize.height * 0.5)];
        flyanimalspeed=[CCLabelTTF labelWithString:@" fly-speed : " fontName:@"Marker Felt" fontSize:30];
        [flyanimalspeed setColor:ccRED];
        [self addChild:flyanimalspeed];
        [flyanimalspeed setPosition:ccp(labelpos, screenSize.height * 0.35)];
        storagecapacity=[CCLabelTTF labelWithString:@" store-size: " fontName:@"Marker Felt" fontSize:30];
        [storagecapacity setColor:ccRED];
        [self addChild:storagecapacity];
        [storagecapacity setPosition:ccp(labelpos, screenSize.height * 0.2)];
        
        //set progess
        CCProgressTimer *ctlandanimal=[CCProgressTimer progressWithFile:@"progress.jpg"];
        int progresspos=ctlandanimal.contentSize.width/2+landanimalspeed.contentSize.width;
        ctlandanimal.position=ccp( progresspos , screenSize.height * 0.5);
        ctlandanimal.type=kCCProgressTimerTypeHorizontalBarLR;//进度条的显示样式 
        [self addChild:ctlandanimal z:0 tag:LAND_SPEED_TAG]; 
        
        CCProgressTimer *ctflyanimal=[CCProgressTimer progressWithFile:@"progress.jpg"];
        ctflyanimal.position=ccp( progresspos, screenSize.height * 0.35);
        ctflyanimal.type=kCCProgressTimerTypeHorizontalBarLR;//进度条的显示样式 
        [self addChild:ctflyanimal z:0 tag:FLY_SPEED_TAG]; 
        
        CCProgressTimer *ctstorage=[CCProgressTimer progressWithFile:@"progress.jpg"];
        ctstorage.position=ccp( progresspos , screenSize.height * 0.2);
        ctstorage.type=kCCProgressTimerTypeHorizontalBarLR;//进度条的显示样式 
        [self addChild:ctstorage z:0 tag:STORAGE_CAPACITY_TAG]; 
        
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
        [self scheduleUpdate];
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

-(void)update:(ccTime)himi{  
    [self unscheduleUpdate];
    [self changeParameter:roleType];
//    ct.percentage++;  
//    if(ct.percentage>=100){  
//        ct.percentage=0;  
//    }  
}

+(id)sceneWithRoleScene
{
    return [[[self alloc] initWithRoleScene] autorelease];
}

@end
