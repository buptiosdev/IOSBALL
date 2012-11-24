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

-(id)initTeachGameLayer
{
    if (self = [super init]) 
    {
        self.isTouchEnabled = YES;
        CGSize screenSize = [[CCDirector sharedDirector] winSize];
        CCLabelTTF *label = [CCLabelTTF labelWithString:@"Tap to start!" fontName:@"Marker Felt" fontSize:64];
        label.scale = 0.4;  
        //CGSize screenSize = [[CCDirector sharedDirector] winSize];
        label.position = CGPointMake(screenSize.width * 0.4, screenSize.height * 0.4);
        
        //CCAction* action = [CCBlink actionWithDuration:1 blinks:1];
        CCBlink* action = [CCBlink actionWithDuration:2 blinks:1]; 
        CCRepeatForever* repeat = [CCRepeatForever actionWithAction:action]; 
        [label runAction: repeat]; 
        
        [self addChild:label z:100];
        
        // IMPORTANT: filenames are case sensitive on iOS devices!
        int teachPicCount = random() % 3;
        NSString* teachStr = [NSString stringWithFormat:@"teach"];
        NSString* teachPic = [NSString stringWithFormat:@"%@%i.png", teachStr, teachPicCount+1];
        CCSprite* background = [CCSprite spriteWithFile:teachPic];

        //change size by diff version manual
        background.scaleX=(screenSize.width)/[background contentSize].width; //按照像素定制图片宽高
        background.scaleY=(screenSize.height)/[background contentSize].height;
        //CGSize screenSize = [[CCDirector sharedDirector] winSize];
        //change size by diff version
        background.position = [GameMainScene sharedMainScene].backgroundPos;
        
        [self addChild:background z:100];
    }
    return self;
}


+(id)createTeachGameLayer
{
    return [[[TeachGameLayer alloc] initTeachGameLayer] autorelease];
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
