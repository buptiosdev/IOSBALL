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
#import "CCScrollLayer.h"

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
        //ccColor4B c = {0,0,0,180};
        //CCLayerColor * difficulty=[CCLayerColor layerWithColor:c];
        //[self addChild:difficulty z:0 tag:TargetNavigationScen];
        
//        CCMenuItemImage * easyBtn = [CCMenuItemImage itemFromNormalImage:@"easy.png"
//                                                           selectedImage:@"easy_dwn.png" 
//                                                           disabledImage:@"easy_dis.png"
//                                                                  target:self
//                                                                selector:@selector(selectMode:)];
//        
//        
//        
//        CCMenuItemImage * normalBtn = [CCMenuItemImage itemFromNormalImage:@"normal.png"
//                                                             selectedImage:@"normal_dwn.png" 
//                                                             disabledImage:@"normal_dis.png"
//                                                                    target:self
//                                                                  selector:@selector(selectMode:)];
//        
//        CCMenuItemImage * extremeBtn = [CCMenuItemImage itemFromNormalImage:@"extreme.png"
//                                                              selectedImage:@"extreme_dwn.png" 
//                                                              disabledImage:@"extreme_dis.png"
//                                                                     target:self
//                                                                   selector:@selector(selectMode:)];
        
        CCLabelTTF *Label1=[CCLabelTTF labelWithString:@"Level 1" fontName:@"Marker Felt" fontSize:25];
        [Label1 setColor:ccRED];
        CCMenuItemLabel * LevelBtn1 = [CCMenuItemLabel itemWithLabel:Label1 target:self selector:@selector(selectMode:)];
        
        CCLabelTTF *Label2=[CCLabelTTF labelWithString:@"Level 2" fontName:@"Marker Felt" fontSize:25];
        [Label2 setColor:ccRED];
        CCMenuItemLabel * LevelBtn2 = [CCMenuItemLabel itemWithLabel:Label2 target:self selector:@selector(selectMode:)];
        
        CCLabelTTF *Label3=[CCLabelTTF labelWithString:@"Level 3" fontName:@"Marker Felt" fontSize:25];
        [Label3 setColor:ccRED];
        CCMenuItemLabel * LevelBtn3 = [CCMenuItemLabel itemWithLabel:Label3 target:self selector:@selector(selectMode:)];
        
        CCLabelTTF *Label4=[CCLabelTTF labelWithString:@"Level 4" fontName:@"Marker Felt" fontSize:25];
        [Label4 setColor:ccRED];
        CCMenuItemLabel * LevelBtn4 = [CCMenuItemLabel itemWithLabel:Label4 target:self selector:@selector(selectMode:)];
        
        CCLabelTTF *Label5=[CCLabelTTF labelWithString:@"Level 5" fontName:@"Marker Felt" fontSize:25];
        [Label5 setColor:ccRED];
        CCMenuItemLabel * LevelBtn5 = [CCMenuItemLabel itemWithLabel:Label5 target:self selector:@selector(selectMode:)];
        
        CCLabelTTF *Label6=[CCLabelTTF labelWithString:@"Level 6" fontName:@"Marker Felt" fontSize:25];
        [Label6 setColor:ccRED];
        CCMenuItemLabel * LevelBtn6 = [CCMenuItemLabel itemWithLabel:Label6 target:self selector:@selector(selectMode:)];
        
        CCLabelTTF *Label7=[CCLabelTTF labelWithString:@"Level 7" fontName:@"Marker Felt" fontSize:25];
        [Label7 setColor:ccRED];
        CCMenuItemLabel * LevelBtn7 = [CCMenuItemLabel itemWithLabel:Label7 target:self selector:@selector(selectMode:)];
        
        CCLabelTTF *Label8=[CCLabelTTF labelWithString:@"Level 8" fontName:@"Marker Felt" fontSize:25];
        [Label8 setColor:ccRED];
        CCMenuItemLabel * LevelBtn8 = [CCMenuItemLabel itemWithLabel:Label8 target:self selector:@selector(selectMode:)];
        
        CCLabelTTF *Label9=[CCLabelTTF labelWithString:@"Level 9" fontName:@"Marker Felt" fontSize:25];
        [Label9 setColor:ccRED];
        CCMenuItemLabel * LevelBtn9 = [CCMenuItemLabel itemWithLabel:Label9 target:self selector:@selector(selectMode:)];
        
        CCLabelTTF *Label10=[CCLabelTTF labelWithString:@"Level 10" fontName:@"Marker Felt" fontSize:25];
        [Label10 setColor:ccRED];
        CCMenuItemLabel * LevelBtn10 = [CCMenuItemLabel itemWithLabel:Label10 target:self selector:@selector(selectMode:)];
        
        CCLabelTTF *Label11=[CCLabelTTF labelWithString:@"Level 11" fontName:@"Marker Felt" fontSize:25];
        [Label11 setColor:ccRED];
        CCMenuItemLabel * LevelBtn11 = [CCMenuItemLabel itemWithLabel:Label11 target:self selector:@selector(selectMode:)];
        
        CCLabelTTF *Label12=[CCLabelTTF labelWithString:@"Level 12" fontName:@"Marker Felt" fontSize:25];
        [Label12 setColor:ccRED];
        CCMenuItemLabel * LevelBtn12 = [CCMenuItemLabel itemWithLabel:Label12 target:self selector:@selector(selectMode:)];
        
        CCLabelTTF *Label13=[CCLabelTTF labelWithString:@"Level 13" fontName:@"Marker Felt" fontSize:25];
        [Label13 setColor:ccRED];
        CCMenuItemLabel * LevelBtn13 = [CCMenuItemLabel itemWithLabel:Label13 target:self selector:@selector(selectMode:)];
        
        CCLabelTTF *Label14=[CCLabelTTF labelWithString:@"Level 14" fontName:@"Marker Felt" fontSize:25];
        [Label14 setColor:ccRED];
        CCMenuItemLabel * LevelBtn14 = [CCMenuItemLabel itemWithLabel:Label14 target:self selector:@selector(selectMode:)];
        
        CCLabelTTF *Label15=[CCLabelTTF labelWithString:@"Level 15" fontName:@"Marker Felt" fontSize:25];
        [Label15 setColor:ccRED];
        CCMenuItemLabel * LevelBtn15 = [CCMenuItemLabel itemWithLabel:Label15 target:self selector:@selector(selectMode:)];
        
        CCLabelTTF *Label16=[CCLabelTTF labelWithString:@"Level 16" fontName:@"Marker Felt" fontSize:25];
        [Label16 setColor:ccRED];
        CCMenuItemLabel * LevelBtn16 = [CCMenuItemLabel itemWithLabel:Label16 target:self selector:@selector(selectMode:)];

        CCLabelTTF *Label17=[CCLabelTTF labelWithString:@"Level 17" fontName:@"Marker Felt" fontSize:25];
        [Label17 setColor:ccRED];
        CCMenuItemLabel * LevelBtn17 = [CCMenuItemLabel itemWithLabel:Label17 target:self selector:@selector(selectMode:)];
        
        CCLabelTTF *Label18=[CCLabelTTF labelWithString:@"Level 18" fontName:@"Marker Felt" fontSize:25];
        [Label18 setColor:ccRED];
        CCMenuItemLabel * LevelBtn18 = [CCMenuItemLabel itemWithLabel:Label18 target:self selector:@selector(selectMode:)];
        
        CCLabelTTF *Label19=[CCLabelTTF labelWithString:@"Level 19" fontName:@"Marker Felt" fontSize:25];
        [Label19 setColor:ccRED];
        CCMenuItemLabel * LevelBtn19 = [CCMenuItemLabel itemWithLabel:Label19 target:self selector:@selector(selectMode:)];
        
        CCLabelTTF *Label20=[CCLabelTTF labelWithString:@"Level 20" fontName:@"Marker Felt" fontSize:25];
        [Label20 setColor:ccRED];
        CCMenuItemLabel * LevelBtn20 = [CCMenuItemLabel itemWithLabel:Label20 target:self selector:@selector(selectMode:)];
        
        CCLabelTTF *returnLabel=[CCLabelTTF labelWithString:@"Main Menu" fontName:@"Marker Felt" fontSize:25];
        [returnLabel setColor:ccRED];
        CCMenuItemLabel * returnBtn = [CCMenuItemLabel itemWithLabel:returnLabel target:self selector:@selector(returnMain)];
        
//        [easyBtn setIsEnabled:YES];
//        [normalBtn setIsEnabled:YES];
//        [extremeBtn setIsEnabled:YES];
//        [returnBtn setIsEnabled:YES];
//        
//        [easyBtn setTag:TargetScene1stScene];
//        [normalBtn setTag:TargetScene2ndScene];
//        [extremeBtn setTag:TargetScene3rdScene];
//        //[returnBtn setTag:TargetNavigationScen];
        [LevelBtn1 setTag:TargetScene1stScene];
        [LevelBtn2 setTag:TargetScene2ndScene];
        [LevelBtn3 setTag:TargetScene3rdScene];
        [LevelBtn4 setTag:TargetScene4thScene];
        [LevelBtn5 setTag:TargetScene5thScene];
        [LevelBtn6 setTag:TargetScene6thScene];
        [LevelBtn7 setTag:TargetScene7thScene];
        [LevelBtn8 setTag:TargetScene8thScene];
        [LevelBtn9 setTag:TargetScene9thScene];
        [LevelBtn10 setTag:TargetScene10thScene];
        [LevelBtn11 setTag:TargetScene11thScene];
        [LevelBtn12 setTag:TargetScene12thScene];
        [LevelBtn13 setTag:TargetScene13thScene];
        [LevelBtn14 setTag:TargetScene14thScene];
        [LevelBtn15 setTag:TargetScene15thScene];
        [LevelBtn16 setTag:TargetScene16thScene];
        [LevelBtn17 setTag:TargetScene17thScene];
        [LevelBtn18 setTag:TargetScene18thScene];
        [LevelBtn19 setTag:TargetScene19thScene];
        [LevelBtn20 setTag:TargetScene20thScene];
        
//        CCMenu * dMenu = [CCMenu menuWithItems:easyBtn,normalBtn,extremeBtn,returnBtn,nil];
//        CCMenu * dMenu = [CCMenu menuWithItems:LevelBtn1,LevelBtn2,LevelBtn3,LevelBtn4,LevelBtn5,LevelBtn6,LevelBtn7,LevelBtn8,LevelBtn9,LevelBtn10,LevelBtn11,LevelBtn12,LevelBtn13,LevelBtn14,LevelBtn15,LevelBtn16,LevelBtn17,LevelBtn18,LevelBtn19,LevelBtn20,returnBtn,nil];
//        [dMenu alignItemsVerticallyWithPadding:10];
//        [dMenu alignItemsHorizontallyWithPadding:10];
        CGSize screenSize = [[CCDirector sharedDirector] winSize];
        CCMenu * easyMenu = [CCMenu menuWithItems:LevelBtn1,LevelBtn2,LevelBtn3,LevelBtn4,LevelBtn5,nil];
        [easyMenu alignItemsHorizontallyWithPadding:23];
        [easyMenu setPosition:ccp((screenSize.width)*0.5f,(screenSize.height)*5/6)];
        //[difficulty addChild:easyMenu];
        
        CCMenu * normalMenu = [CCMenu menuWithItems:LevelBtn6,LevelBtn7,LevelBtn8,LevelBtn9,LevelBtn10, nil];
        [normalMenu alignItemsHorizontallyWithPadding:20];
        [normalMenu setPosition:ccp((screenSize.width)*0.5f,(screenSize.height)*4/6)];
        //[difficulty addChild:normalMenu];
        
        CCMenu * hardMenu = [CCMenu menuWithItems:LevelBtn11,LevelBtn12,LevelBtn13,LevelBtn14,LevelBtn15, nil];
        [hardMenu alignItemsHorizontallyWithPadding:8];
        [hardMenu setPosition:ccp((screenSize.width)*0.5f,(screenSize.height)*3/6)];
        //[difficulty addChild:hardMenu];
        
        CCMenu * extremeMenu = [CCMenu menuWithItems:LevelBtn16,LevelBtn17,LevelBtn18,LevelBtn19,LevelBtn20, nil];
        [extremeMenu alignItemsHorizontallyWithPadding:8];
        [extremeMenu setPosition:ccp((screenSize.width)*0.5f,(screenSize.height)*2/6)];
        //[difficulty addChild:extremeMenu];
        
        
        CCMenu * returnMenu = [CCMenu menuWithItems:returnBtn, nil];
        [returnMenu alignItemsHorizontallyWithPadding:10];
        [returnMenu setPosition:ccp((screenSize.width)*0.5f,(screenSize.height)*1/6)];
        [self addChild:returnMenu];
        
        //test
        CCLayer *pageOne = [[CCLayer alloc] init];
        [pageOne addChild:easyMenu];
        
        // create a blank layer for page 2
        CCLayer *pageTwo = [[CCLayer alloc] init];
        
        // add menu to page 2
        [pageTwo addChild:normalMenu];
        
        CCLayer *pageThree = [[CCLayer alloc] init];
        [pageThree addChild:hardMenu];
        
        CCLayer *pageFour = [[CCLayer alloc] init];
        [pageFour addChild:extremeMenu];
        
        // now create the scroller and pass-in the pages (set widthOffset to 0 for fullscreen pages)
        CCScrollLayer *scroller = [[CCScrollLayer alloc] initWithLayers:[NSMutableArray arrayWithObjects: pageOne,pageTwo,pageThree,pageFour,nil] widthOffset: 0];
        
        // finally add the scroller to your scene
        [self addChild:scroller];
        
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
