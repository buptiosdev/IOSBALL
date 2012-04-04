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



-(id)initWithWorldTmp:(b2World *)world
{
    if ((self = [super init]))
	{
		CGSize screenSize = [[CCDirector sharedDirector] winSize];
        
        //先暂时随便用一个图片代替
		NSString* spriteFrameName = @"pic_6.png";
		CCSprite* tempSprite = [CCSprite spriteWithSpriteFrameName:spriteFrameName];
        
        CGPoint startPos = CGPointMake(([tempSprite contentSize].width) * 0.5f, 
                                       (screenSize.height ) * 0.5f);
		
		// Create a body definition, it's a static body (bumpers don't move)
		b2BodyDef bodyDef;
		bodyDef.position = [Helper toMeters:startPos];
        bodyDef.type = b2_dynamicBody;
        bodyDef.angularDamping = 0.5f;
        
        //阻力
        bodyDef.linearDamping = 0.1f;
        bodyDef.angularDamping = 0.05f;

        
		b2CircleShape circleShape;
		float radiusInMeters = (tempSprite.contentSize.width / PTM_RATIO) * 0.5f;
		circleShape.m_radius = radiusInMeters;
		
		// Define the dynamic body fixture.
		b2FixtureDef fixtureDef;
		fixtureDef.shape = &circleShape;
		fixtureDef.density = 0.5f;
		fixtureDef.friction = 0.7f;
		fixtureDef.restitution = 0.5f;
		
		[super createBodyInWorld:world bodyDef:&bodyDef fixtureDef:&fixtureDef spriteFrameName:spriteFrameName];
		
        initialHitPoints = 5;
        hitPoints = initialHitPoints;
        
		//sprite.color = ccRED;
        
        [[CCTouchDispatcher sharedDispatcher] addTargetedDelegate:self priority:0 swallowsTouches:NO];

        [self scheduleUpdate];
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

-(void) accelerometer:(UIAccelerometer *)accelerometer didAccelerate:(UIAcceleration *)acceleration
{
	// These three values control how the player is moved. I call such values "design parameters" as they 
	// need to be tweaked a lot and are critical for the game to "feel right".
	// Sometimes, like in the case with deceleration and sensitivity, such values can affect one another.
	// For example if you increase deceleration, the velocity will reach maxSpeed faster while the effect
	// of sensitivity is reduced.
	
	// this controls how quickly the velocity decelerates (lower = quicker to change direction)
	float deceleration = 0.4f;
	// this determines how sensitive the accelerometer reacts (higher = more sensitive)
	float sensitivity = 6.0f;
	// how fast the velocity can be at most
	float maxVelocity = 100;
    
	// adjust velocity based on current accelerometer acceleration
	playerVelocity.x = playerVelocity.x * deceleration + acceleration.x * sensitivity;
    
    BOOL yOverflow = NO;
	// we must limit the maximum velocity of the player sprite, in both directions (positive & negative values)
	if (playerVelocity.x > maxVelocity)
	{
		playerVelocity.x = maxVelocity;
	}
	else if (playerVelocity.x < -maxVelocity)
	{
		playerVelocity.x = -maxVelocity;
	}
    
	// Alternatively, the above if/else if block can be rewritten using fminf and fmaxf more neatly like so:
	// playerVelocity.x = fmaxf(fminf(playerVelocity.x, maxVelocity), -maxVelocity);
    playerVelocity.y = playerVelocity.x * acceleration.y / acceleration.x;  
    if (playerVelocity.y > maxVelocity) 
    {
        playerVelocity.y = maxVelocity;
        yOverflow = YES;
    } 
    else if (playerVelocity.y < - maxVelocity) 
    {
        playerVelocity.y = - maxVelocity;
        yOverflow = YES;
    }
    if (yOverflow)
    {
        playerVelocity.x = playerVelocity.y * acceleration.x / acceleration.y;
    }
    
    
}
-(void)applyForceWichAccelar
{
    b2Vec2 force = [Helper toMeters:playerVelocity];
    
	body->ApplyForce(force, body->GetWorldCenter());
    
}
-(void) applyForceTowardsFinger
{
	//b2Vec2 bodyPos = body->GetWorldCenter();
	//b2Vec2 fingerPos = [Helper toMeters:fingerLocation];
	
	//b2Vec2 bodyToFinger = fingerPos - bodyPos;
	
	
	// "Real" gravity falls off by the square over distance. Feel free to try it this way:
    //float distance = bodyToFinger.Normalize();
	//float distanceSquared = distance * distance;
	//b2Vec2 force = ((1.0f / distanceSquared) * 20.0f) * bodyToFinger;
	
	//b2Vec2 force = 2.0f * bodyToFinger;
    
    CGPoint bodyPosition = [Helper toPixels:body->GetPosition()];
    CGPoint acceleration = ccpSub(fingerLocation, bodyPosition);
    // 控制减速的速率(值越低=可以更快的改变方向) 
    float deceleration = 0.4f; 
    //加速计敏感度的值越大,主角精灵对加速计的输入就越敏感 
    float sensitivity = 1.0f;
    // 最大速度值 
    float maxVelocity = 20;
    // 基于当前加速计的加速度调整速度
    //CGPoint playerVelocity;
    BOOL yOverflow = NO;
    
    playerVelocity.x = playerVelocity.x * deceleration + acceleration.x * sensitivity;
    //playerVelocity.y = playerVelocity.y * deceleration + acceleration.y * sensitivity;
    // 我们必须在两个方向上都限制主角精灵的最大速度值 
    if (playerVelocity.x > maxVelocity) 
    {
        playerVelocity.x = maxVelocity;
    } 
    else if (playerVelocity.x < - maxVelocity) 
    {
        playerVelocity.x = - maxVelocity;
    }
    
    playerVelocity.y = playerVelocity.x * acceleration.y / acceleration.x;  
    if (playerVelocity.y > maxVelocity) 
    {
        playerVelocity.y = maxVelocity;
        yOverflow = YES;
    } 
    else if (playerVelocity.y < - maxVelocity) 
    {
        playerVelocity.y = - maxVelocity;
        yOverflow = YES;
    }
    if (yOverflow)
    {
        playerVelocity.x = playerVelocity.y * acceleration.x / acceleration.y;
    }
    


    b2Vec2 force = [Helper toMeters:playerVelocity];
    
	body->ApplyForce(force, body->GetWorldCenter());
}

-(void) update:(ccTime)delta
{
    // The Player should also be stopped from going outside the screen
	CGSize screenSize = [[CCDirector sharedDirector] winSize];
	float imageWidthHalved = [sprite texture].contentSize.width * 0.5f;
    float imageHeightHalved = [sprite texture].contentSize.height * 0.5f;
	float leftBorderLimit = imageWidthHalved;
	float rightBorderLimit = screenSize.width - imageWidthHalved;
    float upBorderLimit = screenSize.height - imageHeightHalved;
    float downBorderLimit = imageHeightHalved;

	if (moveToFinger == YES)
	{
		[self applyForceTowardsFinger];
	}
    
    //[self applyForceWichAccelar];
    if (sprite.position.x <= leftBorderLimit || sprite.position.x >= rightBorderLimit)
	{
		// also set velocity to zero because the player is still accelerating towards the border
		playerVelocity = CGPointMake(0.0f, playerVelocity.y);
	}
    
    if (sprite.position.y <= downBorderLimit || sprite.position.x >= upBorderLimit)
	{
		// also set velocity to zero because the player is still accelerating towards the border
		playerVelocity = CGPointMake(playerVelocity.x, 0.0f);
	}
    CCLOG(@"health is @ %i\n", hitPoints);
	
	/*if (sprite.position.y < -(sprite.contentSize.height * 10))
	{
		// create a new ball and remove the old one
		[self createBallInWorld:body->GetWorld()];
	}*/
}

-(BOOL) ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event
{
	moveToFinger = YES;
	fingerLocation = [Helper locationFromTouch:touch];
	return YES;
}

-(void) ccTouchMoved:(UITouch *)touch withEvent:(UIEvent *)event
{
	fingerLocation = [Helper locationFromTouch:touch];
}

-(void) ccTouchEnded:(UITouch *)touch withEvent:(UIEvent *)event
{
	moveToFinger = NO;
}

-(void) dealloc
{
	[[CCTouchDispatcher sharedDispatcher] removeDelegate:self];
	[super dealloc];
}

@end
