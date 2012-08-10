//
//  LevelScenePair.m
//  GreedFamilyHD
//
//  Created by 赵 苹果 on 12-8-10.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import "LevelScenePair.h"
#import "LoadingScene.h"
#import "NavigationScene.h"

@implementation LevelScenePair

-(id)init
{
    if ((self = [super init])) 
    {
        CCLabelTTF *label1=[CCLabelTTF labelWithString:@"Easy" fontName:@"Marker Felt" fontSize:30];
        CCLabelTTF *lable2=[CCLabelTTF labelWithString:@"Hard" fontName:@"Marker Felt" fontSize:30];
        CCLabelTTF *returnLabel=[CCLabelTTF labelWithString:@"GO Back" fontName:@"Marker Felt" fontSize:25];
        
        CCMenuItemLabel * option1 = [CCMenuItemLabel itemWithLabel:label1 target:self selector:@selector(beginLevel1:)];
		CCMenuItemLabel * option2 = [CCMenuItemLabel itemWithLabel:lable2 target:self selector:@selector(beginLevel2:)];
        CCMenuItemLabel * returnBtn = [CCMenuItemLabel itemWithLabel:returnLabel target:self selector:@selector(goBack:)];
        CCMenu * menu = [CCMenu menuWithItems:option1, option2, returnBtn, nil];
		[menu alignItemsVerticallyWithPadding:10];
		[self addChild:menu];
        CGSize size = [[CCDirector sharedDirector] winSize];
		[menu setPosition:ccp(size.width,size.height/2)];
        
        [option1 runAction:[CCSequence actions:
							[CCEaseOut actionWithAction:[CCMoveBy actionWithDuration:1 position:ccp(-size.width/2,0)]  rate:2],
							[CCRepeat actionWithAction:[CCSequence actions:[CCScaleTo actionWithDuration:1 scale:1.3],[CCScaleTo actionWithDuration:1 scale:1],nil] times:9000],
							nil]];
		[option2 runAction:[CCSequence actions:
							[CCDelayTime actionWithDuration:0.5],[CCEaseOut actionWithAction:[CCMoveBy actionWithDuration:1 position:ccp(-size.width/2,0)]  rate:2],
							[CCRepeat actionWithAction:[CCSequence actions:[CCScaleTo actionWithDuration:1 scale:1.3],[CCScaleTo actionWithDuration:1 scale:1],nil] times:9000],
							nil]];
		[returnBtn runAction:[CCSequence actions:
                                [CCDelayTime actionWithDuration:0.9],[CCEaseOut actionWithAction:[CCMoveBy actionWithDuration:1 position:ccp(-size.width/2,0)]  rate:2],
                                [CCRepeat actionWithAction:[CCSequence actions:[CCScaleTo actionWithDuration:1 scale:1.3],[CCScaleTo actionWithDuration:1 scale:1],nil] times:9000],
                                nil]];

    }
    return self;
}

- (void)beginLevel1:(id)sender 
{
    [[CCDirector sharedDirector] replaceScene:[LoadingScene sceneWithTargetScene:(TargetScenes)TargetScenesPairEasy]];
}
- (void)beginLevel2:(id)sender 
{
    [[CCDirector sharedDirector] replaceScene:[LoadingScene sceneWithTargetScene:(TargetScenes)TargetScenesPairHard]];
}
-(void)goBack:(id)sender
{
    [[CCDirector sharedDirector] replaceScene:[NavigationScene scene]];
}

+(id)scene
{
    //order = order;
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	LevelScenePair *levelScene = [LevelScenePair sceneWithLevelScene];
	
	// add layer as a child to scene
	[scene addChild: levelScene];
    
	return scene;
    
}

+(id)sceneWithLevelScene
{
    return [[[self alloc] init] autorelease];
}
@end
