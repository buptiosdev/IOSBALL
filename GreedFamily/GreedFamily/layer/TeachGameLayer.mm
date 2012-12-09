//
//  TeachGameLayer.m
//  GreedFamily
//
//  Created by 赵 苹果 on 12-9-16.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import "TeachGameLayer.h"
#import "GameMainScene.h"

@interface TeachGameLayer (PrivateMethods)
-(void)pauseLayerDidPause;
-(void)pauseLayerDidUnpause;
@end
@implementation TeachGameLayer


-(void)pauseDelegate
{   
    [[CCDirector sharedDirector] pause];
}

-(void)goBack
{
    [[CCDirector sharedDirector] resume];
}

-(void)alertView:(UIAlertView*)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{  
    NSLog(@"Button %d pressed",buttonIndex);  
    [alertView release];  
    [self goBack];
    if (0 == buttonIndex) {
        NSString * str =@"http://www.sina.com.cn";
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
    }
    
}

-(void)initPic:(int)type
{
    CGSize screenSize = [[CCDirector sharedDirector] winSize];
    NSString* teachPic = nil;
    switch (type) {
        case 1:
        {
            NSString* teachPic1 = [NSString stringWithFormat:@"teachdetail1.jpg"];
            NSString* teachPic2 = [NSString stringWithFormat:@"teachdetail2.jpg"];
            NSString* teachPic3 = [NSString stringWithFormat:@"teachdetail3.jpg"];
            CCSprite* background1 = [CCSprite spriteWithFile:teachPic1];
            CCSprite* background2 = [CCSprite spriteWithFile:teachPic2];
            background2.visible = NO;
            CCSprite* background3 = [CCSprite spriteWithFile:teachPic3];
            background3.visible = NO;
            //change size by diff version manual
            background1.scaleX=(screenSize.width)/[background1 contentSize].width; //按照像素定制图片宽高
            background1.scaleY=(screenSize.height)/[background1 contentSize].height;
            background2.scaleX=(screenSize.width)/[background2 contentSize].width; //按照像素定制图片宽高
            background2.scaleY=(screenSize.height)/[background2 contentSize].height;
            background3.scaleX=(screenSize.width)/[background3 contentSize].width; //按照像素定制图片宽高
            background3.scaleY=(screenSize.height)/[background3 contentSize].height;
            //CGSize screenSize = [[CCDirector sharedDirector] winSize];
            //change size by diff version
            screenSize = [[CCDirector sharedDirector] winSize];
            background1.position = CGPointMake(screenSize.width * 0.5 , screenSize.height * 0.5);
            background2.position = CGPointMake(screenSize.width * 0.5 , screenSize.height * 0.5);
            background3.position = CGPointMake(screenSize.width * 0.5 , screenSize.height * 0.5);
            [self addChild:background1 z:98 tag:98];
            [self addChild:background2 z:99 tag:99];
            [self addChild:background3 z:100 tag:100];
            [self schedule:@selector(visibleScdPic:) interval:3];
            
            //直接返回
            return;
        }

        case 2:
        {
            teachPic = [NSString stringWithFormat:@"teachdetail4-2.jpg"];
            break;
        }
        case 3:
        {
            teachPic = [NSString stringWithFormat:@"teachdetail5.jpg"];
            break;

        }
        case 4:
        {
            teachPic = [NSString stringWithFormat:@"teachscore.png"];
            break;
            
        }
        case 5:
        {
            teachPic = [NSString stringWithFormat:@"teachbomb.jpg"];
            break;
        }
        case 6:
        {
            teachPic = [NSString stringWithFormat:@"teachsnake.png"];
            break;
        }
        case 8:
        {
            teachPic = [NSString stringWithFormat:@"teachmagic.jpg"];
            break;
        }
        case 9:
        {
            teachPic = [NSString stringWithFormat:@"teachstoragetype.png"];
            break;
        }
        case 11:
        {
            teachPic = [NSString stringWithFormat:@"teachice.jpg"];
            break;
        }
        case 13:
        {
            teachPic = [NSString stringWithFormat:@"teachpepper.jpg"];

            break;
        }
        case 14:
        {
            teachPic = [NSString stringWithFormat:@"teachgalic.jpg"];
            break;
        }
        case 17:
        {
            teachPic = [NSString stringWithFormat:@"teachshop.png"];
            break;
        }
        default:
        {
            teachPic = [NSString stringWithFormat:@"teachdetail5.jpg"];
            break;
        }
    }
    CCSprite* background = [CCSprite spriteWithFile:teachPic];
    
    //change size by diff version manual
    background.scaleX=(screenSize.width)/[background contentSize].width; //按照像素定制图片宽高
    background.scaleY=(screenSize.height)/[background contentSize].height;
    //CGSize screenSize = [[CCDirector sharedDirector] winSize];
    //change size by diff version
    screenSize = [[CCDirector sharedDirector] winSize];
    background.position = CGPointMake(screenSize.width * 0.5 , screenSize.height * 0.5);
    [self addChild:background z:100];
    
    //弹出评分提示
    switch (type) {
        case 10:
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"进入评分"
                                                            message:@"如果觉得好去给个好评吧，亲!"
                                                           delegate:self
                                                  cancelButtonTitle:@"现在去评分"
                                                  otherButtonTitles:@"稍候评分",nil];
            alert.delegate =   self;  
            [alert show];
            [self pauseDelegate];
            return;
            
        }
        case 15:
        case 18:
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"进入评分"
                                                            message:@"如果觉得好去给个好评吧，亲!"
                                                           delegate:self
                                                  cancelButtonTitle:@"现在去评分"
                                                  otherButtonTitles:@"已评分",nil];
            alert.delegate =   self;  
            [alert show];
            [self pauseDelegate];
            return;
        }
    }
}

-(id)initTeachGameLayer:(int)type
{
    if (self = [super init]) 
    {
        [self initPic:type];
    }
    return self;
}
-(void) visibleTrdPic:(ccTime)delta
{
    
    CCNode* node = [self getChildByTag:100];
    node.visible = YES;
    [self unschedule:_cmd];
}

-(void) visibleScdPic:(ccTime)delta
{
	// It's not strictly necessary, as we're changing the scene anyway. But just to be safe.

    CCNode* node = [self getChildByTag:99];
    node.visible = YES;
    [self schedule:@selector(visibleTrdPic:) interval:4];
    [self unschedule:_cmd];
}

+(id)createTeachGameLayer:(int)type
{
    return [[[TeachGameLayer alloc] initTeachGameLayer:type] autorelease];
}

-(void)returnGame
{
    //[[GameMainScene sharedMainScene] playAudio:SelectOK];
    [[GameMainScene sharedMainScene] resumeGame];
    [self.parent removeChild:self cleanup:YES];
}

@end
