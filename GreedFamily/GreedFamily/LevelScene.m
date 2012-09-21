//
//  LevelScene.m
//  GreedFamily
//
//  Created by MagicStudio on 12-6-7.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import "LevelScene.h"
#import "LoadingScene.h"
#import "RoleScene.h"
#import "CCScrollLayer.h"
#import "GameShopScene.h"

@implementation LevelScene


-(void)selectMode:(CCMenuItemImage *)btn
{
	int mode = btn.tag;
    [[CCDirector sharedDirector] replaceScene:[LoadingScene sceneWithTargetScene:(TargetScenes)mode]];
}

-(void)returnMain
{
    [[CCDirector sharedDirector] replaceScene:[RoleScene scene]];
}

-(void)connectGameShop:(id)sender
{
    //connect to game center
    [[CCDirector sharedDirector] replaceScene:[GameShopScene gameShopScene]];
}

-(int)getGameStarNumber:(int)level
{
    NSString *str_starlevel = [NSString stringWithFormat:@"%d",level];
    str_starlevel = [str_starlevel stringByAppendingFormat:@"starNum"];    
    NSUserDefaults *usrDef = [NSUserDefaults standardUserDefaults];
    NSInteger starNum = [usrDef integerForKey:str_starlevel];    
    
    return starNum;
}

-(id)initWithLevelScene
{
    if ((self = [super init])) {
		self.isTouchEnabled = YES;

//delete by lyp 20120910
//        CCSpriteFrameCache* frameCache = [CCSpriteFrameCache sharedSpriteFrameCache];
//        [frameCache addSpriteFramesWithFile:@"level_default_default.plist"];
//        CGSize screenSize = [[CCDirector sharedDirector] winSize];
//        int number=20;
//        CCArray * levelarray = [[CCArray alloc]initWithCapacity:number];
//        bool isZero=NO;
//
//        for(int i=0;i<20;i++)
//        {
//            int star=[self getGameStarNumber:i+1];
//            if(isZero==YES)
//            {
//                star=0;
//            }
//            NSString *starname = [NSString stringWithFormat:@"get%istart.png", star];
//            CCSprite *levelpic = [CCSprite spriteWithSpriteFrameName:starname];
//            levelpic.scaleX=(60)/[levelpic contentSize].width; //按照像素定制图片宽高是控制像素的。
//            levelpic.scaleY=(60)/[levelpic contentSize].height;
//            CCLabelTTF *Labelnum=[CCLabelTTF labelWithString:[NSString stringWithFormat:@"%i", i+1] fontName:@"Marker Felt" fontSize:50];
//            if(i<9)
//            {
//                Labelnum.anchorPoint=CGPointMake(-1.2, -0.6);
//            }
//            else
//            {
//                Labelnum.anchorPoint=CGPointMake(-0.5, -0.6);
//            }
//            
//            [levelpic addChild:Labelnum];
//            CCSprite *defaultstar = [CCSprite spriteWithSpriteFrameName:starname];
//            defaultstar.scaleX=(60)/[defaultstar contentSize].width; //按照像素定制图片宽高是控制像素的。
//            defaultstar.scaleY=(60)/[defaultstar contentSize].height;
//            CCMenuItemSprite *level = [CCMenuItemSprite itemFromNormalSprite:levelpic 
//                                                               selectedSprite:defaultstar 
//                                                                       target:self 
//                                                                     selector:@selector(selectMode:)];
//            [level setTag:i+1];
//
//            if(isZero==YES)
//            {
//                [level setIsEnabled:NO];
//            }
//            else
//            {
//                [level setIsEnabled:YES];
//                [Labelnum setColor:ccRED];
//            }
//            
//            if(star==0)
//            {
//                if(isZero==NO)
//                {
//                    isZero=YES;
//                }
//            }
//            [levelarray addObject:level];
//        }
//        CCLabelTTF *returnLabel=[CCLabelTTF labelWithString:@"Return" fontName:@"Marker Felt" fontSize:25];
//        [returnLabel setColor:ccRED];
//        
//        CCMenuItemLabel * returnBtn = [CCMenuItemLabel itemWithLabel:returnLabel target:self selector:@selector(returnMain)];
//        CCLabelTTF *gameShopLabel=[CCLabelTTF labelWithString:@"Shop" fontName:@"Marker Felt" fontSize:30];
//        CCMenuItemLabel * gameShop = [CCMenuItemLabel itemWithLabel:gameShopLabel target:self selector:@selector(connectGameShop:)];
//        
//        CCMenu * easyMenu = [CCMenu menuWithItems:[levelarray objectAtIndex:0],[levelarray objectAtIndex:1],[levelarray objectAtIndex:2],[levelarray objectAtIndex:3],[levelarray objectAtIndex:4],nil];
//        [easyMenu alignItemsHorizontallyWithPadding:-15];
//        [easyMenu setPosition:ccp((screenSize.width)*0.5f+25,(screenSize.height)*5/6)];
//        
//        CCMenu * normalMenu = [CCMenu menuWithItems:[levelarray objectAtIndex:5],[levelarray objectAtIndex:6],[levelarray objectAtIndex:7],[levelarray objectAtIndex:8],[levelarray objectAtIndex:9], nil];
//        [normalMenu alignItemsHorizontallyWithPadding:-15];
//        [normalMenu setPosition:ccp((screenSize.width)*0.5f+25,(screenSize.height)*1/2)];
//        
//        CCMenu * hardMenu = [CCMenu menuWithItems:[levelarray objectAtIndex:10],[levelarray objectAtIndex:11],[levelarray objectAtIndex:12],[levelarray objectAtIndex:13],[levelarray objectAtIndex:14], nil];
//        [hardMenu alignItemsHorizontallyWithPadding:-15];
//        [hardMenu setPosition:ccp((screenSize.width)*0.5f+25,(screenSize.height)*5/6)];
//        
//        CCMenu * extremeMenu = [CCMenu menuWithItems:[levelarray objectAtIndex:15],[levelarray objectAtIndex:16],[levelarray objectAtIndex:17],[levelarray objectAtIndex:18],[levelarray objectAtIndex:19], nil];
//        [extremeMenu alignItemsHorizontallyWithPadding:-15];
//        [extremeMenu setPosition:ccp((screenSize.width)*0.5f+25,(screenSize.height)*1/2)];
//        
//        
//        CCMenu * returnMenu = [CCMenu menuWithItems:returnBtn, gameShop, nil];
//        [returnMenu alignItemsHorizontallyWithPadding:300];
//        [returnMenu setPosition:ccp((screenSize.width)*0.5f,(screenSize.height)*1/7)];
//        [self addChild:returnMenu];
//        
//        //page 1
//        CCLayer *pageOne = [[CCLayer alloc] init];
//        [pageOne addChild:easyMenu];
//        [pageOne addChild:normalMenu];
//        
//        // create a blank layer for page 2
//        CCLayer *pageTwo = [[CCLayer alloc] init];
//        [pageTwo addChild:hardMenu];
//        [pageTwo addChild:extremeMenu];
//        
//        // now create the scroller and pass-in the pages (set widthOffset to 0 for fullscreen pages)
//        CCScrollLayer *scroller = [[CCScrollLayer alloc] initWithLayers:[NSMutableArray arrayWithObjects: pageOne,pageTwo,nil] widthOffset: 0];
//        
//        // finally add the scroller to your scene
//        [self addChild:scroller];        
        
        
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
        int number=20;
        CCArray * levelarray = [[CCArray alloc]initWithCapacity:number];
        bool isZero=NO;
        int scale=75;
        for(int i=0;i<20;i++)
        {
            int star=[self getGameStarNumber:i+1];
            NSString *starname;
            if(isZero==YES)
            {
                starname = @"level4.png";
            }else
            {
                starname = [NSString stringWithFormat:@"level%i.png", star];
            }
            
            CCSprite *levelpic = [CCSprite spriteWithSpriteFrameName:starname];
            levelpic.scaleX=(scale)/[levelpic contentSize].width; //按照像素定制图片宽高是控制像素的。
            levelpic.scaleY=(scale)/[levelpic contentSize].height;
            CCLabelTTF *Labelnum=[CCLabelTTF labelWithString:[NSString stringWithFormat:@"%i", i+1] fontName:@"Marker Felt" fontSize:50];
            if(i<9)
            {
                Labelnum.anchorPoint=CGPointMake(-2.1, -1.5);
            }
            else
            {
                Labelnum.anchorPoint=CGPointMake(-0.8, -1.5);
            }
            
            [levelpic addChild:Labelnum];
            CCSprite *defaultstar = [CCSprite spriteWithSpriteFrameName:starname];
            defaultstar.scaleX=(scale)/[defaultstar contentSize].width; //按照像素定制图片宽高是控制像素的。
            defaultstar.scaleY=(scale)/[defaultstar contentSize].height;
            CCLabelTTF *Labelnum1=[CCLabelTTF labelWithString:[NSString stringWithFormat:@"%i", i+1] fontName:@"Marker Felt" fontSize:50];
            if(i<9)
            {
                Labelnum1.anchorPoint=CGPointMake(-2.1, -1.5);
            }
            else
            {
                Labelnum1.anchorPoint=CGPointMake(-0.8, -1.5);
            }
            
            [defaultstar addChild:Labelnum1];
            CCMenuItemSprite *level = [CCMenuItemSprite itemFromNormalSprite:levelpic 
                                                              selectedSprite:defaultstar 
                                                                      target:self 
                                                                    selector:@selector(selectMode:)];
            [level setTag:i+1];
            
            if(isZero==YES)
            {
                [level setIsEnabled:NO];
            }
            else
            {
                [level setIsEnabled:YES];
                [Labelnum setColor:ccRED];
                [Labelnum1 setColor:ccYELLOW];
            }
            
            if(star==0)
            {
                if(isZero==NO)
                {
                    isZero=YES;
                }
            }
            [levelarray addObject:level];
        }
        
        int levelpadding=-60;
        CCSprite *temp = [CCSprite spriteWithSpriteFrameName:@"level4.png"];
        float horizon=[temp contentSize].width/2 - scale/2;
        
        CCMenu * easyMenu = [CCMenu menuWithItems:[levelarray objectAtIndex:0],[levelarray objectAtIndex:1],[levelarray objectAtIndex:2],[levelarray objectAtIndex:3],[levelarray objectAtIndex:4],nil];
        [easyMenu alignItemsHorizontallyWithPadding:levelpadding];
        [easyMenu setPosition:ccp((screenSize.width)*0.5f+horizon,(screenSize.height)*5/6)];
        
        CCMenu * normalMenu = [CCMenu menuWithItems:[levelarray objectAtIndex:5],[levelarray objectAtIndex:6],[levelarray objectAtIndex:7],[levelarray objectAtIndex:8],[levelarray objectAtIndex:9], nil];
        [normalMenu alignItemsHorizontallyWithPadding:levelpadding];
        [normalMenu setPosition:ccp((screenSize.width)*0.5f+horizon,(screenSize.height)*1/2)];
        
        CCMenu * hardMenu = [CCMenu menuWithItems:[levelarray objectAtIndex:10],[levelarray objectAtIndex:11],[levelarray objectAtIndex:12],[levelarray objectAtIndex:13],[levelarray objectAtIndex:14], nil];
        [hardMenu alignItemsHorizontallyWithPadding:levelpadding];
        [hardMenu setPosition:ccp((screenSize.width)*0.5f+horizon,(screenSize.height)*5/6)];
        
        CCMenu * extremeMenu = [CCMenu menuWithItems:[levelarray objectAtIndex:15],[levelarray objectAtIndex:16],[levelarray objectAtIndex:17],[levelarray objectAtIndex:18],[levelarray objectAtIndex:19], nil];
        [extremeMenu alignItemsHorizontallyWithPadding:levelpadding];
        [extremeMenu setPosition:ccp((screenSize.width)*0.5f+horizon,(screenSize.height)*1/2)];
        
        //page 1
        CCLayer *pageOne = [[CCLayer alloc] init];
        [pageOne addChild:easyMenu];
        [pageOne addChild:normalMenu];
        
        // create a blank layer for page 2
        CCLayer *pageTwo = [[CCLayer alloc] init];
        [pageTwo addChild:hardMenu];
        [pageTwo addChild:extremeMenu];
        
        // now create the scroller and pass-in the pages (set widthOffset to 0 for fullscreen pages)
        CCScrollLayer *scroller = [[CCScrollLayer alloc] initWithLayers:[NSMutableArray arrayWithObjects: pageOne,pageTwo,nil] widthOffset: 0];
        
        // finally add the scroller to your scene
        [self addChild:scroller];
        
        //set return and shop
        //set return in the left-down corner

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
        CCSprite *shop = [CCSprite spriteWithSpriteFrameName:@"shop2.png"];
        CCSprite *shop1 = [CCSprite spriteWithSpriteFrameName:@"shop1.png"];
        shop1.scaleX=1.1; //按照像素定制图片宽高
        shop1.scaleY=1.1;
        CCMenuItemSprite *shopItem = [CCMenuItemSprite itemFromNormalSprite:shop 
                                                             selectedSprite:shop1 
                                                                     target:self 
                                                                   selector:@selector(connectGameShop:)];

        shopItem.scaleX=(45)/[shop contentSize].width; //按照像素定制图片宽高
        shopItem.scaleY=(45)/[shop contentSize].height;
        
        
        CCMenu * shopmenu = [CCMenu menuWithItems:shopItem, nil];
        //right corner=screenSize.width-[shop contentSize].width*(shopscale-0.5)
        [shopmenu setPosition:ccp(screenSize.width-[shop contentSize].width*shopItem.scaleX*0.6,
                                  [shop contentSize].height * shopItem.scaleX * 0.5)];
        [self addChild:shopmenu];

        
    }
    return self;
}

+(id)scene
{
    //order = order;
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	LevelScene *levelScene = [LevelScene sceneWithLevelScene];
	
	// add layer as a child to scene
	[scene addChild: levelScene];
    
	return scene;
    
}

+(id)sceneWithLevelScene
{
    return [[[self alloc] initWithLevelScene] autorelease];
}
@end
