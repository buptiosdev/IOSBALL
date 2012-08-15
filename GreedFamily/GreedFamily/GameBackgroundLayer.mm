//
//  GameBackgroundLayer.m
//  GreedFamily
//
//  Created by 赵 苹果 on 12-4-19.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import "GameBackgroundLayer.h"
#import "GameMainScene.h"
#import "SimpleAudioEngine.h"
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
        [frameCache addSpriteFramesWithFile:@"magicball_default.plist"];
        [frameCache addSpriteFramesWithFile:@"elements_default.plist"];
        [frameCache addSpriteFramesWithFile:@"level_default_default.plist"];
        
        // batch node for all dynamic elements
        CCSpriteBatchNode* batch = [CCSpriteBatchNode batchNodeWithFile:@"magicball_default.png" capacity:100];
        [self addChild:batch z:0 tag:BatchTag];
        
        // batch node for all animation elements
        CCSpriteBatchNode* batch2 = [CCSpriteBatchNode batchNodeWithFile:@"elements_default.png" capacity:100];
        [self addChild:batch2 z:-1 tag:AnimationTag];
        

    //    // a bright background is desireable for this pinball table
    //    CCColorLayer* colorLayer = [CCColorLayer layerWithColor:ccc4(0, 0, 255, 200)];
    //    [self addChild:colorLayer z:100];
        

        // IMPORTANT: filenames are case sensitive on iOS devices!
        CCSprite* background = [CCSprite spriteWithFile:@"background_1.jpg"];
        //change size by diff version manual
        background.scaleX=(480)/[background contentSize].width; //按照像素定制图片宽高
        background.scaleY=(360)/[background contentSize].height;
        //CGSize screenSize = [[CCDirector sharedDirector] winSize];
        //change size by diff version
        background.position = [GameMainScene sharedMainScene].backgroundPos;
        [self addChild:background z:-3];
//        
//        CCSprite* ground = [CCSprite spriteWithSpriteFrameName:@"ground.png"];
//        
//        ground.position = CGPointMake(screenSize.width / 2, 50);
//        [self addChild:ground z:-3];
        
        // Play the background music in an endless loop.
        [self preloadAudio];

        
        //加载瓷砖地图层
        //TileMapLayer *tileMapLayer = [TileMapLayer node];
        //[self addChild:tileMapLayer z:-2 tag:TileMapLayerTag];
    }
    return self;
}

-(void)preloadAudio
{
    //[[SimpleAudioEngine sharedEngine] playBackgroundMusic:@"blues.mp3" loop:YES];
    [[SimpleAudioEngine sharedEngine] preloadEffect:@"bite.caf"];    
    [[SimpleAudioEngine sharedEngine] preloadEffect:@"needtouch.caf"]; 
    [[SimpleAudioEngine sharedEngine] preloadEffect:@"getscore.caf"]; 
    [[SimpleAudioEngine sharedEngine] preloadEffect:@"bomb.caf"]; 
    [[SimpleAudioEngine sharedEngine] preloadEffect:@"bubblebreak.caf"]; 
    [[SimpleAudioEngine sharedEngine] preloadEffect:@"bubblehit.caf"]; 
    [[SimpleAudioEngine sharedEngine] preloadEffect:@"der.caf"]; 
    [[SimpleAudioEngine sharedEngine] preloadEffect:@"ding.caf"]; 
    [[SimpleAudioEngine sharedEngine] preloadEffect:@"dorp.caf"]; 
    [[SimpleAudioEngine sharedEngine] preloadEffect:@"drum.caf"]; 
    [[SimpleAudioEngine sharedEngine] preloadEffect:@"failwarning.caf"]; 
    [[SimpleAudioEngine sharedEngine] preloadEffect:@"good.caf"]; 
    [[SimpleAudioEngine sharedEngine] preloadEffect:@"laugh1.caf"]; 
    [[SimpleAudioEngine sharedEngine] preloadEffect:@"laugh2.caf"]; 
    [[SimpleAudioEngine sharedEngine] preloadEffect:@"select.caf"]; 
    [[SimpleAudioEngine sharedEngine] preloadEffect:@"toll.caf"]; 
}

-(CCSpriteBatchNode*) getSpriteBatch
{
	return (CCSpriteBatchNode*)[self getChildByTag:BatchTag];
}

-(CCSpriteBatchNode*) getAnimationBatch
{
	return (CCSpriteBatchNode*)[self getChildByTag:AnimationTag];
}

-(void) dealloc
{
    instanceOfGameBackgroundLayer = nil; 
    
	[super dealloc];
    

}
@end
