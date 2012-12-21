//
//  ShareScene.h
//  GreedFamily
//
//  Created by MagicStudio on 12-12-14.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "SinaWeibo.h"
#import "SinaWeiboRequest.h"
#define kAppKey             @"4018825710"
#define kAppSecret          @"7bdb89f13fad1636cc118e9e9f7b451b"
#define kAppRedirectURI     @"http://www.sina.com"



@interface ShareScene : CCLayer<SinaWeiboDelegate, SinaWeiboRequestDelegate> {
    SinaWeibo *sina;
//    UIWindow *window;
//    SNViewController *viewController;
    NSDictionary *userInfo;
    NSArray *statuses;
    NSString *postStatusText;
    NSString *postImageStatusText;
}
@property (readonly, nonatomic) SinaWeibo *sina;
//@property (assign, nonatomic) UIWindow *window;
//@property (assign, nonatomic) SNViewController *viewController;

+(id)sceneWithShareScene;
+(id)scene;
@end
