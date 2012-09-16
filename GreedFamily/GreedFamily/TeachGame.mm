//
//  TeachGame.m
//  GreedFamily
//
//  Created by 赵 苹果 on 12-9-16.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import "TeachGame.h"
#import "GameMainScene.h"

@implementation TeachGame

-(id)initTeachGame
{
    if (self = [super init]) 
    {
        self.isTouchEnabled = YES;
        CCLabelTTF *label = [CCLabelTTF labelWithString:@"Tap to start!" fontName:@"Marker Felt" fontSize:64];
        label.scale = 0.4;  
        CCAction* action = [CCBlink actionWithDuration:1 blinks:3];
        [label runAction: action]; 
        
        [self addChild:label z:-10];
        
        // IMPORTANT: filenames are case sensitive on iOS devices!
        CCSprite* background = [CCSprite spriteWithFile:@"teach1.jpg"];
        //change size by diff version manual
        background.scaleX=(480)/[background contentSize].width; //按照像素定制图片宽高
        background.scaleY=(360)/[background contentSize].height;
        //CGSize screenSize = [[CCDirector sharedDirector] winSize];
        //change size by diff version
        background.position = [GameMainScene sharedMainScene].backgroundPos;
        
        [self addChild:background z:-10];
    }
    return self;
}


+(id)createTeachGame
{
    return [[[TeachGame alloc] initTeachGame] autorelease];
}

-(void)returnGame
{
    //[[GameMainScene sharedMainScene] playAudio:SelectOK];
    [[GameMainScene sharedMainScene] resumeGame];
    [self.parent removeChild:self cleanup:YES];
}

-(void)ccTouchesEnded:(NSSet *)touches withEvent:(UIEvent *)event  
{  
    [self returnGame];
} 
@end
