//
//  LandCandyEntity.m
//  GreedFamily
//
//  Created by MagicStudio on 12-5-19.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import "LandCandyEntity.h"
#import "CandyEntity.h"
#import "LandCandyCache.h"
#import "GameBackgroundLayer.h"
@interface LandCandyEntity (PrivateMethods)
-(id)initLandCandy:(int)balltype Pos:(CGPoint)pos BodyVelocity:(CGPoint)bodyVelocity;
@end

@implementation LandCandyEntity

@synthesize sprite = _sprite;
@synthesize ballType = _ballType;
@synthesize candyPosition = _candyPosition;
@synthesize candyVelocity = _candyVelocity;
@synthesize isDowning = _isDowning;
+(id)CreateLandCandyEntity:(int)balltype Pos:(CGPoint)position BodyVelocity:(CGPoint)bodyVelocity
{

    return [[[self alloc] initLandCandy:balltype Pos:position BodyVelocity:bodyVelocity] autorelease];
}

-(id)chooseBall:(int)balltype
{
    NSString *spriteName=nil;
    switch (balltype) {
        case BallTypeRandomBall:
            spriteName=@"puding2.png";
            break;
        case BallTypeKillerBall:
            spriteName=@"chocolate.png";
            break;
        case BallTypeBalloom:
            spriteName=@"cake3.png";
            break;
        case 3:
            spriteName=@"pic_4.png";
            break;
        case 4:
            spriteName=@"pic_1.png";
            break;
        case 5:
            spriteName=@"pic_6.png";
            break;
        default:
            break;
    }
    return spriteName;
}

-(id)initLandCandy:(int)balltype Pos:(CGPoint)pos BodyVelocity:(CGPoint)bodyVelocity
{
    if ((self = [super init]))
	{
        self.ballType = balltype;
        self.candyVelocity = pos;
        NSString * spriteName = [self chooseBall:(balltype)];
//        self.sprite = [CCSprite spriteWithSpriteFrameName:spriteName];
//        self.sprite.position = pos;
//        [self addChild:self.sprite];
        
        CCSpriteBatchNode* batch = [[GameBackgroundLayer sharedGameBackgroundLayer] getSpriteBatch];
        self.sprite = [CCSprite spriteWithSpriteFrameName:spriteName];
        [batch addChild:self.sprite];
        self.sprite.position = pos;
        
        self.candyVelocity =  CGPointMake(bodyVelocity.x/100, -1);
        _isDowning = YES;
        //让球往下运动
        [self scheduleUpdate];
    }
    return self; 
}

-(void)update:(ccTime)delta
{
    if (!_isDowning)
    {
        return;
    }


    CGSize screenSize = [[CCDirector sharedDirector] winSize];
    float imageWidthHalved = [self.sprite contentSize].width * 0.5f; 
    float leftBorderLimit = imageWidthHalved;
    float rightBorderLimit = screenSize.width - imageWidthHalved - 30;
    CGPoint pos = ccpAdd(self.sprite.position, self.candyVelocity);  
    if(pos.x>rightBorderLimit){
        pos.x = rightBorderLimit;
        //self.candyVelocity.x = -self.candyVelocity.x;
        self.candyVelocity = CGPointMake(-self.candyVelocity.x, self.candyVelocity.y);
    }else if(pos.x<leftBorderLimit)
    {
        pos.x = leftBorderLimit;
        //self.candyVelocity.x = -self.candyVelocity.x;
        self.candyVelocity = CGPointMake(-self.candyVelocity.x, self.candyVelocity.y);
    }
    
    self.sprite.position = pos;
    
    if (self.sprite.position.y <=  55) 
    {
        LandCandyCache *landCandyCache = [LandCandyCache sharedLandCandyCache];
        [landCandyCache addToLandCandies:self];
        self.isDowning = NO;
    }
}

-(void) dealloc
{
    CCLOG(@"我靠，被释放了！");
	[super dealloc];
}
@end
