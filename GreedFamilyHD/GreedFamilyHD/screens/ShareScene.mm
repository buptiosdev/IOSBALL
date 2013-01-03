//
//  ShareScene.m
//  GreedFamily
//
//  Created by MagicStudio on 12-12-14.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import "ShareScene.h"
#import "CommonLayer.h"
#import "NavigationScene.h"
#import "SinaWeibo.h"
//#import "SNViewController.h"

float sharelabelscaleY=0.15;


@implementation ShareScene

@synthesize sina;
//@synthesize window = _window;
//@synthesize viewController = _viewController;

static int post_status_times = 0;
- (void)postStatusButtonPressed
{
    if (!postStatusText)
    {
        post_status_times ++;
        [postStatusText release], postStatusText = nil;
        //postStatusText = [[NSString alloc] initWithFormat:@"GreedFamily(贪食家族)！审核已通过！！没赶上圣诞，还来得及元旦！！正在限免下载！！传送门－> https://itunes.apple.com/cn/app/greedfamily/id543100124?mt=8 %i %@", post_status_times, [NSDate date]];
        postStatusText = [[NSString alloc] initWithFormat:@"GreedFamily(贪食家族)！审核已通过！！没赶上圣诞，还来得及元旦！！正在限免下载！！传送门－> https://itunes.apple.com/cn/app/greedfamily/id543100124?mt=8 %@", [NSDate date]];
    }
    
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"分享"
                                                        message:[NSString stringWithFormat:@"您即将分享如下信息 \n\"%@\"", postStatusText]
                                                       delegate:self cancelButtonTitle:@"Cancel"
                                              otherButtonTitles:@"OK", nil];
    alertView.tag = 0;
    [alertView show];
    [alertView release];
}

static int post_image_status_times = 0;
- (void)postImageStatusButtonPressed
{
    if (!postImageStatusText)
    {
        post_image_status_times ++;
        [postImageStatusText release], postImageStatusText = nil;
        //postImageStatusText = [[NSString alloc] initWithFormat:@"给大家分享一个超级好玩的游戏－－贪食家族！ : %i %@", post_image_status_times, [NSDate date]];
        postImageStatusText = [[NSString alloc] initWithFormat:@"GreedFamily(贪食家族)！审核已通过！！没赶上圣诞，还来得及元旦！！正在限免下载！！传送门－> https://itunes.apple.com/cn/app/greedfamily/id543100124?mt=8  %@", [NSDate date]];
    }
    
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"分享"
                                                        message:[NSString stringWithFormat:@"您即将分享如下信息 \n\"%@\"", postImageStatusText]
                                                       delegate:self cancelButtonTitle:@"Cancel"
                                              otherButtonTitles:@"OK", nil];
    
//    UIImageView *viewe = [[UIImageView alloc] initWithFrame:CGRectMake(0.0, 100.0, 100.0, 100.0)];
//    viewe.image = [UIImage imageNamed:@"teachdetail1.jpg"];
//    [alertView addSubview:viewe];
//    [viewe release];
    
    alertView.tag = 1;
    [alertView show];
    [alertView release];
}

- (void)alertView:(UIAlertView *)alertView willDismissWithButtonIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1)
    {
        if (alertView.tag == 0)
        {
            // post status
            //SinaWeibo *sinaweibo = [self sinaweibo];
            [sina requestWithURL:@"statuses/update.json"
                               params:[NSMutableDictionary dictionaryWithObjectsAndKeys:postStatusText, @"status", nil]
                           httpMethod:@"POST"
                             delegate:self];
            
        }
        else if (alertView.tag == 1)
        {
            // post image status
            //SinaWeibo *sinaweibo = [self sinaweibo];
            
            [sina requestWithURL:@"statuses/upload.json"
                               params:[NSMutableDictionary dictionaryWithObjectsAndKeys:
                                       postImageStatusText, @"status",
                                       [UIImage imageNamed:@"logoword.png"], @"pic", nil]
                           httpMethod:@"POST"
                             delegate:self];
            
        }
    }
}




- (void)storeAuthData
{    
    NSDictionary *authData = [NSDictionary dictionaryWithObjectsAndKeys:
                              sina.accessToken, @"AccessTokenKey",
                              sina.expirationDate, @"ExpirationDateKey",
                              sina.userID, @"UserIDKey",
                              sina.refreshToken, @"refresh_token", nil];
    [[NSUserDefaults standardUserDefaults] setObject:authData forKey:@"SinaWeiboAuthData"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}


#pragma mark - SinaWeibo Delegate

- (void)sinaweiboDidLogIn:(SinaWeibo *)sinaweibo
{
    NSLog(@"sinaweiboDidLogIn userID = %@ accesstoken = %@ expirationDate = %@ refresh_token = %@", sinaweibo.userID, sinaweibo.accessToken, sinaweibo.expirationDate,sinaweibo.refreshToken);
    
//    [self resetButtons];
    [self storeAuthData];
    [self postImageStatusButtonPressed];
}

- (void)removeAuthData
{
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"SinaWeiboAuthData"];
}

- (void)sinaweiboDidLogOut:(SinaWeibo *)sinaweibo
{
    NSLog(@"sinaweiboDidLogOut");
    [self removeAuthData];
}

- (void)sinaweiboLogInDidCancel:(SinaWeibo *)sinaweibo
{
    NSLog(@"sinaweiboLogInDidCancel");
}

- (void)sinaweibo:(SinaWeibo *)sinaweibo logInDidFailWithError:(NSError *)error
{
    NSLog(@"sinaweibo logInDidFailWithError %@", error);
}

- (void)sinaweibo:(SinaWeibo *)sinaweibo accessTokenInvalidOrExpired:(NSError *)error
{
    NSLog(@"sinaweiboAccessTokenInvalidOrExpired %@", error);
    [self removeAuthData];
}


#pragma mark - SinaWeiboRequest Delegate 

- (void)request:(SinaWeiboRequest *)request didFailWithError:(NSError *)error
{
    if ([request.url hasSuffix:@"users/show.json"])
    {
        [userInfo release], userInfo = nil;
    }
    else if ([request.url hasSuffix:@"statuses/user_timeline.json"])
    {
        [statuses release], statuses = nil;
    }
    else if ([request.url hasSuffix:@"statuses/update.json"])
    {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Alert"
                                                            message:[NSString stringWithFormat:@"Post status \"%@\" failed!", postStatusText]
                                                           delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
        [alertView show];
        [alertView release];
        
        NSLog(@"Post status failed with error : %@", error);
    }
    else if ([request.url hasSuffix:@"statuses/upload.json"])
    {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Alert"
                                                            message:[NSString stringWithFormat:@"Post image status \"%@\" failed!", postImageStatusText]
                                                           delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
        [alertView show];
        [alertView release];
        
        NSLog(@"Post image status failed with error : %@", error);
    }
}

- (void)request:(SinaWeiboRequest *)request didFinishLoadingWithResult:(id)result
{
    if ([request.url hasSuffix:@"users/show.json"])
    {
        [userInfo release];
        userInfo = [result retain];
    }
    else if ([request.url hasSuffix:@"statuses/user_timeline.json"])
    {
        [statuses release];
        statuses = [[result objectForKey:@"statuses"] retain];
    }
    else if ([request.url hasSuffix:@"statuses/update.json"])
    {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Alert"
                                                            message:[NSString stringWithFormat:@"Post status \"%@\" succeed!", [result objectForKey:@"text"]]
                                                           delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
        [alertView show];
        [alertView release];
        
        [postStatusText release], postStatusText = nil;
    }
    else if ([request.url hasSuffix:@"statuses/upload.json"])
    {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Alert"
                                                            message:[NSString stringWithFormat:@"Post image status \"%@\" succeed!", [result objectForKey:@"text"]]
                                                           delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
        [alertView show];
        [alertView release];
        
        [postImageStatusText release], postImageStatusText = nil;
    }
}

-(void)shareNothing
{
    return;
}

-(void)shareWeibo
{
    [CommonLayer playAudio:SelectOK];
    sina = [[SinaWeibo alloc] initWithAppKey:kAppKey appSecret:kAppSecret appRedirectURI:kAppRedirectURI andDelegate:self];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSDictionary *sinaweiboInfo = [defaults objectForKey:@"SinaWeiboAuthData"];
    if ([sinaweiboInfo objectForKey:@"AccessTokenKey"] && [sinaweiboInfo objectForKey:@"ExpirationDateKey"] && [sinaweiboInfo objectForKey:@"UserIDKey"])
    {
        sina.accessToken = [sinaweiboInfo objectForKey:@"AccessTokenKey"];
        sina.expirationDate = [sinaweiboInfo objectForKey:@"ExpirationDateKey"];
        sina.userID = [sinaweiboInfo objectForKey:@"UserIDKey"];
    }
    [sina logIn];
    if(sina.isLoggedIn){
        NSLog(@"log in");
         //[self postStatusButtonPressed];
    }else{
        NSLog(@"not log in");
    }
    
    //[sinaweibo logIn];
    
}

-(void)returnMain
{
    [CommonLayer playAudio:SelectOK];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [[CCDirector sharedDirector] popScene];
}

-(id)initWithShareScene
{
    if ((self = [super init])) {
		self.isTouchEnabled = YES;
        CCSpriteFrameCache* frameCache = [CCSpriteFrameCache sharedSpriteFrameCache];
        [frameCache addSpriteFramesWithFile:@"levlescene_default_default.plist"];
        [frameCache addSpriteFramesWithFile:@"beginscene_default.plist"];
        CGSize screenSize = [[CCDirector sharedDirector] winSize];
        CCSprite * background = [CCSprite spriteWithFile:@"background_begin.jpg"];
        background.scaleX=(screenSize.width)/[background contentSize].width; //按照像素定制图片宽高是控制像素的。
        background.scaleY=(screenSize.height)/[background contentSize].height;
        NSAssert( background != nil, @"background must be non-nil");
		[background setPosition:ccp(screenSize.width / 2, screenSize.height/2)];
		[self addChild:background];
        
        CCSprite *returnBtn = [CCSprite spriteWithSpriteFrameName:@"return.png"];
        CCSprite *returnBtn1 = [CCSprite spriteWithSpriteFrameName:@"return.png"];
        returnBtn1.scale=1.1;
        CCMenuItemSprite *returnItem = [CCMenuItemSprite itemFromNormalSprite:returnBtn 
                                                               selectedSprite:returnBtn1 
                                                                       target:self 
                                                                     selector:@selector(returnMain)];
        returnItem.scale=screenSize.height*sharelabelscaleY/[returnBtn contentSize].height; //按照像素定制图片宽高
        CCMenu * returnmenu = [CCMenu menuWithItems:returnItem, nil];
        [returnmenu setPosition:ccp([returnBtn contentSize].width * returnItem.scaleX * 0.5,
                                    [returnBtn contentSize].height * returnItem.scaleY * 0.5)];
        
        [self addChild:returnmenu];
        
        //set shop in the right-down corner
        CCSprite *weibo = [CCSprite spriteWithSpriteFrameName:@"sina.png"];
        CCSprite *weibo1 = [CCSprite spriteWithSpriteFrameName:@"sina.png"];
        weibo1.scale=1.1; //按照像素定制图片宽高
        CCMenuItemSprite *weiboItem = [CCMenuItemSprite itemFromNormalSprite:weibo 
                                                             selectedSprite:weibo1 
                                                                     target:self 
                                                                   selector:@selector(shareWeibo)];
        
        weiboItem.scale=screenSize.height*sharelabelscaleY/[weibo contentSize].height;
        
        CCSprite *renren = [CCSprite spriteWithFile:@"renren.png"];
        CCSprite *renren1 = [CCSprite spriteWithFile:@"renren.png"];
        renren1.scale=1.1; //按照像素定制图片宽高
        CCMenuItemSprite *renrenItem = [CCMenuItemSprite itemFromNormalSprite:renren 
                                                              selectedSprite:renren1 
                                                                      target:self 
                                                                    selector:@selector(shareNothing)];
        
        renrenItem.scale=screenSize.height*sharelabelscaleY/[renren contentSize].height;
        
        CCSprite *facebook = [CCSprite spriteWithFile:@"facebook.png"];
        CCSprite *facebook1 = [CCSprite spriteWithFile:@"facebook.png"];
        facebook1.scale=1.1; //按照像素定制图片宽高
        CCMenuItemSprite *facebookItem = [CCMenuItemSprite itemFromNormalSprite:facebook 
                                                              selectedSprite:facebook1 
                                                                      target:self 
                                                                    selector:@selector(shareNothing)];
        
        facebookItem.scale=screenSize.height*sharelabelscaleY/[facebook contentSize].height;
        
        CCSprite *twitter = [CCSprite spriteWithFile:@"twitter.png"];
        CCSprite *twitter1 = [CCSprite spriteWithFile:@"twitter.png"];
        twitter1.scale=1.1; //按照像素定制图片宽高
        CCMenuItemSprite *twitterItem = [CCMenuItemSprite itemFromNormalSprite:twitter 
                                                              selectedSprite:twitter1 
                                                                      target:self 
                                                                    selector:@selector(shareNothing)];
        
        twitterItem.scale=screenSize.height*sharelabelscaleY/[twitter contentSize].height;
        
        CCMenu * weiboMenu = [CCMenu menuWithItems:weiboItem,facebookItem,twitterItem, nil];
        //CCMenu * weiboMenu = [CCMenu menuWithItems:weiboItem, nil];
        [weiboMenu alignItemsHorizontallyWithPadding:screenSize.height*sharelabelscaleY];
        [weiboMenu setPosition:ccp(screenSize.width*0.5, screenSize.height*0.6)];
        [self addChild:weiboMenu];
        
    }
    return self;
}

+(id)scene
{
    //order = order;
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	ShareScene *shareScene = [ShareScene sceneWithShareScene];
	
	// add layer as a child to scene
	[scene addChild: shareScene];
    
	return scene;
    
}

+(id)sceneWithShareScene
{
    return [[[self alloc] initWithShareScene] autorelease];
}
@end
