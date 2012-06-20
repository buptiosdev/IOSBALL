//
//  StorageSprite.m
//  GreedFamily
//
//  Created by 赵 苹果 on 12-4-20.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import "Storage.h"
#import "GameBackgroundLayer.h"
#import "SimpleAudioEngine.h"
#import "Helper.h"
#import "Food.h"
#import "GameMainScene.h"

@interface Storage (PrivateMethods)
-(id)initWithCapacity:(int)storageCapacity;
-(void)moveFood;
-(void)reduceFood:(int)count Turn:(int)turn;
-(void)oneSecondCheckMax:(ccTime)delta;
-(void)combineMain:(int)totalNum;
-(void)checkCombineFood;
-(void)checkLastCombineFood;
@end

@implementation Storage
@synthesize sprite = _sprite;



-(void) registerWithTouchDispatcher
{
    [[CCTouchDispatcher sharedDispatcher] addTargetedDelegate:self priority:-2 swallowsTouches:YES];
}

+(id)createStorage:(int)storageCapacity
{
    return [[[self alloc] initWithCapacity:storageCapacity] autorelease];
}


-(void)initScores
{
    //display the Type Of Score  
    CCSprite *cakeScore = [CCSprite spriteWithSpriteFrameName:@"candy-.png"];
    CCSprite *chocolateScore = [CCSprite spriteWithSpriteFrameName:@"cheese-.png"];
    CCSprite *pudingScore = [CCSprite spriteWithSpriteFrameName:@"apple-.png"];
    
    //按照像素设定图片大小
    cakeScore.scaleX=(20)/[cakeScore contentSize].width;//按照像素定制图片宽高
    chocolateScore.scaleX=(20)/[chocolateScore contentSize].width; //按照像素定制图片宽高
    pudingScore.scaleX=(20)/[pudingScore contentSize].width; //按照像素定制图片宽高
    
    cakeScore.scaleY=(20)/[cakeScore contentSize].height;//按照像素定制图片宽高
    chocolateScore.scaleY=(20)/[chocolateScore contentSize].height; //按照像素定制图片宽高
    pudingScore.scaleY=(20)/[pudingScore contentSize].height; //按照像素定制图片宽高
    

    
    CGSize screenSize = [[CCDirector sharedDirector] winSize];
    cakeScore.position = CGPointMake(295, screenSize.height - 20);
    chocolateScore.position = CGPointMake(355, screenSize.height - 20);
    pudingScore.position = CGPointMake(415, screenSize.height - 20);
    CCSpriteBatchNode* batch = [[GameBackgroundLayer sharedGameBackgroundLayer] getSpriteBatch];
    [batch addChild:cakeScore];
    [batch addChild:chocolateScore];
    [batch addChild:pudingScore];
    
    // Add the score label with z value of -1 so it's drawn below everything else
    cakeScoreLabel = [CCLabelBMFont bitmapFontAtlasWithString:@"x0" fntFile:@"bitmapfont.fnt"];
    cakeScoreLabel.position = CGPointMake(320, screenSize.height - 5);
    cakeScoreLabel.anchorPoint = CGPointMake(0.5f, 1.0f);
    cakeScoreLabel.scale = 0.4;
    [self addChild:cakeScoreLabel z:-2];
    
    chocolateScoreLabel = [CCLabelBMFont bitmapFontAtlasWithString:@"x0" fntFile:@"bitmapfont.fnt"];
    
    chocolateScoreLabel.position = CGPointMake(380, screenSize.height - 5);
    chocolateScoreLabel.anchorPoint = CGPointMake(0.5f, 1.0f);
    chocolateScoreLabel.scale = 0.4;
    [self addChild:chocolateScoreLabel z:-2];
    
    pudingScoreLabel = [CCLabelBMFont bitmapFontAtlasWithString:@"x0" fntFile:@"bitmapfont.fnt"];
    pudingScoreLabel.position = CGPointMake(435, screenSize.height - 5);
    pudingScoreLabel.anchorPoint = CGPointMake(0.5f, 1.0f);
    pudingScoreLabel.scale = 0.4;
    [self addChild:pudingScoreLabel z:-2];
    

    
}

-(id)initWithCapacity:(int)capacity
{
    if ((self = [super init]))
    {
        //[self registerWithTouchDispatcher];
        gamelevel= [GameMainScene sharedMainScene].sceneNum;
        storageCapacity = capacity;
        CCSpriteBatchNode* batch = [[GameBackgroundLayer sharedGameBackgroundLayer] getSpriteBatch];
        _sprite = [CCSprite spriteWithSpriteFrameName:@"storage.png"];
        //先不可见，后续再去掉或替换图片
        _sprite.visible = NO;
        CGSize screenSize = [[CCDirector sharedDirector] winSize];
        _sprite.position = CGPointMake(screenSize.width / 2, 20);
        [batch addChild:_sprite];
        
        [self initScores];

        foodArray = [[CCArray alloc] initWithCapacity:storageCapacity];
        combinArray = (int *)malloc(storageCapacity*sizeof(int));
        canCombine = NO;
        
        

        //gameScore *instanceOfgameScore = [gameScore sharedgameScore];

                
        [self scheduleUpdate];
        [self schedule:@selector(oneSecondCheckMax:) interval:1];
        
        //实时计算得分
        [self schedule:@selector(updateGameScore:) interval:0.5];
    }
    
    return self;
}

//炸掉仓库
-(void)bombStorage
{
    int num = [foodArray count];
    for (int i=0;i < num; i++) 
    {
        [self reduceFood:i Turn:i];
    }
}

//消除同一种颜色的球
-(void)combinTheSameType
{
    int combineNum = 0;
//    BOOL isCombine = NO;
    int sameTypeCount = 0;
    Food *lastFood = nil;
    Food * curFood = nil;
    int lastType = 0;
    int a;
    if ([foodArray count] > 0)
    {
        lastFood = [foodArray objectAtIndex:[foodArray count] - 1];
        lastType = lastFood.foodType;
    }
    else
    {
        return;
    }
    
    for (int i=0;i < storageCapacity; i++)
    {
        if ( i >= [foodArray count])
        {
            break;
        }
        
        curFood = [foodArray objectAtIndex:i];
        if (curFood.foodType == lastFood.foodType) 
        {
            sameTypeCount++;
            foodInStorage[curFood.foodType] += 1;
            
            a = i;
            *(combinArray+combineNum) = a;
            combineNum++;
            
            if (theSameTypeNumOfOneTime < sameTypeCount) 
            {
                theSameTypeNumOfOneTime = sameTypeCount;
            }
        }
    }
        
    needUpdateScore = YES;
    [[SimpleAudioEngine sharedEngine] playEffect:@"getscore.caf"];
    canCombine = YES;
    
    int index;
    for (int i=0;i < combineNum; i++) 
    {
        index = *(combinArray + i);
        [self reduceFood:index Turn:i];
    }
    
    [self moveFood];
    canCombine = NO;
    
    //消完后马上检查，为连续消做准备
    [self checkCombineFood];
    
    [self combineMain:combineNum];
}

-(void)addFoodToStorage:(int)foodType
{
    if (currentCount >= storageCapacity) 
    {
        CCLOG(@"storage is alread full!\n");
        return;
    }
    if (foodType < 3)
    {
        Food * food = [[Food alloc]initWithStorage:self Type:foodType Count:currentCount];
        [foodArray insertObject:food atIndex:currentCount];
        currentCount++;
        [food release];
    }
    //白炸弹
    else if (5 == foodType)
    {
        
    }
    //黑炸弹
    else if (4 == foodType)
    {
        [self bombStorage];
    }
    //水晶球
    else if (3 == foodType)
    {
        [self combinTheSameType];
    }
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
                [[SimpleAudioEngine sharedEngine] playEffect:@"needtouch.caf"];
                break;
            }
        }
    }


}

-(void)checkLastCombineFood
{
    int n = [foodArray count];
    
    if (n < 3) 
    {
        canCombine = NO;
        return;
    }

    Food * curFood = nil;
    Food * leftFood = nil;
    Food *leftmostFood= nil;
    leftmostFood = [foodArray objectAtIndex:n-3];
    leftFood = [foodArray objectAtIndex:n-2];
    if (leftFood.foodType != leftmostFood.foodType)
    {
        canCombine = NO;
        return;
    }
    curFood = [foodArray objectAtIndex:n-1];
    if (curFood.foodType == leftFood.foodType) 
    {
        if (!canCombine)
        {
            [[SimpleAudioEngine sharedEngine] playEffect:@"needtouch.caf"];
            canCombine = YES;
        }
        
    }
    else
    {
        canCombine = NO;
    }
        
    return;
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
        
        float widthPer = [curFood.mySprite contentSize].width * curFood.mySprite.scaleX;
        float highPer = [curFood.mySprite contentSize].height * curFood.mySprite.scaleY;

        CGPoint moveToPosition = CGPointMake(i * widthPer + widthPer * 0.5, highPer * 0.5);
        
        
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
//从仓库前面往后消
-(void)doCombineFood:(int *)totalNum
{
    int combineNum = 0;
    BOOL isCombine = NO;
    int sameTypeCount = 0;

    
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
                    sameTypeCount = 2;
                    foodInStorage[curFood.foodType] += 2;
                    a = i - 2;
                    *(combinArray+combineNum) = a;
                    combineNum++;
                    a = i - 1;
                    *(combinArray+combineNum) = a;
                    combineNum++;
                }
                
                sameTypeCount++;
                foodInStorage[curFood.foodType] += 1;
                
                a = i;
                *(combinArray+combineNum) = a;
                combineNum++;
                
                if (theSameTypeNumOfOneTime < sameTypeCount) 
                {
                    theSameTypeNumOfOneTime = sameTypeCount;
                }
                
                isCombine = YES;
                needUpdateScore = YES;
                [[SimpleAudioEngine sharedEngine] playEffect:@"getscore.caf"];
            }
            else
            {
                isCombine = NO;
                continue;
            }
            
        }
    }
    

    if (!canCombine)
    {
        return;
    }
    
    *totalNum +=  combineNum;
    
    int index;
    for (int i=0;i < combineNum; i++) 
    {
        index = *(combinArray + i);
        [self reduceFood:index Turn:i];
    }
    
    [self moveFood];
    canCombine = NO;
    
    //消完后马上检查，为连续消做准备
    [self checkCombineFood];

}

//从仓库后面往前消
-(void)doCombineFoodFromLast:(int *)totalNum
{
    int combineNum = 0;
    BOOL isCombine = NO;
    int sameTypeCount = 0;
    
    int foodCount = [foodArray count];
    
    if(!canCombine)
    {
        return;
    }
    
    for (int i = foodCount - 3; i >= 0; i--) 
    {
        Food * curFood = nil;
        Food * rightFood = nil;
        Food *rightmostFood= nil;
        rightmostFood = [foodArray objectAtIndex:i+2];
        rightFood = [foodArray objectAtIndex:i+1];
        if (rightFood.foodType != rightmostFood.foodType)
        {
            isCombine = NO;
            continue;
        }
        curFood = [foodArray objectAtIndex:i];
        if (curFood.foodType == rightFood.foodType) 
        {
            int a;
            if (!isCombine)
            {
                sameTypeCount = 2;
                foodInStorage[curFood.foodType] += 2;
                a = i + 2;
                *(combinArray+combineNum) = a;
                combineNum++;
                a = i + 1;
                *(combinArray+combineNum) = a;
                combineNum++;
            }
            
            sameTypeCount++;
            foodInStorage[curFood.foodType] += 1;
            
            a = i;
            *(combinArray+combineNum) = a;
            combineNum++;
            
            if (theSameTypeNumOfOneTime < sameTypeCount) 
            {
                theSameTypeNumOfOneTime = sameTypeCount;
            }
            
            isCombine = YES;
            needUpdateScore = YES;
            [[SimpleAudioEngine sharedEngine] playEffect:@"getscore.caf"];
        }
    }
        
    if (!canCombine)
    {
        return;
    }
    
    *totalNum +=  combineNum;
    
    int index; 

    for (int i = combineNum - 1, j = 0; i >= 0; i--, j++) 
    {
        index = *(combinArray + j);
        [self reduceFood:index Turn:i];
    }
    
    [self moveFood];
    canCombine = NO;
    
    //消完后马上检查，为连续消做准备
    [self checkCombineFood];
    
    return;
}


-(void)updateScores
{
    [pudingScoreLabel setString:[NSString stringWithFormat:@"x%i", foodInStorage[0]]];
    [cakeScoreLabel setString:[NSString stringWithFormat:@"x%i", foodInStorage[1]]];
    [chocolateScoreLabel setString:[NSString stringWithFormat:@"x%i", foodInStorage[2]]];

}


-(void) update:(ccTime)delta
{
    [self checkLastCombineFood];
    
    if (needUpdateScore)
    {
        [self updateScores];
        needUpdateScore = NO;
    }
    
}

-(void)oneSecondCheckMax:(ccTime)delta
{
    if (currentCount == storageCapacity)
    {
        [self reduceFood:storageCapacity Turn:1];
    }
}

-(void)updateGameScore:(ccTime)delta 
{
    CCLOG(@"Into updateGameScore!");
    gameScore *instanceOfgameScore = [gameScore sharedgameScore];
    /*
    -(void)calculateGameScore:(int)level TimesofOneTouch:(int)timesofonetouch 
NumbersOfOneTime:(int)numbersOfOneTime 
TheSameTypeNumOfOneTime:(int)theSameTypeNumOfOneTime
Chocolate:(int)choclolatenum
Cake:(int)cakenum
Circle:(int)circlenum
     */
    //一次消的次数 
    //int timesOfOneTouch;
    //一次消除的个数（所有类型）
    //int numbersOfOneTime;
    //一种类型消除个数
    //int theSameTypeNumOfOneTime;

    [instanceOfgameScore calculateGameScore:gamelevel 
                                         TimesofOneTouch:timesOfOneTouch 
                                         NumbersOfOneTime:numbersOfOneTime 
                                         TheSameTypeNumOfOneTime:theSameTypeNumOfOneTime 
                                         Chocolate:foodInStorage[2] 
                                         Cake:foodInStorage[1] 
                                         Circle:foodInStorage[0]];

}


-(bool) isTouchForMe:(CGPoint)touchLocation
{
    
    return CGRectContainsPoint([self.sprite boundingBox], touchLocation);
}

-(void)combineMain:(int)totalCount
{
    int timesPerTouch = 0;
    //int totalCount = 0;
    //可以连续消
    while (canCombine) 
    {
        timesPerTouch++;
        timesOfOneTouch++;
        //[self doCombineFood:&totalCount];
        //改为从后往前消除
        [self doCombineFoodFromLast:&totalCount];
    }
    
    if (timesOfOneTouch < timesPerTouch) 
    {
        timesOfOneTouch = timesPerTouch;
    }
    
    if (numbersOfOneTime < totalCount)
    {
        numbersOfOneTime = totalCount;
    }
}


-(BOOL) ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event
{
    CGPoint location = [Helper locationFromTouch:touch];
    bool isTouchHandled = [self isTouchForMe:location]; 

    
    if (isTouchHandled)
    {
        _sprite.color = ccRED;
        
        [self combineMain:0];
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
