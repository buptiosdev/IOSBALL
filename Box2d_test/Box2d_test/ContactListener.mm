//
//  ContactListener.m
//  Box2d_test
//
//  Created by 赵 苹果 on 12-3-21.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import "ContactListener.h"

#import "ContactListener.h"
#import "Entity.h"
#import "EnemyEntity.h"
#import "ShipEntity.h"
#import "Bumper.h"

void ContactListener::BeginContact(b2Contact* contact)
{
	b2Body* bodyA = contact->GetFixtureA()->GetBody();
	b2Body* bodyB = contact->GetFixtureB()->GetBody();
	Entity* bodyEntityA = (Entity*)bodyA->GetUserData();
	Entity* bodyEntityB = (Entity*)bodyB->GetUserData();
	
    if ([bodyEntityA isKindOfClass:[Bumper class]] || [bodyEntityB isKindOfClass:[Bumper class]])
        return;

    
	if (bodyEntityA != NULL && bodyEntityB != NULL) 
    {
        bodyEntityA.sprite.color = ccMAGENTA; 
        bodyEntityB.sprite.color = ccMAGENTA;
        bodyEntityA.hitPoints--;
        bodyEntityB.hitPoints--;
        
        if (0 >= bodyEntityA.hitPoints) {
            bodyEntityB.hitPoints += bodyEntityA.initialHitPoints;
            bodyEntityB.initialHitPoints += bodyEntityA.initialHitPoints;
        }
        if (0 >= bodyEntityB.hitPoints) {
            bodyEntityA.hitPoints += bodyEntityB.initialHitPoints;
            bodyEntityA.initialHitPoints += bodyEntityB.initialHitPoints;
        }
    }
}

void ContactListener::EndContact(b2Contact* contact) 
{
	b2Body* bodyA = contact->GetFixtureA()->GetBody();
	b2Body* bodyB = contact->GetFixtureB()->GetBody();
	Entity* bodyEntityA = (Entity*)bodyA->GetUserData();
	Entity* bodyEntityB = (Entity*)bodyB->GetUserData();
    
    if (bodyEntityA != NULL && bodyEntityB != NULL) 
    {
        bodyEntityA.sprite.color = ccWHITE; 
        bodyEntityB.sprite.color = ccWHITE;
    }
}

void ContactListener::PreSolve(b2Contact* contact, const b2Manifold* oldManifold)
{
}

void ContactListener::PostSolve(b2Contact* contact, const b2ContactImpulse* impulse)
{
}

