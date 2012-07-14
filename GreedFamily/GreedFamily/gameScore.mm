//
//  gameScore.mm
//  GreedFamily
//
//  Created by 晋 刘 on 12-6-2.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import "gameScore.h"
#import "GameMainScene.h"
/*
 @interface gameScore (PrivateMethods)
 -(void)updateLabelOfTotalScore:(ccTime)delta;
 @end
 */







@implementation gameScore

NSUserDefaults * standardUserDefaults;

static gameScore  *instanceOfgameScore;
+(gameScore *)sharedgameScore
{
    NSAssert(nil != instanceOfgameScore, @"Storage instance not yet initialized!");
    
    return instanceOfgameScore;
}

-(id)init
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
        //[self scheduleUpdate];
        
        //MyGameScore* p_sharedScrore = [MyGameScore sharedScore];
        /*
         p_sharedScrore = [MyGameScore sharedScore];
         [p_sharedScrore synchronize];
         CCLOG(@"读取到的  is %d",p_sharedScrore.data.level1HighestScore);           
         
         my_struct_gameScore = p_sharedScrore.data;
         int i;
         my_struct_gameScore.level1HighestScore = 12;
         
         p_sharedScrore.data = my_struct_gameScore;
         
         CCLOG(@"修改后的  is %d",p_sharedScrore.data.level1HighestScore);   
         
         [p_sharedScrore synchronize];
         */
        /*
         NSString *saveStr1 = @"我是";   
         NSString *saveStr2 = @"数据";   
         int i = 3;
         NSArray *array = [NSArray arrayWithObjects:saveStr1, saveStr2, i,nil];            
         //Save   
         NSUserDefaults *saveDefaults = [NSUserDefaults standardUserDefaults];   
         [saveDefaults setObject:array forKey:@"SaveKey"];   
         //用于测试是否已经保存了数据   
         saveStr1 = @"hhhhhhiiii";   
         saveStr2 =@"mmmmmmiiii";  
         
         //---Load   
         array = [saveDefaults objectForKey:@"SaveKey"];   
         saveStr1 = [array objectAtIndex:0];   
         saveStr2 = [array objectAtIndex:1];   
         i = [array objectAtIndex:1];   
         CCLOG(@"str:%@",saveStr1);   
         CCLOG(@"astr:%@",saveStr2);  
         CCLOG(@"astr:%@",saveStr2); 
         */
        
        // create a standardUserDefaults variable
        
        standardUserDefaults = [[MyGameScore sharedScore] standardUserDefaults];
        
        // saving an NSString
        //[standardUserDefaults setObject:@"mystring" forKey:@"string"];
        
        // saving an NSInteger
        //[standardUserDefaults setInteger:42 forKey:@"integer"];
        
        // saving a Double
        //[standardUserDefaults setDouble:3.1415 forKey:@"double"];
        
        // saving a Float
        //[standardUserDefaults setFloat:3.1415 forKey:@"float"];
        
        // synchronize the settings
        //[standardUserDefaults synchronize];
        
        
        
        // getting an NSString object
        //NSString *myString = [standardUserDefaults stringForKey:@"string"];
        
        
        
        // getting an NSInteger object
        //NSInteger myInt = [standardUserDefaults integerForKey:@"integer"];
        
        
        //NSInteger level1 = [standardUserDefaults integerForKey:@"level1HighestScore"];
        
        //CCLOG(@"level1 highest score is %d",level1);
        
        // getting an Float object
        //float myFloat = [standardUserDefaults floatForKey:@"float"];
        
        
        
        //[self schedule:@selector(updateLabelOfTotalScore:) interval:1 MyFlag:1];     
        
        //不需要在update 调用 在调用的时候就做判断 进行存储
        //初始化时需要进行一次更新
        [self schedule:@selector(updateLabelOfTotalScore:) interval:0.3];     
    }
    
    
    //addTotalScore
    CGSize screenSize = [[CCDirector sharedDirector] winSize];
    
    CCLabelTTF* my_score = [CCLabelTTF labelWithString:@"SCORE:" fontName:@"Marker Felt" fontSize:20];
    
    my_score.color = ccc3(255,0,0);
    
    my_score.position = CGPointMake(25, screenSize.height - 16);
    [self addChild:my_score]; 
    
    
    //and HighestScore
    
    CCLabelTTF* my_highestscore = [CCLabelTTF labelWithString:@"BEST:" fontName:@"Marker Felt" fontSize:20];
    
    my_highestscore.color = ccc3(255,0,0);
    my_highestscore.position = CGPointMake(25,screenSize.height - 46);
    [self addChild:my_highestscore];
    
    
    
    
    
    totalScoreLabel = [CCLabelBMFont bitmapFontAtlasWithString:@"0" fntFile:@"bitmapfont.fnt"];
    totalScoreLabel.position = CGPointMake(73, screenSize.height - 5);
    totalScoreLabel.anchorPoint = CGPointMake(0.5f, 1.0f);
    totalScoreLabel.scale = 0.3;
    [self addChild:totalScoreLabel z:-2];
    
    int temp_hightestscore;
    temp_hightestscore = [self getGameHighestScore:1];
    hightestTotalScoreLabel = [CCLabelBMFont bitmapFontAtlasWithString:@"0" fntFile:@"bitmapfont.fnt" ];
    [hightestTotalScoreLabel setString:[NSString stringWithFormat:@"%i",temp_hightestscore]];
    hightestTotalScoreLabel.position = CGPointMake(73,screenSize.height - 15);
    hightestTotalScoreLabel.anchorPoint = CGPointMake(0.5, 2.0f);
    hightestTotalScoreLabel.scale = 0.3;
    [self addChild:hightestTotalScoreLabel z:-2];
    
    
    
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

//获取当前关卡得分
/*
-(int )getGameNowScore:(int)level
{
    if (level == 1)
    {
        return my_struct_gameScore.level1NowScore;
    }
    if(level == 2)
    {
        return my_struct_gameScore.level2NowScore;
    }    
    if(level == 3)
    {
        return my_struct_gameScore.level3NowScore;
    }  
    if(level == 4)
    {
        return my_struct_gameScore.level4NowScore;
    }  
    if(level == 5)
    {
        return my_struct_gameScore.level5NowScore;
    }  
    
    CCLOG(@"Into getGameNowScore ERROR/n");
    return 0;
    
}
 */

//获得当前关卡最高得分
//Get The Score From gameScore.m
-(int)getGameHighestScore:(int)level;
{
    
    NSString *str_game_level = [NSString stringWithFormat:@"%d",level];    
    
    NSInteger highestscore = [standardUserDefaults integerForKey:str_game_level];    
    
    return highestscore;
    /*    
     if (level == 1)
     {
     NSInteger level1 = [standardUserDefaults integerForKey:@"level1HighestScore"];
     return level1;
     }
     if(level == 2)
     {
     NSInteger level2 = [standardUserDefaults integerForKey:@"level2HighestScore"];        
     return level2;
     }    
     if(level == 3)
     {
     NSInteger level3 = [standardUserDefaults integerForKey:@"level3HighestScore"];        
     return level3;
     }  
     if(level == 4)
     {
     NSInteger level4 = [standardUserDefaults integerForKey:@"level4HighestScore"];        
     return level4;
     }  
     if(level == 5)
     {
     NSInteger level5 = [standardUserDefaults integerForKey:@"level5HighestScore"];        
     return level5;
     }  
     
     CCLOG(@"Into getGameHighestScore ERROR\n");
     return 0;
     */
}


//时间奖励得分函数
-(void)calculateTimeAward:(int)gameLevel
{
    CCLOG(@"Into calculateTimeAward\n\n");
    
    CCLOG(@"之前的my_nowlevelscore %d",my_nowlevelscore);
    award_nowlevelscore = award_nowlevelscore + 1;
}


//连续消球得分
-(void)calculateContinuousCombineAward:(int)continuousflag 
                               myLevel:(int)gameLevel
{
    CCLOG(@"INTO calculateContinuousCombineAward\n\n");
    my_nowlevelscore = my_nowlevelscore + (continuousflag-1)*2;
    
    //获取游戏关卡的历史最高分
    int temphighestscore = [self getGameHighestScore:gameLevel];
    
    CCLOG(@"temphighestscore: %d\n",temphighestscore);    
    
    
    if (my_nowlevelscore > temphighestscore) 
    {
        
        //直接将int 装成string  当做关卡的值传进去        
        NSString *str_gamelevel = [NSString stringWithFormat:@"%d",gameLevel];
        [[[MyGameScore sharedScore] standardUserDefaults] setInteger:my_nowlevelscore forKey:str_gamelevel];   
        
        //更新左上角关卡的值 
        
        [hightestTotalScoreLabel setString:[NSString stringWithFormat:@"x%i",my_nowlevelscore]];
        
        [totalScoreLabel setString:[NSString stringWithFormat:@"x%i", my_nowlevelscore]];      
    }        
    
    
    
    else
    {
        [totalScoreLabel setString:[NSString stringWithFormat:@"x%i", my_nowlevelscore]];     
    }
    
    
    
}








//一次性消掉N(N>3)个球的得分计算 传进来各种类型的球的数量   
//oneTimeScoreNum  一次消掉了多少个球
-(void)calculateConsistentCombineScore:(int)mygamelevel
                    oneTimeScoreNumber:(int)oneTimeScoreNum
                              foodType:(int)myfoodType
                                Cheese:(int)cheesenum
                                 Candy:(int)candynum
                                 Apple:(int)applenum
{
    CCLOG(@"Into calculateConsistentCombineScore\n");
    int tempnowscore = 0;
    int temphighestscore = 0;
    switch (myfoodType) {
        case 0:
            tempnowscore = (oneTimeScoreNum-3)*my_struct_gameScore_rules.apple;
            break;
        case 1:
            tempnowscore = (oneTimeScoreNum-3)*my_struct_gameScore_rules.candy;         
        case 2:    
            tempnowscore = (oneTimeScoreNum-3)*my_struct_gameScore_rules.cheese;                     
        default:
            CCLOG(@"No myfoodType Means something is wrong check!  \n");            
            break;
    }
    //奖励得分累加
    award_nowlevelscore = award_nowlevelscore + tempnowscore;
    
    //加上基础得分做判断
    CCLOG(@"applenum:%d",applenum);
    int base_score =  cheesenum*my_struct_gameScore_rules.cheese+ candynum*my_struct_gameScore_rules.candy+applenum*my_struct_gameScore_rules.apple;
    
    tempnowscore = award_nowlevelscore + base_score;
    
    
    
    my_nowlevelscore = tempnowscore;
    
    //获取游戏关卡的历史最高分
    temphighestscore = [self getGameHighestScore:mygamelevel];
    
    CCLOG(@"temphighestscore: %d\n",temphighestscore);    
    
    
    if (tempnowscore > temphighestscore) 
    {
        
        //直接将int 装成string  当做关卡的值传进去        
        NSString *str_gamelevel = [NSString stringWithFormat:@"%d",mygamelevel];
        [[[MyGameScore sharedScore] standardUserDefaults] setInteger:tempnowscore forKey:str_gamelevel];   
        
        //更新左上角关卡的值 
        
        [hightestTotalScoreLabel setString:[NSString stringWithFormat:@"x%i",tempnowscore]];
        
    }        
    
    else
    {
        [hightestTotalScoreLabel setString:[NSString stringWithFormat:@"x%i",temphighestscore]];
    }
    
    
    [totalScoreLabel setString:[NSString stringWithFormat:@"x%i", tempnowscore]];
    
    
    
    
    
    
    //NSString *str_gamelevel = [[NSString alloc] init];
    
    //str_gamelevel = [NSString stringWithFormat:@"%d",gamelevel];
    
    //CCLOG(@"转换后的string %s\n",str_gamelevel);    
    
    
    
    //[[[MyGameScore sharedScore] standardUserDefaults] setInteger:tempnowscore forKey:@"level1HighestScore"];    
    
    
    //[str_gamelevel release];
    
    
}



/*
-(void)calculateGameScore:(int)level TimesofOneTouch:(int)timesofonetouch 
         NumbersOfOneTime:(int)numbersOfOneTime 
  TheSameTypeNumOfOneTime:(int)theSameTypeNumOfOneTime
                Chocolate:(int)choclolatenum
                     Cake:(int)cakenum
                   Circle:(int)circlenum
{
    CCLOG(@"Into calculateGameScore\n");
    int tempnowscore;
    int temphighestscore;
    
    tempnowscore = choclolatenum*my_struct_gameScore_rules.chocolate+cakenum*my_struct_gameScore_rules.candy+circlenum*my_struct_gameScore_rules.circle;
    
    tempnowscore += timesofonetouch*my_struct_gameScore_rules.Once4circle+numbersOfOneTime*my_struct_gameScore_rules.Once5circle+numbersOfOneTime*my_struct_gameScore_rules.Once6circle;
    
    CCLOG(@"tempnowscore = %d\n",tempnowscore);   
    
    
    temphighestscore = tempnowscore;
    
    switch (level) {
        case 1:
            my_struct_gameScore.level1NowScore = tempnowscore;
            temphighestscore = [self getGameHighestScore:level];
            CCLOG(@"temphighestscore: %d\n",temphighestscore);
            
            if (tempnowscore > temphighestscore) {
                
                //http://codeexamples.wordpress.com/2011/02/12/nsuserdefaults-example/
                [[[MyGameScore sharedScore] standardUserDefaults] setInteger:tempnowscore forKey:@"level1HighestScore"];
                //[standardUserDefaults setInteger:temphighestscore forKey:@"level1HighestScore"];
            }
            break;
        case 2:
            my_struct_gameScore.level2NowScore = tempnowscore;
            temphighestscore = [self getGameHighestScore:level];
            if(tempnowscore > temphighestscore){
                [[[MyGameScore sharedScore] standardUserDefaults] setInteger:tempnowscore forKey:@"level2HighestScore"];                
            }
            break;            
        case 3:
            my_struct_gameScore.level3NowScore = tempnowscore;
            temphighestscore = [self getGameHighestScore:level];
            if(tempnowscore > temphighestscore){
                [[[MyGameScore sharedScore] standardUserDefaults] setInteger:tempnowscore forKey:@"level3HighestScore"];                
            }
            break;   
        case 4:
            my_struct_gameScore.level4NowScore = tempnowscore;
            temphighestscore = [self getGameHighestScore:level];
            if(tempnowscore > temphighestscore){
                [[[MyGameScore sharedScore] standardUserDefaults] setInteger:tempnowscore forKey:@"level4HighestScore"];                
            }
            break;   
        case 5:
            my_struct_gameScore.level5NowScore = tempnowscore;
            temphighestscore = [self getGameHighestScore:level];
            if(tempnowscore > temphighestscore){
                [[[MyGameScore sharedScore] standardUserDefaults] setInteger:tempnowscore forKey:@"level5HighestScore"];                
            }
            break;               
        default:
            CCLOG(@"Into default  Meanings Something is Wrong  Check \n");
            break;
    }
    
    
    
}
*/


//update 与  [self scheduleUpdate] 对应
-(void) update:(ccTime)delta
{
    CCLOG(@"Into updateLabelOfTotalScore\n");
    
}



/*
 -(void) update:(ccTime)delta
 {
 //CCLOG(@"Into updateLabelOfTotalScore\n");
 int temp_myscore;
 temp_myscore = [self getGameNowScore:1];
 //CCLOG(@"temp_myscore:%d",temp_myscore);
 [totalScoreLabel setString:[NSString stringWithFormat:@"x%i", temp_myscore]];
 }
 */


-(void)updateLabelOfTotalScore:(ccTime)delta 
{
    //CCLOG(@"Into updateLabelOfTotalScore  哈哈哈哈\n");
    
    
    //int temp_myscore;
    int temp_highestscore;
    //temp_myscore = [self getGameNowScore:gamelevel];
    temp_highestscore = [self getGameHighestScore:gamelevel];
    
    //[totalScoreLabel setString:[NSString stringWithFormat:@"x%i", temp_myscore]];
    [hightestTotalScoreLabel setString:[NSString stringWithFormat:@"x%i",temp_highestscore]];
    
}

//更新得分的左上角标签
-(int)updateScoreLabel:(int)now_level_score my_highest_level_score:(int)highest_level_score
{
    CCLOG(@"Into updateScoreLabel  哈哈哈哈\n");
    
    //[totalScoreLabel setString:[NSString stringWithFormat:@"x%i",now_level_score]];
    [hightestTotalScoreLabel setString:[NSString stringWithFormat:@"x%i",highest_level_score]];
    return 0;
}

//when level is over ,call the function
-(CCArray *)calculateScoreWhenGameIsOver:(int)level
{
    CCLOG(@"Into calculateScoreWhenGameIsOver\n");

    CCLOG(@"my_nowlevelscore is %d",my_nowlevelscore);
    CCLOG(@"award_nowlevelscore is %d",award_nowlevelscore);   

    [LevelScore insertObject:[NSNumber numberWithInteger:(my_nowlevelscore-award_nowlevelscore)] atIndex:0];
    
    [LevelScore insertObject:[NSNumber numberWithInteger:award_nowlevelscore] atIndex:1];  
    

    return LevelScore;

}


@end










