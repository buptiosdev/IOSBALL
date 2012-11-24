//
//  GameBackgroundLayer.m
//  GreedFamily
//
//  Created by 赵 苹果 on 12-4-19.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import "GameBackgroundLayer.h"
#import "GameMainScene.h"
#import "CommonLayer.h"
#import "GameScore.h"

@implementation GameBackgroundLayer


+(id)CreateGameBackgroundLayer
{
	return [[[self alloc] init] autorelease];
}

/*创造一个半单例，让其他类可以很方便访问scene*/
static GameBackgroundLayer *instanceOfGameBackgroundLayer;
+(GameBackgroundLayer *)sharedGameBackgroundLayer
{
    NSAssert(nil != instanceOfGameBackgroundLayer, @"GameBackgroundLayer instance not yet initialized!");
    
    return instanceOfGameBackgroundLayer;
}

-(id)init
{
    if ((self = [super init]))
    {
        instanceOfGameBackgroundLayer = self;
        //加载所有的图片列表
        CCSpriteFrameCache* frameCache = [CCSpriteFrameCache sharedSpriteFrameCache];
        //[frameCache addSpriteFramesWithFile:@"magicball_default.plist"];
        //[frameCache addSpriteFramesWithFile:@"elements_default.plist"];
        //[frameCache addSpriteFramesWithFile:@"level_default_default.plist"];
        [frameCache addSpriteFramesWithFile:@"button_default_default.plist"];
        [frameCache addSpriteFramesWithFile:@"gamemain01_default.plist"];
        // batch node for all dynamic elements
        //CCSpriteBatchNode* batch = [CCSpriteBatchNode batchNodeWithFile:@"magicball_default.png" capacity:100];
        CCSpriteBatchNode* batch = [CCSpriteBatchNode batchNodeWithFile:@"gamemain01_default.png" capacity:100];
        [self addChild:batch z:2 tag:BatchTag];
        CCSpriteBatchNode* batch2 = [CCSpriteBatchNode batchNodeWithFile:@"button_default_default.png" capacity:100];
        [self addChild:batch2 z:1 tag:ButtonTag];

        
        // batch node for all animation elements
//        CCSpriteBatchNode* batch2 = [CCSpriteBatchNode batchNodeWithFile:@"elements_default.png" capacity:100];
//        [self addChild:batch2 z:-1 tag:AnimationTag];
        
        // IMPORTANT: filenames are case sensitive on iOS devices!
        CCSprite* background = [CCSprite spriteWithFile:@"background_level.jpg"];
        //change size by diff version manual
        background.scaleX=(480)/[background contentSize].width; //按照像素定制图片宽高
        background.scaleY=(335)/[background contentSize].height;
        //CGSize screenSize = [[CCDirector sharedDirector] winSize];
        //change size by diff version
        background.position = [GameMainScene sharedMainScene].backgroundPos;
        [self addChild:background z:-3];

        
        // Play the background music in an endless loop.
        [self preloadAudio];

    }
    return self;
}

-(void)playBackMusic
{
    NSUserDefaults *usrDef = [NSUserDefaults standardUserDefaults];
    BOOL sound = [usrDef boolForKey:@"music"];
    if (NO == sound) 
    {
        return;
    }
        
    int order = [GameMainScene sharedMainScene].sceneNum;
    
    if (order > 0 && order <= 5) 
    {
        [CommonLayer playBackMusic:GameMusic5];
    }
    else if (order > 0 && order <= 10)
    {
        [CommonLayer playBackMusic:GameMusic6];
    }
    else if (order > 0 && order <= 15) 
    {
        [CommonLayer playBackMusic:GameMusic2];
    }
    else if (order > 0 && order <= 18)
    {
       [CommonLayer playBackMusic:GameMusic3];
    }
    else
    {
       [CommonLayer playBackMusic:GameMusic4];

    }
    //[[SimpleAudioEngine sharedEngine] playBackgroundMusic:@"blues.mp3" loop:YES];
}

-(void)preloadAudio
{
    [self playBackMusic];
    [CommonLayer preloadAudio];
}

-(CCSpriteBatchNode*) getSpriteBatch
{
	return (CCSpriteBatchNode*)[self getChildByTag:BatchTag];
}
-(CCSpriteBatchNode*) getButtonBatch
{
	return (CCSpriteBatchNode*)[self getChildByTag:ButtonTag];
}

//-(CCSpriteBatchNode*) getAnimationBatch
//{
//	return (CCSpriteBatchNode*)[self getChildByTag:AnimationTag];
//}

-(void) dealloc
{
    instanceOfGameBackgroundLayer = nil; 
    
	[super dealloc];
    

}
@end
