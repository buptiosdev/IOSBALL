//
//  gameScore.mm
//  GreedFamily
//
//  Created by 晋 刘 on 12-6-2.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import "GameScore.h"
#import "GameMainScene.h"
#import "GameKitHelper.h"
#import "CommonLayer.h"
/*
 @interface gameScore (PrivateMethods)
 -(void)updateLabelOfTotalScore:(ccTime)delta;
 @end
 */

@implementation GameScore

NSUserDefaults * standardUserDefaults;

static GameScore  *instanceOfgameScore;
+(GameScore *)sharedgameScore
{
    NSAssert(nil != instanceOfgameScore, @"Score instance not yet initialized!");
    
    return instanceOfgameScore;
}

+(id)createGameScore:(int)playID
{
    return [[[self alloc] initWithPlayID:playID] autorelease];
}

-(id)initWithPlayID:(int)playID
{
    if ((self = [super init]))
    {
        instanceOfgameScore = self;
        
        //set Score Rules 
        [self setScoreSetRules];
        
        /*获取关卡号*/
        gamelevel= [GameMainScene sharedMainScene].sceneNum;
        my_nowlevelscore = 0;
        award_nowlevelscore = 0;        
        
        LevelScore = [[CCArray alloc] initWithCapacity:2];        

        standardUserDefaults = [[MyGameScore sharedScore] standardUserDefaults];
    
        
        //不需要在update 调用 在调用的时候就做判断 进行存储
        //初始化时需要进行一次更新
        [self schedule:@selector(updateLabelOfTotalScore:) interval:0.3];     
    
        //addTotalScore
        //CGSize screenSize = [[CCDirector sharedDirector] winSize];
        
        CCLabelTTF* my_score = nil;
        

        //change size by diff version
        if (1 == playID) 
        {
            my_score = [CCLabelTTF labelWithString:@" SCORE:" fontName:@"lmgwtl" fontSize:22];
            my_score.position = [GameMainScene sharedMainScene].scorePos;
        }
        //play2
        else
        {
            my_score = [CCLabelTTF labelWithString:@"P2SCORE:" fontName:@"lmgwtl" fontSize:22];
            my_score.position = [GameMainScene sharedMainScene].scorePlay2Pos;
        }
        my_score.color = ccc3(255,0,0);
        [self addChild:my_score]; 
        //and HighestScore
        
        CCLabelTTF* my_highestscore = [CCLabelTTF labelWithString:@"BEST:" fontName:@"lmgwtl.ttf" fontSize:22];
        my_highestscore.color = ccc3(255,0,0);
        //change size by diff version
        CGPoint distance1 = CGPointMake(0, -30);
        CGPoint distance2 = CGPointMake(40, 17);
        CGPoint distance3 = CGPointMake(40, 19);
        my_highestscore.position =  ccpAdd([GameMainScene sharedMainScene].scorePos, distance1);     
        [self addChild:my_highestscore];
        //初始化得分
        my_nowlevelscore = 0;
        
        totalScoreLabel = [CCLabelBMFont labelWithString:@"0" fntFile:@"bitmapNum.fnt"];
        //change size by diff version
        totalScoreLabel.position = ccpAdd(my_score.position, distance2);
        totalScoreLabel.anchorPoint = CGPointMake(0.5f, 1.0f);
        totalScoreLabel.scale = 0.55;
        [self addChild:totalScoreLabel z:-2];
        
        int temp_hightestscore;
        temp_hightestscore = [self getGameHighestScore:gamelevel];
        hightestTotalScoreLabel = [CCLabelBMFont labelWithString:@"0" fntFile:@"bitmapNum.fnt" ];
        [hightestTotalScoreLabel setString:[NSString stringWithFormat:@"%i",temp_hightestscore]];
        //change size by diff version
        hightestTotalScoreLabel.position = ccpAdd([GameMainScene sharedMainScene].scorePos, distance3);
        hightestTotalScoreLabel.anchorPoint = CGPointMake(0.5, 2.0f);
        hightestTotalScoreLabel.scale = 0.55;
        [self addChild:hightestTotalScoreLabel z:-2];
        
    
    
    }
    return self;
}

//初始化得分规则
-(void)setScoreSetRules
{
    my_struct_gameScore_rules.cheese = 3;
    my_struct_gameScore_rules.candy = 2;
    my_struct_gameScore_rules.apple  = 1;
    my_struct_gameScore_rules.Once4circle = 10;
    my_struct_gameScore_rules.Once5circle = 15;
    my_struct_gameScore_rules.Once6circle = 20;
}

//获得当前关卡最高得分
//Get The Score From gameScore.m
-(int)getGameHighestScore:(int)level;
{
    
    NSString *str_game_level = [NSString stringWithFormat:@"%d",level];    
    
    NSInteger highestscore = [standardUserDefaults integerForKey:str_game_level];    
    
    return highestscore;
}



//叠加奖励得分函数：2次消求间隔小于5s
-(void)calculateTimeAward:(int)gameLevel
{
    CCLOG(@"Into calculateTimeAward\n\n");
    
    CCLOG(@"之前的my_nowlevelscore %d",my_nowlevelscore);
    award_nowlevelscore = award_nowlevelscore + 1;
    my_nowlevelscore += award_nowlevelscore;
    CCLabelBMFont*  getContinuousAward = [CCLabelBMFont labelWithString:@"0" fntFile:@"blackcute.fnt"];
    [getContinuousAward setString:[NSString stringWithFormat:@"%i", award_nowlevelscore]];
    
    getContinuousAward.position = CGPointMake(random()%20 + 10, 80);
    getContinuousAward.anchorPoint = CGPointMake(0.5f, 1.0f);
    getContinuousAward.scale = 1.2;
    getContinuousAward.color = ccBLUE;
    
    //将5个动作组合为一个序列，注意不要忘了用nil结尾。 
    id ac0_ = [CCToggleVisibility action]; 
    id ac1_ = [CCMoveTo actionWithDuration:2 position:ccp(50,300)]; 
    id ac3_ = [CCDelayTime actionWithDuration:3];
    [getContinuousAward runAction:[CCSequence actions:ac3_,ac1_, ac0_,nil]]; 
    
    [self addChild:getContinuousAward z:-1 tag:AccumulateAwardScoreTag];
    [self schedule:@selector(removeAccumulateAwardScore:) interval:6];
    //加入特效
    CCParticleSystem* system;
    system = [ARCH_OPTIMAL_PARTICLE_SYSTEM particleWithFile:@"redscore.plist"];
    system.positionType = kCCPositionTypeFree;
    system.autoRemoveOnFinish = YES;
    system.position = getContinuousAward.position;
    [self addChild:system z:-2 tag:AccumulateAwardScoreSpeciallyTag];
    
    //叠加得分音效
    [CommonLayer playAudio:GetScore];
    
    
    //更新得分
    //延迟奖励得分调用更改    
    [self schedule:@selector(setScoreLabel:) interval:6];   
}


//连续消球奖励得分
-(void)calculateContinuousCombineAward:(int)continuousflag 
                               myLevel:(int)gameLevel
{
    //CCLOG(@"INTO calculateContinuousCombineAward\n\n");
    int tempnowscore = (continuousflag-1)*3;
    
    if (continuousflag <= 1) 
    {
        return;
    }
    my_nowlevelscore += (continuousflag-1)*3;
    
    CCLabelBMFont*  getContinuousAward = [CCLabelBMFont labelWithString:@"0" fntFile:@"bluecute.fnt"];
    [getContinuousAward setString:[NSString stringWithFormat:@"%i", tempnowscore]];
    
    getContinuousAward.position = CGPointMake(random()%20 + 10, 80);
    getContinuousAward.anchorPoint = CGPointMake(0.5f, 1.0f);
    getContinuousAward.scale = 1.1;
    getContinuousAward.color = ccBLUE;

    //将5个动作组合为一个序列，注意不要忘了用nil结尾。 
    id ac0_ = [CCToggleVisibility action]; 
    id ac1_ = [CCMoveTo actionWithDuration:2 position:ccp(50,300)]; 
    id ac3_ = [CCDelayTime actionWithDuration:3];
    [getContinuousAward runAction:[CCSequence actions:ac3_,ac1_, ac0_,nil]]; 
    
    [self addChild:getContinuousAward z:-1 tag:ContinuousAwardScoreTag];
    [self schedule:@selector(removeContinuousAwardScore:) interval:6];
    //加入特效
    CCParticleSystem* system;
    system = [ARCH_OPTIMAL_PARTICLE_SYSTEM particleWithFile:@"scoreblue.plist"];
    system.positionType = kCCPositionTypeFree;
    system.autoRemoveOnFinish = YES;
    system.position = getContinuousAward.position;
    [self addChild:system z:-2 tag:ContinuousAwardScoreSpeciallyTag];
    
    //得分音效
    [CommonLayer playAudio:GetScore];

    
    //更新得分
    //延迟奖励得分调用更改    
    [self schedule:@selector(setScoreLabel:) interval:6];    
    //[totalScoreLabel setString:[NSString stringWithFormat:@"x%i", my_nowlevelscore]];
        
    
}







-(void)setScoreLabel:(ccTime) dt 
{
    [self unschedule:@selector(setScoreLabel:)];
    //更新得分
    //CCLOG(@"Into setScoreLable\n\n");
    [totalScoreLabel setString:[NSString stringWithFormat:@"%i", my_nowlevelscore]];    
}


-(void)removeAccumulateAwardScore: (ccTime) dt
{
    static int moveBaseScoreCount = 0;
    moveBaseScoreCount++;
    CCNode* baseScore = [self getChildByTag:AccumulateAwardScoreTag];
    CCNode* speciallySystem = [self getChildByTag:AccumulateAwardScoreSpeciallyTag];
    
    speciallySystem.position = baseScore.position;    
    
    //5s
    if (moveBaseScoreCount >= 100)
    {
        moveBaseScoreCount = 0;
        [self unschedule:@selector(removeAccumulateAwardScore:)];   
        //消除特效
        [self removeChildByTag:AccumulateAwardScoreTag cleanup:YES];
        [self removeChildByTag:AccumulateAwardScoreSpeciallyTag cleanup:YES];
    }   
}


-(void)removeContinuousAwardScore: (ccTime) dt
{
    static int moveBaseScoreCount = 0;
    moveBaseScoreCount++;
    CCNode* baseScore = [self getChildByTag:ContinuousAwardScoreTag];
    CCNode* speciallySystem = [self getChildByTag:ContinuousAwardScoreSpeciallyTag];
    
    speciallySystem.position = baseScore.position;    
    
    //5s
    if (moveBaseScoreCount >= 100)
    {
        moveBaseScoreCount = 0;
        [self unschedule:@selector(removeContinuousAwardScore:)];   
        //消除特效
        [self removeChildByTag:ContinuousAwardScoreSpeciallyTag cleanup:YES];
        [self removeChildByTag:ContinuousAwardScoreTag cleanup:YES];
    }   
}


-(void)moveBaseScore: (ccTime) dt
{
    
    static int moveBaseScoreCount = 0;
    moveBaseScoreCount++;
    CCNode* baseScore = [self getChildByTag:BaseScoreTag];
    CCNode* speciallySystem = [self getChildByTag:BaseScoreSpeciallyTag];
    
    speciallySystem.position = baseScore.position;    
    
    //5s
    if (moveBaseScoreCount >= 100)
    {
        moveBaseScoreCount = 0;
        [self unschedule:@selector(moveBaseScore:)];   
        //消除特效
        [self removeChildByTag:BaseScoreTag cleanup:YES];
        [self removeChildByTag:BaseScoreSpeciallyTag cleanup:YES];
        
        
    }   
    
}
-(void)removeAwardScore: (ccTime) dt
{
    static int removeAwardScoreCount = 0;
    removeAwardScoreCount++;
    CCNode* awardScore = [self getChildByTag:AwardScoreTag];
    CCNode* speciallySystem = [self getChildByTag:AwardScoreSpeciallyTag];
    
    speciallySystem.position = awardScore.position;
    
    //5s
    if (removeAwardScoreCount >= 80)
    {
        removeAwardScoreCount = 0;
        [self unschedule:@selector(removeAwardScore:)];   
        //消除特效
        [self removeChildByTag:AwardScoreTag cleanup:YES];
        [self removeChildByTag:AwardScoreSpeciallyTag cleanup:YES];
        
        
    }
}





//判断得分函数
-(void)calculateConsistentCombineScore:(int)mygamelevel
                            oneTimeScoreNumber:(int)oneTimeScoreNum
                              foodType:(int)myfoodType
                                Cheese:(int)cheesenum
                                 Candy:(int)candynum
                                 Apple:(int)applenum
                             DelayTime:(int)delayTimeTmp
{
    CCLOG(@"Into calculateConsistentCombineScore\n");
    int tempnowscore = 0;
    int tmpDelayTime = delayTimeTmp;
    //基本得分：
    switch (myfoodType) {
        case 0:
            tempnowscore = (oneTimeScoreNum)*my_struct_gameScore_rules.apple;
            break;
        case 1:
            tempnowscore = (oneTimeScoreNum)*my_struct_gameScore_rules.candy;    
            break;
        case 2:    
            tempnowscore = (oneTimeScoreNum)*my_struct_gameScore_rules.cheese;   
            break;
        default:
            CCLOG(@"No myfoodType Means something is wrong check!  \n");            
            break;
    }
    
    my_nowlevelscore += tempnowscore;
    //接特效
    //加分特效
    CCLabelBMFont*  getBaseScore = [CCLabelBMFont labelWithString:@"0" fntFile:@"yellowcute.fnt"];
    [getBaseScore setString:[NSString stringWithFormat:@"%i", tempnowscore]];
    
    getBaseScore.position = CGPointMake(random()%20 + 10, 80);
    getBaseScore.anchorPoint = CGPointMake(0.5f, 1.0f);
    getBaseScore.scale = 1;
    getBaseScore.color = ccYELLOW;
    [self addChild:getBaseScore z:-2 tag:BaseScoreTag];
    //加入得分特效
    [self schedule:@selector(moveBaseScore:) interval:0.05];
    id ac0 = [CCToggleVisibility action]; 
    id ac1 = [CCMoveTo actionWithDuration:2 position:ccp(50,300)];     
    id ac3 = [CCDelayTime actionWithDuration:tmpDelayTime++];

    //将5个数作组合为一个序列，注意不要忘了用nil结尾 
    [getBaseScore runAction:[CCSequence actions:ac3, ac1, ac0,nil]]; 
    //加入特效
    CCParticleSystem* system;
    system = [ARCH_OPTIMAL_PARTICLE_SYSTEM particleWithFile:@"star.plist"];
    system.positionType = kCCPositionTypeFree;
    system.autoRemoveOnFinish = YES;
    system.position = getBaseScore.position;
    [self addChild:system z:-2 tag:BaseScoreSpeciallyTag];
    //得分音效
    [CommonLayer playAudio:GetScore];
    
    //得分特效
    //延迟得分效果 
    [self schedule:@selector(setScoreLabel:) interval:4];
    //[totalScoreLabel setString:[NSString stringWithFormat:@"x%i", my_nowlevelscore]];
    
    
    if (oneTimeScoreNum <= 3) 
    {
        return;
    }
    //奖励得分
    switch (myfoodType) {
        case 0:
            tempnowscore = (oneTimeScoreNum-3)*my_struct_gameScore_rules.apple;
            break;
        case 1:
            tempnowscore = (oneTimeScoreNum-3)*my_struct_gameScore_rules.candy;    
            break;
        case 2:    
            tempnowscore = (oneTimeScoreNum-3)*my_struct_gameScore_rules.cheese;   
            break;
        default:
            CCLOG(@"No myfoodType Means something is wrong check!  \n");            
            break;
    }

    my_nowlevelscore += tempnowscore;
    //接特效
    //加分特效

    CCLabelBMFont*  getAwardScore = [CCLabelBMFont labelWithString:@"0" fntFile:@"bitmapRed.fnt"];
    [getAwardScore setString:[NSString stringWithFormat:@"%i", tempnowscore]];
    getAwardScore.position = CGPointMake(random()%20 + 20, 80);
    getAwardScore.anchorPoint = CGPointMake(0.5f, 1.0f);
    getAwardScore.scale = 0.6;
    getAwardScore.color = ccRED;

    //将5个劢作组合为一个序列，注意丌要忘了用nil结尾。 
    id ac0_ = [CCToggleVisibility action]; 
    id ac1_ = [CCMoveTo actionWithDuration:2 position:ccp(50,300)]; 
    id ac3_ = [CCDelayTime actionWithDuration:tmpDelayTime];
    [getAwardScore runAction:[CCSequence actions:ac3_,ac1_, ac0_,nil]]; 
    
    [self addChild:getAwardScore z:-1 tag:AwardScoreTag];
    [self schedule:@selector(removeAwardScore:) interval:0.05];
    //加入特效
    CCParticleSystem* system2;
    //system2 = [ARCH_OPTIMAL_PARTICLE_SYSTEM particleWithFile:@"get_score_02.plist"];
    system2 = [ARCH_OPTIMAL_PARTICLE_SYSTEM particleWithFile:@"get_score_02.plist"];
    system2.positionType = kCCPositionTypeFree;
    system2.autoRemoveOnFinish = YES;
    system2.position = getAwardScore.position;
    [self addChild:system2 z:-2 tag:AwardScoreSpeciallyTag];
    //得分音效
    [CommonLayer playAudio:GetScore];

    
    //延迟得分
    [self schedule:@selector(setScoreLabel:) interval:5];
    //[totalScoreLabel setString:[NSString stringWithFormat:@"x%i", my_nowlevelscore]];
}

-(void)changeScore:(int)score DelayTime:(int)scoreDelayTime type:(int)scoreType
{
    //接特效
    //加分特效
    CCLabelBMFont*  getBaseScore = [CCLabelBMFont labelWithString:@"0" fntFile:@"yellowcute.fnt"];
    if (scoreType == 1) {
        [getBaseScore setString:[NSString stringWithFormat:@"-%i", score]];
        my_nowlevelscore -= score;
        if (my_nowlevelscore < 0) {
            my_nowlevelscore = 0;
        }
    }
    else 
    {
        [getBaseScore setString:[NSString stringWithFormat:@"+%i", score]];
        my_nowlevelscore += score;
    }
    
    getBaseScore.position = CGPointMake(random()%30 + 10, 80);
    getBaseScore.anchorPoint = CGPointMake(0.5f, 1.0f);
    getBaseScore.scale = 1;
    getBaseScore.color = ccYELLOW;
    [self addChild:getBaseScore z:-2 tag:PropertyScoreTag];
    //加入得分特效
    [self schedule:@selector(removePropertyScore:) interval:0.05];
    id ac0 = [CCToggleVisibility action]; 
    id ac1 = [CCMoveTo actionWithDuration:2 position:ccp(50,300)];     
    id ac3 = [CCDelayTime actionWithDuration:scoreDelayTime];
    
    //将5个数作组合为一个序列，注意不要忘了用nil结尾 
    [getBaseScore runAction:[CCSequence actions:ac3, ac1, ac0,nil]]; 
    //加入特效
    CCParticleSystem* system;
    system = [ARCH_OPTIMAL_PARTICLE_SYSTEM particleWithFile:@"star.plist"];
    system.positionType = kCCPositionTypeFree;
    system.autoRemoveOnFinish = YES;
    system.position = getBaseScore.position;
    [self addChild:system z:-2 tag:PropertyScoreSpeciallyTag];
    //得分音效
    [CommonLayer playAudio:GetScore];
    
    //得分特效
    //延迟得分效果 
    [self schedule:@selector(setScoreLabel:) interval:4];
}


-(void)removePropertyScore: (ccTime) dt
{
    static int removePropertyScoreCount = 0;
    removePropertyScoreCount++;
    CCNode* awardScore = [self getChildByTag:PropertyScoreTag];
    CCNode* speciallySystem = [self getChildByTag:PropertyScoreSpeciallyTag];
    
    speciallySystem.position = awardScore.position;
    
    //5s
    if (removePropertyScoreCount >= 80)
    {
        removePropertyScoreCount = 0;
        [self unschedule:@selector(removePropertyScore:)];   
        //消除特效
        [self removeChildByTag:PropertyScoreTag cleanup:YES];
        [self removeChildByTag:PropertyScoreSpeciallyTag cleanup:YES];
        
        
    }
}

//update 与  [self scheduleUpdate] 对应
-(void) update:(ccTime)delta
{
    CCLOG(@"Into updateLabelOfTotalScore\n");
    
}

-(void)updateLabelOfTotalScore:(ccTime)delta 
{
    //CCLOG(@"Into updateLabelOfTotalScore  哈哈哈哈\n");
    
    
    //int temp_myscore;
    int temp_highestscore;
    //temp_myscore = [self getGameNowScore:gamelevel];
    temp_highestscore = [self getGameHighestScore:gamelevel];
    
    //[totalScoreLabel setString:[NSString stringWithFormat:@"x%i", temp_myscore]];
    [hightestTotalScoreLabel setString:[NSString stringWithFormat:@"%i",temp_highestscore]];
    
}

//更新得分的左上角标签
-(int)updateScoreLabel:(int)now_level_score my_highest_level_score:(int)highest_level_score
{
    CCLOG(@"Into updateScoreLabel  哈哈哈哈\n");
    
    //[totalScoreLabel setString:[NSString stringWithFormat:@"x%i",now_level_score]];
    [hightestTotalScoreLabel setString:[NSString stringWithFormat:@"%i",highest_level_score]];
    return 0;
}



//when level is over ,call the function
-(CCArray *)calculateScoreWhenGameIsOver:(int)level timestamp:(int)mytimestamp
{
    CCLOG(@"Into calculateScoreWhenGameIsOver\n");
    CCLOG(@"my_nowlevelscore is %d",my_nowlevelscore);
    CCLOG(@"mytimestamp is %d",mytimestamp);
    
    //返回的基础得分
    [LevelScore insertObject:[NSNumber numberWithInteger:(int)(my_nowlevelscore)] atIndex:0];
    
    //rewardTimeScore 返回的时间奖励得分    
    int rewardTimeScore;
    
    int timelimit = [GameMainScene sharedMainScene].mainscenParam.candyCount 
                    * [GameMainScene sharedMainScene].mainscenParam.candyFrequency + RewardTimeScore  * ((level - 1)/10 + 1);
    
    if (mytimestamp <= timelimit) 
    {
        rewardTimeScore = (timelimit - mytimestamp)/1;
    }
    else
    {    
        rewardTimeScore = 0;
    }
    
    [LevelScore insertObject:[NSNumber numberWithInteger:rewardTimeScore] atIndex:1];  
    
    my_nowlevelscore += rewardTimeScore;
    
    int temphighestscore = [self getGameHighestScore:level];   
    
    //更新累计总得分
    //初始化2个元素
    int roalType = [GameMainScene sharedMainScene].roleType;
    NSString *strTotalScore = nil;
    if (3 == roalType) 
    {
        strTotalScore = [NSString stringWithFormat:@"Totalscore_Bird"];
    }
    else if (2 == roalType) 
    {
        strTotalScore = [NSString stringWithFormat:@"Totalscore_Pig"];
    }
    else 
    {
        strTotalScore = [NSString stringWithFormat:@"Totalscore_Panda"];
    }
    int  totalRoleScore = [[[MyGameScore sharedScore] standardUserDefaults] integerForKey:strTotalScore]; 

    totalRoleScore += my_nowlevelscore;
        
    [[[MyGameScore sharedScore] standardUserDefaults] setInteger:totalRoleScore forKey:strTotalScore]; 
    
    //更新累计总时间
    NSString *strTotalTime = [NSString stringWithFormat:@"Playtime"];
    int temTotalTime = [[[MyGameScore sharedScore] standardUserDefaults] integerForKey:strTotalTime]; 
    temTotalTime += mytimestamp;
    [[[MyGameScore sharedScore] standardUserDefaults] setInteger:temTotalTime forKey:strTotalTime]; 
    
    //完成 成就
    NSString* tap1 = @"1_Tap";
    GameKitHelper* gkHelper = [GameKitHelper sharedGameKitHelper];
    GKAchievement* achievement = [gkHelper getAchievementByID:tap1];
    if (achievement.completed == NO)
    {
        float percent = achievement.percentComplete + 100;
        [gkHelper reportAchievementWithID:tap1 percentComplete:percent];
    }
    
    
    if (temTotalTime > 100) 
    {
        NSString* playedTenSeconds = @"PlayedForTenSeconds";
        GameKitHelper* gkHelper = [GameKitHelper sharedGameKitHelper];
        GKAchievement* achievement = [gkHelper getAchievementByID:playedTenSeconds];
        if (achievement.completed == NO)
        {
            float percent = achievement.percentComplete + 100;
            [gkHelper reportAchievementWithID:playedTenSeconds percentComplete:percent];
        }

    }
    

    if (totalRoleScore > 500) {
        NSString* achievementTag = @"Earn500Point";
        GameKitHelper* gkHelper = [GameKitHelper sharedGameKitHelper];
        GKAchievement* achievement = [gkHelper getAchievementByID:achievementTag];
        if (achievement.completed == NO)
        {
            float percent = achievement.percentComplete + 100;
            [gkHelper reportAchievementWithID:achievementTag percentComplete:percent];
        }
    }
    
    if (totalRoleScore > 1000) {
        NSString* achievementTag = @"Earn1000Point";
        GameKitHelper* gkHelper = [GameKitHelper sharedGameKitHelper];
        GKAchievement* achievement = [gkHelper getAchievementByID:achievementTag];
        if (achievement.completed == NO)
        {
            float percent = achievement.percentComplete + 100;
            [gkHelper reportAchievementWithID:achievementTag percentComplete:percent];
        }
    } 
    

    //完成成就 end
    
    int isnewrecord=0;
    if (my_nowlevelscore > temphighestscore)
    {
        //直接将int 装成string  当做关卡的值传进去        
        NSString *str_gamelevel = [NSString stringWithFormat:@"%d",level];
        [[[MyGameScore sharedScore] standardUserDefaults] setInteger:my_nowlevelscore forKey:str_gamelevel];        
        
        //更新左上角关卡的值 
        
        [hightestTotalScoreLabel setString:[NSString stringWithFormat:@"%i",my_nowlevelscore]];        
        [totalScoreLabel setString:[NSString stringWithFormat:@"%i", my_nowlevelscore]]; 
        isnewrecord=1;
    }
    else
    {
        [totalScoreLabel setString:[NSString stringWithFormat:@"%i", my_nowlevelscore]];
    }
    
    //返回的星级评定

    int starNum ;
    if (my_nowlevelscore >= [GameMainScene sharedMainScene].mainscenParam.candyCount * 3)
    {
        starNum = 3;
    }
    else if (my_nowlevelscore >= [GameMainScene sharedMainScene].mainscenParam.candyCount * 2)
    {
        starNum = 2;
    }
    else if (my_nowlevelscore >= [GameMainScene sharedMainScene].mainscenParam.candyCount * 1+level-1)
    {
        starNum = 1;
    }
    else
    {
        starNum = 0;
    }
    
    //直接将int 装成string  当做关卡的值传进去 
    //增加与最大值的比较，只有大于最大值时才更新
    int maxStar=[self getGameStarNumber:level];
    if(starNum>maxStar)
    {
        NSString *str_starlevel = [NSString stringWithFormat:@"%d",level];
        str_starlevel = [str_starlevel stringByAppendingFormat:@"starNum"];
        [[[MyGameScore sharedScore] standardUserDefaults] setInteger:starNum forKey:str_starlevel];         
    }
    //提交缓存文件
    [[[MyGameScore sharedScore] standardUserDefaults] synchronize];
    [LevelScore insertObject:[NSNumber numberWithInteger:starNum] atIndex:2];  
    [LevelScore insertObject:[NSNumber numberWithInteger:isnewrecord] atIndex:3]; 
    return LevelScore;
    
}

//获得当前关卡星级评定
-(int)getGameStarNumber:(int)level
{
    NSString *str_starlevel = [NSString stringWithFormat:@"%d",level];
    str_starlevel = [str_starlevel stringByAppendingFormat:@"starNum"];    
    
    NSInteger starNum = [standardUserDefaults integerForKey:str_starlevel];    
    
    return starNum;
}

-(void) dealloc
{
    [LevelScore release];

	[super dealloc];
}


@end










