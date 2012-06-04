//
//  SaveScore.h
//  GreedFamily
//
//  Created by 晋 刘 on 12-6-4.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


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
typedef struct struct_gameScore struct_gameScore;



@interface MyGameScore : NSObject {
    BOOL  _isLoaded;
    struct_gameScore _data;
}

+(MyGameScore *) sharedScore;
-(BOOL) synchronize;


@end
