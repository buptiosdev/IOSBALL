//
//  LandAnimalSprite.m
//  GreedFamily
//
//  Created by 赵 苹果 on 12-4-19.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import "LandAnimal.h"


@implementation LandAnimal
@synthesize sprite = _sprite;
+(id)CreateLandAnimal
{
	return [[[self alloc] init] autorelease];
}

@end
