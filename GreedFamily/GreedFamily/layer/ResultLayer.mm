//
//  ResultLayer.m
//  GreedFamily
//
//  Created by MagicStudio on 12-6-20.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import "ResultLayer.h"
#import "LevelScene.h"
#import "LoadingScene.h"
#import "GameBackgroundLayer.h"
#import "SimpleAudioEngine.h"
#import "GameMainScene.h"
// 该类在GameMainScene中关卡结束时被调用，用于显示分数／关卡等信息
// 使用方法参见 GameMainScene:pauseGame中注释的部分
// 可供测试使用，点击暂停按钮，即可进行测试


@interface ResultLayer (PrivateMethods)
-(id) initWithResult:(int)level Score:(int)score AddScore:(int)addscore StarNum:(int)starnum Newrecord:(int)isnewrecord;
@end

@implementation ResultLayer

+(id)createResultLayer:(int)level Score:(int)score AddScore:(int)addscore  StarNum:(int)starnum Newrecord:(int)isnewrecord
{
    return [[[ResultLayer alloc] initWithResult:level Score:score AddScore:addscore StarNum:starnum Newrecord:isnewrecord] autorelease];
}

-(void)chooseLevel:(CCMenuItemImage *)btn
{
    int level=btn.tag;
    [[CCDirector sharedDirector] replaceScene:[LoadingScene sceneWithTargetScene:(TargetScenes)level]];
}

-(void)returnLevel
{
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
    [[CCDirector sharedDirector] replaceScene:[LevelScene scene]];
}

-(id) initWithResult:(int)level Score:(int)score AddScore:(int)addscore StarNum:(int)starnum Newrecord:(int)isnewrecord
{
    if ((self = [super init]))
    {   
        CCSprite* background = [CCSprite spriteWithFile:@"resultback.jpg"];
        //change size by diff version manual
        CGSize screenSize = [[CCDirector sharedDirector] winSize];
        background.scaleX=((screenSize.width))/[background contentSize].width; //按照像素定制图片宽高
        background.scaleY=((screenSize.height))/[background contentSize].height;
        //CGSize screenSize = [[CCDirector sharedDirector] winSize];
        //change size by diff version
        background.position = [GameMainScene sharedMainScene].backgroundPos;
        [self addChild:background z:-3];
    
//        CGSize screenSize = [[CCDirector sharedDirector] winSize];
        NSString *levelNum = [NSString stringWithFormat:@"LeveL %d",[[GameMainScene sharedMainScene] mainscenParam].order];
        CCLabelTTF *levelLabel=[CCLabelTTF labelWithString:levelNum fontName:@"Dekers_Bold" fontSize:25];
        [levelLabel setColor:ccBLACK];
        [levelLabel setPosition:ccp((screenSize.width)*0.5f,(screenSize.height)* 0.9)];
        [self addChild:levelLabel];
        
        NSString* temp=[@"base score: " stringByAppendingFormat:@" %d",score];
//        CCLabelTTF* labelscore = [CCLabelTTF labelWithString:temp fontName:@"Georgia-Bold" fontSize:30];
        CCLabelTTF* labelscore = [CCLabelTTF labelWithString:temp fontName:@"Dekers_Bold" fontSize:30];
		CGSize size = [[CCDirector sharedDirector] winSize];
        //change size by diff version query
		labelscore.position = CGPointMake(size.width / 3, size.height * 7 / 9 );
        [labelscore setColor:ccBLACK];
		[self addChild:labelscore];
        
        temp=[@"time award: " stringByAppendingFormat:@" %d",addscore];
        CCLabelTTF* labeladdscore = [CCLabelTTF labelWithString:temp fontName:@"Dekers_Bold" fontSize:30];
        //change size by diff version query
		labeladdscore.position = CGPointMake(size.width / 3, size.height * 5 / 9 );
        [labeladdscore setColor:ccBLACK];
		[self addChild:labeladdscore];
        
        temp=[@"total score: " stringByAppendingFormat:@" %d",score+addscore];
        CCLabelTTF* labeltotalscore = [CCLabelTTF labelWithString:temp fontName:@"Dekers_Bold" fontSize:30];
        //change size by diff version query
		labeltotalscore.position = CGPointMake(size.width / 3, size.height * 3 / 9 );
        [labeltotalscore setColor:ccBLACK];
		[self addChild:labeltotalscore];
        
        //if(isnewrecord==1 && starnum==3)
        //{
        NSString *words=nil;

        if(starnum==0)
        {
            words = @"Failed!";
        }
        else if(isnewrecord==1)
        {
            words = @"New Record!!!";
        }
        else if(starnum==1)
        {
            words = @"Good!";
        }
        else if(starnum==2)
        {
            words = @"Great!";
        }
        else if(starnum == 3)
        {

            words = @"Perfect!";
 
        }
        
            CCLabelTTF* labelnewrecord = [CCLabelTTF labelWithString:words fontName:@"escuela" fontSize:50];
            [labelnewrecord setColor:ccRED];
            labelnewrecord.position=CGPointMake(size.width *4/5, size.height *3/4  );;
            [labelnewrecord runAction:[CCSequence actions:
                                [CCDelayTime actionWithDuration:0.5],
                                [CCRepeat actionWithAction:[CCSequence actions:[CCScaleTo actionWithDuration:1 scale:1.3],[CCScaleTo actionWithDuration:1 scale:1],nil] times:9000],
                                nil]];
            [self addChild:labelnewrecord];
        
        
        //CCSpriteBatchNode* batch = [[GameBackgroundLayer sharedGameBackgroundLayer] getSpriteBatch];
//        CCSpriteBatchNode* buttonBatch = [[GameBackgroundLayer sharedGameBackgroundLayer] getButtonBatch];
        for(int i=0;i<3;i++)
        {
            
            
            CCSprite *star = [CCSprite spriteWithSpriteFrameName:@"star2_magic.png"];
            //change size by diff version query
            star.position=CGPointMake(size.width*2/3+50*i, size.height  / 2 );
            //change size by diff version manual
            star.scaleX=(50)/[star contentSize].width; //按照像素定制图片宽高是控制像素的。
            star.scaleY=(50)/[star contentSize].height;
            [self addChild:star z:1];
            //[buttonBatch addChild:star z:1];
        }
        
        for(int i=0;i<starnum;i++)
        {
            //CCSpriteBatchNode* batch = [[GameBackgroundLayer sharedGameBackgroundLayer] getSpriteBatch];
            CCSprite *star = [CCSprite spriteWithSpriteFrameName:@"star_magic.png"];
            //change size by diff version query
            star.position=CGPointMake(size.width*2/3+50*i, size.height  / 2 );
            //change size by diff version manual
            star.scaleX=(50)/[star contentSize].width; //按照像素定制图片宽高是控制像素的。
            star.scaleY=(50)/[star contentSize].height;
            [self addChild:star z:2];
            //[buttonBatch addChild:star z:2];
        }
        
//        CCLabelTTF *retryLabel=[CCLabelTTF labelWithString:@"Retry" fontName:@"Marker Felt" fontSize:30];
//        [retryLabel setColor:ccRED];
//        CCMenuItemLabel * retryBtn = [CCMenuItemLabel itemWithLabel:retryLabel target:self selector:@selector(chooseLevel:)];
//        [retryBtn setTag:level];
        CCSprite *retry = [CCSprite spriteWithSpriteFrameName:@"retry.png"];
//        retry.scaleX=(40)/[retry contentSize].width; //按照像素定制图片宽高是控制像素的。
//        retry.scaleY=(40)/[retry contentSize].height;
        CCSprite *retry1 = [CCSprite spriteWithSpriteFrameName:@"retry.png"];
//        retry1.scaleX=(40)/[retry1 contentSize].width; //按照像素定制图片宽高是控制像素的。
//        retry1.scaleY=(40)/[retry1 contentSize].height;
        CCMenuItemSprite *retryItem = [CCMenuItemSprite itemFromNormalSprite:retry 
                                                              selectedSprite:retry1 
                                                                      target:self 
                                                                    selector:@selector(chooseLevel:)];
        float labelscale=(40)/[retry1 contentSize].width;
        retryItem.scale=labelscale;
        [retryItem setTag:level];
        
        
        CCSprite *level0 = [CCSprite spriteWithSpriteFrameName:@"backtonavigation.png"];
//        level0.scaleX=(40)/[level0 contentSize].width; //按照像素定制图片宽高是控制像素的。
//        level0.scaleY=(40)/[level0 contentSize].height;
        CCSprite *level1 = [CCSprite spriteWithSpriteFrameName:@"backtonavigation.png"];
//        level1.scaleX=(40)/[level1 contentSize].width; //按照像素定制图片宽高是控制像素的。
//        level1.scaleY=(40)/[level1 contentSize].height;
        CCMenuItemSprite *levelItem = [CCMenuItemSprite itemFromNormalSprite:level0 
                                                              selectedSprite:level1 
                                                                      target:self 
                                                                    selector:@selector(returnLevel)];
        levelItem.scale=labelscale;
        
//        CCLabelTTF *LevelLabel=[CCLabelTTF labelWithString:@"Level" fontName:@"Marker Felt" fontSize:30];
//        [LevelLabel setColor:ccRED];
//        CCMenuItemLabel * LevelBtn = [CCMenuItemLabel itemWithLabel:LevelLabel target:self selector:@selector(returnLevel)];
        
//        CCLabelTTF *nextLabel=[CCLabelTTF labelWithString:@"Next" fontName:@"Marker Felt" fontSize:30];
//        [nextLabel setColor:ccRED];
//        CCMenuItemLabel * nextBtn = [CCMenuItemLabel itemWithLabel:nextLabel target:self selector:@selector(chooseLevel:)];
//        [nextBtn setTag:level+1];
//        if(starnum==0)
//        {
//            [nextBtn setIsEnabled:NO];
//            [nextLabel setColor:ccBLACK];
//        }
        
        CCSprite *next = [CCSprite spriteWithSpriteFrameName:@"next.png"];
//        next.scaleX=(40)/[next contentSize].width; //按照像素定制图片宽高是控制像素的。
//        next.scaleY=(40)/[next contentSize].height;
        CCSprite *next1 = [CCSprite spriteWithSpriteFrameName:@"next.png"];
//        next1.scaleX=(40)/[next1 contentSize].width; //按照像素定制图片宽高是控制像素的。
//        next1.scaleY=(40)/[next1 contentSize].height;
        CCMenuItemSprite *nextItem = [CCMenuItemSprite itemFromNormalSprite:next 
                                                              selectedSprite:next1 
                                                                      target:self 
                                                                   selector:@selector(chooseLevel:)];
        nextItem.scale=labelscale;
        [nextItem setTag:level+1];
        if(starnum==0)
        {
            [nextItem setIsEnabled:NO];
            [nextItem setColor:ccGRAY];
        }
        
        
        CCMenu * dMenu = [CCMenu menuWithItems:retryItem,levelItem,nextItem,nil];
        [dMenu alignItemsHorizontallyWithPadding:40];
        [dMenu setPosition:ccp((size.width)*0.5f,(size.height)*1/6)];
        [self addChild:dMenu];
        
    }
    return self;
}

@end
