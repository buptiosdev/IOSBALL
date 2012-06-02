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

@implementation Competitor
@synthesize sprite = _sprite;
+(id)CreateCompetitor
{
	return [[[self alloc] init] autorelease];
}

-(id)init
{
    if ((self = [super init]))
	{
        CGSize screenSize = [[CCDirector sharedDirector] winSize];
        self.sprite = [CCSprite spriteWithSpriteFrameName:@"bear.png"];
        CCSprite * ground=[CCSprite spriteWithSpriteFrameName:@"ground.png"];
        //self.sprite = [CCSprite spriteWithFile:@"blocks.png"];
        CGPoint startPos = CGPointMake((screenSize.width) * 0.8f, [ground contentSize].height + [self.sprite contentSize].height );
        self.sprite.position=startPos;
        [self addChild:self.sprite]; 
        [self scheduleUpdate];
        direction=-1;
    }
    return self;
}

-(int)checkforcollsion
{
    //int direction=0;
    LandCandyCache *instanceOfLandCandyCache=[LandCandyCache sharedLandCandyCache];
    return [instanceOfLandCandyCache CheckforCandyCollision:self.sprite Type:CompetitorTag];
    //return direction;
}

-(void)update:(ccTime)delta
{
    CGPoint pos=self.sprite.position;
    CGSize screenSize = [[CCDirector sharedDirector] winSize];
    float imageWidthHalved = [self.sprite contentSize].width * 0.5f; 
    float leftBorderLimit = imageWidthHalved;
    float rightBorderLimit = screenSize.width - imageWidthHalved - 30;
    
    if(pos.x>rightBorderLimit){
        direction=-1;
    }else if(pos.x<leftBorderLimit)
    {
        direction=1;
    }
    if(direction==-1){
        self.sprite.flipX=YES;
    }else if (direction==1){
        self.sprite.flipX=NO;
    }
    pos.x+=direction*0.6;
    self.sprite.position=pos;
    [self checkforcollsion];
}
@end
