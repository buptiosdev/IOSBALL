//
//  Pause.m
//  GreedFamily
//
//  Created by 赵 苹果 on 12-4-20.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import "GamePause.h"
#import "GameBackgroundLayer.h"
#import "Helper.h"

@implementation GamePause

@synthesize spritein = _spritein;
@synthesize spriteout = _spriteout;

-(void) registerWithTouchDispatcher
{
    [[CCTouchDispatcher sharedDispatcher] addTargetedDelegate:self priority:-3 swallowsTouches:YES];
}

-(id)init
{
    if ((self = [super init]))
    {
        [self registerWithTouchDispatcher];
        
        CCSpriteBatchNode* batch = [[GameBackgroundLayer sharedGameBackgroundLayer] getSpriteBatch];
        _spritein = [CCSprite spriteWithSpriteFrameName:@"pausein.png"];
        CGSize screenSize = [[CCDirector sharedDirector] winSize];
        _spritein.position = CGPointMake(450, screenSize.height - 10);
        //_spritein.position = CGPointMake(screenSize.width * 0.5, screenSize.height * 0.5);
        _spritein.visible = NO;
        [batch addChild:_spritein z:2];
        
        _spriteout = [CCSprite spriteWithSpriteFrameName:@"pauseout.png"];
        _spriteout.position = CGPointMake(450, screenSize.height - 10);
        //_spritein.position = CGPointMake(screenSize.width / 2, screenSize.height / 2);
        _spriteout.visible = YES;
        [batch addChild:_spriteout z:1];
        
        
    }
    
    return self;
}

-(bool) isTouchForMe:(CGPoint)touchLocation
{
    
    return CGRectContainsPoint([_spritein boundingBox], touchLocation);
}


-(BOOL) ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event
{
    CGPoint location = [Helper locationFromTouch:touch];
    bool isTouchHandled = [self isTouchForMe:location]; 
    if (isTouchHandled)
    {
        _spritein.visible = YES;
    }
    return isTouchHandled;
}

-(void) ccTouchMoved:(UITouch *)touch withEvent:(UIEvent *)event
{
    _spritein.visible = YES;    
    
}

-(void) ccTouchEnded:(UITouch *)touch withEvent:(UIEvent *)event
{
    _spritein.visible = NO;
}

-(void) dealloc
{
    [[CCTouchDispatcher sharedDispatcher] removeDelegate:self];
	[super dealloc];
}


@end
