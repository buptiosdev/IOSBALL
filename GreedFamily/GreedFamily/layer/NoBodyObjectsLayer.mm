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

-(void)initNomal
{
    int familyType = [[GameMainScene sharedMainScene] roleType];
    LandAnimal *landAnimal = [LandAnimal CreateLandAnimal:familyType Play:1];
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

-(void)initPair
{
    LandAnimal *landAnimal = [LandAnimal CreateLandAnimal:1 Play:1];
    [self addChild:landAnimal z:1 tag:LandAnimalTag];
    
    LandAnimal *landAnimalPlay2 = [LandAnimal CreateLandAnimal:2 Play:2];
    [self addChild:landAnimalPlay2 z:1 tag:LandAnimalPlay2Tag];
    
    LandCandyCache * landcandyCache = [LandCandyCache initLandCache];
    [self addChild:landcandyCache z:1 tag:LandCandyTag];
}

-(id)init
{
    if ((self = [super init]))
    {
        instanceOfNoBodyObjectsLayer = self;
        
        if (NO == [GameMainScene sharedMainScene].isPairPlay) 
        {
            [self initNomal];
        }
        else
        {
            [self initPair];
        }
        
    }
    
    return self;
}

-(LandCandyCache*) getLandCandyCache
{
	CCNode* node = [self getChildByTag:LandCandyTag];
	NSAssert([node isKindOfClass:[LandCandyCache class]], @"node is not a LandCandyCache!");
	return (LandCandyCache *)node;
}

-(LandAnimal *) getLandAnimalPlay2
{
	CCNode* node = [self getChildByTag:LandAnimalPlay2Tag];
	NSAssert([node isKindOfClass:[LandAnimal class]], @"node is not a LandAnimal!");
	return (LandAnimal *)node;
}

-(LandAnimal *) getLandAnimal
{
	CCNode* node = [self getChildByTag:LandAnimalTag];
	NSAssert([node isKindOfClass:[LandAnimal class]], @"node is not a LandAnimal!");
	return (LandAnimal *)node;
}

-(void) dealloc
{
	[super dealloc];
    
}
/*creare on the ground candy list*/

@end
