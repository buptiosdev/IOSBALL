//
//  CCAnimationHelper.m
//  SpriteBatches
//
//  Created by Steffen Itterheim on 06.08.10.
//  Copyright 2010 Steffen Itterheim. All rights reserved.
//

#import "CCAnimationHelper.h"

@implementation CCAnimation (Helper)

// Creates an animation from single files.
+(CCAnimation*) animationWithFile:(NSString*)name frameCount:(int)frameCount 
                            delay:(float)delay
{
	// load the animation frames as textures and create the sprite frames
	NSMutableArray* frames = [NSMutableArray arrayWithCapacity:frameCount];
	for (int i = 0; i < frameCount; i++)
	{
		// Assuming all animation files are named "nameX.png" with X being a consecutive number starting with 0.
		NSString* file = [NSString stringWithFormat:@"%@%i.png", name, i];
		CCTexture2D* texture = [[CCTextureCache sharedTextureCache] addImage:file];

		// Assuming that image file animations always use the whole image for each animation frame.
		CGSize texSize = [texture contentSize];
		CGRect texRect = CGRectMake(0, 0, texSize.width, texSize.height);
		//CCSpriteFrame *frame = [CCSpriteFrame frameWithTexture:texture rect:texRect offset:CGPointZero];
        CCSpriteFrame *frame = [CCSpriteFrame frameWithTexture:texture rect:texRect];
		
		[frames addObject:frame];
	}
	
	// create an animation object from all the sprite animation frames
	return [CCAnimation animationWithName:name delay:delay 
                                   frames:frames];
}

// Creates an animation from sprite frames.
+(CCAnimation*) animationWithFrame:(NSString*)frame frameCount:(int)frameCount 
                             delay:(float)delay
{
	// load the ship's animation frames as textures and create a sprite frame
	NSMutableArray* frames = [NSMutableArray arrayWithCapacity:frameCount];
	for (int i = 0; i < frameCount; i++)
	{
		NSString* file = [NSString stringWithFormat:@"%@%i.png", frame, i];
		CCSpriteFrameCache* frameCache = [CCSpriteFrameCache sharedSpriteFrameCache];
		CCSpriteFrame* frame = [frameCache spriteFrameByName:file];
		[frames addObject:frame];
	}
	
	// return an animation object from all the sprite animation frames
	return [CCAnimation animationWithName:frame delay:delay frames:frames];
}

@end
