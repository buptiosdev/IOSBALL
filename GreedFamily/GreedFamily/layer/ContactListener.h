//
//  ContactListener.h
//  GreedFamily
//
//  Created by 赵 苹果 on 12-4-20.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//
#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "Box2D.h"

class ContactListener : public b2ContactListener 
{
private:
    void BeginContact(b2Contact* contact); 
    void EndContact(b2Contact* contact);
    void PreSolve(b2Contact* contact, const b2Manifold* oldManifold);
	void PostSolve(b2Contact* contact, const b2ContactImpulse* impulse);
    void mybody(b2Body* mybodytype,int flag);
    
};
