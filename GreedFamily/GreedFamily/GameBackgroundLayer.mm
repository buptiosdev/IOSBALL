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
    instanceOfGameBackgroundLayer = self;
    //加载所有的图片列表
    CCSpriteFrameCache* frameCache = [CCSpriteFrameCache sharedSpriteFrameCache];
    [frameCache addSpriteFramesWithFile:@"magicball_default.plist"];
    
    // batch node for all dynamic elements
    CCSpriteBatchNode* batch = [CCSpriteBatchNode batchNodeWithFile:@"magicball_default.png" capacity:100];
    [self addChild:batch z:0 tag:BatchTag];

//    // a bright background is desireable for this pinball table
//    CCColorLayer* colorLayer = [CCColorLayer layerWithColor:ccc4(0, 0, 255, 200)];
//    [self addChild:colorLayer z:100];
    

    // IMPORTANT: filenames are case sensitive on iOS devices!
    CCSprite* background = [CCSprite spriteWithSpriteFrameName:@"background.png"];
    CGSize screenSize = [[CCDirector sharedDirector] winSize];
    background.position = CGPointMake(screenSize.width / 2, screenSize.height / 2);
    [self addChild:background z:-3];
    
    // Play the background music in an endless loop.
    [[SimpleAudioEngine sharedEngine] playBackgroundMusic:@"blues.mp3" loop:YES];
    [[SimpleAudioEngine sharedEngine] preloadEffect:@"hit.caf"];    
    //加载瓷砖地图层
    //TileMapLayer *tileMapLayer = [TileMapLayer node];
    //[self addChild:tileMapLayer z:-2 tag:TileMapLayerTag];
    
    return self;
}
-(CCSpriteBatchNode*) getSpriteBatch
{
	return (CCSpriteBatchNode*)[self getChildByTag:BatchTag];
}

-(void) dealloc
{
	[super dealloc];
    
    instanceOfGameBackgroundLayer = nil; 
}
@end
