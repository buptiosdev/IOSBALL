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

@implementation PauseLayer

+(id)createPauseLayer:(ccColor4B)color Level:(int)sceneNum
{
    return [[[PauseLayer alloc] initWithColorLayer:color Level:(int)sceneNum] autorelease];
}

-(void)returnGame
{
    [[GameMainScene sharedMainScene] resumeGame];
    [self.parent removeChild:self cleanup:YES];
}

-(void)changeSound:(CCMenuItemToggle *)sender
{
	NSUserDefaults *usrDef = [NSUserDefaults standardUserDefaults];
	
	if(sender.selectedIndex ==1)
		[usrDef setBool:YES forKey:@"sound"];
	if(sender.selectedIndex ==0)
		[usrDef setBool:NO forKey:@"sound"];
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
	//start a new game
    [[GameMainScene sharedMainScene] resumeGame];
    [[CCDirector sharedDirector] replaceScene:[LevelScene scene]];
}

-(void)retryGame:(CCMenuItemSprite *)btn
{
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
        //[playItem setPosition:ccp((screenSize.width)*0.5f,(screenSize.height)*4/6)];
        
        CCSprite *level = [CCSprite spriteWithSpriteFrameName:@"backtonavigation.png"];
        //change size by diff version manual
        level.scaleX=(60)/[level contentSize].width; //按照像素定制图片宽高是控制像素的。
        level.scaleY=(60)/[level contentSize].height;
        CCSprite *level1 = [CCSprite spriteWithSpriteFrameName:@"backtonavigation.png"];
        //change size by diff version manual
        level1.scaleX=(60)/[level1 contentSize].width; //按照像素定制图片宽高是控制像素的。
        level1.scaleY=(60)/[level1 contentSize].height;
        CCMenuItemSprite *levelItem = [CCMenuItemSprite itemFromNormalSprite:level 
                                                             selectedSprite:level1 
                                                                     target:self 
                                                                   selector:@selector(returnLevel)];
        //[levelItem setPosition:ccp((screenSize.width)*0.5f,(screenSize.height)*2/6)];
        
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
        //[sound setPosition:ccp((screenSize.width)*0.3f,(screenSize.height)*2/6)];
        
        NSUserDefaults *usrDef = [NSUserDefaults standardUserDefaults];
		if([usrDef boolForKey:@"sound"] == YES)
			sound.selectedIndex = 1;
        
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
        //[retryItem setPosition:ccp((screenSize.width)*0.7f,(screenSize.height)*2/6)];
        
        CCMenu * dMenu = [CCMenu menuWithItems:playItem,levelItem,sound,retryItem,nil];
        //[dMenu setPosition:ccp((screenSize.width)*0.5f,(screenSize.height)*4/6)];
        [dMenu alignItemsHorizontallyWithPadding:30];
        [self addChild:dMenu];
    }
    return self;
}


- (void) dealloc
{
	[super dealloc];
}

@end