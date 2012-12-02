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
#import "CCAnimationHelper.h"
#import "CommonLayer.h"

//BEGIN item scale  默认为相对于X的比例
float levelstarscale=75.0/480;
float levelfontscaleY=50.0/320;
int levelfontsize=50;
float levelsnakescaleY=65.0/320;
float levelspeedscale=0.4/480;

float levelreturnscaleY=0.13;
//END



@implementation LevelScene
CCSprite* sprite;
int directionCurrent;

-(void)selectMode:(CCMenuItemImage *)btn
{
	int mode = btn.tag;
    [CommonLayer playAudio:SelectOK];
    [[CCDirector sharedDirector] replaceScene:[LoadingScene sceneWithTargetScene:(TargetScenes)mode]];
}

-(void)returnMain
{
    [CommonLayer playAudio:SelectOK];
    [[CCDirector sharedDirector] replaceScene:[RoleScene scene]];
}

-(void)connectGameShop:(id)sender
{
    //connect to game center
    [CommonLayer playAudio:SelectOK];
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
        float viewsize=screenSize.width*levelstarscale;
        
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
            CCLabelTTF *Labelnum=[CCLabelTTF labelWithString:[NSString stringWithFormat:@"%i", i+1] fontName:@"Marker Felt" fontSize:levelfontsize];
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
            CCLabelTTF *Labelnum1=[CCLabelTTF labelWithString:[NSString stringWithFormat:@"%i", i+1] fontName:@"Marker Felt" fontSize:levelfontsize];
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
            level.scale=(viewsize)/[defaultstar contentSize].width;
            [level setTag:i+1];
            
            if(isZero==YES)
            {
                [level setIsEnabled:NO];
            }
            else
            {
                [level setIsEnabled:YES];
                [Labelnum setColor:ccWHITE];
                [Labelnum1 setColor:ccRED];
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
        
        float levelpadding=(screenSize.width-viewsize*5)/6;
        float horizon=0;
        
        CCMenu * easyMenu = [CCMenu menuWithItems:[levelarray objectAtIndex:0],[levelarray objectAtIndex:1],[levelarray objectAtIndex:2],[levelarray objectAtIndex:3],[levelarray objectAtIndex:4],nil];
        [easyMenu alignItemsHorizontallyWithPadding:levelpadding];
        [easyMenu setPosition:ccp((screenSize.width)*0.5f+horizon,(screenSize.height)*0.8)];
        
        CCMenu * normalMenu = [CCMenu menuWithItems:[levelarray objectAtIndex:5],[levelarray objectAtIndex:6],[levelarray objectAtIndex:7],[levelarray objectAtIndex:8],[levelarray objectAtIndex:9], nil];
        [normalMenu alignItemsHorizontallyWithPadding:levelpadding];
        [normalMenu setPosition:ccp((screenSize.width)*0.5f+horizon,(screenSize.height)*0.45)];
        
        CCMenu * hardMenu = [CCMenu menuWithItems:[levelarray objectAtIndex:10],[levelarray objectAtIndex:11],[levelarray objectAtIndex:12],[levelarray objectAtIndex:13],[levelarray objectAtIndex:14], nil];
        [hardMenu alignItemsHorizontallyWithPadding:levelpadding];
        [hardMenu setPosition:ccp((screenSize.width)*0.5f+horizon,(screenSize.height)*0.8)];
        
        CCMenu * extremeMenu = [CCMenu menuWithItems:[levelarray objectAtIndex:15],[levelarray objectAtIndex:16],[levelarray objectAtIndex:17],[levelarray objectAtIndex:18],[levelarray objectAtIndex:19], nil];
        [extremeMenu alignItemsHorizontallyWithPadding:levelpadding];
        [extremeMenu setPosition:ccp((screenSize.width)*0.5f+horizon,(screenSize.height)*0.45)];
        
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
        returnBtn1.scale=1.1;
        CCMenuItemSprite *returnItem = [CCMenuItemSprite itemFromNormalSprite:returnBtn 
                                                               selectedSprite:returnBtn1 
                                                                       target:self 
                                                                     selector:@selector(returnMain)];
        returnItem.scale=(screenSize.height*levelreturnscaleY)/[returnBtn contentSize].height;
        CCMenu * returnmenu = [CCMenu menuWithItems:returnItem, nil];
        [returnmenu setPosition:ccp([returnBtn contentSize].width * returnItem.scaleX * 0.5,
                                    [returnBtn contentSize].height * returnItem.scaleY * 0.5)];
        [self addChild:returnmenu];
        
        //set shop in the right-down corner
        CCSprite *shop = [CCSprite spriteWithSpriteFrameName:@"shop2.png"];
        CCSprite *shop1 = [CCSprite spriteWithSpriteFrameName:@"shop1.png"];
        shop1.scale=1.1; //按照像素定制图片宽高
        CCMenuItemSprite *shopItem = [CCMenuItemSprite itemFromNormalSprite:shop 
                                                             selectedSprite:shop1 
                                                                     target:self 
                                                                   selector:@selector(connectGameShop:)];

        shopItem.scale=(screenSize.height*levelreturnscaleY)/[shop contentSize].height;
        
        
        CCMenu * shopmenu = [CCMenu menuWithItems:shopItem, nil];
        //right corner=screenSize.width-[shop contentSize].width*(shopscale-0.5)
        [shopmenu setPosition:ccp(screenSize.width-[shop contentSize].width*shopItem.scaleX*0.6,
                                  [shop contentSize].height * shopItem.scaleX * 0.5)];
        [self addChild:shopmenu];

        //add the snake
        sprite= [CCSprite spriteWithSpriteFrameName:@"snake_9_1.png"];
        //按照像素设定图片大小
        sprite.scale=(screenSize.height*levelsnakescaleY)/[sprite contentSize].height;
        CGPoint startPos = CGPointMake((screenSize.width) * 0.8f, screenSize.height*levelreturnscaleY+screenSize.height*levelsnakescaleY*2/5);
        sprite.position = startPos;
        CCAnimation* animation = [CCAnimation animationWithFrame:@"snake_9_" frameCount:4 delay:0.2f];
        
        CCAnimate *animate = [CCAnimate actionWithAnimation:animation restoreOriginalFrame:NO];
        CCSequence *seq = [CCSequence actions: animate,nil];
        
        CCAction *moveAction = [CCRepeatForever actionWithAction: seq ];
        [sprite runAction:moveAction];
        directionCurrent=-1;
        [self addChild:sprite]; 
        [self scheduleUpdate];
        
    }
    return self;
}

-(void)update:(ccTime)delta
{
    CGPoint pos=sprite.position;
    CGSize screenSize = [[CCDirector sharedDirector] winSize];
    float imageWidthHalved = [sprite contentSize].width * sprite.scaleX * 0.5f; 
    float leftBorderLimit = imageWidthHalved;
    float rightBorderLimit = screenSize.width - imageWidthHalved;
    
    if(pos.x>rightBorderLimit){
        directionCurrent = -1;
        [sprite setFlipX:NO];
    }else if(pos.x<leftBorderLimit)
    {
        directionCurrent = 1;
        [sprite setFlipX:YES];
    }
    
    pos.x+=directionCurrent*levelspeedscale*screenSize.width;
    sprite.position=pos;
    return;
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
