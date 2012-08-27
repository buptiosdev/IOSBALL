//
//  TouchSwallowLayer.m
//  GreedFamily
//
//  Created by 赵 苹果 on 12-8-1.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import "TouchSwallowLayer.h"
#import "GameShopScene.h"
//#import "GameMainScene.h"

@interface TouchSwallowLayer (PrivateMethods)
-(id)initwithType:(int)goodsType RoleType:(int)roalType;
@end
@implementation TouchSwallowLayer


-(void) registerWithTouchDispatcher 
{
    [[CCTouchDispatcher sharedDispatcher] addTargetedDelegate: self priority:kCCMenuTouchPriority-1 swallowsTouches:YES ];
}

- (BOOL)ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event
{
    
    if ([myMenu itemForTouch:touch])
    {
        return NO;
    }
    
    return YES;
}

+(id)createTouchSwallowLayer:(int)goodsType RoleType:(int)roalType
{
    return [[[TouchSwallowLayer alloc] initwithType:goodsType RoleType:roalType] autorelease];
}

-(id)initwithType:(int)goodsType RoleType:(int)roalType
{
    if (self = [super init]) 
    {
        curRoleType = roalType;
        
        CCLabelTTF *yesLable =[CCLabelTTF labelWithString:@"Yes" fontName:@"Marker Felt" fontSize:30];
        CCLabelTTF *noLable =[CCLabelTTF labelWithString:@"No" fontName:@"Marker Felt" fontSize:30];
        CGSize screenSize = [[CCDirector sharedDirector] winSize];
        
        CCMenuItemLabel * noMenu = [CCMenuItemLabel itemWithLabel:noLable target:self selector:@selector(noOption:)];
        CCMenuItemLabel * yesMenu = nil;
        NSString *str = nil;
        if (1 == goodsType) 
        {
            yesMenu  = [CCMenuItemLabel itemWithLabel:yesLable target:self selector:@selector(yesAddSpeedOnce:)];
            str = [NSString stringWithFormat:@"您将花去%d分",SPEED1];
        }
        else if (2 == goodsType)
        {
            yesMenu = [CCMenuItemLabel itemWithLabel:yesLable target:self selector:@selector(yesAddSpeedTwice:)];
            str = [NSString stringWithFormat:@"您将花去%d分",SPEED2];
        }
        else if (3 == goodsType)
        {
            yesMenu = [CCMenuItemLabel itemWithLabel:yesLable target:self selector:@selector(yesAddSpeedThird:)];
            str = [NSString stringWithFormat:@"您将花去%d分",SPEED3];
        }
        else if (4 == goodsType)
        {
            yesMenu = [CCMenuItemLabel itemWithLabel:yesLable target:self selector:@selector(yesAddStorageOnce:)];
            str = [NSString stringWithFormat:@"您将花去%d分",STORAGE1];
        }
        else
        {
            yesMenu = [CCMenuItemLabel itemWithLabel:yesLable target:self selector:@selector(yesAddStorageTwice:)];
            str = [NSString stringWithFormat:@"您将花去%d分",STORAGE2];
        }
                
        myMenu = [CCMenu menuWithItems:yesMenu,noMenu,nil];
        
        [myMenu alignItemsVerticallyWithPadding:10];
        
        [myMenu setPosition:ccp(screenSize.width/2,screenSize.height *1/4)];
        [myMenu alignItemsHorizontallyWithPadding:50];
        [self addChild:myMenu z:1 tag:100];
        
        
        
        CCLabelTTF *displayLable1 =[CCLabelTTF labelWithString:str fontName:@"Marker Felt" fontSize:45];
        [displayLable1 setPosition:ccp(screenSize.width/2,screenSize.height* 3/4)];
        CCLabelTTF *displayLable2 =[CCLabelTTF labelWithString:@"是否购买" fontName:@"Marker Felt" fontSize:45];
        [displayLable2 setPosition:ccp(screenSize.width/2,screenSize.height* 5/8)];
        [self addChild:displayLable2];
        [self addChild:displayLable1];
    }
    
    return self;
}


-(void)noOption:(id)sender
{
    
    [self.parent removeChild:self cleanup:YES];
}

-(void)updateScore
{
    [[NSUserDefaults standardUserDefaults] synchronize];
    [(GameShopScene *)self.parent updateScore];
}

-(void)yesAddSpeedOnce:(id)sender
{
    //使用时处以10
    int acceleration = 11;
    //读取得分
    //更新累计得分,算两个role的总分
    NSString *strRolaTotalScore = nil;
    NSString *strAcceleration = nil;
    if (1 == curRoleType) 
    {
        strRolaTotalScore = [NSString stringWithFormat:@"Totalscore_Bird"];
        strAcceleration = [NSString stringWithFormat:@"Acceleration_Bird"];
    }
    else
    {
        strRolaTotalScore = [NSString stringWithFormat:@"Totalscore_Pig"];
        strAcceleration = [NSString stringWithFormat:@"Acceleration_Pig"];
    }
    int rolaTotalScore = [[NSUserDefaults standardUserDefaults] integerForKey:strRolaTotalScore];

    if (SPEED1 > rolaTotalScore) 
    {
        //购买失败音效
//        [[GameMainScene sharedMainScene] playAudio:SelectNo];
        [self.parent removeChild:self cleanup:YES];
        return;
    }

    //修改得分
    rolaTotalScore -= SPEED1;
    [[NSUserDefaults standardUserDefaults] setInteger:rolaTotalScore forKey:strRolaTotalScore]; 
    
    //修改游戏参数
    
    int temAcceleration = [[NSUserDefaults standardUserDefaults] integerForKey:strAcceleration]; 
    if (acceleration > temAcceleration)
    {
        [[NSUserDefaults standardUserDefaults] setInteger:acceleration forKey:strAcceleration]; 
    }
    //购买成功音效
    //    [[GameMainScene sharedMainScene] playAudio:SelectOK];
    //跳过这一个物品，显示下一个 个位表示陆地动物速度
    ((GameShopScene *)self.parent).buyedList += 1;
    //提交数据
    [self updateScore];
    [[CCDirector sharedDirector] replaceScene:[GameShopScene gameShopScene]];
    //[self.parent removeChild:self cleanup:YES];
}
-(void)yesAddSpeedTwice:(id)sender
{
    //使用时处以10
    int acceleration = 12;
    //读取得分
    //更新累计得分,算两个role的总分
    NSString *strRolaTotalScore = nil;
    NSString *strAcceleration = nil;
    if (1 == curRoleType) 
    {
        strRolaTotalScore = [NSString stringWithFormat:@"Totalscore_Bird"];
        strAcceleration = [NSString stringWithFormat:@"Acceleration_Bird"];
    }
    else
    {
        strRolaTotalScore = [NSString stringWithFormat:@"Totalscore_Pig"];
        strAcceleration = [NSString stringWithFormat:@"Acceleration_Pig"];
    }
    int rolaTotalScore = [[NSUserDefaults standardUserDefaults] integerForKey:strRolaTotalScore];
    
    if (SPEED2 > rolaTotalScore) 
    {
        //购买失败音效
//        [[GameMainScene sharedMainScene] playAudio:SelectNo];
        [self.parent removeChild:self cleanup:YES];
        return;
    }
    
    //修改得分
    rolaTotalScore -= SPEED2;
    [[NSUserDefaults standardUserDefaults] setInteger:rolaTotalScore forKey:strRolaTotalScore]; 
    
    //修改游戏参数
    int temAcceleration = [[NSUserDefaults standardUserDefaults] integerForKey:strAcceleration]; 
    if (acceleration > temAcceleration)
    {
        [[NSUserDefaults standardUserDefaults] setInteger:acceleration forKey:strAcceleration]; 
    }
    //购买成功音效
    //    [[GameMainScene sharedMainScene] playAudio:SelectOK];
    //跳过这一个物品，显示下一个 个位表示陆地动物速度
    ((GameShopScene *)self.parent).buyedList += 1;
    //提交数据
    [self updateScore];
    [[CCDirector sharedDirector] replaceScene:[GameShopScene gameShopScene]];
    //[self.parent removeChild:self cleanup:YES];
}

-(void)yesAddSpeedThird:(id)sender
{
    //使用时处以10
    int acceleration = 13;
    //读取得分
    //更新累计得分,算两个role的总分
    NSString *strRolaTotalScore = nil;
    NSString *strAcceleration = nil;
    if (1 == curRoleType) 
    {
        strRolaTotalScore = [NSString stringWithFormat:@"Totalscore_Bird"];
        strAcceleration = [NSString stringWithFormat:@"Acceleration_Bird"];
    }
    else
    {
        strRolaTotalScore = [NSString stringWithFormat:@"Totalscore_Pig"];
        strAcceleration = [NSString stringWithFormat:@"Acceleration_Pig"];
    }
    int rolaTotalScore = [[NSUserDefaults standardUserDefaults] integerForKey:strRolaTotalScore];
    
    if (SPEED3 > rolaTotalScore) 
    {
        //购买失败音效
//        [[GameMainScene sharedMainScene] playAudio:SelectNo];
        [self.parent removeChild:self cleanup:YES];
        return;
    }
    
    //修改得分
    rolaTotalScore -= SPEED3;
    [[NSUserDefaults standardUserDefaults] setInteger:rolaTotalScore forKey:strRolaTotalScore]; 
    
    //修改游戏参数
    int temAcceleration = [[NSUserDefaults standardUserDefaults] integerForKey:strAcceleration]; 
    if (acceleration > temAcceleration)
    {
        [[NSUserDefaults standardUserDefaults] setInteger:acceleration forKey:strAcceleration]; 
    }
    //购买成功音效
    //    [[GameMainScene sharedMainScene] playAudio:SelectOK];
    //跳过这一个物品，显示下一个 个位表示陆地动物速度
    ((GameShopScene *)self.parent).buyedList += 1;
    //提交数据
    [self updateScore];
    [[CCDirector sharedDirector] replaceScene:[GameShopScene gameShopScene]];
    //[self.parent removeChild:self cleanup:YES];
}

-(void)yesAddStorageOnce:(id)sender
{
    int capacity = 9;
    //读取得分
    //更新累计得分,算两个role的总分
    NSString *strRolaTotalScore = nil;
    NSString *strCapacity = nil;
    if (1 == curRoleType) 
    {
        strRolaTotalScore = [NSString stringWithFormat:@"Totalscore_Bird"];
        strCapacity = [NSString stringWithFormat:@"Capacity_Bird"];
    }
    else
    {
        strRolaTotalScore = [NSString stringWithFormat:@"Totalscore_Pig"];
        strCapacity = [NSString stringWithFormat:@"Capacity_Pig"];
    }
    int rolaTotalScore = [[NSUserDefaults standardUserDefaults] integerForKey:strRolaTotalScore];
    
    if (STORAGE1 > rolaTotalScore) 
    {
        //购买失败音效
//        [[GameMainScene sharedMainScene] playAudio:SelectNo];
        [self.parent removeChild:self cleanup:YES];
        return;
    }
    
    //修改得分
    rolaTotalScore -= STORAGE1;
    [[NSUserDefaults standardUserDefaults] setInteger:rolaTotalScore forKey:strRolaTotalScore]; 
    
    //修改游戏参数
    int temCapacity = [[NSUserDefaults standardUserDefaults] integerForKey:strCapacity]; 
    if (capacity > temCapacity)
    {
        [[NSUserDefaults standardUserDefaults] setInteger:capacity forKey:strCapacity]; 
    }

    //购买成功音效
//    [[GameMainScene sharedMainScene] playAudio:SelectOK];
    //跳过这一个物品，显示下一个 十位表示仓库
    ((GameShopScene *)self.parent).buyedList += 10;
    //提交数据
    [self updateScore];
    [[CCDirector sharedDirector] replaceScene:[GameShopScene gameShopScene]];

    //[self.parent removeChild:self cleanup:YES];
}

-(void)yesAddStorageTwice:(id)sender
{
    int capacity = 10;
    //读取得分
    //更新累计得分,算两个role的总分
    NSString *strRolaTotalScore = nil;
    NSString *strCapacity = nil;
    if (1 == curRoleType) 
    {
        strRolaTotalScore = [NSString stringWithFormat:@"Totalscore_Bird"];
        strCapacity = [NSString stringWithFormat:@"Capacity_Bird"];
    }
    else
    {
        strRolaTotalScore = [NSString stringWithFormat:@"Totalscore_Pig"];
        strCapacity = [NSString stringWithFormat:@"Capacity_Pig"];
    }
    int rolaTotalScore = [[NSUserDefaults standardUserDefaults] integerForKey:strRolaTotalScore];
    
    if (STORAGE2 > rolaTotalScore) 
    {
        //购买失败音效
//        [[GameMainScene sharedMainScene] playAudio:SelectNo];
        [self.parent removeChild:self cleanup:YES];
        return;
    }
    
    //修改得分
    rolaTotalScore -= STORAGE2;
    [[NSUserDefaults standardUserDefaults] setInteger:rolaTotalScore forKey:strRolaTotalScore]; 
    
    //修改游戏参数
    int temCapacity = [[NSUserDefaults standardUserDefaults] integerForKey:strCapacity]; 
    if (capacity > temCapacity)
    {
        [[NSUserDefaults standardUserDefaults] setInteger:capacity forKey:strCapacity]; 
    }
    //购买成功音效
    //    [[GameMainScene sharedMainScene] playAudio:SelectOK];
    //跳过这一个物品，显示下一个 十位表示仓库
    ((GameShopScene *)self.parent).buyedList += 10;
    //提交数据
    [self updateScore];
    [[CCDirector sharedDirector] replaceScene:[GameShopScene gameShopScene]];
    //[self.parent removeChild:self cleanup:YES];
}
#pragma mark Layer - Callbacks
-(void) onEnter
{
    [self registerWithTouchDispatcher];
	// then iterate over all the children
	[super onEnter];
}

// issue #624.
// Can't register mouse, touches here because of #issue #1018, and #1021
-(void) onEnterTransitionDidFinish
{	
	[super onEnterTransitionDidFinish];
}

-(void) onExit
{
    
    [[CCTouchDispatcher sharedDispatcher] removeDelegate:self];
	
	[super onExit];
}


-(void) dealloc
{
    //[[CCTouchDispatcher sharedDispatcher] removeDelegate:self];
	[super dealloc];
}

@end
