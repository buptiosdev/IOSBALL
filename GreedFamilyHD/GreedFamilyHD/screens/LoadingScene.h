//
//  LoadingScene.h
//  ScenesAndLayers
//
//  Created by Steffen Itterheim on 27.07.10.
//  Copyright 2010 Steffen Itterheim. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#define TEACH_TIMES 2

typedef enum
{
    TargetScenesPairEasy = -1,
    TargetScenesPairHard = -2,
	TargetSceneINVALID = 0,
	TargetScene1stScene,
	TargetScene2ndScene,
	TargetScene3rdScene,
    TargetScene4thScene,
    TargetScene5thScene,
    TargetScene6thScene,
    TargetScene7thScene,
    TargetScene8thScene,
    TargetScene9thScene,
    TargetScene10thScene,
    TargetScene11thScene,
    TargetScene12thScene,
    TargetScene13thScene,
    TargetScene14thScene,
    TargetScene15thScene,
    TargetScene16thScene,
    TargetScene17thScene,
    TargetScene18thScene,
    TargetScene19thScene,
    TargetScene20thScene,
    TargetScene21thScene,
    TargetScene22thScene,
    TargetScene23thScene,
    TargetScene24thScene,
    TargetScene25thScene,
    TargetScene26thScene,
    TargetScene27thScene,
    TargetScene28thScene,
    TargetScene29thScene,
    TargetScene30thScene,
    TargetNavigationScen,
	TargetSceneMAX,
} TargetScenes;

// LoadingScene is derived directly from Scene. We don't need a CCLayer for this scene.
@interface LoadingScene : CCScene
{
	TargetScenes targetScene_;
//    UIActivityIndicatorView *activityIndicatorView;
//    BOOL gameIsReady;
    //UIView *battleView;
}
@property(assign, nonatomic) int waitTime;
+(id) sceneWithTargetScene:(TargetScenes)targetScene;
-(id) initWithTargetScene:(TargetScenes)targetScene;

@end
