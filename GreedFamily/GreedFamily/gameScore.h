//
//  gameScore.h
//  GreedFamily
//
//  Created by 晋 刘 on 12-6-2.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "MyGameScore.h"
/*
struct  struct_gameScore{
    int level1NowScore;
    int level1HighestScore;
    int level2NowScore;
    int level2HighestScore;
    int level3NowScore;
    int level3HighestScore;
    int level4NowScore;
    int level4HighestScore;    
    int level5NowScore;
    int level5HighestScore;
} ;
*/
struct  struct_gameScore_rules{
    int candy;
    int chocolate;
    int circle;
    int Once6circle;
    int Once5circle;
    int Once4circle;
    
};
struct  struct_gameScore{
    int level1NowScore;
    int level1HighestScore;
    int level2NowScore;
    int level2HighestScore;
    int level3NowScore;
    int level3HighestScore;
    int level4NowScore;
    int level4HighestScore;    
    int level5NowScore;
    int level5HighestScore;
    int version;
} ;





@interface gameScore : CCNode {

    struct_gameScore_rules my_struct_gameScore_rules;
    struct_gameScore my_struct_gameScore;
    CCLabelBMFont*  totalScoreLabel;
    
    
    
}
+(gameScore *)sharedgameScore;

//初始化得分规则
-(void)setScoreSetRules;

//获取当前关卡得分
//-(int)getGameNowScore:(int)level HighestScore:(int)highestscore NowScore:(int)nowScore;
-(int)getGameNowScore:(int)level;

//获得当前关卡最高得分
-(int)getGameHighestScore:(int)level;




//计算当前得分
//一次消的次数 
//int timesOfOneTouch;
//一次消除的个数（所有类型）
//int numbersOfOneTime;
//一种类型消除个数
//int theSameTypeNumOfOneTime;
-(void)calculateGameScore:(int)level TimesofOneTouch:(int)timesofonetouch 
          NumbersOfOneTime:(int)numbersOfOneTime 
          TheSameTypeNumOfOneTime:(int)theSameTypeNumOfOneTime
          Chocolate:(int)choclolatenum
          Cake:(int)cakenum
                   Circle:(int)circlenum;

@end
