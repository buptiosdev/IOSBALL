//
//  SaveScore.m
//  GreedFamily
//
//  Created by 晋 刘 on 12-6-4.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "MyGameScore.h"

@implementation MyGameScore

@synthesize standardUserDefaults = _standardUserDefaults;

static MyGameScore *_sharedScore =nil;

+(MyGameScore *) sharedScore 
{
    if (!_sharedScore)  {
        _sharedScore = [[MyGameScore alloc] init];
    }
    return _sharedScore;
}

-(id) init
{
    self = [super init];
    if (self)
    {
        _standardUserDefaults = [NSUserDefaults standardUserDefaults];
    }

    return self;
}


@end





