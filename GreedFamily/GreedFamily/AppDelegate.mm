//
//  AppDelegate.m
//  GreedFamily
//
//  Created by 赵 苹果 on 12-4-19.
//  Copyright __MyCompanyName__ 2012年. All rights reserved.
//

#import "cocos2d.h"

#import "AppDelegate.h"
#import "GameConfig.h"
#import "RootViewController.h"
#import "NavigationScene.h"
#import "Parse/Parse.h"
#import "RootViewController.h"

@implementation AppDelegate
@synthesize viewController;
@synthesize window,paused;

- (void) removeStartupFlicker
{
	//
	// THIS CODE REMOVES THE STARTUP FLICKER
	//
	// Uncomment the following code if you Application only supports landscape mode
	//
#if GAME_AUTOROTATION == kGameAutorotationUIViewController
	
	//	CC_ENABLE_DEFAULT_GL_STATES();
	//	CCDirector *director = [CCDirector sharedDirector];
	//	CGSize size = [director winSize];
	//	CCSprite *sprite = [CCSprite spriteWithFile:@"Default.png"];
	//	sprite.position = ccp(size.width/2, size.height/2);
	//	sprite.rotation = -90;
	//	[sprite visit];
	//	[[director openGLView] swapBuffers];
	//	CC_ENABLE_DEFAULT_GL_STATES();
	
#endif // GAME_AUTOROTATION == kGameAutorotationUIViewController	
}

- (void) applicationDidFinishLaunching:(UIApplication*)application
{
	// Init the window
	window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
	
    [viewController.view setMultipleTouchEnabled:YES];//开启多点触摸支持  
    
	// Try to use CADisplayLink director
	// if it fails (SDK < 3.1) use the default director
	if( ! [CCDirector setDirectorType:kCCDirectorTypeDisplayLink] )
		[CCDirector setDirectorType:kCCDirectorTypeDefault];
	
	
	CCDirector *director = [CCDirector sharedDirector];
	
	// Init the View Controller
	viewController = [[RootViewController alloc] initWithNibName:nil bundle:nil];
	viewController.wantsFullScreenLayout = YES;
	
	//
	// Create the EAGLView manually
	//  1. Create a RGB565 format. Alternative: RGBA8
	//	2. depth format of 0 bit. Use 16 or 24 bit for 3d effects, like CCPageTurnTransition
	//
	//
	EAGLView *glView = [EAGLView viewWithFrame:[window bounds]
								   pixelFormat:kEAGLColorFormatRGB565	// kEAGLColorFormatRGBA8
								   depthFormat:0						// GL_DEPTH_COMPONENT16_OES
						];
	
	// attach the openglView to the director
	[director setOpenGLView:glView];
	
//	// Enables High Res mode (Retina Display) on iPhone 4 and maintains low res on all other devices
//	if( ! [director enableRetinaDisplay:YES] )
//		CCLOG(@"Retina Display Not supported");
	
	//
	// VERY IMPORTANT:
	// If the rotation is going to be controlled by a UIViewController
	// then the device orientation should be "Portrait".
	//
	// IMPORTANT:
	// By default, this template only supports Landscape orientations.
	// Edit the RootViewController.m file to edit the supported orientations.
	//
#if GAME_AUTOROTATION == kGameAutorotationUIViewController
	[director setDeviceOrientation:kCCDeviceOrientationPortrait];
#else
	[director setDeviceOrientation:kCCDeviceOrientationLandscapeLeft];
#endif
	
	[director setAnimationInterval:1.0/60];
	[director setDisplayFPS:NO];
	
	
	// make the OpenGLView a child of the view controller
	[viewController setView:glView];
	
	// make the View Controller a child of the main window
	[window addSubview: viewController.view];
	
    // Must add the root view controller for GameKitHelper to work!
	window.rootViewController = viewController;
    
	[window makeKeyAndVisible];
	
	// Default texture format for PNG/BMP/TIFF/JPEG/GIF images
	// It can be RGBA8888, RGBA4444, RGB5_A1, RGB565
	// You can change anytime.
	[CCTexture2D setDefaultAlphaPixelFormat:kCCTexture2DPixelFormat_RGBA8888];

	
	// Removes the startup flicker
	[self removeStartupFlicker];
	
	// Run the intro Scene
	[[CCDirector sharedDirector] runWithScene: [NavigationScene sceneWithNavigationScene]];
    
    //add push notice function推送服务器推送
    [Parse setApplicationId:@"w1rAzcRAdPuoX60nNy3fKewfZPYCvgJQdXZYEJ3r" clientKey:@"Rg9avoCht3xPnM8ZrM42rBBeMIijaxpQMcSmAImu"];
    [application registerForRemoteNotificationTypes:(UIRemoteNotificationType)
     (UIRemoteNotificationTypeSound|
      UIRemoteNotificationTypeAlert|
      UIRemoteNotificationTypeBadge)];
    
    //添加本地通知 测试  
    //设置20秒之后 
    NSDate *date = [NSDate dateWithTimeIntervalSinceNow:2000];
    //chuangjian一个本地推送
    UILocalNotification *noti = [[[UILocalNotification alloc] init] autorelease];
    if (noti) {
        [[UIApplication sharedApplication] cancelAllLocalNotifications];
        //设置推送时间
        noti.fireDate = date;
        //设置时区
        noti.timeZone = [NSTimeZone defaultTimeZone];
        //设置重复间隔
        noti.repeatInterval = kCFCalendarUnitWeek;
        //推送声音
        noti.soundName = UILocalNotificationDefaultSoundName;
        //内容
        noti.alertBody = @"您的小猪猪饿了 快回来看看吧";
        noti.alertAction = @"确定";
        //显示在icon上的红色圈中的数子
        noti.applicationIconBadgeNumber = 1;
        //设置userinfo 方便在之后需要撤销的时候使用
        NSDictionary *infoDic = [NSDictionary dictionaryWithObject:@"name" forKey:@"key"];
        noti.userInfo = infoDic;
        //添加推送到uiapplication        
        UIApplication *app = [UIApplication sharedApplication];
        [app scheduleLocalNotification:noti];  
//        [app presentLocalNotificationNow:noti];
        //[noti release];
    }
    //设置打分提示
    NSDate *date2 = [NSDate dateWithTimeIntervalSinceNow:1000];
    UILocalNotification *notiPoint = [[[UILocalNotification alloc] init] autorelease];
    if (notiPoint) {
        [[UIApplication sharedApplication] cancelAllLocalNotifications];
        //设置推送时间
        notiPoint.fireDate = date2;
        //设置时区
        notiPoint.timeZone = [NSTimeZone defaultTimeZone];
        //设置重复间隔
        notiPoint.repeatInterval = kCFCalendarUnitWeek;
        //推送声音
        notiPoint.soundName = UILocalNotificationDefaultSoundName;
        //内容
        notiPoint.alertBody = @"如果感觉好玩去给个好评吧，亲";
        notiPoint.alertAction = @"好的";
        //显示在icon上的红色圈中的数子
        notiPoint.applicationIconBadgeNumber = 1;
        //设置userinfo 方便在之后需要撤销的时候使用
        NSDictionary *infoDic = [NSDictionary dictionaryWithObject:@"point" forKey:@"key"];
        notiPoint.userInfo = infoDic;
        //添加推送到uiapplication        
        UIApplication *app = [UIApplication sharedApplication];
        [app scheduleLocalNotification:notiPoint];  
//        [app presentLocalNotificationNow:notiPoint];
        //[noti release];
    }
}

-(void)alertView:(UIAlertView*)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{  
    NSLog(@"Button %d pressed",buttonIndex);  
    [alertView release];  
    if (0 == buttonIndex) {
        NSString * str =@"http://www.sina.com.cn";
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
    }

}

- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification
{
    UIApplicationState state = [application applicationState];
    if (state == UIApplicationStateInactive)
    {

        //这里，你就可以通过notification的useinfo，干一些你想做的事情了
        application.applicationIconBadgeNumber -= 1;
        
        NSString *reminderText = [notification.userInfo
                                  objectForKey:@"key"];
        NSString *point = @"point";
        if (NSOrderedSame == [reminderText compare:(point)]) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"进入评分"
                                                            message:@"去给个好评吧，亲!"
                                                           delegate:self
                                                  cancelButtonTitle:@"确定"
                                                  otherButtonTitles:@"不用",nil];
            alert.delegate =   self;  
            [alert show];
//            NSString * str =@"http://www.sina.com.cn";
//            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];

        }
        else
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"欢迎回来"
                                                            message:@"快开始战斗吧!"
                                                           delegate:nil
                                                  cancelButtonTitle:@"确定"
                                                  otherButtonTitles:nil];
            [alert show];
        }
        NSLog(@"%@",reminderText);
    }
}

//- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
//{
//    // ****************************************************************************
//    // Uncomment and fill in with your Parse credentials:
//    [Parse setApplicationId:@"w1rAzcRAdPuoX60nNy3fKewfZPYCvgJQdXZYEJ3r" clientKey:@"Rg9avoCht3xPnM8ZrM42rBBeMIijaxpQMcSmAImu"];
////    //
////    // If you are using Facebook, uncomment and fill in with your Facebook App Id:
////    // [PFFacebookUtils initializeWithApplicationId:@"your_facebook_app_id"];
////    // ****************************************************************************
////    
////    [application registerForRemoteNotificationTypes:(UIRemoteNotificationType)
////     (UIRemoteNotificationTypeBadge|
////     UIRemoteNotificationTypeSound|
////     UIRemoteNotificationTypeAlert)];
//    return YES;
//}

- (void)application:(UIApplication *)application 
didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)newDeviceToken
{
    [PFPush storeDeviceToken:newDeviceToken]; // Send parse the device token
    // Subscribe this user to the broadcast channel, "" 
    [PFPush subscribeToChannelInBackground:@"" block:^(BOOL succeeded, NSError *error) {
        if (succeeded) {
            NSLog(@"devToken=%@",newDeviceToken);  

            NSLog(@"Successfully subscribed to the broadcast channel.");
        } else {
            NSLog(@"Failed to subscribe to the broadcast channel.");
        }
    }];
}

- (void)application:(UIApplication *)app didFailToRegisterForRemoteNotificationsWithError:(NSError *)err 
{  
//    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@""
//                                                    message:[NSString stringWithFormat:@"Error in registration. Error: %@", err]
//                                                   delegate:nil
//                                          cancelButtonTitle:@"确定"
//                                          otherButtonTitles:nil];
//    [alert show];
    CCLOG(@"didFailToRegisterForRemoteNotificationsWithError failed!\n");
}

- (void)application:(UIApplication *)application 
didReceiveRemoteNotification:(NSDictionary *)userInfo {
    [PFPush handlePush:userInfo];
    for (id key in userInfo) {
        NSLog(@"key: %@, value: %@", key, [userInfo objectForKey:key]);
    } 
    


}

//add by lyp just for pause
+(AppDelegate *) getAppDelegate {
	
	return (AppDelegate *) [[UIApplication sharedApplication] delegate];
}

- (void)applicationWillResignActive:(UIApplication *)application {
	[[CCDirector sharedDirector] pause];
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
	[[CCDirector sharedDirector] resume];
}

- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application {
	[[CCDirector sharedDirector] purgeCachedData];
}

-(void) applicationDidEnterBackground:(UIApplication*)application {
	[[CCDirector sharedDirector] stopAnimation];
}

-(void) applicationWillEnterForeground:(UIApplication*)application {
	[[CCDirector sharedDirector] startAnimation];
}

- (void)applicationWillTerminate:(UIApplication *)application {
	CCDirector *director = [CCDirector sharedDirector];
	
	[[director openGLView] removeFromSuperview];
	
	[viewController release];
	
	[window release];
	
	[director end];	
}

- (void)applicationSignificantTimeChange:(UIApplication *)application {
	[[CCDirector sharedDirector] setNextDeltaTimeZero:YES];
}

- (void)dealloc {
	[[CCDirector sharedDirector] end];
	[window release];
	[super dealloc];
}

@end
