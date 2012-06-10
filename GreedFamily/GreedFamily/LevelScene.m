//
//  LevelScene.m
//  GreedFamily
//
//  Created by MagicStudio on 12-6-7.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import "LevelScene.h"
#import "LoadingScene.h"
#import "NavigationScene.h"

@implementation LevelScene


-(void)selectMode:(CCMenuItemImage *)btn
{
	int mode = btn.tag;
    [[CCDirector sharedDirector] replaceScene:[LoadingScene sceneWithTargetScene:(TargetScenes)mode]];
}

-(void)returnMain
{
    [[CCDirector sharedDirector] replaceScene:[NavigationScene scene]];
}

-(id)initWithLevelScene
{
    if ((self = [super init])) {
		self.isTouchEnabled = YES;
        ccColor4B c = {0,0,0,180};
        //CCColorLayer * difficulty = [CCColorLayer layerWithColor:c];
        CCLayerColor * difficulty=[CCLayerColor layerWithColor:c];
        [self addChild:difficulty z:0 tag:TargetNavigationScen];
        
        CCMenuItemImage * easyBtn = [CCMenuItemImage itemFromNormalImage:@"easy.png"
                                                           selectedImage:@"easy_dwn.png" 
                                                           disabledImage:@"easy_dis.png"
                                                                  target:self
                                                                selector:@selector(selectMode:)];
        
        
        
        CCMenuItemImage * normalBtn = [CCMenuItemImage itemFromNormalImage:@"normal.png"
                                                             selectedImage:@"normal_dwn.png" 
                                                             disabledImage:@"normal_dis.png"
                                                                    target:self
                                                                  selector:@selector(selectMode:)];
        
        CCMenuItemImage * extremeBtn = [CCMenuItemImage itemFromNormalImage:@"extreme.png"
                                                              selectedImage:@"extreme_dwn.png" 
                                                              disabledImage:@"extreme_dis.png"
                                                                     target:self
                                                                   selector:@selector(selectMode:)];
        
        CCLabelTTF *returnLabel=[CCLabelTTF labelWithString:@"Main Menu" fontName:@"Marker Felt" fontSize:30];
        [returnLabel setColor:ccRED];
        CCMenuItemLabel * returnBtn = [CCMenuItemLabel itemWithLabel:returnLabel target:self selector:@selector(returnMain)];
        
        [easyBtn setIsEnabled:YES];
        [normalBtn setIsEnabled:YES];
        [extremeBtn setIsEnabled:YES];
        [returnBtn setIsEnabled:YES];
        
        [easyBtn setTag:TargetSceneFstScene];
        [normalBtn setTag:TargetSceneScdScene];
        [extremeBtn setTag:TargetSceneThrdScene];
        //[returnBtn setTag:TargetNavigationScen];
        
        CCMenu * dMenu = [CCMenu menuWithItems:easyBtn,normalBtn,extremeBtn,returnBtn,nil];
        [dMenu alignItemsVerticallyWithPadding:10];
        [difficulty addChild:dMenu];
    }
    return self;
}

+(id)scene
{
    //order = order;
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	LevelScene *levelScene = [LevelScene sceneWithLevelScene];
	
	// add layer as a child to scene
	[scene addChild: levelScene];
    
	return scene;
    
}

+(id)sceneWithLevelScene
{
    return [[[self alloc] initWithLevelScene] autorelease];
}
@end
