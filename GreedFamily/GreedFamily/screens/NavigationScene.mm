//
//  NavigationScene.m
//  Box2d_test
//
//  Created by 赵 苹果 on 12-3-25.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//
#import "NavigationScene.h"
#import "LevelScene.h"

@interface Navigation
-(void)newGame:(id)sender;
-(void)options:(id)sender;
-(void)about:(id)sender;
@end


@implementation NavigationScene



-(id)initWithNavigationScene
{
//delete by lyp 20120412
//    if (self = [super init])
//    {
//        self.isTouchEnabled = YES;
//        
//        [[CCTouchDispatcher sharedDispatcher] addTargetedDelegate:self priority:0 swallowsTouches:NO];
//        
//       //CGRect labelRect1 = CGRectMake(20, 20, 50, 30);
//            
//        label1 = [CCLabelTTF labelWithString:@"关卡：1" fontName:@"Marker Felt" fontSize:64];
//        CGSize size = [[CCDirector sharedDirector] winSize]; 
//        label1.position = CGPointMake(size.width / 2, size.height - 30);
//        //[label1 drawTextInRect:labelRect1];
//        [self addChild:label1];
//        
//        //###########################################
//        label2 = [CCLabelTTF labelWithString:@"关卡：2" fontName:@"Marker Felt" fontSize:64];
//        label2.position = CGPointMake(size.width / 2, size.height / 2);
//        [self addChild:label2];
//        
//        label3 = [CCLabelTTF labelWithString:@"关卡：3" fontName:@"Marker Felt" fontSize:64];
//        label3.position = CGPointMake(size.width / 2, 30);
//        [self addChild:label3];
//        
//               
//        sleep(2);
//        
//        [self scheduleUpdate];
//    }
    
//
    if ((self = [super init])) {
		
		self.isTouchEnabled = YES;
		
        CGSize size = [[CCDirector sharedDirector] winSize];
		/*CCSprite * background = [CCSprite spriteWithFile:@"menubackground.png"];
        NSAssert( background != nil, @"background must be non-nil");
        
        
		[background setPosition:ccp(size.width / 2, size.height/2)];
		[self addChild:background];*/
		
		//CCBitmapFontAtlas * newgameLabel = [CCBitmapFontAtlas bitmapFontAtlasWithString:@"NEW GAME" fntFile:@"hud_font.fnt"];
        CCLabelTTF *newgameLabel=[CCLabelTTF labelWithString:@"NEW GAME" fontName:@"Marker Felt" fontSize:30];
        CCLabelTTF *optionsLabel=[CCLabelTTF labelWithString:@"OPTIONS" fontName:@"Marker Felt" fontSize:30];
        CCLabelTTF *aboutLabel=[CCLabelTTF labelWithString:@"ABOUT" fontName:@"Marker Felt" fontSize:30];
		
		[newgameLabel setColor:ccRED];
		[optionsLabel setColor:ccRED];
		[aboutLabel setColor:ccRED];
		
		CCMenuItemLabel * newgame = [CCMenuItemLabel itemWithLabel:newgameLabel target:self selector:@selector(newGame:)];
		CCMenuItemLabel * options = [CCMenuItemLabel itemWithLabel:optionsLabel target:self selector:@selector(options:)];
		CCMenuItemLabel * about = [CCMenuItemLabel itemWithLabel:aboutLabel target:self selector:@selector(about:)];
		
		CCMenu * menu = [CCMenu menuWithItems:newgame,options,about,nil];
		[menu alignItemsVerticallyWithPadding:10];
		[self addChild:menu];
		[menu setPosition:ccp(size.width,size.height/3)];
		
		[newgame runAction:[CCSequence actions:
							[CCEaseOut actionWithAction:[CCMoveBy actionWithDuration:1 position:ccp(-size.width/2,0)]  rate:2],
							[CCRepeat actionWithAction:[CCSequence actions:[CCScaleTo actionWithDuration:1 scale:1.3],[CCScaleTo actionWithDuration:1 scale:1],nil] times:9000],
							nil]];
		[options runAction:[CCSequence actions:
							[CCDelayTime actionWithDuration:0.5],[CCEaseOut actionWithAction:[CCMoveBy actionWithDuration:1 position:ccp(-size.width/2,0)]  rate:2],
							[CCRepeat actionWithAction:[CCSequence actions:[CCScaleTo actionWithDuration:1 scale:1.3],[CCScaleTo actionWithDuration:1 scale:1],nil] times:9000],
							nil]];
		[about runAction:[CCSequence actions:
                          [CCDelayTime actionWithDuration:1],[CCEaseOut actionWithAction:[CCMoveBy actionWithDuration:1 position:ccp(-size.width/2,0)]  rate:2],
                          [CCRepeat actionWithAction:[CCSequence actions:[CCScaleTo actionWithDuration:1 scale:1.3],[CCScaleTo actionWithDuration:1 scale:1],nil] times:9000],
                          nil]];
		
    }    
    
    return self;
}

-(void)newGame:(id)sender
{
	//start a new game
    //[self showDifficultySelection];
	[[CCDirector sharedDirector] replaceScene:[LevelScene scene]];
}

-(void)options:(id)sender
{
	//show the options of the game
    //OptionsScene * gs = [OptionsScene node];
	//[[CCDirector sharedDirector]replaceScene:gs];
}

-(void)about:(id)sender
{
	//about the game 
}


+(id)scene
{
    //order = order;
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	NavigationScene *navigationScene = [NavigationScene sceneWithNavigationScene];
	
	// add layer as a child to scene
	[scene addChild: navigationScene];

	return scene;

}

+(id)sceneWithNavigationScene
{
    return [[[self alloc] initWithNavigationScene] autorelease];
}
/*
-(CGPoint) locationFromTouch:(UITouch*)touch
{
	CGPoint touchLocation = [touch locationInView: [touch view]];
	return [[CCDirector sharedDirector] convertToGL:touchLocation];
}

-(BOOL) ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event
{
	fingerLocation = [self locationFromTouch:touch];
    isTouch = YES;
	return YES;
    
}

-(void) ccTouchEnded:(UITouch *)touch withEvent:(UIEvent *)event
{
    //isTouch = NO;
}

-(void)update:(ccTime)delta
{
    if (isTouch)
    {
        //CGSize size = [[CCDirector sharedDirector] winSize]; 
    
        //CGRect rect1 =  CGRectMake(size.width / 2, size.height - 30.0f, 100.0f, 100.0f);
        //CGRect rect2 =  CGRectMake(size.width / 2, size.height / 2, 100.0f, 100.0f); 
        //CGRect rect3 =  CGRectMake(size.width / 2, 30.0f, 100.0f, 100.0f); 
        if (CGRectContainsPoint([label1 boundingBox], fingerLocation))
        {
        
            CCLOG(@"11111111%@\n", label1.textureRect);
            label1.color = ccWHITE;
            //CCTransitionShrinkGrow* transition = [CCTransitionShrinkGrow transitionWithDuration:3 scene:[MainScene scene:1]];
        
            //[[CCDirector sharedDirector] replaceScene:transition];
        
            [[CCDirector sharedDirector] replaceScene:[LoadingScene sceneWithTargetScene:TargetSceneFstScene]];

            //[[CCDirector sharedDirector] replaceScene:[MainScene scene:1]];
        }
        else if (CGRectContainsPoint([label2 boundingBox], fingerLocation))
        {
            CCLOG(@"22222222\n");
            label2.color = ccWHITE;
            [[CCDirector sharedDirector] replaceScene:[LoadingScene sceneWithTargetScene:TargetSceneScdScene]];
        }
        else if (CGRectContainsPoint([label3 boundingBox], fingerLocation))
        {
            CCLOG(@"333333\n");
            label3.color = ccWHITE;
        
            //[[CCDirector sharedDirector] replaceScene:[LoadingScene sceneWithTargetScene:TargetSceneThrdScene]];
                
            //CCTransitionSlideInB* transition = [CCTransitionSlideInB transitionWithDuration:3 
                                            //scene:[LoadingScene sceneWithTargetScene://TargetSceneThrdScene]];
            //[[CCDirector sharedDirector] replaceScene:transition];
            
            [[CCDirector sharedDirector] replaceScene:[LoadingScene sceneWithTargetScene:TargetSceneThrdScene]];            
            
        }
        isTouch = NO;
        self.isTouchEnabled = NO;
    }
    
}
*/
@end
