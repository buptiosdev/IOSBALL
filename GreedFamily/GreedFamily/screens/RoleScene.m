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
#import "CommonLayer.h"
#import "CCAnimationHelper.h"

#define LAND_SPEED_TAG 10
#define FLY_SPEED_TAG 11
#define STORAGE_CAPACITY_TAG 12
#define FLY_SENSITIVE_TAG 13

//BEGIN item scale  默认为相对于X的比例
float logorolescale=0.2;
float logoroledistance=0.25;
float rolefontscaleY=0.06;
float progressscale=0.6;

float logoreturnscaleY=0.14;
//END


@implementation RoleScene


//add by lyp 2012-10-23
-(void)changeParameter:(int)roletype
{    
    float capacity = [[CommonLayer sharedCommonLayer] getRoleParam:roletype ParamType:ROLESTORAGECAPACITY];
    float flyspeed = [[CommonLayer sharedCommonLayer] getRoleParam:roletype ParamType:ROLEDENSITY];
    //float flysensit = [[CommonLayer sharedCommonLayer] getRoleParam:roletype ParamType:ROLEAIRSENSIT];
    float landspeed = [[CommonLayer sharedCommonLayer] getRoleParam:roletype ParamType:ROLELANDSPEED];

    CCProgressTimer *ctlandanimal=(CCProgressTimer*)[self getChildByTag:LAND_SPEED_TAG];
    ctlandanimal.percentage=landspeed*100;
    CCProgressTimer *ctflyanimal=(CCProgressTimer*)[self getChildByTag:FLY_SPEED_TAG];
    ctflyanimal.percentage=(1-flyspeed)*100/0.8;
    CCProgressTimer *ctstorage=(CCProgressTimer*)[self getChildByTag:STORAGE_CAPACITY_TAG];
    ctstorage.percentage=capacity*100/12;
//    CCProgressTimer *ctsensitive=(CCProgressTimer*)[self getChildByTag:FLY_SENSITIVE_TAG];
//    ctsensitive.percentage=(1-flysensit)*100;
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
        
        
        CCSprite * panda= [CCSprite spriteWithSpriteFrameName:@"logopanda_1.png"];
        [panda setColor:ccGRAY];
        CCSprite *panda1 = [CCSprite spriteWithSpriteFrameName:@"logopanda_1.png"];
        panda1.scale=1.1;
        
        CCAnimation* animation = [CCAnimation animationWithFrame:@"logopanda_" frameCount:5 delay:0.13f];
        CCAnimate *animate = [CCAnimate actionWithAnimation:animation restoreOriginalFrame:NO];
        CCSequence *seq = [CCSequence actions: animate,nil];
        CCAction *moveAction = [CCRepeatForever actionWithAction: seq ];
        [panda1 runAction:moveAction];
        
        
        
        //add disable menu by liuyunpeng 2012-11-25
        CCSprite *panda2 = [CCSprite spriteWithSpriteFrameName:@"lock.png"];
        float lockscale=screenSize.width*logorolescale/[panda2 contentSize].width;
        panda2.scale=lockscale;
        CCMenuItemSprite *menuItem1 = [CCMenuItemSprite itemFromNormalSprite:panda 
                                                               selectedSprite:panda1 
                                                              disabledSprite:panda2
                                                                      target:self 
                                                                    selector:@selector(chooseRole:)];
        //float spritescale=80/[panda contentSize].width;
        menuItem1.scale=screenSize.width*logorolescale/[panda contentSize].width;
        
        CCSprite * pig= [CCSprite spriteWithSpriteFrameName:@"logopig_1.png"];
        [pig setColor:ccGRAY];
        CCSprite *pig1 = [CCSprite spriteWithSpriteFrameName:@"logopig_1.png"];
        pig1.scale=1.1;
        CCAnimation* animationlogopig = [CCAnimation animationWithFrame:@"logopig_" frameCount:5 delay:0.15f];
        
        CCAnimate *animatelogopig = [CCAnimate actionWithAnimation:animationlogopig restoreOriginalFrame:NO];
        CCSequence *seqlogopig = [CCSequence actions: animatelogopig,nil];
        
        CCAction *moveActionlogopig = [CCRepeatForever actionWithAction: seqlogopig ];
        [pig1 runAction:moveActionlogopig];
        CCSprite *pig2 = [CCSprite spriteWithSpriteFrameName:@"lock.png"];
        pig2.scale=lockscale;
        CCMenuItemSprite *menuItem2 = [CCMenuItemSprite itemFromNormalSprite:pig 
                                                              selectedSprite:pig1
                                                              disabledSprite:pig2
                                                                      target:self 
                                                                    selector:@selector(chooseRole:)];
        menuItem2.scale=screenSize.width*logorolescale/[pig contentSize].width;
        
        CCSprite * bird= [CCSprite spriteWithSpriteFrameName:@"logobird.png"];
        [bird setColor:ccGRAY];
        CCSprite *bird1 = [CCSprite spriteWithSpriteFrameName:@"logobird.png"];
        bird1.scale=1.1;
        CCSprite *bird2 = [CCSprite spriteWithSpriteFrameName:@"lock.png"];
        bird1.scale=lockscale;
        CCMenuItemSprite *menuItem3 = [CCMenuItemSprite itemFromNormalSprite:bird 
                                                              selectedSprite:bird1
                                                              disabledSprite:bird2
                                                                      target:self 
                                                                    selector:@selector(chooseRole:)];
        
        menuItem3.scale=screenSize.width*logorolescale/[bird contentSize].width;
        CCRadioMenu *radioMenu =[CCRadioMenu menuWithItems: menuItem1, menuItem2, menuItem3, nil];
        [radioMenu alignItemsHorizontallyWithPadding:screenSize.width*logoroledistance-[panda2 contentSize].width*lockscale/2];
        [radioMenu setPosition:ccp(screenSize.width/2,screenSize.height*3/4)];
        [menuItem1 setTag:1];
        [menuItem2 setTag:2];
        [menuItem3 setTag:3];
        
        //增加隐藏角色的判断 by liuyunpeng 2012-11-25  
        NSUserDefaults *usrDef = [NSUserDefaults standardUserDefaults];
        NSInteger starNum = [usrDef integerForKey:@"5starNum"];
        if(starNum>0){
            menuItem1.isEnabled=YES;
        }else{
            menuItem1.isEnabled=NO;
        }
        starNum = [usrDef integerForKey:@"20starNum"];
        if(starNum>0){
            menuItem3.isEnabled=YES;
        }else{
            menuItem3.isEnabled=NO;
        }
        
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
        //set return in the left-down corner
        //add by lyp 2012-10-23
        int rolefontsize=screenSize.height*rolefontscaleY;
        landanimalspeed=[CCLabelTTF labelWithString:@" landspeed: " fontName:@"Georgia-Bold" fontSize:rolefontsize];
//        ccColor3B color = {20,156,12};
        ccColor3B color = {2,2,2};
        [landanimalspeed setColor:color];
        [self addChild:landanimalspeed];
        int labelpos=landanimalspeed.contentSize.width/2;
        [landanimalspeed setPosition:ccp(labelpos, screenSize.height * 0.5)];
        flyanimalspeed=[CCLabelTTF labelWithString:@" flyspeed : " fontName:@"Georgia-Bold" fontSize:rolefontsize];
        [flyanimalspeed setColor:color];
        [self addChild:flyanimalspeed];
        [flyanimalspeed setPosition:ccp(labelpos, screenSize.height * 0.4)];
        storagecapacity=[CCLabelTTF labelWithString:@" storage: " fontName:@"Georgia-Bold" fontSize:rolefontsize];
        [storagecapacity setColor:color];
        [self addChild:storagecapacity];
        [storagecapacity setPosition:ccp(labelpos, screenSize.height * 0.3)];

        
        //set progess
        CCProgressTimer *ctlandanimal=[CCProgressTimer progressWithFile:@"progress3.png"];
        float progscale=screenSize.width*progressscale/[ctlandanimal contentSize].width;
        int progresspos=ctlandanimal.contentSize.width*progscale/2+landanimalspeed.contentSize.width;
        CCSprite *progress1=[CCSprite spriteWithFile:@"progress2.png"];
        progress1.scale=progscale;
        progress1.position=ccp( progresspos , screenSize.height * 0.5);
        [self addChild:progress1];
        ctlandanimal.position=ccp( progresspos , screenSize.height * 0.5);
        ctlandanimal.type=kCCProgressTimerTypeHorizontalBarLR;//进度条的显示样式 
        ctlandanimal.scale=progscale;
        [self addChild:ctlandanimal z:0 tag:LAND_SPEED_TAG]; 

        CCSprite *progress2=[CCSprite spriteWithFile:@"progress2.png"];
        progress2.scale=progscale;
        progress2.position=ccp( progresspos , screenSize.height * 0.4);
        [self addChild:progress2];
        CCProgressTimer *ctflyanimal=[CCProgressTimer progressWithFile:@"progress3.png"];
        ctflyanimal.position=ccp( progresspos, screenSize.height * 0.4);
        ctflyanimal.type=kCCProgressTimerTypeHorizontalBarLR;//进度条的显示样式 
        ctflyanimal.scale=progscale;
        [self addChild:ctflyanimal z:0 tag:FLY_SPEED_TAG]; 

        CCSprite *progress3=[CCSprite spriteWithFile:@"progress2.png"];
        progress3.scale=progscale;
        progress3.position=ccp( progresspos , screenSize.height * 0.3);
        [self addChild:progress3];
        CCProgressTimer *ctstorage=[CCProgressTimer progressWithFile:@"progress3.png"];
        ctstorage.position=ccp( progresspos , screenSize.height * 0.3);
        ctstorage.type=kCCProgressTimerTypeHorizontalBarLR;//进度条的显示样式 
        ctstorage.scale=progscale;
        [self addChild:ctstorage z:0 tag:STORAGE_CAPACITY_TAG]; 

        
        CCSprite *returnBtn = [CCSprite spriteWithSpriteFrameName:@"return.png"];
        CCSprite *returnBtn1 = [CCSprite spriteWithSpriteFrameName:@"return.png"];
        returnBtn1.scaleX=1.1;
        returnBtn1.scaleY=1.1;
        CCMenuItemSprite *returnItem = [CCMenuItemSprite itemFromNormalSprite:returnBtn 
                                                               selectedSprite:returnBtn1 
                                                                       target:self 
                                                                     selector:@selector(returnMain)];
        returnItem.scale=screenSize.height*logoreturnscaleY/[returnBtn contentSize].height; //按照像素定制图片宽高
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
        
        nextItem.scale=screenSize.height*logoreturnscaleY/[next contentSize].height;
        
        CCMenu * nextMenu = [CCMenu menuWithItems:nextItem, nil];
        //right corner=screenSize.width-[shop contentSize].width*(shopscale-0.5)
        [nextMenu setPosition:ccp(screenSize.width-[next contentSize].width*nextItem.scaleX*0.6,
                                  [next contentSize].height * nextItem.scaleX * 0.5)];
        [self addChild:nextMenu];
        

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
}

+(id)sceneWithRoleScene
{
    return [[[self alloc] initWithRoleScene] autorelease];
}

@end
