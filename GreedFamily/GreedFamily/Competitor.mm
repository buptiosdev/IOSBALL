//
//  CompetitorSprite.m
//  GreedFamily
//
//  Created by 赵 苹果 on 12-4-19.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import "Competitor.h"


@implementation Competitor
@synthesize sprite = _sprite;
+(id)CreateCompetitor
{
	return [[[self alloc] init] autorelease];
}
@end
