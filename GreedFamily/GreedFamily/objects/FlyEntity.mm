//
//  FlyEntity.m
//  ShootEmUp
//
//  Created by Steffen Itterheim on 18.08.10.
//  Copyright 2010 Steffen Itterheim. All rights reserved.
//

#import "FlyEntity.h"
#import "CCAnimationHelper.h"
#import "GameBackgroundLayer.h"

@interface FlyEntity (PrivateMethods)
-(id) initWithShipImage;
-(void)createBallInWorld:(b2World*)world;
-(id)initWithWorld:(b2World *)world;
@end

@implementation FlyEntity
@synthesize flyAction = _flyAction;
@synthesize flyActionArray = _flyActionArray;
@synthesize sprite = _sprite;

+(id) flyAnimal:(b2World *)world
{
	return [[[self alloc] initWithWorld:world] autorelease];
}



-(void)initFlyAction:(CCTexture2D *)texture
{        
    
    _flyActionArray = [[NSMutableArray alloc] init];
    NSMutableArray *animFrames = [NSMutableArray array];
    
    for (int i =0; i <8; i++) {
        
        [animFrames removeAllObjects];
        
        for (int j =0; j <10; j++) {
            CCSpriteFrame *frame = [CCSpriteFrame frameWithTexture:texture rect:CGRectMake(j*75, i*70, 75, 70)];
            [animFrames addObject:frame];
        }
        CCAnimation *animation = [CCAnimation animationWithName:@"fly" delay:0.1f frames:animFrames];
               
        CCAnimate *animate = [CCAnimate actionWithAnimation:animation restoreOriginalFrame:NO];
        CCSequence *seq = [CCSequence actions: animate,
                           nil];
        
        self.flyAction = [CCRepeatForever actionWithAction: seq ];
        [_flyActionArray addObject:self.flyAction];

    }

    
}

-(id)initWithWorld:(b2World *)world
{
    if ((self = [super init]))
	{
		CGSize screenSize = [[CCDirector sharedDirector] winSize];
        //先把动态去掉
        
//         // create an animation object from all the sprite animation frames
//         CCAnimation* anim = [CCAnimation animationWithFrame:@"ship-anim" frameCount:5 delay:0.08f];
//         
//         // add the animation to the sprite (optional)
//         //[sprite addAnimation:anim];
//         
//         // run the animation by using the CCAnimate action
//         CCAnimate* animate = [CCAnimate actionWithAnimation:anim];
//         CCRepeatForever* repeat = [CCRepeatForever actionWithAction:animate];
//         [self.sprite runAction:repeat];
        directionBefore = 0;
        directionCurrent = 0;
        CCTexture2D *texture = [[CCTextureCache sharedTextureCache] addImage:@"dragon.png"];
        //初始化动态效果
        [self initFlyAction:texture];
        
        
        CCSpriteFrame *frame1 = [CCSpriteFrame frameWithTexture:texture rect:CGRectMake(0, 0, 75, 70) ];
        
        self.sprite = [CCSprite spriteWithSpriteFrame:frame1];
        // batch node for all dynamic elements
        CCSpriteBatchNode* batch2 = [CCSpriteBatchNode batchNodeWithFile:@"dragon.png" capacity:100];
        [self addChild:batch2 z:0 tag:2];
        [batch2 addChild:self.sprite];
        //self.sprite = [CCSprite spriteWithSpriteFrameName:@"bird.png"];
        //CCSpriteBatchNode* batch = [[GameBackgroundLayer sharedGameBackgroundLayer] getSpriteBatch];
        //[batch addChild:self.sprite];
        
        //CCSpriteBatchNode* batch = [[GameBackgroundLayer sharedGameBackgroundLayer] getSpriteBatch];
        //[batch addChild:self.sprite];
        
        self.flyAction = [_flyActionArray objectAtIndex:0];
        [self.sprite runAction:_flyAction];
        
        CGPoint startPos = CGPointMake(([self.sprite contentSize].width) * 0.5f, 
                                       (screenSize.height ) * 0.5f);
		
		// Create a body definition, it's a static body (bumpers don't move)
		b2BodyDef bodyDef;
		bodyDef.position = [Helper toMeters:startPos];
        bodyDef.type = b2_dynamicBody;
        
        //阻力
        bodyDef.linearDamping = 0.4f;
        bodyDef.angularDamping = 100.0f;

        
		b2CircleShape circleShape;
		float radiusInMeters = (self.sprite.contentSize.width / PTM_RATIO) * 0.5f;
		circleShape.m_radius = radiusInMeters;
		
		// Define the dynamic body fixture.
		b2FixtureDef fixtureDef;
		fixtureDef.shape = &circleShape;
		fixtureDef.density = 0.5f;
		fixtureDef.friction = 0.7f;
		fixtureDef.restitution = 0.5f;
		
		[super createBodyInWorld:world bodyDef:&bodyDef fixtureDef:&fixtureDef];
        self.sprite.position = startPos;
        initialHitPoints = 6;
        hitPoints = initialHitPoints;
        
        [self scheduleUpdate];
	}
    return self;
}

// moved back to FlyEntity ... the enemies currently don't need it and it gets in the way when
// resetting enemy positions during spawn

// override setPosition to keep entitiy within screen bounds
/*-(void) setPosition:(CGPoint)pos
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
}*/

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
    
	self.body->ApplyForce(force, self.body->GetWorldCenter());
    
}

-(void)playFlyAction : (CGPoint)velocity
{
 
    
    //float distanceToMove = ccpLength(playerVelocity);
    CGFloat moveAngle = ccpToAngle(velocity);
    CGFloat cocosAngle = CC_RADIANS_TO_DEGREES(-1* moveAngle);
    
    //float dragonVelocity =480.0/3.0;
    //float moveDuration = distanceToMove / playerVelocity;
    
    cocosAngle +=23;
    if (cocosAngle <0)
        cocosAngle +=360;
    
    int runAnim = (int)((cocosAngle)/45);
    directionCurrent = runAnim;
    if (directionCurrent == directionBefore)
    {
        return;
    }
    [self.sprite stopAction:_flyAction];
    self.flyAction = [_flyActionArray objectAtIndex:runAnim];
    [self.sprite runAction:_flyAction];
    directionBefore = directionCurrent;
    
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
    
    //CGPoint bodyPosition = [Helper toPixels:self.body->GetPosition()];
    CGPoint acceleration = ccpSub(fingerLocationEnd, fingerLocationBegin);
    acceleration = ccpMult(acceleration, 5/(time2 -time1));
    CCLOG(@"time1 = %f, time2 = %f, time = %f", time1, time2, time2 -time1);
    // 控制减速的速率(值越低=可以更快的改变方向) 
    float deceleration = 0.5f; 
    //加速计敏感度的值越大,主角精灵对加速计的输入就越敏感 
    float sensitivity = 1.2f;
    // 最大速度值 
    float maxVelocity = 4000;
    // 基于当前加速计的加速度调整速度
    //CGPoint playerVelocity;
    BOOL yOverflow = NO;
    
    playerVelocity = [Helper toPixels:self.body->GetLinearVelocity()];
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
    
	self.body->ApplyForce(force, self.body->GetWorldCenter());
    
}

-(void) update:(ccTime)delta
{
    // The Player should also be stopped from going outside the screen
//	CGSize screenSize = [[CCDirector sharedDirector] winSize];
//	float imageWidthHalved = [self.sprite texture].contentSize.width * 0.5f;
//    float imageHeightHalved = [self.sprite texture].contentSize.height * 0.5f;
//	float leftBorderLimit = imageWidthHalved;
//	float rightBorderLimit = screenSize.width - imageWidthHalved;
//    float upBorderLimit = screenSize.height - imageHeightHalved;
//    float downBorderLimit = imageHeightHalved;

	if (moveToFinger == YES)
	{
		[self applyForceTowardsFinger];
        moveToFinger = NO;
	}

//    //[self applyForceWichAccelar];
//    if (self.sprite.position.x <= 40 || self.sprite.position.x >= 380)
//	{
//		// also set velocity to zero because the player is still accelerating towards the border
//		playerVelocity = CGPointMake(0.0f, playerVelocity.y);
//	}
//    
//    if (self.sprite.position.y <= 100 || self.sprite.position.y >= 280)
//	{
//		// also set velocity to zero because the player is still accelerating towards the border
//		playerVelocity = CGPointMake(playerVelocity.x, 0.0f);
//	}
    
    CGPoint bodyVelocity = [Helper toPixels:self.body->GetLinearVelocity()];
    //Float32 bodyAngularVelocity = self.body->GetAngularVelocity();
    //bodyVelocity =  ccpMult(bodyVelocity, bodyAngularVelocity);
    [self playFlyAction:bodyVelocity];
}
-(bool) isTouchForMe:(CGPoint)touchLocation
{
    
    return CGRectContainsPoint([self.sprite boundingBox], touchLocation);
}
-(BOOL) ccTouchBeganForSky:(UITouch *)touch withEvent:(UIEvent *)event
{
	fingerLocation = [Helper locationFromTouch:touch];
    
    time1 = CFAbsoluteTimeGetCurrent();
    
    fingerLocationBegin = [Helper locationFromTouch:touch];
    bool isTouchHandled = [self isTouchForMe:fingerLocation];
    if (isTouchHandled)
    {
        //moveToFinger = YES;
        self.sprite.color = ccYELLOW;
    }
    
	return isTouchHandled;
}

-(void) ccTouchMovedForSky:(UITouch *)touch withEvent:(UIEvent *)event
{
	fingerLocation = [Helper locationFromTouch:touch];
    fingerLocationEnd = [Helper locationFromTouch:touch];
    
}

-(void) ccTouchEndedForSky:(UITouch *)touch withEvent:(UIEvent *)event
{
    time2 = CFAbsoluteTimeGetCurrent();
	moveToFinger = YES;
    self.sprite.color = ccWHITE;
}

-(void) dealloc
{
    [[CCSpriteFrameCache sharedSpriteFrameCache] removeUnusedSpriteFrames];
    [self.flyActionArray removeAllObjects];
    
    self.flyAction = nil;
    
	[super dealloc];
}

@end
