//
//  GameShopScene.m
//  GreedFamily
//
//  Created by 赵 苹果 on 12-7-31.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import "GameShopScene.h"
#import "NavigationScene.h"

@implementation GameShopScene

+(CCScene *) gameShopScene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	GameShopScene *layer = [GameShopScene createGameShopScene];
	
	// add layer as a child to scene
	[scene addChild: layer];
    
	return scene;
}

+(id)createGameShopScene
{
    return [[[GameShopScene alloc] init] autorelease];
}

- (id) init {
    if ((self = [super init])) 
    {
		self.isTouchEnabled = YES;
        
        CGSize screenSize = [[CCDirector sharedDirector] winSize];
        
        CCLabelTTF *returnLabel=[CCLabelTTF labelWithString:@"GO Back" fontName:@"Marker Felt" fontSize:25];
        [returnLabel setColor:ccRED];
        CCMenuItemLabel * returnBtn = [CCMenuItemLabel itemWithLabel:returnLabel target:self selector:@selector(goBack:)];
        [returnBtn setPosition:ccp((screenSize.width)/2,(screenSize.height)/4)];
        CCMenu * menu = [CCMenu menuWithItems:returnBtn,nil];
		[self addChild:menu];
		[menu setPosition:ccp(0,0)];
        

    }   
    
    return self;
}

-(void)goBack:(id)sender
{
    [[CCDirector sharedDirector] replaceScene:[NavigationScene scene]];
}

@end
