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

@implementation PauseLayer

+(id)createPauseLayer:(ccColor4B)color
{
    return [[[PauseLayer alloc] initWithColorLayer:color] autorelease];
}

-(void)returnGame
{
    [[GameMainScene sharedMainScene] resumeGame];
    [self.parent removeChild:self cleanup:YES];
}

-(void)showOption
{
    OptionsScene * gs = [OptionsScene node];
    [[CCDirector sharedDirector]pushScene:gs];
}

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

- (id) initWithColorLayer:(ccColor4B)color{
    if ((self = [super initWithColor:color])) {
		
//		self.isTouchEnabled=YES;
//		
//		CCSprite * paused = [CCSprite spriteWithFile:@"paused.png"];
//		[paused setPosition:ccp(240,160)];
//		[self addChild:paused];
        
        CCLabelTTF *continueLabel=[CCLabelTTF labelWithString:@"continue" fontName:@"Marker Felt" fontSize:30];
        [continueLabel setColor:ccRED];
        CCMenuItemLabel * continueBtn = [CCMenuItemLabel itemWithLabel:continueLabel target:self selector:@selector(returnGame)];
        
        
        CCSprite *play1 = [CCSprite spriteWithSpriteFrameName:@"play2.png"];
        play1.scaleX=(60)/[play1 contentSize].width; //按照像素定制图片宽高是控制像素的。
        play1.scaleY=(60)/[play1 contentSize].height;
        CCSprite *play = [CCSprite spriteWithSpriteFrameName:@"play.png"];
        play.scaleX=(60)/[play contentSize].width; //按照像素定制图片宽高是控制像素的。
        play.scaleY=(60)/[play contentSize].height;
        CCMenuItemSprite *playItem = [CCMenuItemSprite itemFromNormalSprite:play1 
                                                          selectedSprite:play 
                                                                  target:self 
                                                                selector:@selector(returnGame)];
        
//        CCSprite *option = [CCSprite spriteWithSpriteFrameName:@"option.png"];
//        option.scaleX=(60)/[option contentSize].width; //按照像素定制图片宽高是控制像素的。
//        option.scaleY=(60)/[option contentSize].height;
//        CCSprite *option1 = [CCSprite spriteWithSpriteFrameName:@"option.png"];
//        option1.scaleX=(60)/[option1 contentSize].width; //按照像素定制图片宽高是控制像素的。
//        option1.scaleY=(60)/[option1 contentSize].height;
//        CCMenuItemSprite *optionItem = [CCMenuItemSprite itemFromNormalSprite:option 
//                                                             selectedSprite:option1 
//                                                                     target:self 
//                                                                   selector:@selector(showOption)];
        
        
//        CCLabelTTF *returnLabel=[CCLabelTTF labelWithString:@"Main Menu" fontName:@"Marker Felt" fontSize:30];
//        [returnLabel setColor:ccRED];
//        CCMenuItemLabel * returnBtn = [CCMenuItemLabel itemWithLabel:returnLabel target:self selector:@selector(returnMain)];
        
        CCLabelTTF *LevelLabel=[CCLabelTTF labelWithString:@"Level Menu" fontName:@"Marker Felt" fontSize:30];
        [LevelLabel setColor:ccRED];
        CCMenuItemLabel * LevelBtn = [CCMenuItemLabel itemWithLabel:LevelLabel target:self selector:@selector(returnLevel)];
        
        CCMenu * dMenu = [CCMenu menuWithItems:playItem,LevelBtn,nil];
        [dMenu alignItemsVerticallyWithPadding:30];
        [self addChild:dMenu];
    }
    return self;
}


- (void) dealloc
{
	[super dealloc];
}

@end