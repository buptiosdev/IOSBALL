//
//  NoBodyObjectsLayer.m
//  GreedFamily
//
//  Created by 赵 苹果 on 12-4-19.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import "NoBodyObjectsLayer.h"
#import "LandAnimal.h"
#import "Competitor.h"

@implementation NoBodyObjectsLayer
+(id)CreateNoBodyObjectsLayer
{
	return [[[self alloc] init] autorelease];
}

-(id)init
{
    if ((self = [super init]))
    {
        LandAnimal *landAnimal = [LandAnimal CreateLandAnimal];
        [self addChild:landAnimal z:1 tag:LandAnimalTag];
        
        Competitor *competitor = [Competitor CreateCompetitor];
        [self addChild:competitor z:1 tag:CompetitorTag];
    }
    return self;
}

-(void) dealloc
{
	[super dealloc];
    
}
/*creare on the ground candy list*/

@end
