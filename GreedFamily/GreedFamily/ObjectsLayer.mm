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
/*创造一个半单例，让其他类可以很方便访问scene*/
static ObjectsLayer *instanceOfObjectsLayer;
+(ObjectsLayer *)sharedObjectsLayer
{
    NSAssert(nil != instanceOfObjectsLayer, @"ObjectsLayer instance not yet initialized!");
    
    return instanceOfObjectsLayer;
}

+(id)CreateObjectsLayer
{
	return [[[self alloc] init] autorelease];
}

-(id)init
{
    if ((self = [super init]))
    {
        instanceOfObjectsLayer = self;
        
        BodyObjectsLayer *bodyObjectsLayer = [BodyObjectsLayer CreateBodyObjectsLayer];
        [self addChild:bodyObjectsLayer z:1 tag:BodyObjectsLayerTag];
        
        NoBodyObjectsLayer *noBodyObjectsLayer = [NoBodyObjectsLayer CreateNoBodyObjectsLayer];
        [self addChild:noBodyObjectsLayer z:1 tag:NoBodyObjectsLayerTag];
    }
    return self;
}

-(BOOL)isGameFinish
{
    if ([[BodyObjectsLayer sharedBodyObjectsLayer] getCandyCache].isFinish) 
    {
        if (0 >= [[BodyObjectsLayer sharedBodyObjectsLayer] getCandyCache].aliveCandy) 
        {
            if (0 >= [[NoBodyObjectsLayer sharedNoBodyObjectsLayer] getLandCandyCache].landnum) 
            {
                return YES;
            }
        }
    }
    
    return NO;
}

-(void) dealloc
{
	[super dealloc];
     
}

@end
