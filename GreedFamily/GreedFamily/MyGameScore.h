//
//  SaveScore.h
//  GreedFamily
//
//  Created by 晋 刘 on 12-6-4.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



typedef struct struct_gameScore struct_gameScore;



@interface MyGameScore : NSObject {
    
}
@property(assign, nonatomic) NSUserDefaults * standardUserDefaults;
+(MyGameScore *) sharedScore;



@end
