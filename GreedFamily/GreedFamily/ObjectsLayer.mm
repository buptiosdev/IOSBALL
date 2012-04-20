//
//  ObjectLayer.m
//  GreedFamily
//
//  Created by 赵 苹果 on 12-4-19.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import "ObjectsLayer.h"
#import "BodyObjectsLayer.h"
#import "NoBodyObjectsLayer.h"

@implementation ObjectsLayer

+(id)CreateObjectsLayer
{
	return [[[self alloc] init] autorelease];
}

-(id)init
{
    BodyObjectsLayer *bodyObjectsLayer = [BodyObjectsLayer CreateBodyObjectsLayer];
    [self addChild:bodyObjectsLayer z:1 tag:BodyObjectsLayerTag];
    
    NoBodyObjectsLayer *noBodyObjectsLayer = [NoBodyObjectsLayer CreateNoBodyObjectsLayer];
    [self addChild:noBodyObjectsLayer z:1 tag:NoBodyObjectsLayerTag];
    
    return self;
}

@end
