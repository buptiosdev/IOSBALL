//
//  CompetitorSprite.m
//  GreedFamily
//
//  Created by 赵 苹果 on 12-4-19.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import "Competitor.h"
#import "LandCandyCache.h"
#import "NoBodyObjectsLayer.h"
#import "GameMainScene.h"
#import "CCAnimationHelper.h"

@implementation Competitor

@synthesize sprite = _sprite;
@synthesize landCompetitorActionArray = _landCompetitorActionArray;
@synthesize  moveAction = _moveAction;

+(id)CreateCompetitor
{
	return [[[self alloc] init] autorelease];
}
static Competitor *instanceOfCompetitor;
+(Competitor *)sharedCompetitor
{
    NSAssert(nil != instanceOfCompetitor, @"BodyObjectsLayer instance not yet initialized!");
    
    return instanceOfCompetitor;
}

-(void)initMoveAction
{        
    
    _landCompetitorActionArray = [[NSMutableArray alloc] init];
    
    for (int i =0; i <2; i++) {
        
        CCAnimation* animation = nil;
        switch (i) {
            case 0:
                animation = [CCAnimation animationWithFrame:@"snake_3_" frameCount:4 delay:0.2f];
                break;
            case 1:
                animation = [CCAnimation animationWithFrame:@"snake_9_" frameCount:4 delay:0.2f];
                break;
                
            default:
                break;
        }
        
        
        CCAnimate *animate = [CCAnimate actionWithAnimation:animation restoreOriginalFrame:NO];
        CCSequence *seq = [CCSequence actions: animate,
                           nil];
        
        self.moveAction = [CCRepeatForever actionWithAction: seq ];
        [_landCompetitorActionArray addObject:self.moveAction];
        
    }
    
    
}

-(id)init
{
    if ((self = [super init]))
	{
        instanceOfCompetitor=self;
        //初始动画
        [self initMoveAction];
        CGSize screenSize = [[CCDirector sharedDirector] winSize];
        self.sprite = [CCSprite spriteWithSpriteFrameName:@"snake_9_1.png"];
        //按照像素设定图片大小
        //change size by diff version manual
        self.sprite.scaleX=(50)/[self.sprite contentSize].width; //按照像素定制图片宽高
        self.sprite.scaleY=(50)/[self.sprite contentSize].height;
        //CCSprite * ground=[CCSprite spriteWithSpriteFrameName:@"ground.png"];
        //self.sprite = [CCSprite spriteWithFile:@"blocks.png"];
        //change size by diff version query
        CGPoint startPos = CGPointMake((screenSize.width) * 0.8f, [self.sprite contentSize].height * self.sprite.scaleY);
        self.sprite.position = startPos;
        [self addChild:self.sprite]; 
        [self scheduleUpdate];
        //CCAction* action = [CCBlink actionWithDuration:1 blinks:3];
        //[self runAction:action];
        directionCurrent = -1;
        directionBefore = 1;
        speed = [GameMainScene sharedMainScene].mainscenParam.landCompetSpeed;
        waitinterval=0;
    }
    return self;
}

-(void)eatAction
{
    waitinterval += 60;
    CCAction* action = [CCBlink actionWithDuration:1 blinks:3];
    [self runAction:action];
}

-(int)checkforcollsion
{
    //int direction=0;
    LandCandyCache *instanceOfLandCandyCache=[LandCandyCache sharedLandCandyCache];
    return [instanceOfLandCandyCache CheckforCandyCollision:self.sprite Type:CompetitorTag];
    //return direction;
}

-(void)recoverSpeedForde: (ccTime) dt
{
    speed = [GameMainScene sharedMainScene].mainscenParam.landCompetSpeed;
    [self unschedule:@selector(recoverSpeedForde:)];   
    //消除特效
    [self removeChildByTag:IceType cleanup:YES];
    isIce = NO;
}

-(void)recoverSpeedForIn: (ccTime) dt
{
    speed = [GameMainScene sharedMainScene].mainscenParam.landCompetSpeed;
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
    }
    
    //如果转向，则更改动画方向
    if (directionCurrent != directionBefore)
    {
        [self.sprite stopAction:_moveAction];
        if(directionCurrent == -1)
        {
            self.moveAction = [_landCompetitorActionArray objectAtIndex:1];
        }
        else if (directionCurrent == 1)
        {
            self.moveAction = [_landCompetitorActionArray objectAtIndex:0];
            
        }
        [self.sprite runAction:_moveAction];
        directionBefore = directionCurrent;
    }
    
    pos.x+=directionCurrent*speed;
    self.sprite.position=pos;
    [self checkforcollsion];
    
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
    return;
}

-(void)reverseDirection
{
    directionBefore = directionCurrent;
    directionCurrent = -directionBefore;
}
@end
