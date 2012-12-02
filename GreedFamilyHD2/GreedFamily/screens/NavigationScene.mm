//
//  NavigationScene.m
//  Box2d_test
//
//  Created by 赵 苹果 on 12-3-25.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//
#import "NavigationScene.h"
#import "LevelScene.h"
#import "OptionsScene.h"
#import "GameCenterScene.h"
#import "GameKitHelper.h"
#import "GameScore.h"
#import "CCRadioMenu.h"
#import "GameMainScene.h"
#import "LevelScenePair.h"
#import "RoleScene.h"
#import "SimpleAudioEngine.h"
#import "AppDelegate.h"
#import "CCAnimationHelper.h"

@interface Navigation
-(void)newGame:(id)sender;
-(void)options:(id)sender;
-(void)gamecenter:(id)sender;
-(void)playAudio:(int)audioType;
@end


@implementation NavigationScene

@synthesize viewType = _viewType;

-(id)initWithNavigationScene
{
    if ((self = [super init])) {
		self.isTouchEnabled = YES;
        CGSize size = [[CCDirector sharedDirector] winSize];

        CCSpriteFrameCache* frameCache = [CCSpriteFrameCache sharedSpriteFrameCache];
        [frameCache addSpriteFramesWithFile:@"beginscene_default.plist"];
        //set the background pic
		CCSprite * background = [CCSprite spriteWithFile:@"background_begin.jpg"];
        background.scaleX=(size.width)/[background contentSize].width; //按照像素定制图片宽高是控制像素的。
        background.scaleY=(size.height)/[background contentSize].height;
        NSAssert( background != nil, @"background must be non-nil");
		[background setPosition:ccp(size.width / 2, size.height/2)];
		[self addChild:background];
		
        //set logo
        CCSprite *logo = [CCSprite spriteWithSpriteFrameName:@"logoword.png"];
//        logo.scaleX=(size.width*3/4)/[logo contentSize].width; //按照像素定制图片宽高是控制像素的。
//        logo.scaleY=(size.height*3/4)/[logo contentSize].height;
        logo.scaleX=0.5;
        logo.scaleY=0.5;
        [self addChild:logo];
        logo.position=CGPointMake(size.width / 2, size.height * 3 / 4 );
        
//        CCSprite *logopanda = [CCSprite spriteWithSpriteFrameName:@"logopanda.png"];
//        //        logo.scaleX=(size.width*3/4)/[logo contentSize].width; //按照像素定制图片宽高是控制像素的。
//        //        logo.scaleY=(size.height*3/4)/[logo contentSize].height;
//        logopanda.scale=0.4;
//        [self addChild:logopanda];
//        logopanda.position=CGPointMake(size.width / 6, size.height * 2 / 3 );
//        
//        [logopanda runAction:[CCSequence actions:
//        							[CCRepeat actionWithAction:[CCSequence actions:[CCScaleTo actionWithDuration:0.8 scale:0.4],[CCScaleTo actionWithDuration:1 scale:0.45],nil] times:9000],
//        							nil]];        
        
        
//        CCSprite *logopig = [CCSprite spriteWithSpriteFrameName:@"logopig.png"];
//        //        logo.scaleX=(size.width*3/4)/[logo contentSize].width; //按照像素定制图片宽高是控制像素的。
//        //        logo.scaleY=(size.height*3/4)/[logo contentSize].height;
//        logopig.scale=0.4;
//        [self addChild:logopig];
//        logopig.position=CGPointMake(size.width *5 / 6, size.height * 2 / 3 );
//        
//        [logopig runAction:[CCSequence actions:
//                              [CCRepeat actionWithAction:[CCSequence actions:[CCScaleTo actionWithDuration:0.8 scale:0.45],[CCScaleTo actionWithDuration:1 scale:0.4],nil] times:9000],
//                              nil]];    
        
        //add panda action by lyp 20121029
        CCSprite *logopanda= [CCSprite spriteWithSpriteFrameName:@"logopanda_1.png"];
        //按照像素设定图片大小
        logopanda.scale=0.75; //按照像素定制图片宽高
        logopanda.position = CGPointMake(size.width / 7, size.height * 2 / 3 );;
        CCAnimation* animation = [CCAnimation animationWithFrame:@"logopanda_" frameCount:5 delay:0.15f];
        
        CCAnimate *animate = [CCAnimate actionWithAnimation:animation restoreOriginalFrame:NO];
        CCSequence *seq = [CCSequence actions: animate,nil];
        
        CCAction *moveAction = [CCRepeatForever actionWithAction: seq ];
        [logopanda runAction:moveAction];
        [self addChild:logopanda];
        
        
        CCSprite *logopig= [CCSprite spriteWithSpriteFrameName:@"logopig_1.png"];
        //按照像素设定图片大小
        logopig.scale=0.75; //按照像素定制图片宽高
        logopig.position = CGPointMake(size.width *6 / 7, size.height * 2 / 3 );
        CCAnimation* animationlogopig = [CCAnimation animationWithFrame:@"logopig_" frameCount:5 delay:0.20f];
        
        CCAnimate *animatelogopig = [CCAnimate actionWithAnimation:animationlogopig restoreOriginalFrame:NO];
        CCSequence *seqlogopig = [CCSequence actions: animatelogopig,nil];
        
        CCAction *moveActionlogopig = [CCRepeatForever actionWithAction: seqlogopig ];
        [logopig runAction:moveActionlogopig];
        [self addChild:logopig];
        
        
        //set play 
        CCSprite *play = [CCSprite spriteWithSpriteFrameName:@"playpic.png"];
        //play.scaleX=1.1;
        play.scaleY=1.05;
        CCSprite *play1 = [CCSprite spriteWithSpriteFrameName:@"playpic.png"];
//        play1.scaleX=0.75; //按照像素定制图片宽高是控制像素的。
//        play1.scaleY=0.9;
        CCMenuItemSprite *playitem = [CCMenuItemSprite itemFromNormalSprite:play 
                                                              selectedSprite:play1 
                                                                      target:self 
                                                                    selector:@selector(newGame:)];
        CCMenu * playmenu = [CCMenu menuWithItems:playitem, nil];
        [playmenu setPosition:ccp(size.width/2,size.height*2/5)];
        [self addChild:playmenu];
        
        
        
        
        //set pair play 
        CCSprite *pairplay = [CCSprite spriteWithSpriteFrameName:@"shoppic.png"];
        //play.scaleX=1.1;
        pairplay.scaleY=1.05;
        CCSprite *pairplay1 = [CCSprite spriteWithSpriteFrameName:@"shoppic.png"];
        //        play1.scaleX=0.75; //按照像素定制图片宽高是控制像素的。
        //        play1.scaleY=0.9;
        CCMenuItemSprite *pairplayitem = [CCMenuItemSprite itemFromNormalSprite:pairplay 
                                                             selectedSprite:pairplay1 
                                                                     target:self 
                                                                   selector:@selector(pairGame:)];
        CCMenu * plairplaymenu = [CCMenu menuWithItems:pairplayitem, nil];
        [playmenu setPosition:ccp(size.width/2,size.height*2/5)];
        [self addChild:plairplaymenu];
        
        
        //set option in the left-down corner

        CCSprite *option = [CCSprite spriteWithSpriteFrameName:@"optionpic.png"];
//        option.scaleX=optscale;
//        option.scaleY=optscale;
        CCSprite *option1 = [CCSprite spriteWithSpriteFrameName:@"optionpic.png"];
        option1.scaleX=1.1;
        option1.scaleY=1.1;
        CCMenuItemSprite *optionItem = [CCMenuItemSprite itemFromNormalSprite:option 
                                                              selectedSprite:option1 
                                                                      target:self 
                                                                    selector:@selector(options:)];
        float optscale=50/[option contentSize].width;
        //float clickoptscale=optscale*1.1f;
        optionItem.scale=optscale;
        
        CCMenu * optionmenu = [CCMenu menuWithItems:optionItem, nil];
        [optionmenu setPosition:ccp([option contentSize].width*optscale/2,[option contentSize].height*optscale/2)];
        [self addChild:optionmenu];
        
        //set info in the right-down corner
        CCSprite *info = [CCSprite spriteWithSpriteFrameName:@"unfoldpic.png"];
//        info.scaleX=optscale;
//        info.scaleY=optscale;
        CCSprite *info1 = [CCSprite spriteWithSpriteFrameName:@"unfoldpic.png"];
        info1.scaleX=1.1;
        info1.scaleY=1.1;
        CCMenuItemSprite *infoItem = [CCMenuItemSprite itemFromNormalSprite:info 
                                                               selectedSprite:info1 
                                                                       target:self 
                                                                     selector:@selector(displayInfo:)];
        infoItem.scale=optscale;
        CCMenu * infomenu = [CCMenu menuWithItems:infoItem, nil];
        [infomenu setPosition:ccp(size.width-[info contentSize].width*optscale/2,[info contentSize].height*optscale/2)];
        [self addChild:infomenu];
        

        //set leadership
        CCSprite *leader = [CCSprite spriteWithSpriteFrameName:@"leaderboardpic.png"];
//        leader.scaleX=leaderscale;
//        leader.scaleY=leaderscale;
        CCSprite *leader1 = [CCSprite spriteWithSpriteFrameName:@"leaderboardpic.png"];
        float leaderscale=40/[leader contentSize].width;
        //float clickleaderscale=leaderscale*1.1f;
        leader1.scaleX=1.1;
        leader1.scaleY=1.1;
        CCMenuItemSprite *leaderItem = [CCMenuItemSprite itemFromNormalSprite:leader 
                                                             selectedSprite:leader1 
                                                                     target:self 
                                                                   selector:@selector(showGameLeaderboard:)];

        leaderItem.scale=leaderscale;
        
        //set achivement
        CCSprite * achivement= [CCSprite spriteWithSpriteFrameName:@"achievementspic.png"];
//        achivement.scaleX=leaderscale;
//        achivement.scaleY=leaderscale;
        CCSprite *achivement1 = [CCSprite spriteWithSpriteFrameName:@"achievementspic.png"];
        achivement1.scaleX=1.1;
        achivement1.scaleY=1.1;
        CCMenuItemSprite *achivementItem = [CCMenuItemSprite itemFromNormalSprite:achivement 
                                                               selectedSprite:achivement1 
                                                                       target:self 
                                                                     selector:@selector(showGameAchievements:)];
        achivementItem.scale=leaderscale;        
        
        //add by liuyunpeng 2012-11-18  user review
        CCSprite * userreview= [CCSprite spriteWithSpriteFrameName:@"shop1.png"];
        CCSprite *userreview1 = [CCSprite spriteWithSpriteFrameName:@"shop1.png"];
        userreview1.scaleX=1.1;
        userreview1.scaleY=1.1;
        CCMenuItemSprite *userreviewItem = [CCMenuItemSprite itemFromNormalSprite:userreview 
                                                                   selectedSprite:userreview1 
                                                                           target:self 
                                                                         selector:@selector(showGameUserReview:)];
        userreviewItem.scale=leaderscale;        
        
        
        
        
        CCMenu * leadermenu = [CCMenu menuWithItems:leaderItem, achivementItem, userreviewItem, nil];
        // center= size.width/2+[achivement contentSize].width*(0.5-leaderscale/2)
        [leadermenu setPosition:ccp(size.width/2,[leader contentSize].height*optscale/2)];
        //[leadermenu setPosition:ccp(size.width/2, size.height/4)];
        //set the distance to be the 1.5times of the label
        [leadermenu alignItemsHorizontallyWithPadding:[leader contentSize].width*optscale*1.5];
        [self addChild:leadermenu];
        
        
        
    
        
// delete by lyp 2012-9-2        
//        CCLabelTTF *newgameLabel=[CCLabelTTF labelWithString:@"NEW GAME" fontName:@"Marker Felt" fontSize:30];
//        CCLabelTTF *optionsLabel=[CCLabelTTF labelWithString:@"OPTIONS" fontName:@"Marker Felt" fontSize:30];
//        CCLabelTTF *gamecenterLabel=[CCLabelTTF labelWithString:@"Multi Play" fontName:@"Marker Felt" fontSize:30];
//        CCLabelTTF *leaderboardLabel=[CCLabelTTF labelWithString:@"LeaderBoard" fontName:@"Marker Felt" fontSize:30];
//        CCLabelTTF *archievementsLabel=[CCLabelTTF labelWithString:@"Achievements" fontName:@"Marker Felt" fontSize:30];
//
//        CCLabelTTF *pairPlayLabel=[CCLabelTTF labelWithString:@"Pair Play" fontName:@"Marker Felt" fontSize:30];
//        CCLabelTTF *developerInfoLabel=[CCLabelTTF labelWithString:@"Information" fontName:@"Marker Felt" fontSize:30];
//		
//		[newgameLabel setColor:ccRED];
//		[optionsLabel setColor:ccRED];
//		[gamecenterLabel setColor:ccRED];
//		
//		CCMenuItemLabel * newgame = [CCMenuItemLabel itemWithLabel:newgameLabel target:self selector:@selector(newGame:)];
//		CCMenuItemLabel * options = [CCMenuItemLabel itemWithLabel:optionsLabel target:self selector:@selector(options:)];
//		CCMenuItemLabel * gamecenter = [CCMenuItemLabel itemWithLabel:gamecenterLabel target:self selector:@selector(connectGameCenter:)];
//        CCMenuItemLabel * leaderboard = [CCMenuItemLabel itemWithLabel:leaderboardLabel target:self selector:@selector(showGameLeaderboard:)];
//		CCMenuItemLabel * archievements = [CCMenuItemLabel itemWithLabel:archievementsLabel target:self selector:@selector(showGameAchievements:)];
// 
//		CCMenuItemLabel * pairPlay = [CCMenuItemLabel itemWithLabel:pairPlayLabel target:self selector:@selector(pairGame:)];
//        CCMenuItemLabel * developerInfo = [CCMenuItemLabel itemWithLabel:developerInfoLabel target:self selector:@selector(displayInfo:)];
//		CCMenu * menu = [CCMenu menuWithItems:newgame,options,leaderboard,archievements,pairPlay,gamecenter, developerInfo, nil];
//		[menu alignItemsVerticallyWithPadding:10];
//		[self addChild:menu];
//		[menu setPosition:ccp(size.width/2,size.height/2)];

//  set play action
//		[newgame runAction:[CCSequence actions:
//							[CCEaseOut actionWithAction:[CCMoveBy actionWithDuration:1 position:ccp(-size.width/2,0)]  rate:2],
//							[CCRepeat actionWithAction:[CCSequence actions:[CCScaleTo actionWithDuration:1 scale:1.3],[CCScaleTo actionWithDuration:1 scale:1],nil] times:9000],
//							nil]];
//		[options runAction:[CCSequence actions:
//							[CCDelayTime actionWithDuration:0.5],[CCEaseOut actionWithAction:[CCMoveBy actionWithDuration:1 position:ccp(-size.width/2,0)]  rate:2],
//							[CCRepeat actionWithAction:[CCSequence actions:[CCScaleTo actionWithDuration:1 scale:1.3],[CCScaleTo actionWithDuration:1 scale:1],nil] times:9000],
//							nil]];
//		[leaderboard runAction:[CCSequence actions:
//                          [CCDelayTime actionWithDuration:0.9],[CCEaseOut actionWithAction:[CCMoveBy actionWithDuration:1 position:ccp(-size.width/2,0)]  rate:2],
//                          [CCRepeat actionWithAction:[CCSequence actions:[CCScaleTo actionWithDuration:1 scale:1.3],[CCScaleTo actionWithDuration:1 scale:1],nil] times:9000],
//                          nil]];
//        
//        [archievements runAction:[CCSequence actions:
//                               [CCDelayTime actionWithDuration:1],[CCEaseOut actionWithAction:[CCMoveBy actionWithDuration:1 position:ccp(-size.width/2,0)]  rate:2],
//                               [CCRepeat actionWithAction:[CCSequence actions:[CCScaleTo actionWithDuration:1 scale:1.3],[CCScaleTo actionWithDuration:1 scale:1],nil] times:9000],
//                               nil]];
//        [gamecenter runAction:[CCSequence actions:
//                                [CCDelayTime actionWithDuration:0.9],[CCEaseOut actionWithAction:[CCMoveBy actionWithDuration:1 position:ccp(-size.width/2,0)]  rate:2],
//                                [CCRepeat actionWithAction:[CCSequence actions:[CCScaleTo actionWithDuration:1 scale:1.3],[CCScaleTo actionWithDuration:1 scale:1],nil] times:9000],nil]];
//        [pairPlay runAction:[CCSequence actions:
//                             [CCDelayTime actionWithDuration:1],[CCEaseOut actionWithAction:[CCMoveBy actionWithDuration:1 position:ccp(-size.width/2,0)]  rate:2],
//                             [CCRepeat actionWithAction:[CCSequence actions:[CCScaleTo actionWithDuration:1 scale:1.3],[CCScaleTo actionWithDuration:1 scale:1],nil] times:9000],nil]];
        
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
    
    return self;
}

//角色选择回调函数，把角色类型写入文件
//- (void)button1Tapped:(id)sender 
//{
//    NSString *strName = [NSString stringWithFormat:@"RoleType"];
//    [[NSUserDefaults standardUserDefaults] setInteger:1 forKey:strName];
//}
//- (void)button2Tapped:(id)sender 
//{
//    NSString *strName = [NSString stringWithFormat:@"RoleType"];
//    [[NSUserDefaults standardUserDefaults] setInteger:2 forKey:strName];
//}
//- (void)button3Tapped:(id)sender 
//{
//    [[NSUserDefaults standardUserDefaults] setInteger:3 forKey:@"RoleType"];
//}


-(void)playAudio:(int)audioType
{
    NSUserDefaults *usrDef = [NSUserDefaults standardUserDefaults];
    BOOL sound = [usrDef boolForKey:@"sound"];
    if (NO == sound) 
    {
        return;
    }
    
    switch (audioType) {
        case NeedTouch:
            [[SimpleAudioEngine sharedEngine] playEffect:@"needtouch.caf"];
            break; 
            
        case GetScore:
            [[SimpleAudioEngine sharedEngine] playEffect:@"getscore.caf"];
            break;            
            
        case EatCandy:
            [[SimpleAudioEngine sharedEngine] playEffect:@"der.caf"];
            break;            
            
        case EatGood:
            [[SimpleAudioEngine sharedEngine] playEffect:@"good.caf"];
            break;    
            
        case EatBad:
            [[SimpleAudioEngine sharedEngine] playEffect:@"toll.caf"];
            break;
            
        case Droping:
            [[SimpleAudioEngine sharedEngine] playEffect:@"drop.caf"];
            break;            
            
        case BubbleBreak:
            [[SimpleAudioEngine sharedEngine] playEffect:@"bubblebreak.caf"];
            break;            
            
        case BubbleHit:
            [[SimpleAudioEngine sharedEngine] playEffect:@"bubblehit.caf"];
            break;            
            
        case SelectOK:
            [[SimpleAudioEngine sharedEngine] playEffect:@"select.caf"];
            break;            
            
        case SelectNo:
            [[SimpleAudioEngine sharedEngine] playEffect:@"failwarning.caf"];
            break;            
            
        case Bombing:
            [[SimpleAudioEngine sharedEngine] playEffect:@"bomb.caf"];
            break;   
            
        case NewHighScore:
            [[SimpleAudioEngine sharedEngine] playEffect:@"drum.caf"];
            break;   
            
        default:
            break;
    }
}

//滚动
-(void)viewAddPointY{
    view.scrollView.contentOffset = ccpAdd(view.scrollView.contentOffset, ccp(0,0.8));//让UIScrollView显示内容每次慢慢向上移动0.8像素
    //view.scrollView.contentSize.height :得到UIScrollView的高度
    if (view.scrollView.contentOffset.y >= view.scrollView.contentSize.height)
    {
        view.scrollView.contentOffset = ccp(0,-view.scrollView.frame.size.height+500);
    }
}


-(void)newGame:(id)sender
{
	//start a new game
    //[self showDifficultySelection];
    //数据提交
//    CCLOG(@"role type: %d", [[NSUserDefaults standardUserDefaults]  integerForKey:@"RoleType"]);
//
//    [[NSUserDefaults standardUserDefaults] synchronize];
//	[[CCDirector sharedDirector] replaceScene:[LevelScene scene]];
    [self playAudio:SelectOK];
    if (isCreateIndicatorView)
    {
        [activityIndicatorView stopAnimating ];  //停止  
        isCreateIndicatorView = NO;
    }
    [[CCDirector sharedDirector] replaceScene:[RoleScene scene]];
    
}

-(void)options:(id)sender
{
    [self playAudio:SelectOK];
    
    if (isCreateIndicatorView)
    {
        [activityIndicatorView stopAnimating ];  //停止  
        isCreateIndicatorView = NO;
    }
	//show the options of the game
    OptionsScene * gs = [OptionsScene node];
	//[[CCDirector sharedDirector]replaceScene:gs];
    [[CCDirector sharedDirector]pushScene:gs];
}

-(void)displayInfo:(id)sender
{
    [self playAudio:SelectOK];
    
     if (isCreateIndicatorView)
     {
         [activityIndicatorView stopAnimating ];  //停止  
         isCreateIndicatorView = NO;
     }
         
	//show the options of the game
//    infoView = [[DeveloperInfo alloc] initWithNibName:@"Info View" bundle:nil];
//    [[[CCDirector sharedDirector] openGLView] addSubview:infoView.view];
    view = [[DeveloperInfo alloc] initWithNibName:@"DeveloperInfo" bundle:nil];
    [[[CCDirector sharedDirector] openGLView] addSubview:view.view];
    //[view release];
    [self schedule:@selector(viewAddPointY) interval:0.03];
}



-(void) updateScoreAndShowLeaderBoard
{
    //更新累计得分,算两个role的总分
    NSString *strTotalScore = [NSString stringWithFormat:@"Totalscore_Bird"];
    int temTotalScore = [[[MyGameScore sharedScore] standardUserDefaults] integerForKey:strTotalScore];
    strTotalScore = [NSString stringWithFormat:@"Totalscore_Pig"];
    temTotalScore += [[[MyGameScore sharedScore] standardUserDefaults] integerForKey:strTotalScore];
    strTotalScore = [NSString stringWithFormat:@"Totalscore_Panda"];
    temTotalScore += [[[MyGameScore sharedScore] standardUserDefaults] integerForKey:strTotalScore];
    //更新累计总时间
    NSString *strTotalTime = [NSString stringWithFormat:@"Playtime"];
    int temTotalTime = [[[MyGameScore sharedScore] standardUserDefaults] integerForKey:strTotalTime];  
    
    strTotalScore = [NSString stringWithFormat:@"Totalscore"];
    //传入分数和时间累计数
	GameKitHelper* gkHelper = [GameKitHelper sharedGameKitHelper];
    [gkHelper submitScore:temTotalTime category:strTotalTime];
    [gkHelper submitScore:temTotalScore category:strTotalScore];
    
    [gkHelper showLeaderboard];
    
}

-(void) updateScoreAndShowAchievements
{
    //更新累计得分,算两个role的总分
    NSString *strTotalScore = [NSString stringWithFormat:@"Totalscore_Bird"];
    int temTotalScore = [[[MyGameScore sharedScore] standardUserDefaults] integerForKey:strTotalScore];
    strTotalScore = [NSString stringWithFormat:@"Totalscore_Pig"];
    temTotalScore += [[[MyGameScore sharedScore] standardUserDefaults] integerForKey:strTotalScore];
    strTotalScore = [NSString stringWithFormat:@"Totalscore_Panda"];
    temTotalScore += [[[MyGameScore sharedScore] standardUserDefaults] integerForKey:strTotalScore];
    //更新累计总时间
    NSString *strTotalTime = [NSString stringWithFormat:@"Playtime"];
    int temTotalTime = [[[MyGameScore sharedScore] standardUserDefaults] integerForKey:strTotalTime]; 
    
    strTotalScore = [NSString stringWithFormat:@"Totalscore"];
    //传入分数和时间累计数
	GameKitHelper* gkHelper = [GameKitHelper sharedGameKitHelper];
    [gkHelper submitScore:temTotalTime category:strTotalTime];
    [gkHelper submitScore:temTotalScore category:strTotalScore];
    
    [gkHelper showAchievements];
    
}

-(void)showGameLeaderboard:(id)sender
{
    [self playAudio:SelectOK];
    
    //启动load图标
    if (!isCreateIndicatorView)
    {
        
        if (!activityIndicatorView)
        {
            activityIndicatorView = [[[UIActivityIndicatorView alloc]   
                                      initWithActivityIndicatorStyle:   
                                      UIActivityIndicatorViewStyleWhiteLarge] autorelease];  
            
            activityIndicatorView.center = CGPointMake(70,240);  
            
            [activityIndicatorView startAnimating]; 
            //activityIndicatorView.activityIndicatorViewStyle= UIActivityIndicatorViewStyleGray;
            //[self.view addSubview:activityIndicatorView ];   
            AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;  
            [delegate.window addSubview:activityIndicatorView];
        }
        else
        {
            [activityIndicatorView startAnimating];
        }
        [self schedule:@selector(stopAnimating:) interval:5];
        isCreateIndicatorView = YES;
    }
    
	//connect to game center
    GameKitHelper* gkHelper = [GameKitHelper sharedGameKitHelper];
    gkHelper.delegate = self;
    _viewType = 0;
    [gkHelper authenticateLocalPlayer];

    //第一次调用需要初始化后在里边调用
    if (gkHelper.callCount != 0) 
    {
        [self updateScoreAndShowLeaderBoard];
    }

}

-(void)showGameAchievements:(id)sender
{
    [self playAudio:SelectOK];
    
    //启动load图标
    if (!isCreateIndicatorView)
    {
        if (!activityIndicatorView)
        {
            activityIndicatorView = [[[UIActivityIndicatorView alloc]   
                                      initWithActivityIndicatorStyle:   
                                      UIActivityIndicatorViewStyleWhiteLarge] autorelease];  
            
            activityIndicatorView.center = CGPointMake(70,240);  
            
            [activityIndicatorView startAnimating]; 
            //activityIndicatorView.activityIndicatorViewStyle= UIActivityIndicatorViewStyleGray;
            //[self.view addSubview:activityIndicatorView ];   
            AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;  
            [delegate.window addSubview:activityIndicatorView];
        }
        else
        {
            [activityIndicatorView startAnimating];
        }
        [self schedule:@selector(stopAnimating:) interval:5];
        isCreateIndicatorView = YES;
    }
	//connect to game center
    //[[CCDirector sharedDirector] replaceScene:[GameCenterScene gamecenterScene]];
    GameKitHelper* gkHelper = [GameKitHelper sharedGameKitHelper];
    gkHelper.delegate = self;
    _viewType = 1;
    [gkHelper authenticateLocalPlayer];
    
    //第一次调用需要初始化后在里边调用
    if (gkHelper.callCount != 0) 
    {
        [self updateScoreAndShowAchievements];
    }
}

-(void)showGameUserReview:(id)sender
{ 
//    NSString *str = [NSString stringWithFormat: 
//                   @"itms-apps://ax.itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?type=Purple+Software&id=%d", 
//                   1234 ]; 
    NSString * str =@"http://www.sina.com.cn";
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
    
}

-(void)stopAnimating: (ccTime) dt
{
    [self unschedule:@selector(stopAnimating:)];   
    if (isCreateIndicatorView)
    {
        [activityIndicatorView stopAnimating ];  //停止  
        isCreateIndicatorView = NO;
    }
}
                               
-(void)connectGameCenter:(id)sender
{
    [self playAudio:SelectOK];
    //connect to game center
    [[CCDirector sharedDirector] replaceScene:[GameCenterScene gamecenterScene]];
}

-(void)pairGame:(id)sender
{
    [self playAudio:SelectOK];
    //connect to game center
    //[[CCDirector sharedDirector] replaceScene:[LoadingScene sceneWithTargetScene:TargetSceneINVALID]];
	[[CCDirector sharedDirector] replaceScene:[LevelScenePair scene]];
}

+(id)scene
{
    //order = order;
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	NavigationScene *navigationScene = [NavigationScene sceneWithNavigationScene];
	
	// add layer as a child to scene
	[scene addChild: navigationScene];

	return scene;

}

+(id)sceneWithNavigationScene
{
    return [[[self alloc] initWithNavigationScene] autorelease];
}



#pragma mark GameKitHelper delegate methods
-(int) getViewType
{
    return _viewType;
}

-(void) onLocalPlayerAuthenticationChanged
{
	GKLocalPlayer* localPlayer = [GKLocalPlayer localPlayer];
	CCLOG(@"LocalPlayer isAuthenticated changed to: %@", localPlayer.authenticated ? @"YES" : @"NO");
	
	if (localPlayer.authenticated)
	{
		GameKitHelper* gkHelper = [GameKitHelper sharedGameKitHelper];
		[gkHelper getLocalPlayerFriends];
		//[gkHelper resetAchievements];
	}	
}

-(void) onFriendListReceived:(NSArray*)friends
{
	CCLOG(@"onFriendListReceived: %@", [friends description]);
	GameKitHelper* gkHelper = [GameKitHelper sharedGameKitHelper];
	[gkHelper getPlayerInfo:friends];
}

-(void) onPlayerInfoReceived:(NSArray*)players
{
	CCLOG(@"onPlayerInfoReceived: %@", [players description]);
    
    for (GKPlayer* gkPlayer in players)
	{
		CCLOG(@"PlayerID: %@, Alias: %@, isFriend: %i", gkPlayer.playerID, gkPlayer.alias, gkPlayer.isFriend);
	}
    
    //更新累计得分,算两个role的总分
    NSString *strTotalScore = [NSString stringWithFormat:@"Totalscore_Bird"];
    int temTotalScore = [[[MyGameScore sharedScore] standardUserDefaults] integerForKey:strTotalScore];
    strTotalScore = [NSString stringWithFormat:@"Totalscore_Pig"];
    temTotalScore += [[[MyGameScore sharedScore] standardUserDefaults] integerForKey:strTotalScore];
    strTotalScore = [NSString stringWithFormat:@"Totalscore_Panda"];
    temTotalScore += [[[MyGameScore sharedScore] standardUserDefaults] integerForKey:strTotalScore];
    //更新累计总时间
    NSString *strTotalTime = [NSString stringWithFormat:@"Playtime"];
    int temTotalTime = [[[MyGameScore sharedScore] standardUserDefaults] integerForKey:strTotalTime]; 
    
    strTotalScore = [NSString stringWithFormat:@"Totalscore"];
    //传入分数和时间累计数
	GameKitHelper* gkHelper = [GameKitHelper sharedGameKitHelper];
    [gkHelper submitScore:temTotalTime category:strTotalTime];
    [gkHelper submitScore:temTotalScore category:strTotalScore];
}

-(void) onScoresSubmitted:(bool)success
{
	CCLOG(@"onScoresSubmitted: %@", success ? @"YES" : @"NO");
	
	if (success)
	{
		GameKitHelper* gkHelper = [GameKitHelper sharedGameKitHelper];
		[gkHelper retrieveTopTenAllTimeGlobalScores];
	}
}

-(void) onScoresReceived:(NSArray*)scores
{
	CCLOG(@"onScoresReceived: %@", [scores description]);
	GameKitHelper* gkHelper = [GameKitHelper sharedGameKitHelper];
	
    if (0 != gkHelper.callCount) 
    {
        return;
    }
    
    if (_viewType == 0) 
    {
        [gkHelper showLeaderboard];
    }
    
    else
    {
        [gkHelper showAchievements];
    }
}

-(void) onLeaderboardViewDismissed
{
	CCLOG(@"onLeaderboardViewDismissed");
}

-(void) onAchievementReported:(GKAchievement*)achievement
{
	CCLOG(@"onAchievementReported: %@", achievement);
}

-(void) onAchievementsLoaded:(NSDictionary*)achievements
{
	CCLOG(@"onLocalPlayerAchievementsLoaded: %@", [achievements description]);
}

-(void) onResetAchievements:(bool)success
{
	CCLOG(@"onResetAchievements: %@", success ? @"YES" : @"NO");
}

-(void) onAchievementsViewDismissed
{
    
	CCLOG(@"onAchievementsViewDismissed");
}

/*
-(CGPoint) locationFromTouch:(UITouch*)touch
{
	CGPoint touchLocation = [touch locationInView: [touch view]];
	return [[CCDirector sharedDirector] convertToGL:touchLocation];
}

-(BOOL) ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event
{
	fingerLocation = [self locationFromTouch:touch];
    isTouch = YES;
	return YES;
    
}

-(void) ccTouchEnded:(UITouch *)touch withEvent:(UIEvent *)event
{
    //isTouch = NO;
}

-(void)update:(ccTime)delta
{
    if (isTouch)
    {
        //CGSize size = [[CCDirector sharedDirector] winSize]; 
    
        //CGRect rect1 =  CGRectMake(size.width / 2, size.height - 30.0f, 100.0f, 100.0f);
        //CGRect rect2 =  CGRectMake(size.width / 2, size.height / 2, 100.0f, 100.0f); 
        //CGRect rect3 =  CGRectMake(size.width / 2, 30.0f, 100.0f, 100.0f); 
        if (CGRectContainsPoint([label1 boundingBox], fingerLocation))
        {
        
            CCLOG(@"11111111%@\n", label1.textureRect);
            label1.color = ccWHITE;
            //CCTransitionShrinkGrow* transition = [CCTransitionShrinkGrow transitionWithDuration:3 scene:[MainScene scene:1]];
        
            //[[CCDirector sharedDirector] replaceScene:transition];
        
            [[CCDirector sharedDirector] replaceScene:[LoadingScene sceneWithTargetScene:TargetSceneFstScene]];

            //[[CCDirector sharedDirector] replaceScene:[MainScene scene:1]];
        }
        else if (CGRectContainsPoint([label2 boundingBox], fingerLocation))
        {
            CCLOG(@"22222222\n");
            label2.color = ccWHITE;
            [[CCDirector sharedDirector] replaceScene:[LoadingScene sceneWithTargetScene:TargetSceneScdScene]];
        }
        else if (CGRectContainsPoint([label3 boundingBox], fingerLocation))
        {
            CCLOG(@"333333\n");
            label3.color = ccWHITE;
        
            //[[CCDirector sharedDirector] replaceScene:[LoadingScene sceneWithTargetScene:TargetSceneThrdScene]];
                
            //CCTransitionSlideInB* transition = [CCTransitionSlideInB transitionWithDuration:3 
                                            //scene:[LoadingScene sceneWithTargetScene://TargetSceneThrdScene]];
            //[[CCDirector sharedDirector] replaceScene:transition];
            
            [[CCDirector sharedDirector] replaceScene:[LoadingScene sceneWithTargetScene:TargetSceneThrdScene]];            
            
        }
        isTouch = NO;
        self.isTouchEnabled = NO;
    }
    
}
*/
@end