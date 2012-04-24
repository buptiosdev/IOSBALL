//
//  PauseLayer.m
//  AerialGun
//
//  Created by Pablo Ruiz on 6/7/10.
//  Copyright 2010 Infinix Software. All rights reserved.
//

#import "PauseLayer.h"
#import "GameMainScene.h"

@implementation PauseLayer

+(id)createPauseLayer:(ccColor4B)color
{
    return [[[PauseLayer alloc] initWithColor1:color] autorelease];
}

- (id) initWithColor1:(ccColor4B)color{
    if ((self = [super initWithColor:color])) {
		
		self.isTouchEnabled=YES;
		
		CCSprite * paused = [CCSprite spriteWithFile:@"paused.png"];
		[paused setPosition:ccp(240,160)];
		[self addChild:paused];
		
    }
    return self;
}



- (void)ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
	for( UITouch *touch in touches ) {
		CGPoint location = [touch locationInView: [touch view]];
		
		location = [[CCDirector sharedDirector] convertToGL: location];
		
//		GameLayer * gl = (GameLayer *)[self.parent getChildByTag:KGameLayer];
//		[gl resume];
        [[GameMainScene sharedMainScene]resume];
		[self.parent removeChild:self cleanup:YES];
	}
}

- (void) dealloc
{
	[super dealloc];
}

@end