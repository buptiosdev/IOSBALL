//
//  ContactListener.m
//  GreedFamily
//
//  Created by 赵 苹果 on 12-4-20.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

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
#import "CandyEntity.h"
#import "PropertyEntity.h"
#import "FlyEntity.h"
#import "GameMainScene.h"
#import "CommonLayer.h"

void ContactListener::BeginContact(b2Contact* contact)
{
	b2Body* bodyA = contact->GetFixtureA()->GetBody();
	b2Body* bodyB = contact->GetFixtureB()->GetBody();
	Entity* bodyEntityA = (Entity*)bodyA->GetUserData();
	Entity* bodyEntityB = (Entity*)bodyB->GetUserData();
	
    //if ([bodyEntityA isKindOfClass:[Bumper class]] || [bodyEntityB isKindOfClass:[Bumper class]])
    //    return;
    
	if (bodyEntityA != NULL && bodyEntityB != NULL) 
    {

        if ([bodyEntityA isKindOfClass:[FlyEntity class]])
        {

            if (![bodyEntityB isKindOfClass:[FlyEntity class]])
            {
                bodyEntityB.hitPoints--;
                if(0 == bodyEntityB.hitPoints)
                {
                    [CommonLayer playAudio:BubbleBreak];
                }
                else
                {
                    [CommonLayer playAudio:BubbleHit];
                }
                
            }
            else
            {
                //对手相碰的音效
                [CommonLayer playAudio:BubbleHit];
            }

        }
             
        else if ([bodyEntityB isKindOfClass:[FlyEntity class]]) 
        {
            
            if (![bodyEntityA isKindOfClass:[FlyEntity class]])
            {
                bodyEntityA.hitPoints--;
                if(0 == bodyEntityA.hitPoints)
                {
                    [CommonLayer playAudio:BubbleBreak];
                }
                else
                {
                    [CommonLayer playAudio:BubbleHit];
                }
            }
            

        }

        
        
        if (0 >= bodyEntityA.hitPoints 
            && ([bodyEntityA isKindOfClass:[CandyEntity class]]|| [bodyEntityA isKindOfClass:[PropertyEntity class]])) 
        {
            if ([bodyEntityB isKindOfClass:[FlyEntity class]])
            {
                bodyEntityA.otherLineSpeed = [Helper toPixels:bodyEntityB.body->GetLinearVelocity()];
                bodyEntityA.flyFamilyType = ((FlyEntity *)bodyEntityB).familyType;
                
            }
        }
        if (0 >= bodyEntityB.hitPoints 
            && ([bodyEntityB isKindOfClass:[CandyEntity class]] || [bodyEntityB isKindOfClass:[PropertyEntity class]])) {
            if ([bodyEntityA isKindOfClass:[FlyEntity class]])
            {
                bodyEntityB.otherLineSpeed = [Helper toPixels:bodyEntityA.body->GetLinearVelocity()];
                bodyEntityB.flyFamilyType = ((FlyEntity *)bodyEntityA).familyType;
            }
        }
    }
}

void ContactListener::EndContact(b2Contact* contact) 
{
//	b2Body* bodyA = contact->GetFixtureA()->GetBody();
//	b2Body* bodyB = contact->GetFixtureB()->GetBody();
//    
//	Entity* bodyEntityA = (Entity*)bodyA->GetUserData();
//	Entity* bodyEntityB = (Entity*)bodyB->GetUserData();
//    

    
}

void ContactListener::PreSolve(b2Contact* contact, const b2Manifold* oldManifold)
{
}

void ContactListener::PostSolve(b2Contact* contact, const b2ContactImpulse* impulse)
{
}

/*void ContactListener::mybody(b2Body* mybodytype,int flag)
{
    //添加碰撞粒子效果
    CCParticleSystem* system;
    
    
    if (flag==1) {
        system = [ARCH_OPTIMAL_PARTICLE_SYSTEM particleWithFile:@"fx-explosion.plist"];
    }
    else {
        system = [ARCH_OPTIMAL_PARTICLE_SYSTEM particleWithFile:@"fx-explosion2.plist"];    
    }    
    // Set some parameters that can't be set in Particle Designer
    
    system.positionType = kCCPositionTypeFree;
    system.autoRemoveOnFinish = YES;
    
    //system.position = bodyEntityA.position;
    
    //system.position = [Helper toPixels:bodyEntityA.position];
    
    system.position = [Helper toPixels:mybodytype->GetPosition()];
    
    //system.position = [Helper toPixels:bodyEntityB.position];
    // Add the particle effect to the GameScene, for these reasons:
    // - self is a sprite added to a spritebatch and will only allow CCSprite nodes (it crashes if you try)
    // - self is now invisible which might affect rendering of the particle effect
    // - since the particle effects are short lived, there is no harm done by adding them directly to the GameScene
    //[[GameScene sharedGameScene] addChild:system];                    
    
    [[GameMainScene sharedMainScene] addChild:system];      
    
    
}*/





