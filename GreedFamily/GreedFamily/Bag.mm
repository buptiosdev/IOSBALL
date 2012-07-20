//
//  Bag.m
//  GreedFamily
//
//  Created by 赵 苹果 on 12-4-20.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import "Bag.h"
#import "GameBackgroundLayer.h"
#import "Helper.h"
#import "BodyObjectsLayer.h"
#import "PropertyCache.h"
#import "LandAnimal.h"
//#import "Storage.h"
#import "TouchCatchLayer.h"

@implementation Bag
@synthesize sprite = _sprite;
//-(void) registerWithTouchDispatcher
//{
//    [[CCTouchDispatcher sharedDispatcher] addTargetedDelegate:self priority:-1 swallowsTouches:YES];
//}


//- (void)onStart:(id)sender{
//    PropertyCache *thePropCache = [[BodyObjectsLayer sharedBodyObjectsLayer] getPropertyCache];
//    b2World *theworld = [BodyObjectsLayer sharedBodyObjectsLayer].world;
//    [thePropCache addOneProperty:1 World:theworld Tag:1];
//}
//- (void)onBomb:(id)sender{
//    PropertyCache *thePropCache = [[BodyObjectsLayer sharedBodyObjectsLayer] getPropertyCache];
//    b2World *theworld = [BodyObjectsLayer sharedBodyObjectsLayer].world;
//    [thePropCache addOneProperty:2 World:theworld Tag:2];
//}
//
//- (void)onCrystal:(id)sender{
//    PropertyCache *thePropCache = [[BodyObjectsLayer sharedBodyObjectsLayer] getPropertyCache];
//    b2World *theworld = [BodyObjectsLayer sharedBodyObjectsLayer].world;
//    [thePropCache addOneProperty:0 World:theworld Tag:0];
//}
-(void)onPepper:(id)sender
{
    if (0 >= pepperNum) 
    {
        return;
    }
    CCLOG(@"hot!!!!!!!!\n");
    [[LandAnimal sharedLandAnimal] increaseSpeed];
    pepperNum--;
    [pepperLabel setString:[NSString stringWithFormat:@"x%i", pepperNum]];
}

-(void)onCrystal:(id)sender
{
    if (0 >= crystalNum)
    {
        return;
    }
    Storage *storage = [[TouchCatchLayer sharedTouchCatchLayer] getStorage];

    //[storage combinTheSameType];
    [storage combinTheSameTypeNew]; 
    crystalNum--;
    [crystalLabel setString:[NSString stringWithFormat:@"x%i", crystalNum]];
}
-(id)init
{
    if ((self = [super init]))
    {
        //[self registerWithTouchDispatcher];
        
//        CCSpriteBatchNode* batch = [[GameBackgroundLayer sharedGameBackgroundLayer] getSpriteBatch];
//        _sprite = [CCSprite spriteWithSpriteFrameName:@"bag_background.png"];
//        CGSize screenSize = [[CCDirector sharedDirector] winSize];
//        _sprite.position = CGPointMake(464, screenSize.height / 2);
//        [batch addChild:_sprite z:-3];
        CGSize screenSize = [[CCDirector sharedDirector] winSize];
        pepperNum = 0;
        crystalNum = 0;
        
//        CCSprite *startNormal = [CCSprite spriteWithSpriteFrameName:@"start2.png"];
//        CCSprite *startSelected = [CCSprite spriteWithSpriteFrameName:@"start.png"];
//        CCMenuItemSprite *starts = [CCMenuItemSprite itemFromNormalSprite:startNormal 
//                                                           selectedSprite:startSelected 
//                                                                   target:self 
//                                                                 selector:@selector(onStart:)];
//        
//        CCSprite *bombNormal = [CCSprite spriteWithSpriteFrameName:@"bomb1.png"];
//        CCSprite *bombSelected = [CCSprite spriteWithSpriteFrameName:@"bomb2.png"];
//        CCMenuItemSprite *bombs = [CCMenuItemSprite itemFromNormalSprite:bombNormal 
//                                                           selectedSprite:bombSelected 
//                                                                   target:self 
//                                                                 selector:@selector(onBomb:)];
        
        CCSprite *fruitNormal = [CCSprite spriteWithSpriteFrameName:@"moon.png"];
        CCSprite *fruitSelected = [CCSprite spriteWithSpriteFrameName:@"apple.png"];
        CCMenuItemSprite *fruits = [CCMenuItemSprite itemFromNormalSprite:fruitNormal 
                                                          selectedSprite:fruitSelected 
                                                                  target:self 
                                                                selector:@selector(onPepper:)];
        
        CCSprite *crystalNormal = [CCSprite spriteWithSpriteFrameName:@"crystal.png"];
        CCSprite *crystalSelected = [CCSprite spriteWithSpriteFrameName:@"ball.png"];
        CCMenuItemSprite *crystals = [CCMenuItemSprite itemFromNormalSprite:crystalNormal 
                                                          selectedSprite:crystalSelected 
                                                                  target:self 
                                                                selector:@selector(onCrystal:)];
        

        //CCMenu *menu = [CCMenu menuWithItems:starts, bombs, fruits, crystals, nil];
        CCMenu *menu = [CCMenu menuWithItems:fruits, crystals, nil];
        [menu setPosition:ccp(screenSize.width * 3 / 4 + 20, 15)];
        [menu alignItemsHorizontallyWithPadding:30];
        [self addChild:menu z: -2];
        
        
        pepperLabel = [CCLabelBMFont bitmapFontAtlasWithString:@"0" fntFile:@"bitmapfont.fnt"];
        pepperLabel.position = CGPointMake(360, 15);
        pepperLabel.anchorPoint = CGPointMake(0.5f, 1.0f);
        pepperLabel.scale = 0.2;
        [self addChild:pepperLabel z:-1];
        
        
        crystalLabel = [CCLabelBMFont bitmapFontAtlasWithString:@"0" fntFile:@"bitmapfont.fnt"];
        crystalLabel.position = CGPointMake(420, 13);
        crystalLabel.anchorPoint = CGPointMake(0.5f, 1.0f);
        crystalLabel.scale = 0.2;
        [self addChild:crystalLabel z:-1];
        
        
//        timeTmp.type=kCCProgressTimerTypeRadialCW;//进度条的显示样式  
//        timeTmp.percentage = 0; //当前进度       
//        timeTmp.position = ccp(200, 200);         
//        
//        
//        timeTmp = [CCProgressTimer progressWithFile:@"cd.png"];
//
//        [self addChild:timeTmp];
//
//
//        int mPercentage = 100;  
//        [timeTmp setPercentage:mPercentage];
//        [timeTmp setPercentage:(100-mPercentage++)]; 
    
    }
    
    return self;
}

-(void)addPepper
{
    pepperNum++;
    [pepperLabel setString:[NSString stringWithFormat:@"x%i", pepperNum]];
}

-(void)addCrystal
{
    crystalNum++;
    [crystalLabel setString:[NSString stringWithFormat:@"x%i", crystalNum]];
}


-(void)update:(ccTime)delta
{
    timeTmp.percentage++;  
    if(timeTmp.percentage>=100)
    {  
        timeTmp.percentage=0;  
    } 
}

//
//-(bool) isTouchForMe:(CGPoint)touchLocation
//{
//    
//    return CGRectContainsPoint([self.sprite boundingBox], touchLocation);
//}
//
//
//-(BOOL) ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event
//{
//    CGPoint location = [Helper locationFromTouch:touch];
//    bool isTouchHandled = [self isTouchForMe:location]; 
//    if (isTouchHandled)
//    {
//        _sprite.color = ccRED;
////        static int i = 0;
////        i += CCRANDOM_0_1()*10;
////        int tag = i % 3;
////        PropertyCache *thePropCache = [[BodyObjectsLayer sharedBodyObjectsLayer] getPropertyCache];
////        b2World *theworld = [BodyObjectsLayer sharedBodyObjectsLayer].world;
////        [thePropCache addOneProperty:tag World:theworld Tag:tag];
//    }
//    return isTouchHandled;
//}
//
//-(void) ccTouchMoved:(UITouch *)touch withEvent:(UIEvent *)event
//{
//	_sprite.color = ccYELLOW;
//    
//    
//}
//
//-(void) ccTouchEnded:(UITouch *)touch withEvent:(UIEvent *)event
//{
//	_sprite.color = ccWHITE;
//}
//
//
//#pragma mark Layer - Callbacks
//-(void) onEnter
//{
//    [self registerWithTouchDispatcher];
//	// then iterate over all the children
//	[super onEnter];
//}
//
//// issue #624.
//// Can't register mouse, touches here because of #issue #1018, and #1021
//-(void) onEnterTransitionDidFinish
//{	
//	[super onEnterTransitionDidFinish];
//}
//
//-(void) onExit
//{
//    
//    [[CCTouchDispatcher sharedDispatcher] removeDelegate:self];
//	
//	[super onExit];
//}

-(void) dealloc
{
    //[[CCTouchDispatcher sharedDispatcher] removeDelegate:self];
	[super dealloc];
}


@end
