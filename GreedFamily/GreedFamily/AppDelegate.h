//
//  AppDelegate.h
//  GreedFamily
//
//  Created by 赵 苹果 on 12-4-19.
//  Copyright __MyCompanyName__ 2012年. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RootViewController;

@interface AppDelegate : NSObject <UIApplicationDelegate> {
	UIWindow			*window;
	RootViewController	*viewController;
    bool paused;
}
+(AppDelegate *) get;

@property(readwrite,nonatomic) bool paused;
@property (nonatomic, retain) UIWindow *window;

@end
