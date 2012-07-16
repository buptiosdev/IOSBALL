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
        self.sprite.scaleX=(50)/[self.sprite contentSize].width; //按照像素定制图片宽高
        self.sprite.scaleY=(50)/[self.sprite contentSize].height;
        //CCSprite * ground=[CCSprite spriteWithSpriteFrameName:@"ground.png"];
        //self.sprite = [CCSprite spriteWithFile:@"blocks.png"];
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
    waitinterval = +60;
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

-(void)recoverSpeed: (ccTime) dt
{
    speed = [GameMainScene sharedMainScene].mainscenParam.landAnimalSpeed;
    [self unschedule:@selector(recoverSpeed:)];   
}

//加速
-(void)decreaseSpeed
{
    speed = speed / 2;
    [self schedule:@selector(recoverSpeed:) interval:10];
    //加入加速特效
}

-(void)bombed
{
    waitinterval += 180;
    //加入炸弹特效
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
    return;
}
@end
