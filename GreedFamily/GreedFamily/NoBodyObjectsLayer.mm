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
#import "LandCandyCache.h"
#import "GameMainScene.h"

@implementation NoBodyObjectsLayer

/*创造一个半单例，让其他类可以很方便访问scene*/
static NoBodyObjectsLayer *instanceOfNoBodyObjectsLayer;
+(NoBodyObjectsLayer *)sharedNoBodyObjectsLayer
{
    NSAssert(nil != instanceOfNoBodyObjectsLayer, @"BodyObjectsLayer instance not yet initialized!");
    
    return instanceOfNoBodyObjectsLayer;
}
+(id)CreateNoBodyObjectsLayer
{
	return [[[self alloc] init] autorelease];
}

-(id)init
{
    if ((self = [super init]))
    {
        instanceOfNoBodyObjectsLayer = self;
        
        LandAnimal *landAnimal = [LandAnimal CreateLandAnimal];
        [self addChild:landAnimal z:1 tag:LandAnimalTag];
        
        BOOL isCreate = [GameMainScene sharedMainScene].mainscenParam.landCompetitorExist;
        
        if (isCreate)
        {
            Competitor *competitor = [Competitor CreateCompetitor];
            [self addChild:competitor z:1 tag:CompetitorTag];
        }
        
        LandCandyCache * landcandyCache = [LandCandyCache initLandCache];
        [self addChild:landcandyCache z:1 tag:LandCandyTag];
    }
    return self;
}

-(LandCandyCache*) getLandCandyCache
{
	CCNode* node = [self getChildByTag:LandCandyTag];
	NSAssert([node isKindOfClass:[LandCandyCache class]], @"node is not a LandCandyCache!");
	return (LandCandyCache *)node;
}


-(void) dealloc
{
	[super dealloc];
    
}
/*creare on the ground candy list*/

@end
