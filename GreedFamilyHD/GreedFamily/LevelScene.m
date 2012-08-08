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
//#import "GameScore.h"

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

-(int)getGameStarNumber:(int)level
{
    NSString *str_starlevel = [NSString stringWithFormat:@"%d",level];
    str_starlevel = [str_starlevel stringByAppendingFormat:@"starNum"];    
    NSUserDefaults *usrDef = [NSUserDefaults standardUserDefaults];
    NSInteger starNum = [usrDef integerForKey:str_starlevel];    
    
    return starNum;
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
        
        CCSpriteFrameCache* frameCache = [CCSpriteFrameCache sharedSpriteFrameCache];
        [frameCache addSpriteFramesWithFile:@"level_default_default.plist"];
        CGSize screenSize = [[CCDirector sharedDirector] winSize];
        int number=20;
        CCArray * levelarray = [[CCArray alloc]initWithCapacity:number];
        bool isZero=NO;
        for(int i=0;i<20;i++)
        {
            int star=[self getGameStarNumber:i+1];
            if(isZero==YES)
            {
                star=0;
            }
            NSString *starname = [NSString stringWithFormat:@"get%istart.png", star];
            CCSprite *levelpic = [CCSprite spriteWithSpriteFrameName:starname];
            //change size by diff version manual
            levelpic.scaleX=(60)/[levelpic contentSize].width; //按照像素定制图片宽高是控制像素的。
            levelpic.scaleY=(60)/[levelpic contentSize].height;
            CCLabelTTF *Labelnum=[CCLabelTTF labelWithString:[NSString stringWithFormat:@"%i", i+1] fontName:@"Marker Felt" fontSize:50];
            if(i<9)
            {
                Labelnum.anchorPoint=CGPointMake(-1.2, -0.6);
            }
            else
            {
                Labelnum.anchorPoint=CGPointMake(-0.5, -0.6);
            }
            
            [levelpic addChild:Labelnum];
            CCSprite *defaultstar = [CCSprite spriteWithSpriteFrameName:@"get0start.png"];
            //change size by diff version manual
            defaultstar.scaleX=(60)/[defaultstar contentSize].width; //按照像素定制图片宽高是控制像素的。
            defaultstar.scaleY=(60)/[defaultstar contentSize].height;
            CCMenuItemSprite *level = [CCMenuItemSprite itemFromNormalSprite:levelpic 
                                                               selectedSprite:defaultstar 
                                                                       target:self 
                                                                     selector:@selector(selectMode:)];
            [level setTag:i+1];

            if(isZero==YES)
            {
                [level setIsEnabled:NO];
            }
            else
            {
                [level setIsEnabled:YES];
                [Labelnum setColor:ccRED];
            }
            
            if(star==0)
            {
                if(isZero==NO)
                {
                    isZero=YES;
                }
            }
            [levelarray addObject:level];
        }
        
        
//        CCLabelTTF *Label1=[CCLabelTTF labelWithString:@"Level 1" fontName:@"Marker Felt" fontSize:25];
//        [Label1 setColor:ccRED];
//        CCMenuItemLabel * LevelBtn1 = [CCMenuItemLabel itemWithLabel:Label1 target:self selector:@selector(selectMode:)];
//        
//        CCLabelTTF *Label2=[CCLabelTTF labelWithString:@"Level 2" fontName:@"Marker Felt" fontSize:25];
//        [Label2 setColor:ccRED];
//        CCMenuItemLabel * LevelBtn2 = [CCMenuItemLabel itemWithLabel:Label2 target:self selector:@selector(selectMode:)];
//        
//        CCLabelTTF *Label3=[CCLabelTTF labelWithString:@"Level 3" fontName:@"Marker Felt" fontSize:25];
//        [Label3 setColor:ccRED];
//        CCMenuItemLabel * LevelBtn3 = [CCMenuItemLabel itemWithLabel:Label3 target:self selector:@selector(selectMode:)];
//        
//        CCLabelTTF *Label4=[CCLabelTTF labelWithString:@"Level 4" fontName:@"Marker Felt" fontSize:25];
//        [Label4 setColor:ccRED];
//        CCMenuItemLabel * LevelBtn4 = [CCMenuItemLabel itemWithLabel:Label4 target:self selector:@selector(selectMode:)];
//        
//        CCLabelTTF *Label5=[CCLabelTTF labelWithString:@"Level 5" fontName:@"Marker Felt" fontSize:25];
//        [Label5 setColor:ccRED];
//        CCMenuItemLabel * LevelBtn5 = [CCMenuItemLabel itemWithLabel:Label5 target:self selector:@selector(selectMode:)];
//        
//        CCLabelTTF *Label6=[CCLabelTTF labelWithString:@"Level 6" fontName:@"Marker Felt" fontSize:25];
//        [Label6 setColor:ccRED];
//        CCMenuItemLabel * LevelBtn6 = [CCMenuItemLabel itemWithLabel:Label6 target:self selector:@selector(selectMode:)];
//        
//        CCLabelTTF *Label7=[CCLabelTTF labelWithString:@"Level 7" fontName:@"Marker Felt" fontSize:25];
//        [Label7 setColor:ccRED];
//        CCMenuItemLabel * LevelBtn7 = [CCMenuItemLabel itemWithLabel:Label7 target:self selector:@selector(selectMode:)];
//        
//        CCLabelTTF *Label8=[CCLabelTTF labelWithString:@"Level 8" fontName:@"Marker Felt" fontSize:25];
//        [Label8 setColor:ccRED];
//        CCMenuItemLabel * LevelBtn8 = [CCMenuItemLabel itemWithLabel:Label8 target:self selector:@selector(selectMode:)];
//        
//        CCLabelTTF *Label9=[CCLabelTTF labelWithString:@"Level 9" fontName:@"Marker Felt" fontSize:25];
//        [Label9 setColor:ccRED];
//        CCMenuItemLabel * LevelBtn9 = [CCMenuItemLabel itemWithLabel:Label9 target:self selector:@selector(selectMode:)];
//        
//        CCLabelTTF *Label10=[CCLabelTTF labelWithString:@"Level 10" fontName:@"Marker Felt" fontSize:25];
//        [Label10 setColor:ccRED];
//        CCMenuItemLabel * LevelBtn10 = [CCMenuItemLabel itemWithLabel:Label10 target:self selector:@selector(selectMode:)];
//        
//        CCLabelTTF *Label11=[CCLabelTTF labelWithString:@"Level 11" fontName:@"Marker Felt" fontSize:25];
//        [Label11 setColor:ccRED];
//        CCMenuItemLabel * LevelBtn11 = [CCMenuItemLabel itemWithLabel:Label11 target:self selector:@selector(selectMode:)];
//        
//        CCLabelTTF *Label12=[CCLabelTTF labelWithString:@"Level 12" fontName:@"Marker Felt" fontSize:25];
//        [Label12 setColor:ccRED];
//        CCMenuItemLabel * LevelBtn12 = [CCMenuItemLabel itemWithLabel:Label12 target:self selector:@selector(selectMode:)];
//        
//        CCLabelTTF *Label13=[CCLabelTTF labelWithString:@"Level 13" fontName:@"Marker Felt" fontSize:25];
//        [Label13 setColor:ccRED];
//        CCMenuItemLabel * LevelBtn13 = [CCMenuItemLabel itemWithLabel:Label13 target:self selector:@selector(selectMode:)];
//        
//        CCLabelTTF *Label14=[CCLabelTTF labelWithString:@"Level 14" fontName:@"Marker Felt" fontSize:25];
//        [Label14 setColor:ccRED];
//        CCMenuItemLabel * LevelBtn14 = [CCMenuItemLabel itemWithLabel:Label14 target:self selector:@selector(selectMode:)];
//        
//        CCLabelTTF *Label15=[CCLabelTTF labelWithString:@"Level 15" fontName:@"Marker Felt" fontSize:25];
//        [Label15 setColor:ccRED];
//        CCMenuItemLabel * LevelBtn15 = [CCMenuItemLabel itemWithLabel:Label15 target:self selector:@selector(selectMode:)];
//        
//        CCLabelTTF *Label16=[CCLabelTTF labelWithString:@"Level 16" fontName:@"Marker Felt" fontSize:25];
//        [Label16 setColor:ccRED];
//        CCMenuItemLabel * LevelBtn16 = [CCMenuItemLabel itemWithLabel:Label16 target:self selector:@selector(selectMode:)];
//
//        CCLabelTTF *Label17=[CCLabelTTF labelWithString:@"Level 17" fontName:@"Marker Felt" fontSize:25];
//        [Label17 setColor:ccRED];
//        CCMenuItemLabel * LevelBtn17 = [CCMenuItemLabel itemWithLabel:Label17 target:self selector:@selector(selectMode:)];
//        
//        CCLabelTTF *Label18=[CCLabelTTF labelWithString:@"Level 18" fontName:@"Marker Felt" fontSize:25];
//        [Label18 setColor:ccRED];
//        CCMenuItemLabel * LevelBtn18 = [CCMenuItemLabel itemWithLabel:Label18 target:self selector:@selector(selectMode:)];
//        
//        CCLabelTTF *Label19=[CCLabelTTF labelWithString:@"Level 19" fontName:@"Marker Felt" fontSize:25];
//        [Label19 setColor:ccRED];
//        CCMenuItemLabel * LevelBtn19 = [CCMenuItemLabel itemWithLabel:Label19 target:self selector:@selector(selectMode:)];
//        
//        CCLabelTTF *Label20=[CCLabelTTF labelWithString:@"Level 20" fontName:@"Marker Felt" fontSize:25];
//        [Label20 setColor:ccRED];
//        CCMenuItemLabel * LevelBtn20 = [CCMenuItemLabel itemWithLabel:Label20 target:self selector:@selector(selectMode:)];
//        
//        
//        [LevelBtn1 setTag:TargetScene1stScene];
//        [LevelBtn2 setTag:TargetScene2ndScene];
//        [LevelBtn3 setTag:TargetScene3rdScene];
//        [LevelBtn4 setTag:TargetScene4thScene];
//        [LevelBtn5 setTag:TargetScene5thScene];
//        [LevelBtn6 setTag:TargetScene6thScene];
//        [LevelBtn7 setTag:TargetScene7thScene];
//        [LevelBtn8 setTag:TargetScene8thScene];
//        [LevelBtn9 setTag:TargetScene9thScene];
//        [LevelBtn10 setTag:TargetScene10thScene];
//        [LevelBtn11 setTag:TargetScene11thScene];
//        [LevelBtn12 setTag:TargetScene12thScene];
//        [LevelBtn13 setTag:TargetScene13thScene];
//        [LevelBtn14 setTag:TargetScene14thScene];
//        [LevelBtn15 setTag:TargetScene15thScene];
//        [LevelBtn16 setTag:TargetScene16thScene];
//        [LevelBtn17 setTag:TargetScene17thScene];
//        [LevelBtn18 setTag:TargetScene18thScene];
//        [LevelBtn19 setTag:TargetScene19thScene];
//        [LevelBtn20 setTag:TargetScene20thScene];
        
        CCLabelTTF *returnLabel=[CCLabelTTF labelWithString:@"Main Menu" fontName:@"Marker Felt" fontSize:25];
        [returnLabel setColor:ccRED];
        CCMenuItemLabel * returnBtn = [CCMenuItemLabel itemWithLabel:returnLabel target:self selector:@selector(returnMain)];

        CCMenu * easyMenu = [CCMenu menuWithItems:[levelarray objectAtIndex:0],[levelarray objectAtIndex:1],[levelarray objectAtIndex:2],[levelarray objectAtIndex:3],[levelarray objectAtIndex:4],nil];
        [easyMenu alignItemsHorizontallyWithPadding:-15];
        [easyMenu setPosition:ccp((screenSize.width)*0.5f+25,(screenSize.height)*5/6)];
        
        CCMenu * normalMenu = [CCMenu menuWithItems:[levelarray objectAtIndex:5],[levelarray objectAtIndex:6],[levelarray objectAtIndex:7],[levelarray objectAtIndex:8],[levelarray objectAtIndex:9], nil];
        [normalMenu alignItemsHorizontallyWithPadding:-15];
        [normalMenu setPosition:ccp((screenSize.width)*0.5f+25,(screenSize.height)*1/2)];
        
        CCMenu * hardMenu = [CCMenu menuWithItems:[levelarray objectAtIndex:10],[levelarray objectAtIndex:11],[levelarray objectAtIndex:12],[levelarray objectAtIndex:13],[levelarray objectAtIndex:14], nil];
        [hardMenu alignItemsHorizontallyWithPadding:-15];
        [hardMenu setPosition:ccp((screenSize.width)*0.5f+25,(screenSize.height)*5/6)];
        
        CCMenu * extremeMenu = [CCMenu menuWithItems:[levelarray objectAtIndex:15],[levelarray objectAtIndex:16],[levelarray objectAtIndex:17],[levelarray objectAtIndex:18],[levelarray objectAtIndex:19], nil];
        [extremeMenu alignItemsHorizontallyWithPadding:-15];
        [extremeMenu setPosition:ccp((screenSize.width)*0.5f+25,(screenSize.height)*1/2)];
        
        
        CCMenu * returnMenu = [CCMenu menuWithItems:returnBtn, nil];
        [returnMenu alignItemsHorizontallyWithPadding:0];
        [returnMenu setPosition:ccp((screenSize.width)*0.5f,(screenSize.height)*1/7)];
        [self addChild:returnMenu];
        
        //test
        CCLayer *pageOne = [[CCLayer alloc] init];
        [pageOne addChild:easyMenu];
        [pageOne addChild:normalMenu];
        
        // create a blank layer for page 2
        CCLayer *pageTwo = [[CCLayer alloc] init];
        [pageTwo addChild:hardMenu];
        [pageTwo addChild:extremeMenu];
        
        // now create the scroller and pass-in the pages (set widthOffset to 0 for fullscreen pages)
        CCScrollLayer *scroller = [[CCScrollLayer alloc] initWithLayers:[NSMutableArray arrayWithObjects: pageOne,pageTwo,nil] widthOffset: 0];
        
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
