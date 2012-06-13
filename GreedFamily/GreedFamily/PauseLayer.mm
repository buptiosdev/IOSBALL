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

-(void)returnMain
{
	//start a new game
    [[GameMainScene sharedMainScene] resumeGame];
    [[CCDirector sharedDirector] replaceScene:[NavigationScene scene]];
}

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
        
        CCLabelTTF *returnLabel=[CCLabelTTF labelWithString:@"Main Menu" fontName:@"Marker Felt" fontSize:30];
        [returnLabel setColor:ccRED];
        CCMenuItemLabel * returnBtn = [CCMenuItemLabel itemWithLabel:returnLabel target:self selector:@selector(returnMain)];
        
        CCLabelTTF *LevelLabel=[CCLabelTTF labelWithString:@"Level Menu" fontName:@"Marker Felt" fontSize:30];
        [LevelLabel setColor:ccRED];
        CCMenuItemLabel * LevelBtn = [CCMenuItemLabel itemWithLabel:LevelLabel target:self selector:@selector(returnLevel)];
        
        CCMenu * dMenu = [CCMenu menuWithItems:continueBtn,returnBtn,LevelBtn,nil];
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