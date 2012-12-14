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

float sharelabelscaleY=0.13;


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
        postStatusText = [[NSString alloc] initWithFormat:@"test post status : %i %@", post_status_times, [NSDate date]];
    }
    
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Alert"
                                                        message:[NSString stringWithFormat:@"Will post status with text \"%@\"", postStatusText]
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
        postImageStatusText = [[NSString alloc] initWithFormat:@"test post image status : %i %@", post_image_status_times, [NSDate date]];
    }
    
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Alert"
                                                        message:[NSString stringWithFormat:@"Will post image status with text \"%@\"", postImageStatusText]
                                                       delegate:self cancelButtonTitle:@"Cancel"
                                              otherButtonTitles:@"OK", nil];
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
                                       [UIImage imageNamed:@"teachdetail1.jpg"], @"pic", nil]
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
    [[CCDirector sharedDirector] replaceScene:[NavigationScene scene]];
}

-(id)initWithShareScene
{
    if ((self = [super init])) {
		self.isTouchEnabled = YES;
        CCSpriteFrameCache* frameCache = [CCSpriteFrameCache sharedSpriteFrameCache];
        [frameCache addSpriteFramesWithFile:@"levlescene_default_default.plist"];
        CCLabelTTF *levelLabel=[CCLabelTTF labelWithString:@"share from ios" fontName:@"Dekers_Bold" fontSize:25];
        CGSize screenSize = [[CCDirector sharedDirector] winSize];
        //[levelLabel setColor:ccBLACK];
        [levelLabel setPosition:ccp(screenSize.width / 2, screenSize.height/2)];
        [self addChild:levelLabel];
        
        CCSprite *returnBtn = [CCSprite spriteWithSpriteFrameName:@"return.png"];
        CCSprite *returnBtn1 = [CCSprite spriteWithSpriteFrameName:@"return.png"];
        returnBtn1.scaleX=1.1;
        returnBtn1.scaleY=1.1;
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
        CCSprite *next = [CCSprite spriteWithSpriteFrameName:@"return.png"];
        CCSprite *next1 = [CCSprite spriteWithSpriteFrameName:@"return.png"];
        [next setFlipX:YES];//Y轴镜像反转
        [next1 setFlipX:YES];//Y轴镜像反转
        next1.scaleX=1.1; //按照像素定制图片宽高
        next1.scaleY=1.1;
        CCMenuItemSprite *nextItem = [CCMenuItemSprite itemFromNormalSprite:next 
                                                             selectedSprite:next1 
                                                                     target:self 
                                                                   selector:@selector(shareWeibo)];
        
        nextItem.scale=screenSize.height*sharelabelscaleY/[next contentSize].height;
        
        CCMenu * nextMenu = [CCMenu menuWithItems:nextItem, nil];
        //right corner=screenSize.width-[shop contentSize].width*(shopscale-0.5)
        [nextMenu setPosition:ccp(screenSize.width-[next contentSize].width*nextItem.scaleX*0.6,
                                  [next contentSize].height * nextItem.scaleX * 0.5)];
        [self addChild:nextMenu];
        
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