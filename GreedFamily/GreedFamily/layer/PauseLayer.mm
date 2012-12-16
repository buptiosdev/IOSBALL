//
//  PauseLayer.m
//  AerialGun
//
//  Created by Pablo Ruiz on 6/7/10.
//  Copyright 2010 Infinix Software. All rights reserved.
//

#import "PauseLayer.h"
#import "GameMainScene.h"
#import "NavigationScene.h"
#import "LevelScene.h"
#import "OptionsScene.h"
#import "LoadingScene.h"
#import "CDAudioManager.h"
#import "CommonLayer.h"


//BEGIN item scale  默认为相对于X的比例
float pauselabelscale=40.0/480;
float pauseplayscale=60.0/480;
//END


@implementation PauseLayer

+(id)createPauseLayer:(ccColor4B)color Level:(int)sceneNum
{
    return [[[PauseLayer alloc] initWithColorLayer:color Level:(int)sceneNum] autorelease];
}

-(void)returnGame
{
    //[[GameMainScene sharedMainScene] playAudio:SelectOK];
    [[GameMainScene sharedMainScene] resumeGame];
    [self.parent removeChild:self cleanup:YES];
}

-(void)changeSound:(CCMenuItemToggle *)sender
{
    [CommonLayer playAudio:SelectOK];
	NSUserDefaults *usrDef = [NSUserDefaults standardUserDefaults];
	
	if(sender.selectedIndex ==1){
        [usrDef setBool:YES forKey:@"sound"];
        //[CDAudioManager sharedManager].mute=NO;
    }
		
	if(sender.selectedIndex ==0){
        [usrDef setBool:NO forKey:@"sound"];
    }
		
}

-(void)changeMusic:(CCMenuItemToggle *)sender
{
    [CommonLayer playAudio:SelectOK];
	NSUserDefaults *usrDef = [NSUserDefaults standardUserDefaults];
	
	if(sender.selectedIndex ==1)
    {
        [usrDef setBool:YES forKey:@"music"];
        int order = [GameMainScene sharedMainScene].sceneNum;
        
        if (order > 0 && order <= 10) 
        {
            [CommonLayer playBackMusic:GameMusic2];
        }
        else 
        {
            [CommonLayer playBackMusic:GameMusic1];
        }
    }
	if(sender.selectedIndex ==0)
    {
        [usrDef setBool:NO forKey:@"music"];
        [CommonLayer playBackMusic:StopGameMusic];  

    }
}

-(void)getTeachInfo:(CCMenuItemToggle *)sender
{
    //CCLayer *teachLayer = [[CCLayer node] autorelease];
    
    [infoMenu setIsEnabled:NO];
    
    CGSize screenSize = [[CCDirector sharedDirector] winSize];
    
    CCSprite *nextPic = [CCSprite spriteWithSpriteFrameName:@"playgame1.png"];
    CCSprite *nextPic2 = [CCSprite spriteWithSpriteFrameName:@"playgame1.png"];
    nextPic2.scaleX = 1.1;
    nextPic2.scaleY = 1.1;
    CCSprite *lastPic = [CCSprite spriteWithSpriteFrameName:@"playgame1.png"];
    CCSprite *lastPic2 = [CCSprite spriteWithSpriteFrameName:@"playgame1.png"]; 
    lastPic2.scaleX = 1.1;
    lastPic2.scaleY = 1.1;
    [lastPic setFlipX:YES];//Y轴镜像反转
    [lastPic2 setFlipX:YES];//Y轴镜像反转
    CCSprite *returnBackPic = [CCSprite spriteWithSpriteFrameName:@"close.png"];
    CCSprite *returnBackPic2 = [CCSprite spriteWithSpriteFrameName:@"close.png"];
    returnBackPic2.scaleX = 1.1;
    returnBackPic2.scaleY = 1.1;
    
    CCMenuItemSprite *nextMenu = [CCMenuItemSprite itemFromNormalSprite:nextPic 
                                              selectedSprite:nextPic2 
                                                      target:self 
                                                    selector:@selector(onNextPic:)];
    CCMenuItemSprite *lastMenu = [CCMenuItemSprite itemFromNormalSprite:lastPic 
                                                         selectedSprite:lastPic2 
                                                                 target:self 
                                                               selector:@selector(onLastPic:)];
    CCMenuItemSprite *returnBackMenu = [CCMenuItemSprite itemFromNormalSprite:returnBackPic 
                                                         selectedSprite:returnBackPic2 
                                                                 target:self 
                                                               selector:@selector(onReturnBackPic:)];
    
    nextMenu.scale=screenSize.width*pauselabelscale/[nextPic contentSize].width; //按照像素定制图片宽高
    lastMenu.scale=screenSize.width*pauselabelscale/[lastPic contentSize].width; //按照像素定制图片宽高
    returnBackMenu.scale=screenSize.width*pauselabelscale/[returnBackPic contentSize].width; //按照像素定制图片宽高
    

    CCMenu *controlMenu = [CCMenu menuWithItems:lastMenu, nextMenu, returnBackMenu,nil];
    
    [controlMenu alignItemsVerticallyWithPadding:20];
    //change size by diff version
    controlMenu.position = CGPointMake(screenSize.width * 0.9, screenSize.height * 0.4);

    [self addChild:controlMenu z:20 tag:100];
    
    teachPicCount = 0;
    NSString* teachStr = [NSString stringWithFormat:@"teach"];
    NSString* teachPic = [NSString stringWithFormat:@"%@%i.png", teachStr, teachPicCount+1];
    
    teachSprite = [CCSprite spriteWithFile:teachPic];
    teachSprite.position = CGPointMake(screenSize.width * 0.5, screenSize.height * 0.5);
    teachSprite.scaleX=(screenSize.width)/[teachSprite contentSize].width; //按照像素定制图片宽高
    teachSprite.scaleY=(screenSize.height)/[teachSprite contentSize].height;
    [self addChild:teachSprite z:2 tag:101];
    
    //[self addChild:teachLayer z:1 tag:100];
}

-(void)onNextPic:(CCMenuItemToggle *)sender
{
    [self removeChildByTag:(NSInteger)101 cleanup:YES];
    teachPicCount++;
    teachPicCount = teachPicCount % 3;
    CGSize screenSize = [[CCDirector sharedDirector] winSize];
    NSString* teachStr = [NSString stringWithFormat:@"teach"];
    NSString* teachPic = [NSString stringWithFormat:@"%@%i.png", teachStr, teachPicCount+1];
//    CGSize screenSize = [[CCDirector sharedDirector] winSize];
    teachSprite = [CCSprite spriteWithFile:teachPic];
    teachSprite.position = CGPointMake(screenSize.width * 0.5, screenSize.height * 0.5);
    teachSprite.scaleX=(screenSize.width)/[teachSprite contentSize].width; //按照像素定制图片宽高
    teachSprite.scaleY=(screenSize.height)/[teachSprite contentSize].height;
    
    [self addChild:teachSprite z:20 tag:101];
}

-(void)onLastPic:(CCMenuItemToggle *)sender
{
    [self removeChildByTag:(NSInteger)101 cleanup:YES];
//    CGSize screenSize = [[CCDirector sharedDirector] winSize];
    teachPicCount--;
    if (teachPicCount == -1)
    {
        teachPicCount = 2;
    }
    
    teachPicCount = teachPicCount % 3;
    
    NSString* teachStr = [NSString stringWithFormat:@"teach"];
    NSString* teachPic = [NSString stringWithFormat:@"%@%i.png", teachStr, teachPicCount+1];
    CGSize screenSize = [[CCDirector sharedDirector] winSize];
    teachSprite = [CCSprite spriteWithFile:teachPic];
    teachSprite.position = CGPointMake(screenSize.width * 0.5, screenSize.height * 0.5);
    teachSprite.scaleX=(screenSize.width)/[teachSprite contentSize].width; //按照像素定制图片宽高
    teachSprite.scaleY=(screenSize.height)/[teachSprite contentSize].height;

    [self addChild:teachSprite z:20 tag:101];
    
}

-(void)onReturnBackPic:(CCMenuItemToggle *)sender
{
    [infoMenu setIsEnabled:YES];
    [self removeChildByTag:(NSInteger)100 cleanup:YES];
    [self removeChildByTag:(NSInteger)101 cleanup:YES];
}


//-(void)showOption
//{
//    OptionsScene * gs = [OptionsScene node];
//    [[CCDirector sharedDirector]pushScene:gs];
//}

//-(void)returnMain
//{
//	//start a new game
//    [[GameMainScene sharedMainScene] resumeGame];
//    [[CCDirector sharedDirector] replaceScene:[NavigationScene scene]];
//}

-(void)returnLevel
{
    [CommonLayer playAudio:SelectOK];
	//start a new game
    [[GameMainScene sharedMainScene] resumeGame];
    [[CCDirector sharedDirector] replaceScene:[LevelScene scene]];
    //播放背景音乐
    NSUserDefaults *usrDef = [NSUserDefaults standardUserDefaults];
    BOOL sound = [usrDef boolForKey:@"music"];
    if (YES == sound) 
    {
        [CommonLayer playBackMusic:UnGameMusic1];
//        int randomNum = random()%2;
//        
//        if (0 == randomNum) 
//        {
////            [[SimpleAudioEngine sharedEngine] playBackgroundMusic:@"destinationshort.mp3" loop:YES];
//            [CommonLayer playBackMusic:UnGameMusic1];
//        }
//        else
//        {
////            [[SimpleAudioEngine sharedEngine] playBackgroundMusic:@"barnbeatshort.mp3" loop:YES];
//            [CommonLayer playBackMusic:UnGameMusic2];
//            
//        }
    }
    
}

-(void)retryGame:(CCMenuItemSprite *)btn
{
    [CommonLayer playAudio:SelectOK];
    [[GameMainScene sharedMainScene] resumeGame];
    int level=btn.tag;
    [[CCDirector sharedDirector] replaceScene:[LoadingScene sceneWithTargetScene:(TargetScenes)level]];
}

- (id) initWithColorLayer:(ccColor4B)color Level:(int)sceneNum{
    if ((self = [super initWithColor:color])) {
        
        CGSize screenSize = [[CCDirector sharedDirector] winSize];
        NSString *levelNum = [NSString stringWithFormat:@"LeveL-%d",sceneNum];
        //CCLabelTTF *levelLabel=[CCLabelTTF labelWithString:levelNum fontName:@"Zapfino" fontSize:25];
        CCLabelTTF *levelLabel=[CCLabelTTF labelWithString:levelNum fontName:@"Dekers_Bold" fontSize:30];
        [levelLabel setColor:ccYELLOW];
        [levelLabel setPosition:ccp((screenSize.width)*0.5f,(screenSize.height)* 0.8)];
        [self addChild:levelLabel];
        
        
        //play
        CCSprite *play1 = [CCSprite spriteWithSpriteFrameName:@"play2.png"];
        //change size by diff version manual
        CCSprite *play = [CCSprite spriteWithSpriteFrameName:@"play.png"];
        CCMenuItemSprite *playItem = [CCMenuItemSprite itemFromNormalSprite:play1 
                                                          selectedSprite:play 
                                                                  target:self 
                                                                selector:@selector(returnGame)];
        playItem.scale=screenSize.width*pauseplayscale/[play contentSize].width; //按照像素定制图片宽高是控制像素的。
        CCMenu * playMenu = [CCMenu menuWithItems:playItem,nil];
        [playMenu setPosition:ccp((screenSize.width)*0.5f,(screenSize.height) * 0.6)];
        [self addChild:playMenu];
    
        //level
        CCSprite *level = [CCSprite spriteWithSpriteFrameName:@"backtonavigation.png"];
        CCSprite *level1 = [CCSprite spriteWithSpriteFrameName:@"backtonavigation.png"];
        level1.scaleX=1.1; //按照像素定制图片宽高是控制像素的。
        level1.scaleY=1.1;
        CCMenuItemSprite *levelItem = [CCMenuItemSprite itemFromNormalSprite:level 
                                                             selectedSprite:level1 
                                                                     target:self 
                                                                   selector:@selector(returnLevel)];
        levelItem.scale=screenSize.width*pauselabelscale/[level contentSize].width; //按照像素定制图片宽高是控制像素的。
//        CCMenu * levelMenu = [CCMenu menuWithItems:levelItem,nil];
//        [levelMenu setPosition:ccp((screenSize.width)*0.5f, (screenSize.height) * 0.3)];
//        [self addChild:levelMenu];
        
        
        //sound
        CCSprite *soundoff = [CCSprite spriteWithSpriteFrameName:@"music.png"];
        CCSprite *soundon = [CCSprite spriteWithSpriteFrameName:@"music2.png"];
        CCSprite *soundoff1 = [CCSprite spriteWithSpriteFrameName:@"music.png"];
        CCSprite *soundon1 = [CCSprite spriteWithSpriteFrameName:@"music2.png"];
        
        CCMenuItemSprite *unchecked=[CCMenuItemSprite itemFromNormalSprite:soundoff selectedSprite:soundon];
        CCMenuItemSprite *checked=[CCMenuItemSprite itemFromNormalSprite:soundon1 selectedSprite:soundoff1];
        CCMenuItemToggle * sound = [CCMenuItemToggle itemWithTarget:self selector:@selector(changeSound:) items:checked,unchecked,nil];
        sound.scale=screenSize.width*pauselabelscale/[soundoff contentSize].width; //按照像素定制图片宽高是控制像素的。
        
//        CCMenu * soundMenu = [CCMenu menuWithItems:sound,nil];
//        [soundMenu setPosition:ccp((screenSize.width)/6,(screenSize.height)* 0.3)];
//        [self addChild:soundMenu];
        NSUserDefaults *usrDef = [NSUserDefaults standardUserDefaults];
		if([usrDef boolForKey:@"sound"] == YES)
			sound.selectedIndex = 1;
        
        
        //music
        CCSprite *musicoff = [CCSprite spriteWithSpriteFrameName:@"sound.png"];
        CCSprite *musicon = [CCSprite spriteWithSpriteFrameName:@"sound2.png"];
        CCSprite *musicoff1 = [CCSprite spriteWithSpriteFrameName:@"sound.png"];
        CCSprite *musicon1 = [CCSprite spriteWithSpriteFrameName:@"sound2.png"];
        
        CCMenuItemSprite *uncheckedmusic=[CCMenuItemSprite itemFromNormalSprite:musicoff selectedSprite:musicon];
        CCMenuItemSprite *checkedmusic=[CCMenuItemSprite itemFromNormalSprite:musicon1 selectedSprite:musicoff1];
		CCMenuItemToggle * music = [CCMenuItemToggle itemWithTarget:self selector:@selector(changeMusic:) items:checkedmusic,uncheckedmusic,nil];
        music.scale=screenSize.width*pauselabelscale/[soundoff contentSize].width; //按照像素定制图片宽高是控制像素的。
        
//        CCMenu * musicMenu = [CCMenu menuWithItems:music,nil];
//        [musicMenu setPosition:ccp((screenSize.width)/3,(screenSize.height)*0.3)];
//        [self addChild:musicMenu];
        //NSUserDefaults *usrDef = [NSUserDefaults standardUserDefaults];
		if([usrDef boolForKey:@"music"] == YES)
			music.selectedIndex = 1;
        
        //retry
        //change size by diff version manual  
        //change scale by zyj
        CCSprite *retry = [CCSprite spriteWithSpriteFrameName:@"retry.png"];
        CCSprite *retry1 = [CCSprite spriteWithSpriteFrameName:@"retry.png"];
        retry1.scaleX= 1.1;//按照像素定制图片宽高是控制像素的。
        retry1.scaleY= 1.1;
        CCMenuItemSprite *retryItem = [CCMenuItemSprite itemFromNormalSprite:retry 
                                                              selectedSprite:retry1 
                                                                      target:self 
                                                                    selector:@selector(retryGame:)];
        retryItem.scale = screenSize.width*pauselabelscale/[retry contentSize].width;
        [retryItem setTag:sceneNum];
//        CCMenu * retryMenu = [CCMenu menuWithItems:retryItem,nil];
//        [retryMenu setPosition:ccp((screenSize.width)*0.7f,(screenSize.height)* 0.3)];
//        [self addChild:retryMenu];
        
        CCMenu * allmenu = [CCMenu menuWithItems:levelItem,sound,music,retryItem, nil];
        [allmenu setPosition:ccp((screenSize.width)*0.5f,(screenSize.height)* 0.3)];
        [allmenu alignItemsHorizontallyWithPadding:screenSize.width*pauselabelscale];
        [self addChild:allmenu];
        
        
        //teach
        CCSprite *info = [CCSprite spriteWithSpriteFrameName:@"teach.png"];
        CCSprite *info2 = [CCSprite spriteWithSpriteFrameName:@"teach.png"];
        info2.scaleX = 1.1;
        info2.scaleY = 1.1;
        infoMenu = [CCMenuItemSprite itemFromNormalSprite:info 
                                                             selectedSprite:info2 
                                                                     target:self 
                                                                   selector:@selector(getTeachInfo:)];
        infoMenu.scale=screenSize.width*pauselabelscale/[info contentSize].width; //按照像素定制图片宽高是控制像素的。

        CCMenu *menu = [CCMenu menuWithItems: infoMenu, nil];
        [menu setPosition:ccp(screenSize.width * 0.9 , screenSize.height * 0.8)];
        
        [self addChild:menu];
    }
    return self;
}


- (void) dealloc
{
	[super dealloc];
}

@end