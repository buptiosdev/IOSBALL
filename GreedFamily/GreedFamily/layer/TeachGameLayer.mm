//
//  TeachGameLayer.m
//  GreedFamily
//
//  Created by 赵 苹果 on 12-9-16.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import "TeachGameLayer.h"
#import "GameMainScene.h"

@implementation TeachGameLayer

-(void)initpic:(int)type
{
    CGSize screenSize = [[CCDirector sharedDirector] winSize];
    
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

            break;
        }

        case 2:
        {
            NSString* teachPic = [NSString stringWithFormat:@"teachdetail4-2.jpg"];
//            NSString* teachPic = [NSString stringWithFormat:@"%@%i.png", teachStr, type];
            CCSprite* background = [CCSprite spriteWithFile:teachPic];
            
            //change size by diff version manual
            background.scaleX=(screenSize.width)/[background contentSize].width; //按照像素定制图片宽高
            background.scaleY=(screenSize.height)/[background contentSize].height;
            //CGSize screenSize = [[CCDirector sharedDirector] winSize];
            //change size by diff version
            screenSize = [[CCDirector sharedDirector] winSize];
            background.position = CGPointMake(screenSize.width * 0.5 , screenSize.height * 0.5);
            [self addChild:background z:100];
            break;
        }

        case 3:
        {
            NSString* teachPic = [NSString stringWithFormat:@"teachdetail5.jpg"];
            CCSprite* background = [CCSprite spriteWithFile:teachPic];
            
            //change size by diff version manual
            background.scaleX=(screenSize.width)/[background contentSize].width; //按照像素定制图片宽高
            background.scaleY=(screenSize.height)/[background contentSize].height;
            //CGSize screenSize = [[CCDirector sharedDirector] winSize];
            //change size by diff version
            screenSize = [[CCDirector sharedDirector] winSize];
            background.position = CGPointMake(screenSize.width * 0.5 , screenSize.height * 0.5);
            [self addChild:background z:100];
            break;
        }
        case 4:
        {
            NSString* teachPic = [NSString stringWithFormat:@"teachmagic.jpg"];
//            NSString* teachPic = [NSString stringWithFormat:@"%@%i.png", teachStr, type];
            CCSprite* background = [CCSprite spriteWithFile:teachPic];
            
            //change size by diff version manual
            background.scaleX=(screenSize.width)/[background contentSize].width; //按照像素定制图片宽高
            background.scaleY=(screenSize.height)/[background contentSize].height;
            //CGSize screenSize = [[CCDirector sharedDirector] winSize];
            //change size by diff version
            screenSize = [[CCDirector sharedDirector] winSize];
            background.position = CGPointMake(screenSize.width * 0.5 , screenSize.height * 0.5);
            [self addChild:background z:100];
            break;
        }
        case 5:
        {
            NSString* teachPic = [NSString stringWithFormat:@"teachbomb.jpg"];
//            NSString* teachPic = [NSString stringWithFormat:@"%@%i.png", teachStr, type];
            CCSprite* background = [CCSprite spriteWithFile:teachPic];
            
            //change size by diff version manual
            background.scaleX=(screenSize.width)/[background contentSize].width; //按照像素定制图片宽高
            background.scaleY=(screenSize.height)/[background contentSize].height;
            //CGSize screenSize = [[CCDirector sharedDirector] winSize];
            //change size by diff version
            screenSize = [[CCDirector sharedDirector] winSize];
            background.position = CGPointMake(screenSize.width * 0.5 , screenSize.height * 0.5);
            [self addChild:background z:100];
            break;
        }
        case 12:
        {
            NSString* teachPic = [NSString stringWithFormat:@"teachpepper.jpg"];
            //            NSString* teachPic = [NSString stringWithFormat:@"%@%i.png", teachStr, type];
            CCSprite* background = [CCSprite spriteWithFile:teachPic];
            
            //change size by diff version manual
            background.scaleX=(screenSize.width)/[background contentSize].width; //按照像素定制图片宽高
            background.scaleY=(screenSize.height)/[background contentSize].height;
            //CGSize screenSize = [[CCDirector sharedDirector] winSize];
            //change size by diff version
            screenSize = [[CCDirector sharedDirector] winSize];
            background.position = CGPointMake(screenSize.width * 0.5 , screenSize.height * 0.5);
            [self addChild:background z:100];
            break;
        }
        case 11:
        {
            NSString* teachPic = [NSString stringWithFormat:@"teachice.jpg"];
            //            NSString* teachPic = [NSString stringWithFormat:@"%@%i.png", teachStr, type];
            CCSprite* background = [CCSprite spriteWithFile:teachPic];
            
            //change size by diff version manual
            background.scaleX=(screenSize.width)/[background contentSize].width; //按照像素定制图片宽高
            background.scaleY=(screenSize.height)/[background contentSize].height;
            //CGSize screenSize = [[CCDirector sharedDirector] winSize];
            //change size by diff version
            screenSize = [[CCDirector sharedDirector] winSize];
            background.position = CGPointMake(screenSize.width * 0.5 , screenSize.height * 0.5);
            [self addChild:background z:100];
            break;
        }
        case 13:
        {
            NSString* teachPic = [NSString stringWithFormat:@"teachgalic.jpg"];
            //            NSString* teachPic = [NSString stringWithFormat:@"%@%i.png", teachStr, type];
            CCSprite* background = [CCSprite spriteWithFile:teachPic];
            
            //change size by diff version manual
            background.scaleX=(screenSize.width)/[background contentSize].width; //按照像素定制图片宽高
            background.scaleY=(screenSize.height)/[background contentSize].height;
            //CGSize screenSize = [[CCDirector sharedDirector] winSize];
            //change size by diff version
            screenSize = [[CCDirector sharedDirector] winSize];
            background.position = CGPointMake(screenSize.width * 0.5 , screenSize.height * 0.5);
            [self addChild:background z:100];
            break;
        }
        default:
            break;
    }
    
}

-(id)initTeachGameLayer:(int)type
{
    if (self = [super init]) 
    {
//        self.isTouchEnabled = YES;
//        CGSize screenSize = [[CCDirector sharedDirector] winSize];
//        CCLabelTTF *label = [CCLabelTTF labelWithString:@"Tap to start!" fontName:@"Marker Felt" fontSize:64];
//        label.scale = 0.4;  
//        //CGSize screenSize = [[CCDirector sharedDirector] winSize];
//        label.position = CGPointMake(screenSize.width * 0.4, screenSize.height * 0.4);
//        
//        //CCAction* action = [CCBlink actionWithDuration:1 blinks:1];
//        CCBlink* action = [CCBlink actionWithDuration:2 blinks:1]; 
//        CCRepeatForever* repeat = [CCRepeatForever actionWithAction:action]; 
//        [label runAction: repeat]; 
        [self initpic:type];
//        [self addChild:label z:100];
        
        // IMPORTANT: filenames are case sensitive on iOS devices!
//        int teachPicCount = random() % 3;

        
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

//-(void)ccTouchesEnded:(NSSet *)touches withEvent:(UIEvent *)event  
//{  
//    [self returnGame];
//} 
@end
