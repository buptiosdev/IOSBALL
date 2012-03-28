//
//  StaticTable.h
//  PhysicsBox2d
//
//  Created by Steffen Itterheim on 22.09.10.
//  Copyright 2010 Steffen Itterheim. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "Box2D.h"
#import "ShipEntity.h"

@interface TableSetup : CCNode
{
	b2World* world_;
    CCSpriteBatchNode* batch;
    CGSize screenSize;
}

+(id) setupTableWithWorld:(b2World*)world Order:(int)order;
-(ShipEntity*) defaultShip;
+(CGRect) screenRect;
+(TableSetup *)sharedTable;
@end
