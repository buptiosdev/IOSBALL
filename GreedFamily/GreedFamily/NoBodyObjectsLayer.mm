//
//  NoBodyObjectsLayer.m
//  GreedFamily
//
//  Created by 赵 苹果 on 12-4-19.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import "NoBodyObjectsLayer.h"
#import "LandAnimalSprite.h"
#import "CompetitorSprite.h"

@implementation NoBodyObjectsLayer
+(id)CreateNoBodyObjectsLayer
{
	return [[[self alloc] init] autorelease];
}

-(id)init
{
    LandAnimalSprite *landAnimalSprite = [LandAnimalSprite CreateLandAnimalSprite];
    [self addChild:landAnimalSprite z:1 tag:LandAnimalSpriteTag];
    
    CompetitorSprite *competitorSprite = [CompetitorSprite CreateCompetitorSprite];
    [self addChild:competitorSprite z:1 tag:CompetitorSpriteTag];
    
    return self;
}

/*creare on the ground candy list*/

@end
