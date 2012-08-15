//
//  LandAnimalSprite.m
//  GreedFamily
//
//  Created by 赵 苹果 on 12-4-19.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import "LandAnimal.h"
#import "GameBackgroundLayer.h"
#import "LandCandyCache.h"
#import "NoBodyObjectsLayer.h"
#import "GameMainScene.h"
#import "CCAnimationHelper.h"

@implementation LandAnimal

@synthesize sprite = _sprite;
@synthesize landAnimalActionArray = _landAnimalActionArray;
@synthesize  moveAction = _moveAction;


+(id)CreateLandAnimal:(int)roleType Play:(int)playID
{
	return [[[self alloc] initWithType:roleType Play:playID] autorelease];
}

static LandAnimal *instanceOfLandAnimal;
+(LandAnimal *)sharedLandAnimal
{
    NSAssert(nil != instanceOfLandAnimal, @"BodyObjectsLayer instance not yet initialized!");
    
    return instanceOfLandAnimal;
}

-(void)initMoveAction
{        
    
    _landAnimalActionArray = [[NSMutableArray alloc] init];
       
    for (int i =0; i <2; i++) {
        
        CCAnimation* animation = nil;
        //小鸟
        if (1 == familyType) 
        {
            switch (i) {
                case 0:
                    animation = [CCAnimation animationWithFrame:@"girlbird_3_" frameCount:3 delay:0.2f];
                    break;
                case 1:
                    animation = [CCAnimation animationWithFrame:@"girlbird_9_" frameCount:3 delay:0.2f];
                    break;
                                
                default:
                    break;
            }
        }
        //小猪
        else if (2 == familyType)
        {
            switch (i) {
                case 0:
                    animation = [CCAnimation animationWithFrame:@"girlbird_3_" frameCount:3 delay:0.2f];
                    break;
                case 1:
                    animation = [CCAnimation animationWithFrame:@"girlbird_9_" frameCount:3 delay:0.2f];
                    break;
                    
                default:
                    break;
            }
        }
        
        
        CCAnimate *animate = [CCAnimate actionWithAnimation:animation restoreOriginalFrame:NO];
        CCSequence *seq = [CCSequence actions: animate,
                           nil];
        
        self.moveAction = [CCRepeatForever actionWithAction: seq ];
        [_landAnimalActionArray addObject:self.moveAction];
        
    }
    
    
}

-(id)initWithType:(int)roleType Play:(int)playID
{
    if ((self = [super init]))
	{
        instanceOfLandAnimal = self;
        animalID = playID;
        familyType = roleType;
        //初始化动画
        [self initMoveAction];
        
        CGSize screenSize = [[CCDirector sharedDirector] winSize];
        CGPoint startPos;
        //小鸟
        if (1 == familyType)
        {
            self.sprite = [CCSprite spriteWithSpriteFrameName:@"girlbird_3_1.png"];
            //按照像素设定图片大小
            //change size by diff version manual
            self.sprite.scaleX=(40)/[self.sprite contentSize].width; //按照像素定制图片宽高
            self.sprite.scaleY=(40)/[self.sprite contentSize].height;
            //        CCSprite * ground=[CCSprite spriteWithSpriteFrameName:@"ground.png"];
            //self.sprite = [CCSprite spriteWithFile:@"blocks.png"];
            //change size by diff version manual
            startPos = CGPointMake((screenSize.width) * 0.5f, [self.sprite contentSize].height*self.sprite.scaleY + 5);
            directionCurrent = 1;
            directionBefore = -1;
        }
       
        //小猪
        else if (2 == familyType)
        {
            self.sprite = [CCSprite spriteWithSpriteFrameName:@"girlbird_3_1.png"];
            //按照像素设定图片大小
            //change size by diff version manual
            self.sprite.scaleX=(40)/[self.sprite contentSize].width; //按照像素定制图片宽高
            self.sprite.scaleY=(40)/[self.sprite contentSize].height;
            //        CCSprite * ground=[CCSprite spriteWithSpriteFrameName:@"ground.png"];
            //self.sprite = [CCSprite spriteWithFile:@"blocks.png"];
            //change size by diff version manual
            startPos = CGPointMake((screenSize.width) * 0.5f, [self.sprite contentSize].height*self.sprite.scaleY + 5);
            directionCurrent = -1;
            directionBefore = 1;
        }
        self.sprite.position=startPos;
        [self addChild:self.sprite]; 
        [self scheduleUpdate];
        isSmoke = NO;
        isPepper = NO;
        isIce = NO;
        isCrystal = NO;
        isSpeedfast = NO;
        speed = [GameMainScene sharedMainScene].mainscenParam.landAnimalSpeed;
        if (speed > 0.6) 
        {
            //加入加速特效
            CCParticleSystem* system;
            system = [ARCH_OPTIMAL_PARTICLE_SYSTEM particleWithFile:@"landspeedfast.plist"];
            system.positionType = kCCPositionTypeFree;
            system.autoRemoveOnFinish = YES;
            system.position = self.sprite.position;
            [self addChild:system z:1 tag:SpeedfastType];
            isSpeedfast = YES;

        }
        waitinterval = 0;
    }
    return self;
}

-(void)eatAction:(int)foodType
{
    waitinterval += 60;
    if (7 == foodType || 6 == foodType || 3 == foodType) 
    {
        [[GameMainScene sharedMainScene] playAudio:EatGood];
    }
    else if (4 == foodType)
    {
        //音效
        [[GameMainScene sharedMainScene] playAudio:Bombing];
    }
    else if (5 == foodType)
    {
        [[GameMainScene sharedMainScene] playAudio:EatBad];
    }
    else
    {
        [[GameMainScene sharedMainScene] playAudio:EatCandy];
    }
    CCAction* action = [CCBlink actionWithDuration:1 blinks:5];
    [self runAction:action];
}

-(int)checkforcollsion
{
    int direction=0;
    LandCandyCache *instanceOfLandCandyCache=[LandCandyCache sharedLandCandyCache];
    
    direction = [instanceOfLandCandyCache CheckforCandyCollision:self.sprite Type:LandAnimalTag Play:animalID];
    
    if (0 != direction) {
        return direction;
    }
    //没有吃到食物，方向没有改变
    else
    {
        return directionCurrent;
    }
    //return direction;
}

-(void)recoverSpeedForde: (ccTime) dt
{
    speed = [GameMainScene sharedMainScene].mainscenParam.landAnimalSpeed;
    [self unschedule:@selector(recoverSpeedForde:)];   
    //消除特效
    [self removeChildByTag:IceType cleanup:YES];
    isIce = NO;
}

-(void)recoverSpeedForIn: (ccTime) dt
{
    speed = [GameMainScene sharedMainScene].mainscenParam.landAnimalSpeed;
    [self unschedule:@selector(recoverSpeedForIn:)];   
    //消除特效
    [self removeChildByTag:PepperType cleanup:YES];
    isPepper = NO;
}

-(void)reduceCrystal: (ccTime) dt
{
    [self unschedule:@selector(reduceCrystal:)];   
    //消除特效
    [self removeChildByTag:CrystalType cleanup:YES];
    isCrystal = NO;
}

-(void)removeTheSomke: (ccTime) dt
{
    [self unschedule:@selector(cmd_)];   
    //消除特效
    [self removeChildByTag:SmokeType cleanup:YES];
    isSmoke = NO;
}



-(void)increaseSpeed
{
    [self unschedule:@selector(recoverSpeedForIn:)];   
    //消除特效
    [self removeChildByTag:PepperType cleanup:YES];
    isPepper = NO;
    
    speed = speed * 2;
    [self schedule:@selector(recoverSpeedForIn:) interval:10];
    //加入加速特效
    CCParticleSystem* system;
    system = [ARCH_OPTIMAL_PARTICLE_SYSTEM particleWithFile:@"land_poison.plist"];
    system.positionType = kCCPositionTypeFree;
    system.autoRemoveOnFinish = YES;
    system.position = self.sprite.position;
    [self addChild:system z:1 tag:PepperType];
    isPepper = YES;
}

-(void)decreaseSpeed
{
    [self unschedule:@selector(recoverSpeedForde:)];   
    //消除特效
    [self removeChildByTag:IceType cleanup:YES];
    isIce = NO;

    speed = speed / 2;
    [self schedule:@selector(recoverSpeedForde:) interval:10];
    //加入减速特效
    CCParticleSystem* system;
    system = [ARCH_OPTIMAL_PARTICLE_SYSTEM particleWithFile:@"land_ice.plist"];
    system.positionType = kCCPositionTypeFree;
    system.autoRemoveOnFinish = YES;
    system.position = self.sprite.position;
    [self addChild:system z:1 tag:IceType];
    isIce = YES;
}

-(void)getCrystal
{
    
    [self schedule:@selector(reduceCrystal:) interval:2];
    //加入水晶球特效
    CCParticleSystem* system;
    system = [ARCH_OPTIMAL_PARTICLE_SYSTEM particleWithFile:@"land_crystal.plist"];
    system.positionType = kCCPositionTypeGrouped;
    system.autoRemoveOnFinish = YES;
    system.position = self.sprite.position;
    [self addChild:system z:1 tag:CrystalType];
    isCrystal = YES;
}


-(void)bombed
{
    waitinterval += 180;
    //加入炸弹特效
    CCParticleSystem* system;
    system = [ARCH_OPTIMAL_PARTICLE_SYSTEM particleWithFile:@"land_bomb.plist"];
    system.positionType = kCCPositionTypeFree;
    system.autoRemoveOnFinish = YES;
    system.position = self.sprite.position;
    [self addChild:system];
}

-(void)reverseDirection
{
    directionBefore = directionCurrent;
    directionCurrent = -directionBefore;
    [self schedule:@selector(removeTheSomke:) interval:5];
    isSmoke = YES;
    CCParticleSystem* system;
    system = [ARCH_OPTIMAL_PARTICLE_SYSTEM particleWithFile:@"besmoked.plist"];
    system.positionType = kCCPositionTypeFree;
    system.autoRemoveOnFinish = YES;
    system.position = self.sprite.position;
    [self addChild:system z:1 tag:SmokeType];
}

-(void)update:(ccTime)delta
{
    if(waitinterval>0)
    {
        waitinterval--;
        return;
    }
    CGPoint pos=self.sprite.position;
    CGSize screenSize = [[CCDirector sharedDirector] winSize];
    float imageWidthHalved = [self.sprite contentSize].width * self.sprite.scaleX * 0.5f; 
    float leftBorderLimit = imageWidthHalved;
    float rightBorderLimit = screenSize.width - imageWidthHalved;
    
    if(pos.x>rightBorderLimit){
        directionCurrent = -1;
    }else if(pos.x<leftBorderLimit)
    {
        directionCurrent = 1;
    }else{
        directionCurrent = [self checkforcollsion];
    }
    
    //如果转向，则更改动画方向
    if (directionCurrent != directionBefore)
    {
        [self.sprite stopAction:_moveAction];
        if(directionCurrent == -1)
        {
            self.moveAction = [_landAnimalActionArray objectAtIndex:1];
        }
        else if (directionCurrent == 1)
        {
            self.moveAction = [_landAnimalActionArray objectAtIndex:0];

        }
        [self.sprite runAction:_moveAction];
        directionBefore = directionCurrent;
    }
    
    pos.x+=directionCurrent*speed;
    self.sprite.position=pos;
    //同步自身位置，供特效实用
    if (isPepper) 
    {
        CCNode* node = [self getChildByTag:PepperType];
        node.position = pos;
    }
    if (isIce) 
    {
        CCNode* node = [self getChildByTag:IceType];
        node.position = pos;

    }
    if (isCrystal) 
    {
        CCNode* node = [self getChildByTag:CrystalType];
        node.position = pos;
        
    }
    if (isSpeedfast) 
    {
        CCNode* node = [self getChildByTag:SpeedfastType];
        node.position = pos;
    }
    if (isSmoke) 
    {
        CCNode* node = [self getChildByTag:SmokeType];
        node.position = pos;
        
    }
    return;
}

-(void)setCurDirection
{
    if (isSmoke) 
    {
        return;
    }
    
    LandCandyCache *instanceOfLandCandyCache=[LandCandyCache sharedLandCandyCache];
    int dirction = 0;
    
    dirction = [instanceOfLandCandyCache getCurDirection:self.sprite];
    if (0 != dirction)
    {
        directionCurrent = dirction;
    }
}

@end