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
#import "NoBodyObjectsLayer.h"
#import "Competitor.h"
#import "LandAnimal.h"
#import "GameMainScene.h"
@implementation LandCandyCache

@synthesize landnum = _landnum;
@synthesize airnum = _airnum;


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
    int i = 0;
    if(num>0)
    {
        for(i = 0;i < num;i++)
        {
            LandCandyEntity * landcandy = [controlCandies objectAtIndex:i];

            if(landcandy.sprite.visible == NO 
               && landcandy.ballType == balltype)
            {
                landcandy.isDowning = YES;
                landcandy.sprite.visible = YES;
                landcandy.sprite.position = position;
                landcandy.waitinterval = 15;
                //设置物体初始的速度，由动量守恒，考虑到气球的缓冲作用，将下落物体的初始速度设置为flyanimal的初始
                //速度的1／100,之后X方向为匀速运动，Y方向为自由落体，加速度值参见LandCandEntity
                landcandy.candyVelocity = CGPointMake(bodyVelocity.x/100, bodyVelocity.y/100);
                _airnum++;
                return;
                //return landcandy;
            }
        }
    }
    LandCandyEntity * candyEntity = [LandCandyEntity CreateLandCandyEntity:balltype Pos:position BodyVelocity:bodyVelocity];
    [self addChild:candyEntity z:2 tag:2];
    [controlCandies insertObject:candyEntity atIndex:i];
    _airnum++;
    return;
    //[landcandies addObject:candyEntity];
    //return candyEntity;
}

-(void)addToLandCandies:(LandCandyEntity *)landCandy
{
    [landcandies insertObject:landCandy atIndex:_landnum];
    _landnum++;
    _airnum--;

    [[[NoBodyObjectsLayer sharedNoBodyObjectsLayer] getLandAnimal] setCurDirection];
    if (YES == [GameMainScene sharedMainScene].isPairPlay) 
    {
        [[[NoBodyObjectsLayer sharedNoBodyObjectsLayer] getLandAnimalPlay2] setCurDirection];
    }

    CCLOG(@"landnum++ =%d\n",_landnum);
}

-(void)competitorEat:(int)foodType
{
    //冰块
    if (foodType == 5) 
    {
        [[Competitor sharedCompetitor] decreaseSpeed];
    }
    //炸弹
    else if (foodType == 4)
    {
        [[Competitor sharedCompetitor] bombed];
    }
    //水晶球
    else if (foodType == 3)
    {
        [[Competitor sharedCompetitor] getCrystal];
    }
    //辣椒
    else if (foodType == 6)
    {
        [[Competitor sharedCompetitor] increaseSpeed];
    }
    else if (foodType == 7)
    {
        [[Competitor sharedCompetitor] reverseDirection];
    }
    [[Competitor sharedCompetitor]eatAction:foodType];
}

-(void)landAnimalEat:(CCSprite *)landanimal FoodType:(int)foodType Play:(int)playID
{
    Storage *storage = nil;
    if (1 == playID) 
    {
        storage = [[TouchCatchLayer sharedTouchCatchLayer] getStorage]; 
    }
    else
    {
        storage = [[TouchCatchLayer sharedTouchCatchLayer] getStoragePlay2];
    }
    
    [storage addFoodToStorage:foodType];
    
    
    [(LandAnimal *)[landanimal parent] eatAction:foodType];
}

-(int)getCurDirection:(CCSprite *)landanimal
{
    int direction = 0;
    float distance=1000;
    //float landanimalsize = landanimal.contentSize.width * landanimal.scaleX;
    for(int i=0;i<_landnum;i++)
    {
        LandCandyEntity * landcandy=[landcandies objectAtIndex:i];
        CCSprite * candy=landcandy.sprite;
        if(candy.visible==NO)
        {
            continue;
        }
        
        float actualdistance=ccpDistance(landanimal.position, candy.position);
        
        if(actualdistance<distance)
        {
            distance=actualdistance;
            if(landanimal.position.x-candy.position.x>0)
            {
                direction=-1;
            }
            else
            {
                direction=1;
            }
            
        }
    }
    return direction;
}

-(int)CheckforCandyCollision:(CCSprite *)landanimal Type:(int)landtype Play:(int)playID
{
    float landanimalsize = landanimal.contentSize.width * landanimal.scaleX;
    //float spidersize=[[spiders lastObject] texture].contentSize.width;
    //float collisiondistance=playersize*0.5f+spidersize*0.4f;
    //int num=[landcandies count];
    int direction = 0;
//    float distance=1000;
    for(int i=0;i<_landnum;i++)
    {
        LandCandyEntity * landcandy=[landcandies objectAtIndex:i];
        CCSprite * candy=landcandy.sprite;
        if(candy.visible==NO)
        {
            continue;
        }
        
        float candysize = candy.contentSize.width * candy.scaleX;
        float actualdistance=ccpDistance(landanimal.position, candy.position);
        float collisiondistance=landanimalsize*0.5f+candysize*0.4f;
        if(actualdistance<=collisiondistance)
        {
            //set the candy unvisible
            id actionScale = [CCScaleBy actionWithDuration:2]; 
            [candy runAction:actionScale];
            //candy.visible=NO;
            _landnum--;
            CCLOG(@"landnum-- =%d\n",_landnum);
            [landcandies removeObjectAtIndex:i];
            //call the storage interface
            if(landtype == LandAnimalTag)
            {
                direction = [self getCurDirection:landanimal];
                if (YES == [GameMainScene sharedMainScene].isPairPlay) 
                {
                    if (1 == playID) 
                    {
                        [[[NoBodyObjectsLayer sharedNoBodyObjectsLayer] getLandAnimalPlay2] setCurDirection];
                    }
                    else
                    {
                        [[[NoBodyObjectsLayer sharedNoBodyObjectsLayer] getLandAnimal] setCurDirection];
                    }
                    
                }
                [self landAnimalEat:landanimal FoodType:landcandy.ballType Play:playID];
                //烟雾球改变现在方向
//                if (7 == landcandy.ballType) {
//                    direction = -direction;
//                }
            }
            else
            {
                [self competitorEat:landcandy.ballType];
                //同样要设置一下动物的方向
                [[LandAnimal sharedLandAnimal] setCurDirection];
                
            }
            
        }
//        else
//        {
//            if(actualdistance<distance){
//                distance=actualdistance;
//                if(landanimal.position.x-candy.position.x>0){
//                    direction=-1;
//                }else{
//                    direction=1;
//                }
//            }
//        }

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
        _landnum = 0;
        _airnum = 0;
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
