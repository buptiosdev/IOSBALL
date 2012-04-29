//
//  StorageSprite.m
//  GreedFamily
//
//  Created by 赵 苹果 on 12-4-20.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import "Storage.h"
#import "GameBackgroundLayer.h"
#import "Helper.h"
#import "Food.h"

@interface Storage (PrivateMethods)
-(id)initWithCapacity:(int)storageCapacity;
-(void)moveFood;
@end

@implementation Storage
@synthesize sprite = _sprite;

-(void) registerWithTouchDispatcher
{
    [[CCTouchDispatcher sharedDispatcher] addTargetedDelegate:self priority:-1 swallowsTouches:YES];
}

+(id)createStorage:(int)storageCapacity
{
    return [[[self alloc] initWithCapacity:storageCapacity] autorelease];
}

-(id)initWithCapacity:(int)capacity
{
    if ((self = [super init]))
    {
        //[self registerWithTouchDispatcher];
        storageCapacity = capacity;
        CCSpriteBatchNode* batch = [[GameBackgroundLayer sharedGameBackgroundLayer] getSpriteBatch];
        _sprite = [CCSprite spriteWithSpriteFrameName:@"storage.png"];
        CGSize screenSize = [[CCDirector sharedDirector] winSize];
        _sprite.position = CGPointMake(screenSize.width / 2, 20);
        [batch addChild:_sprite];

        foodArray = [[CCArray alloc] initWithCapacity:storageCapacity];
        combinArray = (int *)malloc(storageCapacity*sizeof(int));
        canCombine = NO;
        
        [self scheduleUpdate];
    }
    
    return self;
}


-(void)addFoodToStorage:(int)foodType
{
    if (currentCount >= storageCapacity) 
    {
        CCLOG(@"storage is alread full!\n");
        return;
    }
    Food * food = [[Food alloc]initWithStorage:self Type:foodType Count:currentCount];
    [foodArray insertObject:food atIndex:currentCount];
    currentCount++;
    [food release];
}

-(void)reduceFood:(int)count Turn:(int)turn
{
    [[foodArray objectAtIndex:(count - turn)] mySprite].visible = NO;
//    [foodArray removeObjectAtIndex:count];
    [foodArray removeObjectAtIndex:(count - turn)];
    currentCount--;
}

-(void)checkCombineFood
{
    if (canCombine)
    {
        return;
    }
    for (int i=0;i < storageCapacity; i++)
    {
        if ( i >= [foodArray count])
        {
            break;
        }
        if (i>1) 
        {
            Food * curFood = nil;
            Food * leftFood = nil;
			Food *leftmostFood= nil;
            leftmostFood = [foodArray objectAtIndex:i-2];
            leftFood = [foodArray objectAtIndex:i-1];
            if (leftFood.foodType != leftmostFood.foodType)
            {
                continue;
            }
            curFood = [foodArray objectAtIndex:i];
            if (curFood.foodType == leftFood.foodType) 
            {
                canCombine = YES;
                break;
            }
        }
    }


}

-(void)moveFood
{
    Food *curFood = nil;
    for (int i=0;i < storageCapacity; i++)
    {
        if ( i >= [foodArray count])
        {
            break;
        }
        
        curFood = [foodArray objectAtIndex:i];
        if (nil == curFood) 
        {
            continue;
        }
        CGPoint moveToPosition = CGPointMake(i * 32 + 16, 20);
        if (!__CGPointEqualToPoint(curFood.mySprite.position, moveToPosition))
        {
//            CCAction *moveAction = [CCSequence actions:
//                                    [CCMoveTo actionWithDuration:2 position:moveToPosition],
//                                    nil
//                                    ];
//            
//            [curFood runAction:moveAction];
            
            
            CCMoveTo* move = [CCMoveTo actionWithDuration:3 position:moveToPosition]; 
            CCEaseInOut* ease = [CCEaseInOut actionWithAction:move rate:4];
            [curFood runAction:ease];
            
            curFood.mySprite.position = moveToPosition;
        }
        
//        if (nil == curFood)
//        {
//            for (int j = i + 1; j < storageCapacity; j++) 
//            {
//                moveFood = [foodArray objectAtIndex:j];
//                
//                if (nil == moveFood) 
//                {
//                    continue;
//                }
//                [foodArray insertObject:moveFood atIndex:i];
//                [foodArray removeObjectAtIndex:j];
//                //action
//                CGPoint moveToPosition = CGPointMake(i * 32 + 16, 20);
//                CCAction *moveAction = [CCSequence actions:
//                                   [CCMoveTo actionWithDuration:0.5 position:moveToPosition],
//                                   nil
//                                   ];
//                
//                [moveFood runAction:moveAction];
//            }
//        }
//        
//
//        
    }

    
}

-(void)doCombineFood
{
    int combineNum = 0;
    BOOL isCombine = NO;
    
    
    if(!canCombine)
    {
        return;
    }
    
    for (int i=0;i < storageCapacity; i++)
    {
        if ( i >= [foodArray count])
        {
            break;
        }
        if (i>1) 
        {
            Food * curFood = nil;
            Food * leftFood = nil;
			Food *leftmostFood= nil;
            leftmostFood = [foodArray objectAtIndex:i-2];
            leftFood = [foodArray objectAtIndex:i-1];
            if (leftFood.foodType != leftmostFood.foodType)
            {
                isCombine = NO;
                continue;
            }
            curFood = [foodArray objectAtIndex:i];
            if (curFood.foodType == leftFood.foodType) 
            {
                int a;
                if (!isCombine)
                {
                    a = i - 2;
                    *(combinArray+combineNum) = a;
                    combineNum++;
                    a = i - 1;
                    *(combinArray+combineNum) = a;
                    combineNum++;
                }
                a = i;
                *(combinArray+combineNum) = a;
                combineNum++;
                
                isCombine = YES;
            }
        }
    }
    

    if (!canCombine)
    {
        return;
    }
    int index;
    for (int i=0;i < combineNum; i++) 
    {
        index = *(combinArray + i);
        [self reduceFood:index Turn:i];
    }
    
    [self moveFood];
    canCombine = NO;
}

-(void) update:(ccTime)delta
{
    static int i = 0;
    i++;
    if (0 == i % 100) 
    {
        [self addFoodToStorage:(int)(CCRANDOM_0_1()*100) % 3 ];
    }
        
    [self checkCombineFood];
    
}

-(bool) isTouchForMe:(CGPoint)touchLocation
{
    
    return CGRectContainsPoint([self.sprite boundingBox], touchLocation);
}


-(BOOL) ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event
{
    CGPoint location = [Helper locationFromTouch:touch];
    bool isTouchHandled = [self isTouchForMe:location]; 
    if (isTouchHandled)
    {
        _sprite.color = ccRED;
        
        if (canCombine)
        {
            [self doCombineFood];
        }
    }
    return isTouchHandled;
}

-(void) ccTouchMoved:(UITouch *)touch withEvent:(UIEvent *)event
{
	_sprite.color = ccYELLOW;

    
}

-(void) ccTouchEnded:(UITouch *)touch withEvent:(UIEvent *)event
{
	_sprite.color = ccWHITE;
}

#pragma mark Layer - Callbacks
-(void) onEnter
{
    [self registerWithTouchDispatcher];
	// then iterate over all the children
	[super onEnter];
}

// issue #624.
// Can't register mouse, touches here because of #issue #1018, and #1021
-(void) onEnterTransitionDidFinish
{	
	[super onEnterTransitionDidFinish];
}


-(void) onExit
{
    
    [[CCTouchDispatcher sharedDispatcher] removeDelegate:self];
	
	[super onExit];
}

-(void) dealloc
{
    [foodArray release];
    free(combinArray);
	[super dealloc];
}
@end
