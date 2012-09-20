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
#import "SimpleAudioEngine.h"

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
    [[GameMainScene sharedMainScene] playAudio:SelectOK];
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
    [[GameMainScene sharedMainScene] playAudio:SelectOK];
	NSUserDefaults *usrDef = [NSUserDefaults standardUserDefaults];
	
	if(sender.selectedIndex ==1)
    {
        int order = [GameMainScene sharedMainScene].sceneNum;
        
        if (order > 0 && order <= 10) 
        {
            [[SimpleAudioEngine sharedEngine] playBackgroundMusic:@"huanqinshort.mp3" loop:YES];
        }
        else if (order > 0 && order <= 15) 
        {
            [[SimpleAudioEngine sharedEngine] playBackgroundMusic:@"morningmusicshort.mp3" loop:YES];
        }
        else if (order > 0 && order <= 18)
        {
            [[SimpleAudioEngine sharedEngine] playBackgroundMusic:@"caribbeanblueshort.mp3" loop:YES];
        }
        else
        {
            [[SimpleAudioEngine sharedEngine] playBackgroundMusic:@"cautiouspathshort.mp3" loop:YES];
            
        }
        
		[usrDef setBool:YES forKey:@"music"];
    }
	if(sender.selectedIndex ==0)
    {
        [[SimpleAudioEngine sharedEngine] stopBackgroundMusic];
		[usrDef setBool:NO forKey:@"music"];
    }
}

-(void)getTeachInfo:(CCMenuItemToggle *)sender
{
    //CCLayer *teachLayer = [[CCLayer node] autorelease];
    
    CGSize screenSize = [[CCDirector sharedDirector] winSize];
    
    CCSprite *nextPic = [CCSprite spriteWithSpriteFrameName:@"playgame1.png"];
    CCSprite *nextPic2 = [CCSprite spriteWithSpriteFrameName:@"playgame1.png"];
    CCSprite *lastPic = [CCSprite spriteWithSpriteFrameName:@"playgame1.png"];
    CCSprite *lastPic2 = [CCSprite spriteWithSpriteFrameName:@"playgame1.png"]; 
    [lastPic setFlipY:YES];//Y轴镜像反转
    [lastPic2 setFlipY:YES];//Y轴镜像反转
    CCSprite *returnBackPic = [CCSprite spriteWithSpriteFrameName:@"returnback.png"];
    CCSprite *returnBackPic2 = [CCSprite spriteWithSpriteFrameName:@"returnback.png"];
    
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
    
    nextMenu.scaleX=(30)/[nextPic contentSize].width; //按照像素定制图片宽高
    nextMenu.scaleY=(30)/[nextPic contentSize].height;
    lastMenu.scaleX=(30)/[lastPic contentSize].width; //按照像素定制图片宽高
    lastMenu.scaleY=(30)/[lastPic contentSize].height;
    returnBackMenu.scaleX=(30)/[returnBackPic contentSize].width; //按照像素定制图片宽高
    returnBackMenu.scaleY=(30)/[returnBackPic contentSize].height;
    

    CCMenu *controlMenu = [CCMenu menuWithItems:lastMenu, nextMenu, returnBackMenu,nil];
    

    
    //change size by diff version
    controlMenu.position = CGPointMake(screenSize.width * 0.5, screenSize.height * 0.5);

    [self addChild:controlMenu z:20 tag:101];
    
    teachPicCount = 0;
    NSString* teachStr = [NSString stringWithFormat:@"teach"];
    NSString* teachPic = [NSString stringWithFormat:@"%@%i.png", teachStr, teachPicCount+1];
    
    teachSprite = [CCSprite spriteWithFile:teachPic];
    teachSprite.position = CGPointMake(screenSize.width * 0.5, screenSize.height * 0.5);
    teachSprite.scaleX=(480)/[teachSprite contentSize].width; //按照像素定制图片宽高
    teachSprite.scaleY=(320)/[teachSprite contentSize].height;
    [self addChild:teachSprite z:1 tag:100];
    
    
    //[self addChild:teachLayer z:1 tag:100];
}

-(void)onNextPic:(CCMenuItemToggle *)sender
{
    teachPicCount++;
    teachPicCount = teachPicCount % 3;
    
    NSString* teachStr = [NSString stringWithFormat:@"teach"];
    NSString* teachPic = [NSString stringWithFormat:@"%@%i.png", teachStr, teachPicCount+1];
    
    teachSprite = [CCSprite spriteWithFile:teachPic];
    
}
-(void)onLastPic:(CCMenuItemToggle *)sender
{
    teachPicCount--;
    teachPicCount = teachPicCount % 3;
    
    NSString* teachStr = [NSString stringWithFormat:@"teach"];
    NSString* teachPic = [NSString stringWithFormat:@"%@%i.png", teachStr, teachPicCount+1];

    teachSprite = [CCSprite spriteWithFile:teachPic];
    
}
-(void)onReturnBackPic:(CCMenuItemToggle *)sender
{
    [self removeChildByTag:(NSInteger)100 cleanup:YES];
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
    [[GameMainScene sharedMainScene] playAudio:SelectOK];
	//start a new game
    [[GameMainScene sharedMainScene] resumeGame];
    [[CCDirector sharedDirector] replaceScene:[LevelScene scene]];
    //播放背景音乐
    NSUserDefaults *usrDef = [NSUserDefaults standardUserDefaults];
    BOOL sound = [usrDef boolForKey:@"music"];
    if (YES == sound) 
    {
        int randomNum = random()%2;
        
        if (0 == randomNum) 
        {
            [[SimpleAudioEngine sharedEngine] playBackgroundMusic:@"destinationshort.mp3" loop:YES];
        }
        else
        {
            [[SimpleAudioEngine sharedEngine] playBackgroundMusic:@"barnbeatshort.mp3" loop:YES];
            
        }
    }
}

-(void)retryGame:(CCMenuItemSprite *)btn
{
    //[[GameMainScene sharedMainScene] playAudio:SelectOK];
    [[GameMainScene sharedMainScene] resumeGame];
    int level=btn.tag;
    [[CCDirector sharedDirector] replaceScene:[LoadingScene sceneWithTargetScene:(TargetScenes)level]];
}

- (id) initWithColorLayer:(ccColor4B)color Level:(int)sceneNum{
    if ((self = [super initWithColor:color])) {
        
//        CCLabelTTF *continueLabel=[CCLabelTTF labelWithString:@"continue" fontName:@"Marker Felt" fontSize:30];
//        [continueLabel setColor:ccRED];
//        CCMenuItemLabel * continueBtn = [CCMenuItemLabel itemWithLabel:continueLabel target:self selector:@selector(returnGame)];
        CGSize screenSize = [[CCDirector sharedDirector] winSize];
        NSString *levelNum = [NSString stringWithFormat:@"Level %d",sceneNum];
        CCLabelTTF *levelLabel=[CCLabelTTF labelWithString:levelNum fontName:@"Marker Felt" fontSize:30];
        
        [levelLabel setPosition:ccp((screenSize.width)*0.5f,(screenSize.height)*5/6)];
        [self addChild:levelLabel];
        
        CCSprite *play1 = [CCSprite spriteWithSpriteFrameName:@"play2.png"];
        //change size by diff version manual
        play1.scaleX=(60)/[play1 contentSize].width; //按照像素定制图片宽高是控制像素的。
        play1.scaleY=(60)/[play1 contentSize].height;
        CCSprite *play = [CCSprite spriteWithSpriteFrameName:@"play.png"];
        play.scaleX=(60)/[play contentSize].width; //按照像素定制图片宽高是控制像素的。
        play.scaleY=(60)/[play contentSize].height;
        CCMenuItemSprite *playItem = [CCMenuItemSprite itemFromNormalSprite:play1 
                                                          selectedSprite:play 
                                                                  target:self 
                                                                selector:@selector(returnGame)];
        CCMenu * playMenu = [CCMenu menuWithItems:playItem,nil];
        [playMenu setPosition:ccp((screenSize.width)*0.5f,(screenSize.height)*4/6)];
        [self addChild:playMenu];
        
        CCSprite *level = [CCSprite spriteWithSpriteFrameName:@"backtonavigation.png"];
        level.scaleX=(40)/[level contentSize].width; //按照像素定制图片宽高是控制像素的。
        level.scaleY=(40)/[level contentSize].height;
        CCSprite *level1 = [CCSprite spriteWithSpriteFrameName:@"backtonavigation.png"];
        level1.scaleX=(40)/[level1 contentSize].width; //按照像素定制图片宽高是控制像素的。
        level1.scaleY=(40)/[level1 contentSize].height;
        CCMenuItemSprite *levelItem = [CCMenuItemSprite itemFromNormalSprite:level 
                                                             selectedSprite:level1 
                                                                     target:self 
                                                                   selector:@selector(returnLevel)];
        CCMenu * levelMenu = [CCMenu menuWithItems:levelItem,nil];
        [levelMenu setPosition:ccp((screenSize.width)*0.5f,(screenSize.height)*2/6)];
        [self addChild:levelMenu];
        
        
//        CCLabelTTF *returnLabel=[CCLabelTTF labelWithString:@"Main Menu" fontName:@"Marker Felt" fontSize:30];
//        [returnLabel setColor:ccRED];
//        CCMenuItemLabel * returnBtn = [CCMenuItemLabel itemWithLabel:returnLabel target:self selector:@selector(returnMain)];
        
//        CCLabelTTF *LevelLabel=[CCLabelTTF labelWithString:@"Level Menu" fontName:@"Marker Felt" fontSize:30];
//        [LevelLabel setColor:ccRED];
//        CCMenuItemLabel * LevelBtn = [CCMenuItemLabel itemWithLabel:LevelLabel target:self selector:@selector(returnLevel)];
        
        CCSprite *soundoff = [CCSprite spriteWithSpriteFrameName:@"music.png"];
        soundoff.scaleX=(40)/[soundoff contentSize].width; //按照像素定制图片宽高是控制像素的。
        soundoff.scaleY=(40)/[soundoff contentSize].height;
        CCSprite *soundon = [CCSprite spriteWithSpriteFrameName:@"music2.png"];
        soundon.scaleX=(40)/[soundon contentSize].width; //按照像素定制图片宽高是控制像素的。
        soundon.scaleY=(40)/[soundon contentSize].height;
        
        CCSprite *soundoff1 = [CCSprite spriteWithSpriteFrameName:@"music.png"];
        soundoff1.scaleX=(40)/[soundoff1 contentSize].width; //按照像素定制图片宽高是控制像素的。
        soundoff1.scaleY=(40)/[soundoff1 contentSize].height;
        CCSprite *soundon1 = [CCSprite spriteWithSpriteFrameName:@"music2.png"];
        soundon1.scaleX=(40)/[soundon1 contentSize].width; //按照像素定制图片宽高是控制像素的。
        soundon1.scaleY=(40)/[soundon1 contentSize].height;
        
        
        
        CCMenuItemSprite *unchecked=[CCMenuItemSprite itemFromNormalSprite:soundoff selectedSprite:soundon];
        CCMenuItemSprite *checked=[CCMenuItemSprite itemFromNormalSprite:soundon1 selectedSprite:soundoff1];
        
//        CCMenuItemImage * unchecked2 = [CCMenuItemImage itemFromNormalImage:@"options_check.png"
//                                                              selectedImage:@"options_check_d.png"];
//		
//		CCMenuItemImage * checked2 = [CCMenuItemImage itemFromNormalImage:@"options_check_d.png"
//                                                            selectedImage:@"options_check.png" ];
		
		CCMenuItemToggle * sound = [CCMenuItemToggle itemWithTarget:self selector:@selector(changeSound:) items:checked,unchecked,nil];
        CCMenu * soundMenu = [CCMenu menuWithItems:sound,nil];
        [soundMenu setPosition:ccp((screenSize.width)*0.3f,(screenSize.height)*2/6)];
        [self addChild:soundMenu];
        NSUserDefaults *usrDef = [NSUserDefaults standardUserDefaults];
		if([usrDef boolForKey:@"sound"] == YES)
			sound.selectedIndex = 1;
        
        
        CCSprite *musicoff = [CCSprite spriteWithSpriteFrameName:@"sound.png"];
        musicoff.scaleX=(40)/[soundoff contentSize].width; //按照像素定制图片宽高是控制像素的。
        musicoff.scaleY=(40)/[soundoff contentSize].height;
        CCSprite *musicon = [CCSprite spriteWithSpriteFrameName:@"sound2.png"];
        musicon.scaleX=(40)/[soundon contentSize].width; //按照像素定制图片宽高是控制像素的。
        musicon.scaleY=(40)/[soundon contentSize].height;
        
        CCSprite *musicoff1 = [CCSprite spriteWithSpriteFrameName:@"sound.png"];
        musicoff1.scaleX=(40)/[soundoff1 contentSize].width; //按照像素定制图片宽高是控制像素的。
        musicoff1.scaleY=(40)/[soundoff1 contentSize].height;
        CCSprite *musicon1 = [CCSprite spriteWithSpriteFrameName:@"sound2.png"];
        musicon1.scaleX=(40)/[soundon1 contentSize].width; //按照像素定制图片宽高是控制像素的。
        musicon1.scaleY=(40)/[soundon1 contentSize].height;
        
        
        
        CCMenuItemSprite *uncheckedmusic=[CCMenuItemSprite itemFromNormalSprite:musicoff selectedSprite:musicon];
        CCMenuItemSprite *checkedmusic=[CCMenuItemSprite itemFromNormalSprite:musicon1 selectedSprite:musicoff1];
		
		CCMenuItemToggle * music = [CCMenuItemToggle itemWithTarget:self selector:@selector(changeMusic:) items:checkedmusic,uncheckedmusic,nil];
        CCMenu * musicMenu = [CCMenu menuWithItems:music,nil];
        [musicMenu setPosition:ccp((screenSize.width)*0.3f,(screenSize.height)*4/7)];
        [self addChild:musicMenu];
        //NSUserDefaults *usrDef = [NSUserDefaults standardUserDefaults];
		if([usrDef boolForKey:@"music"] == YES)
			music.selectedIndex = 1;
        
        //retry
        //change size by diff version manual
        CCSprite *retry = [CCSprite spriteWithSpriteFrameName:@"retry.png"];
        retry.scaleX=(40)/[retry contentSize].width; //按照像素定制图片宽高是控制像素的。
        retry.scaleY=(40)/[retry contentSize].height;
        CCSprite *retry1 = [CCSprite spriteWithSpriteFrameName:@"retry.png"];
        retry1.scaleX=(40)/[retry1 contentSize].width; //按照像素定制图片宽高是控制像素的。
        retry1.scaleY=(40)/[retry1 contentSize].height;
        CCMenuItemSprite *retryItem = [CCMenuItemSprite itemFromNormalSprite:retry 
                                                              selectedSprite:retry1 
                                                                      target:self 
                                                                    selector:@selector(retryGame:)];
        [retryItem setTag:sceneNum];
        CCMenu * retryMenu = [CCMenu menuWithItems:retryItem,nil];
        [retryMenu setPosition:ccp((screenSize.width)*0.7f,(screenSize.height)*2/6)];
        
    
        //dMenu.anchorPoint=CGPointMake(0, 0);
        //[dMenu setPosition:ccp((screenSize.width)*0.5f,(screenSize.height)*4/6)];
        //[dMenu alignItemsHorizontallyWithPadding:30];
        [self addChild:retryMenu];
        
        CCSprite *info = [CCSprite spriteWithSpriteFrameName:@"info.png"];
        CCSprite *info2 = [CCSprite spriteWithSpriteFrameName:@"info.png"];
                
        CCMenuItemSprite *infoMenu = [CCMenuItemSprite itemFromNormalSprite:info 
                                                             selectedSprite:info2 
                                                                     target:self 
                                                                   selector:@selector(getTeachInfo:)];
        infoMenu.scaleX=(40)/[info contentSize].width; //按照像素定制图片宽高是控制像素的。
        infoMenu.scaleY=(40)/[info contentSize].height;

        CCMenu *menu = [CCMenu menuWithItems: infoMenu, nil];
        [menu setPosition:ccp(screenSize.width * 0.8 , screenSize.height * 0.8)];
        
        [self addChild:menu];
    }
    return self;
}


- (void) dealloc
{
	[super dealloc];
}

@end