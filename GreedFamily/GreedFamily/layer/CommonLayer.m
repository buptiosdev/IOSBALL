//
//  CommonLayer.m
//  GreedFamily
//
//  Created by 赵 苹果 on 12-11-24.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import "CommonLayer.h"
#import "SimpleAudioEngine.h"
@interface CommonLayer (PrivateMethods)
-(id)initCommonLayer;
+(id)createCommonLayer;
-(void)initRoleParam;
@end

//init the curMusic    modify by liuyunpeng 2012-12-9
MusicType curMusic=0;

@implementation CommonLayer
@synthesize roleParamArray = _roleParamArray;
//@synthesize curMusic = _curMusic;

/*创造一个半单例，让其他类可以很方便访问scene*/
static CommonLayer *instanceOfCommonLayer;
+(CommonLayer *)sharedCommonLayer
{
//    NSAssert(nil != instanceOfCommonLayer, @"GameMainScene instance not yet initialized!");
    if (nil == instanceOfCommonLayer) {
        return [CommonLayer createCommonLayer];
    }
    
    return instanceOfCommonLayer;
}

-(id)initCommonLayer
{
    if (self = [super init]) 
    {
        [self initRoleParam];
    }
    
    return self;
}

+(id)createCommonLayer
{
    return [[[CommonLayer alloc] initCommonLayer] autorelease];
}

//角色的属性设置
-(void)initRoleParam
{
    self.roleParamArray = (struct RoleParam *)malloc(sizeof(struct RoleParam)*ROLE_TYPE_COUNT);
    //panda
    self.roleParamArray[0].density = 0.65f;
    self.roleParamArray[0].restitution = 0.5f;
    self.roleParamArray[0].friction = 0.5f;
    self.roleParamArray[0].linearDamping = 0.45f;
    self.roleParamArray[0].sensitivity = 0.5f;
    self.roleParamArray[0].airspeed = 1.0f;
    self.roleParamArray[0].hitEffect = 0.4f;
    self.roleParamArray[0].landSpeed = 0.55f;
    self.roleParamArray[0].storageCapacity = 7;
    //pig
    self.roleParamArray[1].density = 0.7f;
    self.roleParamArray[1].restitution = 0.4f;
    self.roleParamArray[1].friction = 0.6f;
    self.roleParamArray[1].linearDamping = 0.5f;
    self.roleParamArray[1].sensitivity = 0.5f;
    self.roleParamArray[1].airspeed = 1.0f;
    self.roleParamArray[1].hitEffect = 0.5f;
    self.roleParamArray[1].landSpeed = 0.5f;
    self.roleParamArray[1].storageCapacity = 8;
    //bird
    self.roleParamArray[2].density = 0.55f;
    self.roleParamArray[2].restitution = 0.7f;
    self.roleParamArray[2].friction = 0.4f;
    self.roleParamArray[2].linearDamping = 0.3f;
    self.roleParamArray[2].sensitivity = 0.5f;
    self.roleParamArray[2].airspeed = 1.0f;
    self.roleParamArray[2].hitEffect = 0.2f;
    self.roleParamArray[2].landSpeed = 0.4f;
    self.roleParamArray[2].storageCapacity = 6;
    
}


-(float)getRoleParam:(int)roleType ParamType:(int)paramType
{
    int count = roleType -1;
    float baseValue;
    
    NSString *strBuyedList = nil;
    if (1 == roleType)
    {
        strBuyedList = [NSString stringWithFormat:@"Buyedlist_Panda"];
    }
    else if (2 == roleType)
    {
        strBuyedList = [NSString stringWithFormat:@"Buyedlist_Pig"];
    }
    else if (3 == roleType)
    {
        strBuyedList = [NSString stringWithFormat:@"Buyedlist_Bird"];
    }
    else
    {
        assert(NO);
    }
    int buyedList = [[NSUserDefaults standardUserDefaults] integerForKey:strBuyedList];
    
    if (paramType == ROLELANDSPEED) 
    {
        baseValue = self.roleParamArray[count].landSpeed;
        
        int level = (buyedList%10);
        
        return baseValue + level * baseValue * 0.1;
    }
    else if (paramType == ROLESTORAGECAPACITY) 
    {
        baseValue = self.roleParamArray[count].storageCapacity;
        
        int level = ((buyedList/10)%10);
        
        return baseValue + level;
    }
    else if (paramType == ROLEAIRSPEED) 
    {
        baseValue = self.roleParamArray[count].airspeed;
        
//        int level = ((buyedList/100)%10);
//        
//        return baseValue + level * baseValue * 0.1;
        return baseValue;
    }
    else if (paramType == ROLEAIRSENSIT) 
    {
        baseValue = self.roleParamArray[count].sensitivity;
        
//        int level = (buyedList/1000%10);
//        
//        return baseValue - level * baseValue * 0.1;

        return baseValue;
    }
    else if (paramType == ROLELINEARDAMP) 
    {
        baseValue = self.roleParamArray[count].linearDamping;
        return baseValue;    
    }
    else if (paramType == ROLEDENSITY) 
    {
        baseValue = self.roleParamArray[count].density;
        int level = ((buyedList/100)%10);
        return baseValue - level*baseValue*0.1;
    }
    else if (paramType == ROLEFRICION) 
    {
        baseValue = self.roleParamArray[count].friction;
        return baseValue;
    }
    else if (paramType == ROLERESTITUTION) 
    {
        baseValue = self.roleParamArray[count].restitution;
        return baseValue;
    }
    else if (paramType == ROLEHITEFFECT) 
    {
        baseValue = self.roleParamArray[count].hitEffect;
        return baseValue;
    }
    else if (paramType == ROLESTORAGETYPE) 
    {
        int level = ((buyedList/1000)%10);
        return level+1;
    }
    else
    {
        assert(0);
    }

    return 0;
    
}


+(void)playAudio:(int)audioType
{
    NSUserDefaults *usrDef = [NSUserDefaults standardUserDefaults];
    BOOL sound = [usrDef boolForKey:@"sound"];
    if (NO == sound) 
    {
        return;
    }
    
    switch (audioType) {
        case NeedTouch:
            [[SimpleAudioEngine sharedEngine] playEffect:@"needtouch.caf"];
            break; 
            
        case GetScore:
            [[SimpleAudioEngine sharedEngine] playEffect:@"getscore.caf"];
            break;            
            
        case EatCandy:
            [[SimpleAudioEngine sharedEngine] playEffect:@"der.caf"];
            break;            
            
        case EatGood:
            [[SimpleAudioEngine sharedEngine] playEffect:@"good.caf"];
            break;    
            
        case EatBad:
            [[SimpleAudioEngine sharedEngine] playEffect:@"toll.caf"];
            break;
            
        case Droping:
            [[SimpleAudioEngine sharedEngine] playEffect:@"drop.caf"];
            break;            
            
        case BubbleBreak:
            [[SimpleAudioEngine sharedEngine] playEffect:@"bubblebreak.caf"];
            break;            
            
        case BubbleHit:
            [[SimpleAudioEngine sharedEngine] playEffect:@"bubblehit.caf"];
            break;            
            
        case SelectOK:
            [[SimpleAudioEngine sharedEngine] playEffect:@"select.caf"];
            break;            
            
        case SelectNo:
            [[SimpleAudioEngine sharedEngine] playEffect:@"failwarning.caf"];
            break;            
            
        case Bombing:
            [[SimpleAudioEngine sharedEngine] playEffect:@"bomb.caf"];
            break;   
            
        case NewHighScore:
            [[SimpleAudioEngine sharedEngine] playEffect:@"drum.caf"];
            break;   
        case Speedup:
            [[SimpleAudioEngine sharedEngine] playEffect:@"speedup.caf"];
            break;
            
        default:
            break;
    }
}

+(void)playBackMusic:(int)musicType
{
    //播放背景音乐
    NSUserDefaults *usrDef = [NSUserDefaults standardUserDefaults];
    BOOL music = [usrDef boolForKey:@"music"];
    if (NO == music) 
    {
        switch (musicType) {
            case StopGameMusic:
                [[SimpleAudioEngine sharedEngine] stopBackgroundMusic];
                //add by liuyunpeng 2012-12-09
                curMusic=0;
                break; 

        }
        
        return;
    }
    //add by liuyunpeng 2012-12-09
    if(curMusic==musicType){
        return;
    }else{
        curMusic=musicType;
    }
    
    switch (musicType) {
        case UnGameMusic1:
            [[SimpleAudioEngine sharedEngine] playBackgroundMusic:@"destination.mp3" loop:YES];
            break; 
            
        case UnGameMusic2:
            [[SimpleAudioEngine sharedEngine] playBackgroundMusic:@"barn-beat.mp3" loop:YES];
            break; 
        
        case GameMusic1:
            [[SimpleAudioEngine sharedEngine] playBackgroundMusic:@"wildbird.mp3" loop:YES];
            break; 
        case GameMusic2:
            [[SimpleAudioEngine sharedEngine] playBackgroundMusic:@"morning.mp3" loop:YES];
            break; 
//        case GameMusic3:
//            [[SimpleAudioEngine sharedEngine] playBackgroundMusic:@"caribbeanblueshort.mp3" loop:YES];
//            break;     
//        case GameMusic4:
//            [[SimpleAudioEngine sharedEngine] playBackgroundMusic:@"cautiouspathshort.mp3" loop:YES];
//            break;  
//        case GameMusic5:
//            [[SimpleAudioEngine sharedEngine] playBackgroundMusic:@"I'm In Trouble.mp3" loop:YES];
//            break;  
//        case GameMusic6:
//            [[SimpleAudioEngine sharedEngine] playBackgroundMusic:@"Animal Farm.mp3" loop:YES];
//            break;
        default:
            break;
    }
}

+(void)preloadAudio
{
    [[SimpleAudioEngine sharedEngine] preloadEffect:@"bite.caf"];    
    [[SimpleAudioEngine sharedEngine] preloadEffect:@"needtouch.caf"]; 
    [[SimpleAudioEngine sharedEngine] preloadEffect:@"getscore.caf"]; 
    [[SimpleAudioEngine sharedEngine] preloadEffect:@"bomb.caf"]; 
    [[SimpleAudioEngine sharedEngine] preloadEffect:@"bubblebreak.caf"]; 
    [[SimpleAudioEngine sharedEngine] preloadEffect:@"bubblehit.caf"]; 
    [[SimpleAudioEngine sharedEngine] preloadEffect:@"der.caf"]; 
    [[SimpleAudioEngine sharedEngine] preloadEffect:@"ding.caf"]; 
    [[SimpleAudioEngine sharedEngine] preloadEffect:@"dorp.caf"]; 
    [[SimpleAudioEngine sharedEngine] preloadEffect:@"drum.caf"]; 
    [[SimpleAudioEngine sharedEngine] preloadEffect:@"failwarning.caf"]; 
    [[SimpleAudioEngine sharedEngine] preloadEffect:@"good.caf"]; 
    [[SimpleAudioEngine sharedEngine] preloadEffect:@"laugh1.caf"]; 
    [[SimpleAudioEngine sharedEngine] preloadEffect:@"laugh2.caf"]; 
    [[SimpleAudioEngine sharedEngine] preloadEffect:@"select.caf"]; 
    [[SimpleAudioEngine sharedEngine] preloadEffect:@"toll.caf"]; 
    [[SimpleAudioEngine sharedEngine] preloadEffect:@"speedup.caf"];
}
-(void) dealloc
{
    instanceOfCommonLayer = nil; 
	free(self.roleParamArray);
    [super dealloc];
}
@end
