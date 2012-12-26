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
#import "GameMainScene.h"
#import "CommonLayer.h"

@interface FlyEntity (PrivateMethods)
-(id) initWithShipImage;
-(void)createBallInWorld:(b2World*)world;
-(id)initWithWorld:(b2World *)world RoleType:(int)roleType;
@end

@implementation FlyEntity
@synthesize body = _body;
@synthesize flyAction = _flyAction;
@synthesize flyActionArray = _flyActionArray;
@synthesize sprite = _sprite;
@synthesize familyType = _familyType;
+(id) flyAnimal:(b2World *)world RoleType:(int)roleType
{
	return [[[self alloc] initWithWorld:world RoleType:roleType] autorelease];
}



-(void)initFlyAction
{        
    
    _flyActionArray = [[NSMutableArray alloc] init];
    for (int i = 0; i < 2; i++) {
        CCAnimation* animation = nil;
        //小鸟
        if (3 == _familyType) 
        {
            switch (i) 
            {
                case 0:
                    animation = [CCAnimation animationWithFrame:@"boybird_3_" frameCount:5 delay:0.1f];
                    break;
                case 1:
                    animation = [CCAnimation animationWithFrame:@"boybird_9_" frameCount:5 delay:0.1f];
                    break;
                    

                default:
                    break;
            }

        }
        //小猪
        else if (2 == _familyType)
        {
            switch (i) 
            {
                case 0:
                    animation = [CCAnimation animationWithFrame:@"boypig_3_" frameCount:5 delay:0.1f];
                    break;
                case 1:
                    animation = [CCAnimation animationWithFrame:@"boypig_9_" frameCount:5 delay:0.1f];
                    break;

                    
                default:
                    break;
            }

        }
        //小猪
        else if (1 == _familyType)
        {
            switch (i) 
            {
                case 0:
                    animation = [CCAnimation animationWithFrame:@"pandaboy_3_" frameCount:5 delay:0.1f];
                    break;
                case 1:
                    animation = [CCAnimation animationWithFrame:@"pandaboy_9_" frameCount:5 delay:0.1f];
                    break;
                    
                    
                default:
                    break;
            }
        }
               
        CCAnimate *animate = [CCAnimate actionWithAnimation:animation restoreOriginalFrame:NO];
        CCSequence *seq = [CCSequence actions: animate,
                           nil];
        
        CCSpeed *speed =[CCSpeed actionWithAction:[CCRepeatForever actionWithAction:seq] speed:1.0f];
        [_flyActionArray addObject:speed];

    }

    
}

-(id)initWithWorld:(b2World *)world RoleType:(int)roleType
{
    if ((self = [super init]))
	{
		CGSize screenSize = [[CCDirector sharedDirector] winSize];
        float picScale = 0.0;
        //指定是猪还是鸟。1。小鸟 2。小猪
        _familyType = roleType;
        directionBefore = 0;
        directionCurrent = 0;
        [self initFlyAction];
        
        if (1 == _familyType)
        {
            self.sprite = [CCSprite spriteWithSpriteFrameName:@"pandaboy_3_1.png"];
            //按照像素设定图片大小
            //change size by diff version manual
//            self.sprite.scaleX=(60)/[self.sprite contentSize].width; //按照像素定制图片宽高
//            self.sprite.scaleY=(60)/[self.sprite contentSize].height;
            picScale = 80.0/1024;
            self.sprite.scale=screenSize.width*picScale/[self.sprite contentSize].width;

        }
        else if (2 == _familyType)
        {
            self.sprite = [CCSprite spriteWithSpriteFrameName:@"boypig_3_1.png"];
            //按照像素设定图片大小
            //change size by diff version manual
//            self.sprite.scaleX=(80)/[self.sprite contentSize].width; //按照像素定制图片宽高
//            self.sprite.scaleY=(80)/[self.sprite contentSize].height;
            picScale = 110.0/1024;
            self.sprite.scale=screenSize.width*picScale/[self.sprite contentSize].width;

        }
        else if (3 == _familyType)
        {
            self.sprite = [CCSprite spriteWithSpriteFrameName:@"boybird_3_1.png"];
            //按照像素设定图片大小
//            self.sprite.scaleX=(50)/[self.sprite contentSize].width; //按照像素定制图片宽高
//            self.sprite.scaleY=(50)/[self.sprite contentSize].height;
            picScale = 70.0/1024;
            self.sprite.scale=screenSize.width*picScale/[self.sprite contentSize].width;

        }
        //按照像素设定图片大小//为什么batch不能用？？
        //[batch addChild:self.sprite z:-1]; 
        [self addChild:self.sprite z:-1]; 
        self.sprite.visible = YES;
        self.flyAction = [_flyActionArray objectAtIndex:0];
        [self.sprite runAction:_flyAction];
        //change size by diff version query
        CGPoint startPos = CGPointMake(([self.sprite contentSize].width) * 0.5f, 
                                       (screenSize.height ) * 0.5f);
		
		// Create a body definition, it's a static body (bumpers don't move)
        //小熊
        b2BodyDef bodyDef;
        b2FixtureDef fixtureDef;
        if (1 == _familyType)
        {
            b2CircleShape circleShape;
            float radiusInMeters = (((self.sprite.contentSize.width * self.sprite.scaleX) - 10) / PTM_RATIO) * 0.5f;
            circleShape.m_radius = radiusInMeters;
            fixtureDef.shape = &circleShape;

        }
        //小猪
        else if (2 == _familyType)
        {
            
            b2CircleShape circleShape;
            float radiusInMeters = (((self.sprite.contentSize.width * self.sprite.scaleX) - 20) / PTM_RATIO) * 0.5f;
            circleShape.m_radius = radiusInMeters;
            
            // Define the dynamic body fixture.
            fixtureDef.shape = &circleShape;
        }
        //小鸟
        else if (3 == _familyType)
        {
            bodyDef.fixedRotation = true;
            b2CircleShape circleShape;
            float radiusInMeters = (((self.sprite.contentSize.width * self.sprite.scaleX) - 10) / PTM_RATIO) * 0.5f;
            circleShape.m_radius = radiusInMeters;
            
            // Define the dynamic body fixture.
            fixtureDef.shape = &circleShape;
            
        }
        
        bodyDef.position = [Helper toMeters:startPos];
        bodyDef.type = b2_dynamicBody;
        //阻力
//        bodyDef.linearDamping = [[GameMainScene sharedMainScene] roleParamArray][_familyType - 1].linearDamping;
        bodyDef.linearDamping = [[CommonLayer sharedCommonLayer] getRoleParam:_familyType ParamType:ROLELINEARDAMP];
        bodyDef.angularDamping = 100.0f;
        //不旋转
        bodyDef.fixedRotation = true;
        fixtureDef.density = [[CommonLayer sharedCommonLayer] getRoleParam:_familyType ParamType:ROLEDENSITY];
        fixtureDef.friction = [[CommonLayer sharedCommonLayer] getRoleParam:_familyType ParamType:ROLEFRICION];
        fixtureDef.restitution = [[CommonLayer sharedCommonLayer] getRoleParam:_familyType ParamType:ROLERESTITUTION];
        		
		[super createBodyInWorld:world bodyDef:&bodyDef fixtureDef:&fixtureDef];
        self.sprite.position = startPos;
        initialHitPoints = 6;
        hitPoints = initialHitPoints;
        
        [self scheduleUpdate];
	}
    return self;
}

-(void)applyForceWichAccelar
{
    b2Vec2 force = [Helper toMeters:playerVelocity];
    
	self.body->ApplyForce(force, self.body->GetWorldCenter());
    
}

-(void)playFlyAction : (CGPoint)velocity
{
    
    CGFloat moveAngle = ccpToAngle(velocity);
    CGFloat cocosAngle = CC_RADIANS_TO_DEGREES(-1* moveAngle);

    //cocosAngle +=10;
    cocosAngle +=85;
    while (cocosAngle <0)
    {
        cocosAngle +=360;
    }
    
    //2个方向
    int runAnim = (int)((cocosAngle)/180);
    //8个方向
    //int runAnim = (int)((cocosAngle)/45);
    directionCurrent = runAnim;
    if (directionCurrent != directionBefore)
    {
        if(runAnim ==0 || runAnim ==1)
        {
            [self.sprite stopAction:_flyAction];
            self.flyAction = [_flyActionArray objectAtIndex:runAnim];
            [self.sprite runAction:_flyAction];
            directionBefore = directionCurrent;
        }
        else
        {
            CCLOG(@"flyaction error");
            assert(0);
        }
    }

    //根据飞行速度调节动画速率
    CGFloat flySpeed = ccpLengthSQ([self getFlySpeed]);
    if (flySpeed < 100)
    {
        [self.flyAction setSpeed:1];
    }  
    else if (flySpeed < 1000) 
    {
        [self.flyAction setSpeed:1.3];
    }
    else if (flySpeed > 50000)
    {
        [self.flyAction setSpeed:3];
        //加入炸弹特效
        CCParticleSystem* system;
        system = [ARCH_OPTIMAL_PARTICLE_SYSTEM particleWithFile:@"speedfast2.plist"];
        system.positionType = kCCPositionTypeFree;
        system.autoRemoveOnFinish = YES;
        system.position = self.sprite.position;
        [self addChild:system z:-1 tag:100];
    }
    else if (flySpeed > 20000)
    {
        [self.flyAction setSpeed:2];
    }
    else
    {
        [self.flyAction setSpeed:1.5];
        
    }
    
    
}

-(void) applyForceTowardsFinger
{    
    CGPoint acceleration = ccpSub(fingerLocationEnd, fingerLocationBegin);
    acceleration = ccpMult(acceleration, 5/(time2 -time1));
    CCLOG(@"time1 = %f, time2 = %f, time = %f", time1, time2, time2 -time1);
    
    float sensitivity = [[CommonLayer sharedCommonLayer] getRoleParam:_familyType ParamType:ROLEDENSITY];
    float airspeed = [[CommonLayer sharedCommonLayer] getRoleParam:_familyType ParamType:ROLEAIRSPEED];
    
    // 最大速度值 
    float maxVelocity = 4000;
    //BOOL yOverflow = NO;
    
    playerVelocity = [Helper toPixels:self.body->GetLinearVelocity()];
    CCLOG(@"before playervelocity is %f , %f",playerVelocity.x,playerVelocity.y);
    playerVelocity.x = playerVelocity.x * sensitivity + acceleration.x * airspeed;
    playerVelocity.y = playerVelocity.y * sensitivity + acceleration.y * airspeed;
    CCLOG(@"acceleration is %f , %f",acceleration.x,acceleration.y);
//    //!!!!!!!!!!!!!!!!!!!!!!!!!!!必须检查是否为0,否则会发生除0错误。modify by liuyunpeng 2012-11-18
//    if(acceleration.x==0||acceleration.y==0){
//        return;
//    }
    //playerVelocity.y = playerVelocity.x * acceleration.y / acceleration.x;  
    if (playerVelocity.y > maxVelocity) 
    {
        playerVelocity.y = maxVelocity;
        //yOverflow = YES;
    } 
    else if (playerVelocity.y < - maxVelocity) 
    {
        playerVelocity.y = - maxVelocity;
       // yOverflow = YES;
    }
//    if (yOverflow)
//    {
//        playerVelocity.x = playerVelocity.y * acceleration.x / acceleration.y;
//    }
    //modify by liuyunpeng 2012-11-18
    // 我们必须在两个方向上都限制主角精灵的最大速度值 
    if (playerVelocity.x > maxVelocity) 
    {
        playerVelocity.x = maxVelocity;
    } 
    else if (playerVelocity.x < - maxVelocity) 
    {
        playerVelocity.x = - maxVelocity;
    }
    CCLOG(@"after playervelocity is %f , %f",playerVelocity.x,playerVelocity.y);
    b2Vec2 force = [Helper toMeters:playerVelocity];
    
	self.body->ApplyForce(force, self.body->GetWorldCenter());
    
}

-(CGPoint)getFlySpeed
{
    return [Helper toPixels:self.body->GetLinearVelocity()];
}

-(void) update:(ccTime)delta
{
	if (moveToFinger == YES)
	{
		[self applyForceTowardsFinger];
        moveToFinger = NO;
	}    
    CGPoint bodyVelocity = [Helper toPixels:self.body->GetLinearVelocity()];
    [self playFlyAction:bodyVelocity];
}

-(bool) isTouchForMe:(CGPoint)touchLocation
{
    return CGRectContainsPoint([self.sprite boundingBox], touchLocation);
}

-(void) ccTouchBeganForSky2:(UITouch *)touch withEvent:(UIEvent *)event
{    
    time1 = CFAbsoluteTimeGetCurrent();
    
    fingerLocationBegin = [Helper locationFromTouch:touch];

    return;
}

-(BOOL) ccTouchBeganForSky:(UITouch *)touch withEvent:(UIEvent *)event
{

    bool isTouchHandled = [self isTouchForMe:fingerLocation];
    if (!isTouchHandled)
    {
        return isTouchHandled;
    }
    fingerLocation = [Helper locationFromTouch:touch];
    
    time1 = CFAbsoluteTimeGetCurrent();
    
    fingerLocationBegin = [Helper locationFromTouch:touch];
    
	return isTouchHandled;
}

-(void) ccTouchMovedForSky:(UITouch *)touch withEvent:(UIEvent *)event
{
	fingerLocation = [Helper locationFromTouch:touch];
    fingerLocationEnd = [Helper locationFromTouch:touch];
}

-(void) ccTouchEndedForSky:(UITouch *)touch withEvent:(UIEvent *)event
{
    fingerLocationEnd = [Helper locationFromTouch:touch];
    time2 = CFAbsoluteTimeGetCurrent();
    float distance = ccpDistance(fingerLocationBegin, fingerLocationEnd);
    double interval=time2-time1;
    if (distance > 1 && interval > 0.01) 
    {
        moveToFinger = YES;
    }else
    {
        CCLOG(@"distance is %f , interval is %f",distance,interval);
    }
}

-(void) dealloc
{
    [[CCSpriteFrameCache sharedSpriteFrameCache] removeUnusedSpriteFrames];
    [self.flyActionArray removeAllObjects];
    
    self.flyAction = nil;
    
	[super dealloc];
}

@end
