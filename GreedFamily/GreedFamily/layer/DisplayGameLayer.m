//
//  DisplayGameLayer.m
//  GreedFamily
//
//  Created by 赵 苹果 on 12-12-9.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import "DisplayGameLayer.h"


@implementation DisplayGameLayer


-(void)initPic:(int)type
{
    CGSize screenSize = [[CCDirector sharedDirector] winSize];
    NSString* displayPic = nil;
    switch (type) {
        case 5:
        {
            displayPic = [NSString stringWithFormat:@"teachbomb.jpg"];
            break;
        }
        case 8:
        {
            displayPic = [NSString stringWithFormat:@"teachmagic.jpg"];
            break;
        }
        case 11:
        {
            displayPic = [NSString stringWithFormat:@"teachice.jpg"];
            break;
        }
        case 13:
        {
            displayPic = [NSString stringWithFormat:@"teachpepper.jpg"];
            
            break;
        }
        case 14:
        {
            displayPic = [NSString stringWithFormat:@"teachgalic.jpg"];
            break;
        }
        default:
        {
            int randomNum = random()%2;
            
            if (0 == randomNum) 
            {
                displayPic = [NSString stringWithFormat:@"display_pig.png"];
            }
            else
            {
                displayPic = [NSString stringWithFormat:@"display_snake.png"];
            }
            
            break;
        }
            
    }
    CCSprite* background = [CCSprite spriteWithFile:displayPic];
    
    //change size by diff version manual
    background.scaleX=(screenSize.width)/[background contentSize].width; //按照像素定制图片宽高
    background.scaleY=(screenSize.height)/[background contentSize].height;
    //CGSize screenSize = [[CCDirector sharedDirector] winSize];
    //change size by diff version
    screenSize = [[CCDirector sharedDirector] winSize];
    background.position = CGPointMake(screenSize.width * 0.5 , screenSize.height * 0.5);
    [self addChild:background z:1];
    
}

-(id)initDisplayGameLayer:(int)type
{
    if (self = [super init]) 
    {
        [self initPic:type];
    }
    return self;
}

+(id)createDisplayGameLayer:(int)type
{
    return [[[DisplayGameLayer alloc] initDisplayGameLayer:type] autorelease];
}

@end
