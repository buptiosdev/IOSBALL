//
//  ShipEntity.m
//  ShootEmUp
//
//  Created by Steffen Itterheim on 18.08.10.
//  Copyright 2010 Steffen Itterheim. All rights reserved.
//

#import "ShipEntity.h"
#import "CCAnimationHelper.h"
#import "MainScene.h"
#import "TableSetup.h"
#import "HealthbarComponent.h"

@interface ShipEntity (PrivateMethods)
-(id) initWithShipImage;
-(void)createBallInWorld:(b2World*)world;
-(id)initWithWorldTmp:(b2World *)world;
@end

@implementation ShipEntity

+(id) ship:(b2World *)world
{
	return [[[self alloc] initWithWorldTmp:world] autorelease];
}

-(id)initWithWorld:(b2World *)world
{
    if ((self = [super init]))
	{
        //先把动态去掉
        /* 
        // create an animation object from all the sprite animation frames
		CCAnimation* anim = [CCAnimation animationWithFrame:@"ship-anim" frameCount:5 delay:0.08f];
		
		// add the animation to the sprite (optional)
		//[sprite addAnimation:anim];
		
		// run the animation by using the CCAnimate action
		CCAnimate* animate = [CCAnimate actionWithAnimation:anim];
		CCRepeatForever* repeat = [CCRepeatForever actionWithAction:animate];
		[self.sprite runAction:repeat];
        */
        
		[self createBallInWorld:world];
		
		//不太清楚这一行是干什么的 添加触摸事件？这里不需要
        //[[CCTouchDispatcher sharedDispatcher] addTargetedDelegate:self priority:0 swallowsTouches:NO];
		
		/*[self scheduleUpdate];*/
	}
	return self;
    
}

-(void) createBallInWorld:(b2World*)world
{
	//CGSize screenSize = [[CCDirector sharedDirector] winSize];
    NSString* spriteFrameName = @"button-activated.png";
	CCSprite* tempSprite = [CCSprite spriteWithSpriteFrameName:spriteFrameName];
    
    //CGPoint startPos = CGPointMake(([tempSprite contentSize].width) * 0.5f, 
    //                               (screenSize.height ) * 0.5f);
    CGPoint startPos = CGPointMake(100, 390);	
    // Create a body definition and set it to be a dynamic body
	b2BodyDef bodyDef;
	bodyDef.type = b2_dynamicBody;
	bodyDef.position = [Helper toMeters:startPos];
	bodyDef.angularDamping = 0.9f;
	
	b2CircleShape shape;
	float radiusInMeters = (tempSprite.contentSize.width / PTM_RATIO) * 0.5f;
	shape.m_radius = radiusInMeters;
	
	// Define the dynamic body fixture.
	b2FixtureDef fixtureDef;
	fixtureDef.shape = &shape;
	fixtureDef.density = 0.8f;
	fixtureDef.friction = 0.7f;
	fixtureDef.restitution = 0.3f;
	
	[super createBodyInWorld:world bodyDef:&bodyDef fixtureDef:&fixtureDef spriteFrameName:spriteFrameName];
	
	//sprite.color = ccRED;
    //sprite.color = ccORANGE;

}

-(id)initWithWorldTmp:(b2World *)world
{
    if ((self = [super init]))
	{
		CGSize screenSize = [[CCDirector sharedDirector] winSize];
        
        //先暂时随便用一个图片代替
		NSString* spriteFrameName = @"ship-anim1.png";
		CCSprite* tempSprite = [CCSprite spriteWithSpriteFrameName:spriteFrameName];
        
        CGPoint startPos = CGPointMake(([tempSprite contentSize].width) * 0.5f, 
                                       (screenSize.height ) * 0.5f);
		
		// Create a body definition, it's a static body (bumpers don't move)
		b2BodyDef bodyDef;
		bodyDef.position = [Helper toMeters:startPos];
        bodyDef.type = b2_dynamicBody;
        bodyDef.angularDamping = 0.5f;

        
		b2CircleShape circleShape;
		float radiusInMeters = (tempSprite.contentSize.width / PTM_RATIO) * 0.5f;
		circleShape.m_radius = radiusInMeters;
		
		// Define the dynamic body fixture.
		b2FixtureDef fixtureDef;
		fixtureDef.shape = &circleShape;
		fixtureDef.density = 0.8f;
		fixtureDef.friction = 0.7f;
		fixtureDef.restitution = 0.3f;
		
		[super createBodyInWorld:world bodyDef:&bodyDef fixtureDef:&fixtureDef spriteFrameName:spriteFrameName];
		
        initialHitPoints = 20;
        hitPoints = initialHitPoints;
        
        HealthbarComponent* healthbar = [HealthbarComponent spriteWithSpriteFrameName:@"healthbar.png"];
        [self addChild:healthbar z:-2];
		//sprite.color = ccRED;
	}
    return self;
}

// moved back to ShipEntity ... the enemies currently don't need it and it gets in the way when
// resetting enemy positions during spawn

// override setPosition to keep entitiy within screen bounds
-(void) setPosition:(CGPoint)pos
{
	// If the current position is (still) outside the screen no adjustments should be made!
	// This allows entities to move into the screen from outside.
	if (CGRectContainsRect([TableSetup screenRect], [self.sprite boundingBox]))
	{
		CGSize screenSize = [[CCDirector sharedDirector] winSize];
		float halfWidth = self.contentSize.width * 0.5f;
		float halfHeight = self.contentSize.height * 0.5f;
		
		// Cap the position so the Ship's sprite stays on the screen
		if (pos.x < halfWidth)
		{
			pos.x = halfWidth;
		}
		else if (pos.x > (screenSize.width - halfWidth))
		{
			pos.x = screenSize.width - halfWidth;
		}
		
		if (pos.y < halfHeight)
		{
			pos.y = halfHeight;
		}
		else if (pos.y > (screenSize.height - halfHeight))
		{
			pos.y = screenSize.height - halfHeight;
		}
	}
	
	[super setPosition:pos];
}




@end
