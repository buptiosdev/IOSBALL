//
//  LandCandyCache.m
//  GreedFamily
//
//  Created by MagicStudio on 12-5-19.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import "LandCandyCache.h"
#import "LandCandyEntity.h"
#import "TouchCatchLayer.h"
#import "Storage.h"

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

//-(id) CreateLandCandy:(int)balltype Pos:(CGPoint)position BodyVelocity:(CGPoint)bodyVelocity
//{
//    int num = [landcandies count];
//    if(num>0){
//        for(int i=0;i<num;i++)
//        {
//            LandCandyEntity * landcandy=[landcandies objectAtIndex:i];
//            CCSprite * candy=landcandy.sprite;
//            if(candy.visible==NO && landcandy.ballType==balltype)
//            {
//                candy.visible=YES;
//                candy.position=position;
//                landcandy.position=position;
//                return landcandy;
//            }
//        }
//    }
//    LandCandyEntity * candyEntity = [LandCandyEntity CreateLandCandyEntity:balltype Pos:position BodyVelocity:bodyVelocity];
//    [self addChild:candyEntity z:-2 tag:2];
//    [landcandies insertObject:candyEntity atIndex:num];
//    //[landcandies addObject:candyEntity];
//    return candyEntity;
//}

-(void) CreateLandCandy:(int)balltype Pos:(CGPoint)position BodyVelocity:(CGPoint)bodyVelocity
{
    int num = [controlCandies count];
    if(num>0)
    {
        for(int i = 0;i < num;i++)
        {
            LandCandyEntity * landcandy = [controlCandies objectAtIndex:i];

            if(landcandy.sprite.visible == NO 
               && landcandy.ballType == balltype)
            {
                landcandy.sprite.visible = YES;
                landcandy.sprite.position = position;
                landcandy.isDowning = YES;
                return;
                //return landcandy;
            }
        }
    }
    LandCandyEntity * candyEntity = [LandCandyEntity CreateLandCandyEntity:balltype Pos:position BodyVelocity:bodyVelocity];
    [self addChild:candyEntity z:2 tag:2];
    [controlCandies insertObject:candyEntity atIndex:num];
    return;
    //[landcandies addObject:candyEntity];
    //return candyEntity;
}

-(void)addToLandCandies:(LandCandyEntity *)landCandy
{
    [landcandies insertObject:landCandy atIndex:landnum];
    landnum++;
}

-(int)CheckforCandyCollision:(CCSprite *)landanimal
{
    float landanimalsize = landanimal.contentSize.width;
    //float spidersize=[[spiders lastObject] texture].contentSize.width;
    //float collisiondistance=playersize*0.5f+spidersize*0.4f;
    //int num=[landcandies count];
    int direction = 0;
    float distance=1000;
    for(int i=0;i<landnum;i++)
    {
        LandCandyEntity * landcandy=[landcandies objectAtIndex:i];
        CCSprite * candy=landcandy.sprite;
        if(candy.visible==NO)
        {
            continue;
        }
        
        float candysize = candy.contentSize.width;
        float actualdistance=ccpDistance(landanimal.position, candy.position);
        float collisiondistance=landanimalsize*0.5f+candysize*0.4f;
        if(actualdistance<=collisiondistance)
        {
            //set the candy unvisible
            candy.visible=NO;
            landnum--;
            [landcandies removeObjectAtIndex:i];
            //call the storage interface
            Storage *storage = [[TouchCatchLayer sharedTouchCatchLayer] getStorage];
            [storage addFoodToStorage:landcandy.ballType];
            
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
        //CGSize screenSize = [[CCDirector sharedDirector] winSize];
        int numbers=10;
        landcandies = [[CCArray alloc]initWithCapacity:numbers];
        controlCandies = [[CCArray alloc]initWithCapacity:numbers];
        landnum = 0;
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
    [controlCandies release];
	[super dealloc];
}
@end
