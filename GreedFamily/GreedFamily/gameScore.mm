//
//  gameScore.mm
//  GreedFamily
//
//  Created by 晋 刘 on 12-6-2.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import "gameScore.h"


@implementation gameScore


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
        
        [self scheduleUpdate];
        
        //[self schedule:@selector(updateLabelOfTotalScore:) interval:1];        
        
    }
    

    //addTotalScore
    CGSize screenSize = [[CCDirector sharedDirector] winSize];
    
    CCLabelTTF* my_score = [CCLabelTTF labelWithString:@"score:" fontName:@"Marker Felt" fontSize:20];
    
    my_score.color = ccc3(255,0,0);
    
    my_score.position = CGPointMake(25, screenSize.height - 16);
    [self addChild:my_score]; 
    
    
    
    
    
    totalScoreLabel = [CCLabelBMFont bitmapFontAtlasWithString:@"0" fntFile:@"bitmapfont.fnt"];
    totalScoreLabel.position = CGPointMake(60, screenSize.height - 5);
    totalScoreLabel.anchorPoint = CGPointMake(0.5f, 1.0f);
    totalScoreLabel.scale = 0.3;
    [self addChild:totalScoreLabel z:-2];
    
    return self;
}

//初始化得分规则
-(void)setScoreSetRules
{
    my_struct_gameScore_rules.chocolate = 3;
    my_struct_gameScore_rules.candy = 2;
    my_struct_gameScore_rules.candy = 1;
    my_struct_gameScore_rules.Once4circle = 10;
    my_struct_gameScore_rules.Once5circle = 15;
    my_struct_gameScore_rules.Once6circle = 20;
}

//获取当前关卡得分
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

//获得当前关卡最高得分
-(int)getGameHighestScore:(int)level;
{
    if (level == 1)
    {
        return my_struct_gameScore.level1HighestScore;
    }
    if(level == 2)
    {
        return my_struct_gameScore.level2HighestScore;
    }    
    if(level == 3)
    {
        return my_struct_gameScore.level3HighestScore;
    }  
    if(level == 4)
    {
        return my_struct_gameScore.level4HighestScore;
    }  
    if(level == 5)
    {
        return my_struct_gameScore.level5HighestScore;
    }  
    
    CCLOG(@"Into getGameHighestScore ERROR/n");
    return 0;

}
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
    
    //加入本地存储后首先进行初始化
    temphighestscore = tempnowscore;
    
    switch (level) {
        case 1:
            my_struct_gameScore.level1NowScore = tempnowscore;
            my_struct_gameScore.level1HighestScore = temphighestscore;
            break;
        case 2:
            my_struct_gameScore.level2NowScore = tempnowscore;
            my_struct_gameScore.level2HighestScore = temphighestscore;
            break;            
        case 3:
            my_struct_gameScore.level3NowScore = tempnowscore;
            my_struct_gameScore.level3HighestScore = temphighestscore;
            break;   
        case 4:
            my_struct_gameScore.level4NowScore = tempnowscore;
            my_struct_gameScore.level4HighestScore = temphighestscore;
            break;   
        case 5:
            my_struct_gameScore.level5NowScore = tempnowscore;
            my_struct_gameScore.level5HighestScore = temphighestscore;
            break;               
        default:
            CCLOG(@"Into default  Meanings Something is Wrong  Check \n");
            break;
    }
    
    
    
}

-(void) update:(ccTime)delta
{
    //CCLOG(@"Into updateLabelOfTotalScore\n");
    int temp_myscore;
    temp_myscore = [self getGameNowScore:1];
    //CCLOG(@"temp_myscore:%d",temp_myscore);
    [totalScoreLabel setString:[NSString stringWithFormat:@"x%i", temp_myscore]];
}



-(void)updateLabelOfTotalScore:(ccTime)delta
{
    CCLOG(@"Into updateLabelOfTotalScore\n");

    /*
       int temp_myscore;
    temp_myscore = [self getGameNowScore:1];
    [totalScoreLabel setString:[NSString stringWithFormat:@"x%i", temp_myscore]];
    */
    
}



@end
