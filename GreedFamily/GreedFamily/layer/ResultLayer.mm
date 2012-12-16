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
#import "CommonLayer.h"
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
//        int randomNum = random()%2;
//        
//        if (0 == randomNum) 
//        {
//            [[SimpleAudioEngine sharedEngine] playBackgroundMusic:@"destinationshort.mp3" loop:YES];
//        }
//        else
//        {
//            [[SimpleAudioEngine sharedEngine] playBackgroundMusic:@"barnbeatshort.mp3" loop:YES];
//        }
        [CommonLayer playBackMusic:UnGameMusic1];
    }
    [[CCDirector sharedDirector] replaceScene:[LevelScene scene]];
}

-(void)showStar
{
    NSString *words=nil;
    if(starNum==0)
    {
        words = @"Failed!";
    }
    else if(isNewrecord==1)
    {
        //新纪录音效
        [CommonLayer playAudio:NewHighScore];
        words = @"New Record!!!";
    }
    else if(starNum==1)
    {
        words = @"Good!";
    }
    else if(starNum==2)
    {
        words = @"Great!";
    }
    else if(starNum == 3)
    {
        
        words = @"Perfect!";
        
    }
    CGSize size = [[CCDirector sharedDirector] winSize];
    CCLabelTTF* labelnewrecord = [CCLabelTTF labelWithString:words fontName:@"ARIALN" fontSize:40];
    [labelnewrecord setColor:ccRED];
    labelnewrecord.position=CGPointMake(size.width *4/5, size.height *3/4  );;
    [labelnewrecord runAction:[CCSequence actions:
                               [CCDelayTime actionWithDuration:0.5],
                               [CCRepeat actionWithAction:[CCSequence actions:[CCScaleTo actionWithDuration:1 scale:1.3],[CCScaleTo actionWithDuration:1 scale:1],nil] times:9000],
                               nil]];
    [self addChild:labelnewrecord];
    
    for(int i=0;i<3;i++)
    {
        CCSprite *star = [CCSprite spriteWithSpriteFrameName:@"star2_magic.png"];
        //change size by diff version query
        star.position=CGPointMake(size.width*2/3+50*i, size.height  / 2 );
        //change size by diff version manual
        star.scaleX=(50)/[star contentSize].width; //按照像素定制图片宽高是控制像素的。
        star.scaleY=(50)/[star contentSize].height;
        [self addChild:star z:1];
    }
    
    for(int i=0;i<starNum;i++)
    {
        CCSprite *star = [CCSprite spriteWithSpriteFrameName:@"star_magic.png"];
        //change size by diff version query
        star.position=CGPointMake(size.width*2/3+50*i, size.height  / 2 );
        //change size by diff version manual
        star.scaleX=(50)/[star contentSize].width; //按照像素定制图片宽高是控制像素的。
        star.scaleY=(50)/[star contentSize].height;
        [self addChild:star z:2];
        
    }
}

-(id) initWithResult:(int)level Score:(int)score AddScore:(int)addscore StarNum:(int)starnum Newrecord:(int)isnewrecord
{
    if ((self = [super init]))
    {   
        background = [CCSprite spriteWithFile:@"resultback.jpg"];
        //change size by diff version manual
        CGSize size = [[CCDirector sharedDirector] winSize];
        background.scaleX=((size.width))/[background contentSize].width; //按照像素定制图片宽高
        background.scaleY=((size.height))/[background contentSize].height;
        //change size by diff version
        background.position = CGPointMake(size.width / 2, size.height*1.5);
        [self addChild:background z:-3];
    
        CGPoint moveToPosition = [GameMainScene sharedMainScene].backgroundPos;       
        CCMoveTo* move = [CCMoveTo actionWithDuration:1 position:moveToPosition]; 
        CCEaseInOut* ease = [CCEaseInOut actionWithAction:move rate:1];
        [background runAction:ease];   
        
        totalscore=addscore+score;
        timescore=addscore;
        basescore=score;
        starNum=starnum;
        isNewrecord=basescore;
        curtotalscore=score;
        curtimescore=0;
        curbasescore=0;
        isShow1 = NO;
        isShow2 = NO;
        gameLevel = level;
        
        [self schedule:@selector(showResult:) interval:1];
    }
    return self;
}
-(void)showResult:(ccTime)delta
{
    [self unschedule:@selector(showResult:)];   
    CGSize size = [[CCDirector sharedDirector] winSize];

    NSString *levelNum = [NSString stringWithFormat:@"LeveL %d",[[GameMainScene sharedMainScene] mainscenParam].order];
    CCLabelTTF *levelLabel=[CCLabelTTF labelWithString:levelNum fontName:@"Dekers_Bold" fontSize:25];
    [levelLabel setColor:ccBLACK];
    [levelLabel setPosition:ccp((size.width)*0.5f,(size.height)* 0.9)];
    [self addChild:levelLabel];
    
    //        NSString* temp=[@"base score: " stringByAppendingFormat:@" %d",score];
    //        CCLabelTTF* labelscore = [CCLabelTTF labelWithString:temp fontName:@"Dekers_Bold" fontSize:30];
    //		labelscore.position = CGPointMake(size.width / 3, size.height * 7 / 9 );
    //        [labelscore setColor:ccBLACK];
    //		[self addChild:labelscore];
    


    CCLabelTTF* labelscore = [CCLabelTTF labelWithString:@"base score: " fontName:@"Dekers_Bold" fontSize:30];
    labelscore.position = CGPointMake(size.width / 3, size.height * 7 / 9 );
    [labelscore setColor:ccBLACK];
    [self addChild:labelscore];
    
    
    //add by liuyunpeng
    basescorelabel = [CCLabelTTF labelWithString:@"0" fontName:@"Dekers_Bold" fontSize:30];
    //change size by diff version query
    basescorelabel.position = CGPointMake(size.width *0.6, size.height * 7 / 9 );
    [basescorelabel setColor:ccBLACK];
    [self addChild:basescorelabel];
    
    CCSprite *retry = [CCSprite spriteWithSpriteFrameName:@"retry.png"];
    CCSprite *retry1 = [CCSprite spriteWithSpriteFrameName:@"retry.png"];
    CCMenuItemSprite *retryItem = [CCMenuItemSprite itemFromNormalSprite:retry 
                                                          selectedSprite:retry1 
                                                                  target:self 
                                                                selector:@selector(chooseLevel:)];
    float labelscale=(40)/[retry1 contentSize].width;
    retryItem.scale=labelscale;
    [retryItem setTag:gameLevel];
    
    
    CCSprite *level0 = [CCSprite spriteWithSpriteFrameName:@"backtonavigation.png"];
    CCSprite *level1 = [CCSprite spriteWithSpriteFrameName:@"backtonavigation.png"];
    CCMenuItemSprite *levelItem = [CCMenuItemSprite itemFromNormalSprite:level0 
                                                          selectedSprite:level1 
                                                                  target:self 
                                                                selector:@selector(returnLevel)];
    levelItem.scale=labelscale;
    
    CCSprite *next = [CCSprite spriteWithSpriteFrameName:@"next.png"];
    CCSprite *next1 = [CCSprite spriteWithSpriteFrameName:@"next.png"];
    CCMenuItemSprite *nextItem = [CCMenuItemSprite itemFromNormalSprite:next 
                                                         selectedSprite:next1 
                                                                 target:self 
                                                               selector:@selector(chooseLevel:)];
    nextItem.scale=labelscale;
    [nextItem setTag:gameLevel+1];
    if(starNum==0)
    {
        [nextItem setIsEnabled:NO];
        [nextItem setColor:ccGRAY];
    }
    
    
    CCMenu * dMenu = [CCMenu menuWithItems:retryItem,levelItem,nextItem,nil];
    [dMenu alignItemsHorizontallyWithPadding:40];
    [dMenu setPosition:ccp((size.width)*0.5f,(size.height)*1/6)];
    [self addChild:dMenu];
    
    [self schedule:@selector(countScore:) interval:0.08];
}


-(void) countScore:(ccTime)delta
{
    CGSize size = [[CCDirector sharedDirector] winSize];
    NSString* temp=nil;
    if(curbasescore<=basescore){
        temp=[NSString stringWithFormat:@"%d",curbasescore];
        [basescorelabel setString:temp];
        curbasescore++;
    }else if(curtimescore<=timescore){
        if (NO == isShow1)
        {
            isShow1 = YES;
            CCLabelTTF* labeladdscore = [CCLabelTTF labelWithString:@"time award: " fontName:@"Dekers_Bold" fontSize:30];
            //change size by diff version query
            labeladdscore.position = CGPointMake(size.width / 3, size.height * 5 / 9 );
            [labeladdscore setColor:ccBLACK];
            [self addChild:labeladdscore];
            
            //add by liuyunpeng
            timescorelabel = [CCLabelTTF labelWithString:@"0" fontName:@"Dekers_Bold" fontSize:30];
            //change size by diff version query
            timescorelabel.position = CGPointMake(size.width *0.6, size.height * 5 / 9 );
            [timescorelabel setColor:ccBLACK];
            [self addChild:timescorelabel];
            sleep(0.5);
        }
        
        temp=[NSString stringWithFormat:@"%d",curtimescore];
        [timescorelabel setString:temp];
        curtimescore++;
    }else if(curtotalscore<=totalscore){
        
        if (NO == isShow2)
        {
            isShow2 = YES;
            CCLabelTTF* labeltotalscore = [CCLabelTTF labelWithString:@"total score: " fontName:@"Dekers_Bold" fontSize:30];
            //change size by diff version query
            labeltotalscore.position = CGPointMake(size.width / 3, size.height * 3 / 9 );
            [labeltotalscore setColor:ccBLACK];
            [self addChild:labeltotalscore];
            
            //add by liuyunpeng
            NSString* tempScore=[NSString stringWithFormat:@"%d",curtotalscore];
            totalscorelabel = [CCLabelTTF labelWithString:tempScore fontName:@"Dekers_Bold" fontSize:30];
            //change size by diff version query
            totalscorelabel.position = CGPointMake(size.width *0.6, size.height * 3 / 9 );
            [totalscorelabel setColor:ccBLACK];
            [self addChild:totalscorelabel];
            sleep(0.5);
        }
        
        temp=[NSString stringWithFormat:@"%d",curtotalscore];
        [totalscorelabel setString:temp];
        curtotalscore++;
    }else {
        [self unscheduleAllSelectors];
        [self showStar];
    }
}


@end
