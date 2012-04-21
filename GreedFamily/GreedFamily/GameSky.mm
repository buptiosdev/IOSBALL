//
//  Sky.m
//  GreedFamily
//
//  Created by 赵 苹果 on 12-4-20.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import "GameSky.h"
#import "FlyEntity.h"
#import "BodyObjectsLayer.h"

@implementation GameSky

-(void) registerWithTouchDispatcher
{
    [[CCTouchDispatcher sharedDispatcher] addTargetedDelegate:self priority:0 swallowsTouches:YES];
}

-(id)init
{
    if ((self = [super init]))
    {
        [self registerWithTouchDispatcher];
        flyEntity = [[BodyObjectsLayer sharedBodyObjectsLayer] flyAnimal];
    }
    return self;
}


-(BOOL) ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event
{
    return [flyEntity ccTouchBeganForSky:touch withEvent:event];
}

-(void) ccTouchMoved:(UITouch *)touch withEvent:(UIEvent *)event
{
	[flyEntity ccTouchMovedForSky:touch withEvent:event];
     
}

-(void) ccTouchEnded:(UITouch *)touch withEvent:(UIEvent *)event
{
	[flyEntity ccTouchEndedForSky:touch withEvent:event];
}

-(void) dealloc
{
	[[CCTouchDispatcher sharedDispatcher] removeDelegate:self];
	[super dealloc];
}
@end
