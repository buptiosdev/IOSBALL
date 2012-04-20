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
#import "FlyEntity.h"
#import "SimpleAudioEngine.h"
#import "GameMainScene.h"


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
        [[SimpleAudioEngine sharedEngine] playEffect:@"hit.caf"];
        
        bodyEntityA.sprite.color = ccMAGENTA; 
        bodyEntityB.sprite.color = ccMAGENTA;
        bodyEntityA.hitPoints--;
        bodyEntityB.hitPoints--;
        
        if (0 >= bodyEntityA.hitPoints) {
            bodyEntityB.hitPoints += bodyEntityA.initialHitPoints;
            bodyEntityB.initialHitPoints += bodyEntityA.initialHitPoints;
            //bodyEntityA.sprite.visible = NO;
            //CGPoint positionNew = CGPointMake(-100, -100);
            //bodyEntityA.body->SetTransform([Helper toMeters:positionNew], 0);
        }
        if (0 >= bodyEntityB.hitPoints) {
            bodyEntityA.hitPoints += bodyEntityB.initialHitPoints;
            bodyEntityA.initialHitPoints += bodyEntityB.initialHitPoints;
            //bodyEntityB.sprite.visible = NO;
            //CGPoint positionNew = CGPointMake(-100, -100);
            //bodyEntityB.body->SetTransform([Helper toMeters:positionNew], 0);
            
        }
    }
}

void ContactListener::EndContact(b2Contact* contact) 
{
	b2Body* bodyA = contact->GetFixtureA()->GetBody();
	b2Body* bodyB = contact->GetFixtureB()->GetBody();
	Entity* bodyEntityA = (Entity*)bodyA->GetUserData();
	Entity* bodyEntityB = (Entity*)bodyB->GetUserData();
    
    if (1 == bodyEntityA.hitPoints)
    {
        bodyEntityA.sprite.color = ccRED;
        //mybody(bodyA,1);
        
        //        //添加碰撞粒子效果
        //        CCParticleSystem* system;
        //        system = [ARCH_OPTIMAL_PARTICLE_SYSTEM particleWithFile:@"fx-explosion2.plist"];
        //        // Set some parameters that can't be set in Particle Designer
        //        
        //        system.positionType = kCCPositionTypeFree;
        //        system.autoRemoveOnFinish = YES;
        //        
        //        //system.position = bodyEntityA.position;
        //        
        //        //system.position = [Helper toPixels:bodyEntityA.position];
        //        
        //        system.position = [Helper toPixels:bodyA->GetPosition()];
        //        
        //        //system.position = [Helper toPixels:bodyEntityB.position];
        //        // Add the particle effect to the GameScene, for these reasons:
        //        // - self is a sprite added to a spritebatch and will only allow CCSprite nodes (it crashes if you try)
        //        // - self is now invisible which might affect rendering of the particle effect
        //        // - since the particle effects are short lived, there is no harm done by adding them directly to the GameScene
        //        //[[GameScene sharedGameScene] addChild:system];                    
        //        
        //        [[MainScene sharedMainScene] addChild:system];             
        
        
        
        
        
        
    }
    else if (2 == bodyEntityA.hitPoints)
    {
        //mybody(bodyA,1);
        bodyEntityA.sprite.color = ccORANGE;
    }
    else if (3 == bodyEntityA.hitPoints)
    {
        //mybody(bodyA,1);        
        bodyEntityA.sprite.color = ccYELLOW;
    }
    else if (4 == bodyEntityA.hitPoints)
    {
        //mybody(bodyA,1);        
        bodyEntityA.sprite.color = ccGREEN;
    }
    else
    {
        //mybody(bodyA,2);        
        bodyEntityA.sprite.color = ccWHITE;   
    }
    
    
    if (1 == bodyEntityB.hitPoints)
    {
        //mybody(bodyB,1);        
        //        //添加碰撞粒子效果
        //        CCParticleSystem* system;
        //        system = [ARCH_OPTIMAL_PARTICLE_SYSTEM particleWithFile:@"fx-explosion.plist"];
        //        // Set some parameters that can't be set in Particle Designer
        //        
        //        system.positionType = kCCPositionTypeFree;
        //        system.autoRemoveOnFinish = YES;
        //        
        //        //system.position = bodyEntityA.position;
        //        
        //        //system.position = [Helper toPixels:bodyEntityA.position];
        //        
        //        system.position = [Helper toPixels:bodyB->GetPosition()];
        //        
        //        //system.position = [Helper toPixels:bodyEntityB.position];
        //        // Add the particle effect to the GameScene, for these reasons:
        //        // - self is a sprite added to a spritebatch and will only allow CCSprite nodes (it crashes if you try)
        //        // - self is now invisible which might affect rendering of the particle effect
        //        // - since the particle effects are short lived, there is no harm done by adding them directly to the GameScene
        //        //[[GameScene sharedGameScene] addChild:system];                    
        //        
        //        [[MainScene sharedMainScene] addChild:system];             
        
        
        
        bodyEntityB.sprite.color = ccRED;
    }
    else if (2 == bodyEntityB.hitPoints)
    {
        //mybody(bodyB,2);                
        bodyEntityB.sprite.color = ccORANGE;
    }
    else if (3 == bodyEntityB.hitPoints)
    {
        //mybody(bodyB,1);                
        bodyEntityB.sprite.color = ccYELLOW;
    }
    else if (4 == bodyEntityB.hitPoints)
    {
        //mybody(bodyB,1);                
        bodyEntityB.sprite.color = ccGREEN;
    }
    else
    {
        //mybody(bodyB,1);                
        bodyEntityB.sprite.color = ccWHITE;   
    }
    
    //    if (bodyEntityA != NULL && bodyEntityB != NULL) 
    //    {
    //        bodyEntityA.sprite.color = ccWHITE; 
    //        bodyEntityB.sprite.color = ccWHITE;
    //    }
    
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





