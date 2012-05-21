//
//  LandCandyEntity.m
//  GreedFamily
//
//  Created by MagicStudio on 12-5-19.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import "LandCandyEntity.h"
#import "CandyEntity.h"
@interface LandCandyEntity (PrivateMethods)
-(id)initLandCandy:(int)balltype Pos:(CGPoint)pos;
@end

@implementation LandCandyEntity

@synthesize sprite = _sprite;
@synthesize Balltype = _Balltype;
@synthesize position = _position;
+(id)CreateLandCandyEntity:(int)balltype Pos:(CGPoint)position
{
    return [[[self alloc] initLandCandy:balltype Pos:position] autorelease];
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
        default:
            break;
    }
    return spriteName;
}

-(id)initLandCandy:(int)balltype Pos:(CGPoint)pos
{
    if ((self = [super init]))
	{
        Balltype=balltype;
        position=pos;
        NSString * spriteName=[self chooseBall:(balltype)];
        self.sprite = [CCSprite spriteWithSpriteFrameName:spriteName];
        self.sprite.position=pos;
        [self addChild:self.sprite];
    }
    return self;
}


@end
