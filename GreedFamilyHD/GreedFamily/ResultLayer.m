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

// 该类在GameMainScene中关卡结束时被调用，用于显示分数／关卡等信息
// 使用方法参见 GameMainScene:pauseGame中注释的部分
// 可供测试使用，点击暂停按钮，即可进行测试


@interface ResultLayer (PrivateMethods)
-(id) initWithResult:(ccColor4B)color Level:(int)level Score:(int)score AddScore:(int)addscore StarNum:(int)starnum;
@end

@implementation ResultLayer

+(id)createResultLayer:(ccColor4B)color Level:(int)level Score:(int)score AddScore:(int)addscore  StarNum:(int)starnum
{
    return [[[ResultLayer alloc] initWithResult:color Level:level Score:score AddScore:addscore StarNum:starnum] autorelease];
}

-(void)chooseLevel:(CCMenuItemImage *)btn
{
    int level=btn.tag;
    [[CCDirector sharedDirector] replaceScene:[LoadingScene sceneWithTargetScene:(TargetScenes)level]];
}

-(void)returnLevel
{
    [[CCDirector sharedDirector] replaceScene:[LevelScene scene]];
}

-(id) initWithResult:(ccColor4B)color Level:(int)level Score:(int)score AddScore:(int)addscore StarNum:(int)starnum
{
    if ((self = [super initWithColor:color]))
    {
        NSString* temp=[@"level score: " stringByAppendingFormat:@" %d",score];
        CCLabelTTF* labelscore = [CCLabelTTF labelWithString:temp fontName:@"Marker Felt" fontSize:30];
		CGSize size = [[CCDirector sharedDirector] winSize];
        //change size by diff version query
		labelscore.position = CGPointMake(size.width / 3, size.height * 4 / 5 );
        [labelscore setColor:ccBLUE];
		[self addChild:labelscore];
        
        temp=[@"added score: " stringByAppendingFormat:@" %d",addscore];
        CCLabelTTF* labeladdscore = [CCLabelTTF labelWithString:temp fontName:@"Marker Felt" fontSize:30];
        //change size by diff version query
		labeladdscore.position = CGPointMake(size.width / 3, size.height * 3 / 5 );
        [labeladdscore setColor:ccBLUE];
		[self addChild:labeladdscore];
        
        temp=[@"total score: " stringByAppendingFormat:@" %d",score+addscore];
        CCLabelTTF* labeltotalscore = [CCLabelTTF labelWithString:temp fontName:@"Marker Felt" fontSize:30];
        //change size by diff version query
		labeltotalscore.position = CGPointMake(size.width / 3, size.height * 2 / 5 );
        [labeltotalscore setColor:ccBLUE];
		[self addChild:labeltotalscore];
        

        for(int i=0;i<3;i++)
        {
            CCSpriteBatchNode* batch = [[GameBackgroundLayer sharedGameBackgroundLayer] getSpriteBatch];
            CCSprite *star = [CCSprite spriteWithSpriteFrameName:@"star2_magic.png"];
            //change size by diff version query
            star.position=CGPointMake(size.width*2/3+50*i, size.height  / 2 );
            //change size by diff version manual
            star.scaleX=(50)/[star contentSize].width; //按照像素定制图片宽高是控制像素的。
            star.scaleY=(50)/[star contentSize].height;
            [batch addChild:star z:1];
            //[self addChild:star];
        }
        
        for(int i=0;i<starnum;i++)
        {
            CCSpriteBatchNode* batch = [[GameBackgroundLayer sharedGameBackgroundLayer] getSpriteBatch];
            CCSprite *star = [CCSprite spriteWithSpriteFrameName:@"star_magic.png"];
            //change size by diff version query
            star.position=CGPointMake(size.width*2/3+50*i, size.height  / 2 );
            //change size by diff version manual
            star.scaleX=(50)/[star contentSize].width; //按照像素定制图片宽高是控制像素的。
            star.scaleY=(50)/[star contentSize].height;
            [batch addChild:star z:2];
            //[self addChild:star];
        }
        
        CCLabelTTF *retryLabel=[CCLabelTTF labelWithString:@"Retry" fontName:@"Marker Felt" fontSize:30];
        [retryLabel setColor:ccRED];
        CCMenuItemLabel * retryBtn = [CCMenuItemLabel itemWithLabel:retryLabel target:self selector:@selector(chooseLevel:)];
        
        CCLabelTTF *LevelLabel=[CCLabelTTF labelWithString:@"Level" fontName:@"Marker Felt" fontSize:30];
        [LevelLabel setColor:ccRED];
        CCMenuItemLabel * LevelBtn = [CCMenuItemLabel itemWithLabel:LevelLabel target:self selector:@selector(returnLevel)];
        
        CCLabelTTF *nextLabel=[CCLabelTTF labelWithString:@"Next" fontName:@"Marker Felt" fontSize:30];
        [nextLabel setColor:ccRED];
        CCMenuItemLabel * nextBtn = [CCMenuItemLabel itemWithLabel:nextLabel target:self selector:@selector(chooseLevel:)];
        
        [retryBtn setTag:level];
        [nextBtn setTag:level+1];
        if(starnum==0)
        {
            [nextBtn setIsEnabled:NO];
            [nextLabel setColor:ccBLACK];
        }
        
        CCMenu * dMenu = [CCMenu menuWithItems:retryBtn,LevelBtn,nextBtn,nil];
        [dMenu alignItemsHorizontallyWithPadding:40];
        [dMenu setPosition:ccp((size.width)*0.5f,(size.height)*1/5)];
        [self addChild:dMenu];
        
    }
    return self;
}

@end
