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

@implementation LandAnimal

@synthesize sprite = _sprite;

+(id)CreateLandAnimal
{
	return [[[self alloc] init] autorelease];
}

static LandAnimal *instanceOfLandAnimal;
+(LandAnimal *)sharedLandAnimal
{
    NSAssert(nil != instanceOfLandAnimal, @"BodyObjectsLayer instance not yet initialized!");
    
    return instanceOfLandAnimal;
}

-(id)init
{
    if ((self = [super init]))
	{
        instanceOfLandAnimal = self;
        CGSize screenSize = [[CCDirector sharedDirector] winSize];
        self.sprite = [CCSprite spriteWithSpriteFrameName:@"bird-wife.png"];
        //按照像素设定图片大小
        self.sprite.scaleX=(40)/[self.sprite contentSize].width; //按照像素定制图片宽高
        self.sprite.scaleY=(40)/[self.sprite contentSize].height;
//        CCSprite * ground=[CCSprite spriteWithSpriteFrameName:@"ground.png"];
        //self.sprite = [CCSprite spriteWithFile:@"blocks.png"];
        CGPoint startPos = CGPointMake((screenSize.width) * 0.5f, [self.sprite contentSize].height*self.sprite.scaleY + 5);
        self.sprite.position=startPos;
        [self addChild:self.sprite]; 
        [self scheduleUpdate];
        direction=1;
        speed=0.5f;
        waitinterval=0;
    }
    return self;
}

-(void)eatAction
{
    waitinterval = 60;
    CCAction* action = [CCBlink actionWithDuration:1 blinks:5];
    [self runAction:action];
}

-(int)checkforcollsion
{
    //int direction=0;
    LandCandyCache *instanceOfLandCandyCache=[LandCandyCache sharedLandCandyCache];
    return [instanceOfLandCandyCache CheckforCandyCollision:self.sprite Type:LandAnimalTag];
    //return direction;
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
    float rightBorderLimit = screenSize.width - imageWidthHalved - 30;
    
    if(pos.x>rightBorderLimit){
        direction=-1;
    }else if(pos.x<leftBorderLimit)
    {
        direction=1;
    }else{
        direction=[self checkforcollsion];
    }
    
    if(direction==-1){
        self.sprite.flipX=YES;
    }else if (direction==1){
        self.sprite.flipX=NO;
    }
    pos.x+=direction*0.5;
    self.sprite.position=pos;
    
    return;
}


@end