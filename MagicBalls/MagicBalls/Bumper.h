//
//  Bumper.h
//  PhysicsBox2d
//
//  Created by Steffen Itterheim on 22.09.10.
//  Copyright 2010 Steffen Itterheim. All rights reserved.
//

#import "Entity.h"

@interface Bumper : Entity
{
}

+(id) bumperWithWorld:(b2World*)world position:(CGPoint)pos;

@end
