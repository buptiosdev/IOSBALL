//
//  Bag.m
//  GreedFamily
//
//  Created by 赵 苹果 on 12-4-20.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import "Bag.h"
#import "GameBackgroundLayer.h"
#import "Helper.h"
#import "BodyObjectsLayer.h"
#import "PropertyCache.h"
#import "LandAnimal.h"
#import "TouchCatchLayer.h"
#import "GameMainScene.h"
#import "NoBodyObjectsLayer.h"
#import "CommonLayer.h"

//BEGIN item scale  默认为相对于X的比例
float bagitemscale=40.0/480;
float bagstorescale=25.0/480;
//END


@implementation Bag
@synthesize sprite = _sprite;


-(void)callTimePepper: (ccTime) dt
{
    CCProgressTimer*timeTmp=(CCProgressTimer*)[self getChildByTag:pepperTimeTag];
    timeTmp.percentage++;  
    if(timeTmp.percentage>=100)
    {  
        [pepperPropMenu setIsEnabled:YES];
        timeTmp.percentage=0;  
        [self unschedule:_cmd];
    }   
    
}

-(void)callTimeCrystal: (ccTime) dt
{
    CCProgressTimer*timeTmp=(CCProgressTimer*)[self getChildByTag:crystalTimeTag];
    timeTmp.percentage++;  
    if(timeTmp.percentage>=100)
    {  
        [crystalPropMenu setIsEnabled:YES];
        timeTmp.percentage=0;  
        [self unschedule:_cmd];
    }   
    
}

-(void)callTimeSmoke: (ccTime) dt
{
    CCProgressTimer*timeTmp=(CCProgressTimer*)[self getChildByTag:smokeTimeTag];
    timeTmp.percentage++;  
    if(timeTmp.percentage>=100)
    {  
        [smokePropMenu setIsEnabled:YES];
        timeTmp.percentage=0;  
        [self unschedule:_cmd];
    }   
    
}

-(void)onPepper:(id)sender
{
    if (0 >= pepperNum) 
    {
        return;
    }
    [CommonLayer playAudio:Speedup];
    if (1 == bagID) 
    {
        [[[NoBodyObjectsLayer sharedNoBodyObjectsLayer] getLandAnimal] increaseSpeed];
    }
    else
    {
        [[[NoBodyObjectsLayer sharedNoBodyObjectsLayer] getLandAnimalPlay2] increaseSpeed];
    }
    pepperNum--;
    if (0 == pepperNum) 
    {
        //消失动画
        pepperMenu.visible = NO;
    } 
    else
    {
        [pepperPropMenu setIsEnabled:NO];
        [self schedule:@selector(callTimePepper:) interval:0.1];
    }
    [pepperLabel setString:[NSString stringWithFormat:@"x%i", pepperNum]];
    
}

-(void)onCrystal:(id)sender
{
    //音效
    [CommonLayer playAudio:Laugh1];
    
    if (0 >= crystalNum)
    {
        return;
    }
    Storage *storage = nil;

    if (1 == bagID) 
    {
        storage = [[TouchCatchLayer sharedTouchCatchLayer] getStorage];

    }
    else
    {
        storage = [[TouchCatchLayer sharedTouchCatchLayer] getStoragePlay2];
    }
    [storage combinTheSameTypeNew]; 
    crystalNum--;
    if (0 == crystalNum) 
    {
        //消失动画
        crystalMenu.visible = NO;
    } 
    else
    {
        [crystalPropMenu setIsEnabled:NO];
        [self schedule:@selector(callTimeCrystal:) interval:0.1];
    }

    [crystalLabel setString:[NSString stringWithFormat:@"x%i", crystalNum]];
    
}

-(void)onSmoke:(id)sender
{
    if (0 >= smokeNum)
    {
        return;
    }
//可以当作破最高分特效    
//    
//    CCParticleSystem* system;
//    system = [ARCH_OPTIMAL_PARTICLE_SYSTEM particleWithFile:@"smoke2.plist"];
//    system.positionType = kCCPositionTypeGrouped;
//    system.autoRemoveOnFinish = YES;
//    //system.position = self.sprite.position;
//    [self addChild:system];

//    [[LandAnimal sharedLandAnimal] reverseDirection];
    if (1 == bagID) 
    {
        [[[NoBodyObjectsLayer sharedNoBodyObjectsLayer] getLandAnimal] reverseDirection];
    }
    else
    {
        [[[NoBodyObjectsLayer sharedNoBodyObjectsLayer] getLandAnimalPlay2] reverseDirection];
    }

    smokeNum--;
    if (0 == smokeNum) 
    {
        //消失动画
        smokeMenu.visible = NO;
    } 
    else
    {
        [smokePropMenu setIsEnabled:NO];
        [self schedule:@selector(callTimeSmoke:) interval:0.1];
    }
    [smokeLabel setString:[NSString stringWithFormat:@"x%i", smokeNum]];
    
}
+(id)createBag:(int)playID
{
    return [[[self alloc] initWithPlayID:playID] autorelease];
}

-(id)initWithPlayID:(int)playID
{
    if ((self = [super init]))
    {
        CGSize screenSize = [[CCDirector sharedDirector] winSize];
        pepperNum = 0;
        crystalNum = 0;
        bagID = playID;
        
        CCSprite *pepperProp1 = [CCSprite spriteWithSpriteFrameName:@"pepper-.png"];
        CCSprite *pepperProp2 = [CCSprite spriteWithSpriteFrameName:@"pepper-.png"];    
        pepperPropMenu = [CCMenuItemSprite itemFromNormalSprite:pepperProp1 
                                                                   selectedSprite:pepperProp2 
                                                                           target:self 
                                                                         selector:@selector(onPepper:)];
        pepperPropMenu.scale=screenSize.width*bagitemscale/[pepperProp1 contentSize].width; //按照像素定制图片宽高
        pepperLabel = [CCLabelBMFont labelWithString:@"x0" fntFile:@"bitmapNum4.fnt"];
        
        pepperLabel.anchorPoint = CGPointMake(-2.35, -0.2);
        pepperLabel.scale=0.8;
        [pepperPropMenu addChild:pepperLabel z:1];
        pepperMenu = [CCMenu menuWithItems:pepperPropMenu,nil];
        //change size by diff version
        if (1 == bagID) 
        {
            pepperMenu.position = [GameMainScene sharedMainScene].pepperMenuPos;
        }
        else
        {
            pepperMenu.position = [GameMainScene sharedMainScene].pepperMenuPlay2Pos;
        }
        CCSpriteBatchNode* buttonBatch = [[GameBackgroundLayer sharedGameBackgroundLayer] getButtonBatch];
        //显示背包背景
        CCSprite *star = [CCSprite spriteWithSpriteFrameName:@"star2_magic.png"];
        //change size by diff version query
        star.position=pepperMenu.position;
        //change size by diff version manual
        star.scale=screenSize.width*bagstorescale/[star contentSize].width; //按照像素定制图片宽高是控制像素的。
        [buttonBatch addChild:star z:-2];
            
            
        pepperMenu.visible = NO;
        [self addChild:pepperMenu z:-2 ];
        CCProgressTimer *timePepper = [CCProgressTimer progressWithFile:@"cd.png"];
        timePepper.type=kCCProgressTimerTypeRadialCW;//进度条的显示样式  
        timePepper.percentage = 0; //当前进度       
        timePepper.position = pepperMenu.position; 
        [self addChild:timePepper z:-1 tag:pepperTimeTag];
        
        CCSprite *crystalProp1 = [CCSprite spriteWithSpriteFrameName:@"magic-.png"];
        CCSprite *crystalProp2 = [CCSprite spriteWithSpriteFrameName:@"magic-.png"];    
        crystalPropMenu = [CCMenuItemSprite itemFromNormalSprite:crystalProp1 
                                                                   selectedSprite:crystalProp2 
                                                                           target:self 
                                                                         selector:@selector(onCrystal:)];
        crystalPropMenu.scale=screenSize.width*bagitemscale/[crystalProp1 contentSize].width; //按照像素定制图片宽高

        crystalLabel = [CCLabelBMFont labelWithString:@"x0" fntFile:@"bitmapNum4.fnt" ];
        crystalLabel.anchorPoint = CGPointMake(-2.35, -0.2);
        crystalLabel.scale=0.8;
        [crystalPropMenu addChild:crystalLabel z:1];
        crystalMenu = [CCMenu menuWithItems:crystalPropMenu,nil];
        //change size by diff version
        CGPoint distance = CGPointMake(0, 45);
        if (NO == [GameMainScene sharedMainScene].isPairPlay) {
            distance = CGPointMake(45, 0);
        }
        crystalMenu.position = ccpAdd(distance, pepperMenu.position);
        //显示背包背景
        CCSprite *star2 = [CCSprite spriteWithSpriteFrameName:@"star2_magic.png"];
        //change size by diff version query
        star2.position=crystalMenu.position;
        //change size by diff version manual
        star2.scale=screenSize.width*bagstorescale/[star contentSize].width; //按照像素定制图片宽高是控制像素的。
        [buttonBatch addChild:star2 z:-2];
        crystalMenu.visible = NO;
        [self addChild:crystalMenu z:-2];
        CCProgressTimer *timeCrystal = [CCProgressTimer progressWithFile:@"cd.png"];
        timeCrystal.type=kCCProgressTimerTypeRadialCW;//进度条的显示样式  
        timeCrystal.percentage = 0; //当前进度       
        timeCrystal.position = crystalMenu.position; 
        [self addChild:timeCrystal z:-1 tag:crystalTimeTag];
        
        
        CCSprite *smokeProp1 = [CCSprite spriteWithSpriteFrameName:@"garlic-.png"];
        CCSprite *smokeProp2 = [CCSprite spriteWithSpriteFrameName:@"garlic-.png"];    
        smokePropMenu = [CCMenuItemSprite itemFromNormalSprite:smokeProp1 
                                                  selectedSprite:smokeProp2 
                                                          target:self 
                                                        selector:@selector(onSmoke:)];
        smokePropMenu.scale=screenSize.width*bagitemscale/[smokeProp1 contentSize].width; //按照像素定制图片宽高
        
        smokeLabel = [CCLabelBMFont labelWithString:@"x0" fntFile:@"bitmapNum4.fnt"];
        smokeLabel.anchorPoint = CGPointMake(-2.35, -0.2);
        smokeLabel.scale=0.8;
        [smokePropMenu addChild:smokeLabel z:1];
        smokeMenu = [CCMenu menuWithItems:smokePropMenu,nil];
        //change size by diff version
        CGPoint distance2 = CGPointMake(0, 90);
        if (NO == [GameMainScene sharedMainScene].isPairPlay) {
            distance2 = CGPointMake(90, 0);
        }
        smokeMenu.position = ccpAdd(distance2, pepperMenu.position);
        //显示背包背景
        CCSprite *star3 = [CCSprite spriteWithSpriteFrameName:@"star2_magic.png"];
        //change size by diff version query
        star3.position=smokeMenu.position;
        //change size by diff version manual
        star3.scale=screenSize.width*bagstorescale/[star contentSize].width; //按照像素定制图片宽高是控制像素的。
        [buttonBatch addChild:star3 z:-2];
        
        smokeMenu.visible = NO;
        [self addChild:smokeMenu z:-2];
        CCProgressTimer *timeSmoke = [CCProgressTimer progressWithFile:@"cd.png"];
        timeSmoke.type=kCCProgressTimerTypeRadialCW;//进度条的显示样式  
        timeSmoke.percentage = 0; //当前进度       
        timeSmoke.position = smokeMenu.position; 
        [self addChild:timeSmoke z:-1 tag:smokeTimeTag];

    }
    
    return self;
}

-(void)addPepper
{
    if (0 == pepperNum) 
    {
        //出现动画
        //change size by diff version
        CGPoint moveToPosition;
        CGPoint distance;
        if (NO == [GameMainScene sharedMainScene].isPairPlay) {

            moveToPosition = [GameMainScene sharedMainScene].pepperMenuPos;
            distance = CGPointMake(0, -30);
        }
        else
        {
            if (1 == bagID) 
            {
                moveToPosition = [GameMainScene sharedMainScene].pepperMenuPos;
                distance = CGPointMake(-50, 0);
            }
            else
            {
                moveToPosition = [GameMainScene sharedMainScene].pepperMenuPlay2Pos;
                distance = CGPointMake(50, 0);
            }
        }
        pepperMenu.position = ccpAdd(moveToPosition, distance);
        pepperMenu.visible = YES;
        CCMoveTo* move = [CCMoveTo actionWithDuration:1 position:moveToPosition]; 
        CCEaseInOut* ease = [CCEaseInOut actionWithAction:move rate:2];
        [pepperMenu runAction:ease];

    }
    pepperNum++;
    [pepperLabel setString:[NSString stringWithFormat:@"x%i", pepperNum]];
}

-(void)addCrystal
{
    if (0 == crystalNum) 
    {
        //出现动画
        //change size by diff version
        CGPoint distance1 = CGPointMake(0, 45);
        CGPoint distance2;
        CGPoint moveToPosition;
        if (NO == [GameMainScene sharedMainScene].isPairPlay) {
            distance1 = CGPointMake(45, 0);
            moveToPosition = ccpAdd(distance1, [GameMainScene sharedMainScene].pepperMenuPos);
            distance2 = CGPointMake(0, -30);
        }
        else
        {
            if (1 == bagID) 
            {
                moveToPosition = ccpAdd(distance1, [GameMainScene sharedMainScene].pepperMenuPos);
                distance2 = CGPointMake(-50, 0);
            }
            else
            {
                moveToPosition = ccpAdd(distance1, [GameMainScene sharedMainScene].pepperMenuPlay2Pos);
                distance2 = CGPointMake(50, 0);
            }
        }        
        crystalMenu.position = ccpAdd(moveToPosition, distance2);
        crystalMenu.visible = YES;
        CCMoveTo* move = [CCMoveTo actionWithDuration:1 position:moveToPosition]; 
        CCEaseInOut* ease = [CCEaseInOut actionWithAction:move rate:2];
        [crystalMenu runAction:ease];

    }
    crystalNum++;
    [crystalLabel setString:[NSString stringWithFormat:@"x%i", crystalNum]];
}

-(void)addSmoke
{
    if (0 == smokeNum) 
    {
        //出现动画
        //change size by diff version
        CGPoint distance1 = CGPointMake(0, 90);
        CGPoint distance2;
        CGPoint moveToPosition;
        if (NO == [GameMainScene sharedMainScene].isPairPlay) {
            distance1 = CGPointMake(90, 0);
            moveToPosition = ccpAdd(distance1, [GameMainScene sharedMainScene].pepperMenuPos);
            distance2 = CGPointMake(0, -30);
        }
        else
        {
            if (1 == bagID) 
            {
                moveToPosition = ccpAdd(distance1, [GameMainScene sharedMainScene].pepperMenuPos);
                distance2 = CGPointMake(-50, 0);
            }
            else
            {
                moveToPosition = ccpAdd(distance1, [GameMainScene sharedMainScene].pepperMenuPlay2Pos);
                distance2 = CGPointMake(50, 0);
            }
        }
        smokeMenu.position = ccpAdd(distance2, moveToPosition);
        smokeMenu.visible = YES;
        CCMoveTo* move = [CCMoveTo actionWithDuration:1 position:moveToPosition]; 
        CCEaseInOut* ease = [CCEaseInOut actionWithAction:move rate:2];
        [smokeMenu runAction:ease];

    }
    smokeNum++;
    [smokeLabel setString:[NSString stringWithFormat:@"x%i", smokeNum]];
}



-(void) dealloc
{
    //[[CCTouchDispatcher sharedDispatcher] removeDelegate:self];
	[super dealloc];
}


@end
