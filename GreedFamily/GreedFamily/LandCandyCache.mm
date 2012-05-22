//
//  LandCandyCache.m
//  GreedFamily
//
//  Created by MagicStudio on 12-5-19.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import "LandCandyCache.h"
#import "LandCandyEntity.h"


@implementation LandCandyCache

+(id)initLandCache
{
	return [[[self alloc] init] autorelease];
}

/*创造一个半单例，让其他类可以很方便访问scene*/
static LandCandyCache *instanceOfLandCandyCache;
+(LandCandyCache *)sharedLandCandyCache
{
    NSAssert(nil != instanceOfLandCandyCache, @"BodyObjectsLayer instance not yet initialized!");
    
    return instanceOfLandCandyCache;
}

-(id) CreateLandCandy:(int)balltype Pos:(CGPoint)position
{
    int num = [landcandies count];
    if(num>0){
        for(int i=0;i<num;i++)
        {
            LandCandyEntity * landcandy=[landcandies objectAtIndex:i];
            CCSprite * candy=landcandy.sprite;
            if(candy.visible==NO && landcandy.Balltype==balltype)
            {
                candy.visible=YES;
                candy.position=position;
                landcandy.position=position;
                return landcandy;
            }
        }
    }
    LandCandyEntity * candyEntity = [LandCandyEntity CreateLandCandyEntity:balltype Pos:position];
    [self addChild:candyEntity z:0 tag:2];
    [landcandies addObject:candyEntity];
    return candyEntity;
}

-(int)CheckforCandyCollision:(CCSprite *)landanimal
{
    float landanimalsize=[landanimal texture].contentSize.width;
    //float spidersize=[[spiders lastObject] texture].contentSize.width;
    //float collisiondistance=playersize*0.5f+spidersize*0.4f;
    int num=[landcandies count];
    int direction = 0;
    float distance=1000;
    for(int i=0;i<num;i++)
    {
        LandCandyEntity * landcandy=[landcandies objectAtIndex:i];
        CCSprite * candy=landcandy.sprite;
        if(candy.visible==NO)
        {
            continue;
        }
        
        float candysize=[candy texture].contentSize.width;
        float actualdistance=ccpDistance(landanimal.position, candy.position);
        float collisiondistance=landanimalsize*0.5f+candysize*0.4f;
        if(actualdistance<=collisiondistance)
        {
            //set the candy unvisible
            candy.visible=NO;
            //call the storage interface
            
        }else{
            if(actualdistance<distance){
                distance=actualdistance;
                if(landanimal.position.x-candy.position.x>0){
                    direction=-1;
                }else{
                    direction=1;
                }
            }
        }

    }
    return direction;
}

-(id)init
{
    if ((self = [super init]))
	{
        instanceOfLandCandyCache = self;
        CGSize screenSize = [[CCDirector sharedDirector] winSize];
        int numbers=10;
        landcandies=[[CCArray alloc]initWithCapacity:numbers];
        
        //[self scheduleUpdate];
    }
    return self;
}

-(void)update:(ccTime)delta
{
}

-(void) dealloc
{
	[landcandies release];
	[super dealloc];
}
@end
