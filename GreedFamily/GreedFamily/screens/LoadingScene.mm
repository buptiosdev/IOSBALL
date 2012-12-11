//
//  LoadingScene.m
//  ScenesAndLayers
//
//  Created by Steffen Itterheim on 27.07.10.
//  Copyright 2010 Steffen Itterheim. All rights reserved.
//

#import "LoadingScene.h"
#import "GameMainScene.h"
#import "NavigationScene.h"
#import "AppDelegate.h"
#import "TeachGameLayer.h"
#import "DisplayGameLayer.h"
@interface LoadingScene (PrivateMethods)
-(void) update:(ccTime)delta;
-(int)getAndIncreaseLevelPlayTimes:(int)level;
@end

@implementation LoadingScene
@synthesize waitTime = _waitTime;

+(id) sceneWithTargetScene:(TargetScenes)targetScene;
{
	CCLOG(@"%@: %@", NSStringFromSelector(_cmd), self);
    
	// This creates an autorelease object of self (the current class: LoadingScene)
	return [[[self alloc] initWithTargetScene:targetScene] autorelease];
}

-(id) initWithTargetScene:(TargetScenes)targetScene
{
	if ((self = [super init]))
	{
		targetScene_ = targetScene;
        CGSize size = [[CCDirector sharedDirector] winSize];
//		CCLabelTTF* label = [CCLabelTTF labelWithString:@"Loading ..." fontName:@"Marker Felt" fontSize:64];
//        label.scale = 0.4;
//		label.position = CGPointMake(size.width * 0.8, size.height * 0.2);
//		[self addChild:label z:-1 tag:100];
        
//        //添加load圆圈图标
//        activityIndicatorView = [[[UIActivityIndicatorView alloc]   
//                                               initWithActivityIndicatorStyle:   
//                                               UIActivityIndicatorViewStyleWhiteLarge] autorelease];  
//                
//        activityIndicatorView.center = CGPointMake(190,240);  
//                
//        [activityIndicatorView startAnimating]; 
//        //activityIndicatorView.activityIndicatorViewStyle= UIActivityIndicatorViewStyleGray;
//        //[self.view addSubview:activityIndicatorView ];   
//		AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;  
//        [delegate.window addSubview:activityIndicatorView];
//		// Must wait one frame before loading the target scene!
//		// Two reasons: first, it would crash if not. Second, the Loading label wouldn't be displayed.
        int levelPlayTimes = [self getAndIncreaseLevelPlayTimes:targetScene_];
        
        _waitTime = 2;
        if (levelPlayTimes >= TEACH_TIMES) {
            //广告或宣传画或说明
            DisplayGameLayer *p = [DisplayGameLayer createDisplayGameLayer:targetScene_];
            [self addChild:p];
        }
        else
        {
            //教学或评分 
            TeachGameLayer *p = [TeachGameLayer createTeachGameLayer:targetScene_];
            [self addChild:p];
            //这几关信息量比较大
            if (1 == targetScene || 4 == targetScene || 9 == targetScene) {
                _waitTime = 10;
            }
            else 
            {
                _waitTime = 3;
            }
        }
        
        //add by liuyunpeng 2012-12-09
        //set progess
        CCProgressTimer *ctlandanimal=[CCProgressTimer progressWithFile:@"progressgrey.png"];
        ctlandanimal.position=ccp( size.width*0.5 , size.height * 0.5);
        ctlandanimal.type=kCCProgressTimerTypeHorizontalBarRL;//进度条的显示样式 
        //ctlandanimal.type=kCCProgressTimerTypeRadialCW;//进度条的显示样式
        ctlandanimal.scaleX=size.width/[ctlandanimal contentSize].width;
        ctlandanimal.scaleY=size.height/[ctlandanimal contentSize].height;
        ctlandanimal.percentage=100;
        [self addChild:ctlandanimal z:0 tag:101]; 
        
        
        [self schedule:@selector(waitAWhile:) interval:_waitTime];
        [self scheduleUpdate];
	}
	
	return self;
}
  
-(int)getAndIncreaseLevelPlayTimes:(int)level 
{
    NSString *str_starlevel = [NSString stringWithFormat:@"%d",level];
    str_starlevel = [str_starlevel stringByAppendingFormat:@"PlayTimes"];    
    NSUserDefaults *usrDef = [NSUserDefaults standardUserDefaults];
    NSInteger playTimes = [usrDef integerForKey:str_starlevel];  
    int nowPlayTime = playTimes+1;
    [usrDef setInteger:nowPlayTime forKey:str_starlevel];
    return playTimes;
}

-(void) waitAWhile:(ccTime)delta
{
	// It's not strictly necessary, as we're changing the scene anyway. But just to be safe.
	[self unscheduleAllSelectors];
//	[activityIndicatorView stopAnimating ];  //停止  
    if(targetScene_>=TargetNavigationScen)
    {
        [[CCDirector sharedDirector] replaceScene:[NavigationScene scene]];
    }
    else
    {
        [[CCDirector sharedDirector] replaceScene:[GameMainScene scene:targetScene_]];
    }
}

//add by liuyunpeng 2012-12-09
-(void)update:(ccTime)delta
{  
    CCProgressTimer*ct=(CCProgressTimer*)[self getChildByTag:101];   
//    if(ct.percentage>=100){
//        ct.percentage=100;
//        return;  
//    }else{
//        ct.percentage=ct.percentage+100.0/(_waitTime*60);
//    }
    if(ct.percentage<=0){
        ct.percentage=0;
        return;  
    }else{
        ct.percentage=ct.percentage-100.0/(_waitTime*60);
    }

}
 

-(void) dealloc
{
	CCLOG(@"%@: %@", NSStringFromSelector(_cmd), self);	
	[super dealloc];
}

@end
