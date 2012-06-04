//
//  SaveScore.m
//  GreedFamily
//
//  Created by 晋 刘 on 12-6-4.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "MyGameScore.h"

@implementation MyGameScore
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
        _isLoaded = NO;
        //初始化设置 
        memset(&_data,0,sizeof(_data));
        _data.version = 1;
    }

    return self;
}


         
-(BOOL) synchronize
{
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    NSData *data = nil;
    
    if(_isLoaded)
    {
        //写入设置到defaults 
        data = [NSData dataWithBytes:&_data length:sizeof(_data)];
        [prefs setValue:data forKey:@"gameScore"];
        return [prefs synchronize];
    }            
    
    //从defaults 读取设置    
    data = [prefs dataForKey:@"gameScore"];
    if (!data || [data length] != sizeof(_data)) return NO;
    [data getBytes:&_data   length:sizeof(_data)];
    _isLoaded = YES;
    return YES;
}

@end




//http://www.cocoachina.com/iphonedev/sdk/2010/1206/2445.html
