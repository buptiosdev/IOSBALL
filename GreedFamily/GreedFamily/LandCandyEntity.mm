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
#import "CCAnimationHelper.h"

@interface LandCandyEntity (PrivateMethods)
-(id)initLandCandy:(int)balltype Pos:(CGPoint)pos BodyVelocity:(CGPoint)bodyVelocity;
@end

@implementation LandCandyEntity

@synthesize sprite = _sprite;
@synthesize ballType = _ballType;
@synthesize candyPosition = _candyPosition;
@synthesize candyVelocity = _candyVelocity;
@synthesize isDowning = _isDowning;
@synthesize landCandyActionArray = _landCandyActionArray;
@synthesize fallAction = _fallAction;

+(id)CreateLandCandyEntity:(int)balltype Pos:(CGPoint)position BodyVelocity:(CGPoint)bodyVelocity
{

    return [[[self alloc] initLandCandy:balltype Pos:position BodyVelocity:bodyVelocity] autorelease];
}

-(id)chooseBall:(int)balltype
{
    NSString *spriteName=nil;
    switch (balltype) {
        case BallTypeRandomBall:
            spriteName=@"apple-_1.png";
            break;
        case BallTypeKillerBall:
            spriteName=@"cheese-_1.png";
            break;
        case BallTypeBalloom:
            spriteName=@"candy-_1.png";
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

-(void)initFallAction
{        
    
    _landCandyActionArray = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < 3; i++) {
        
        CCAnimation* animation = nil;
        switch (i) {
            case 0:
                animation = [CCAnimation animationWithFrame:@"apple-_" frameCount:5 delay:0.3f];
                break;
            case 1:
                animation = [CCAnimation animationWithFrame:@"candy-_" frameCount:2 delay:0.5f];
                break;
            case 2:
                animation = [CCAnimation animationWithFrame:@"cheese-_" frameCount:2 delay:0.5f];
                break;
                
            default:
                break;
        }
        
        
        CCAnimate *animate = [CCAnimate actionWithAnimation:animation restoreOriginalFrame:NO];
        CCSequence *seq = [CCSequence actions: animate,
                           nil];
        
        self.fallAction = [CCRepeatForever actionWithAction: seq ];
        [_landCandyActionArray addObject:self.fallAction];
        
    }
}

-(id)initLandCandy:(int)balltype Pos:(CGPoint)pos BodyVelocity:(CGPoint)bodyVelocity
{
    if ((self = [super init]))
	{
        //初始动画
        [self initFallAction];
        self.ballType = balltype;
        self.candyVelocity = pos;
        NSString * spriteName = [self chooseBall:(balltype)];
//        self.sprite = [CCSprite spriteWithSpriteFrameName:spriteName];
//        self.sprite.position = pos;
//        [self addChild:self.sprite];
        
        CCSpriteBatchNode* batch = [[GameBackgroundLayer sharedGameBackgroundLayer] getAnimationBatch];
        self.sprite = [CCSprite spriteWithSpriteFrameName:spriteName];

        //按照像素设定图片大小
        self.sprite.scaleX=(30)/[self.sprite contentSize].width; //按照像素定制图片宽高
        self.sprite.scaleY=(30)/[self.sprite contentSize].height;
        [batch addChild:self.sprite];
        self.sprite.position = pos;
        
        self.candyVelocity =  CGPointMake(bodyVelocity.x/100, -1);
        _isDowning = YES;
        
        //动画
        if (_ballType < 3)
        {
            [self.sprite stopAction:_fallAction];
            self.fallAction = [_landCandyActionArray objectAtIndex:_ballType];
            [self.sprite runAction:_fallAction];
        }
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
    float imageWidthHalved = [self.sprite contentSize].width * self.sprite.scaleX * 0.5f; 
    float leftBorderLimit = imageWidthHalved;
    float rightBorderLimit = screenSize.width - imageWidthHalved;
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
    
    if (self.sprite.position.y <=  35) 
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
