#import "OptionsScene.h"
#import "NavigationScene.h"

@implementation OptionsScene

- (id) init {
    self = [super init];
    if (self != nil) {
		
        [self addChild:[OptionsLayer node]];
		
    }
    return self;
}

-(void)dealloc
{
	[super dealloc];
}

@end

@implementation OptionsLayer
- (id) init {
    if ((self = [super init])) {
		
		self.isTouchEnabled = YES;
		CGSize screenSize = [[CCDirector sharedDirector] winSize];
//		CCSprite * background = [CCSprite spriteWithFile:@"background_1.png"];
//		[background setPosition:ccp(160,240)];
//		[self addChild:background];
		
//		CCBitmapFontAtlas * difficultyLabel = [CCBitmapFontAtlas bitmapFontAtlasWithString:@"DIFFICULTY" fntFile:@"hud_font.fnt"];
//		[difficultyLabel setColor:ccRED];
//		[self addChild:difficultyLabel];
//		[difficultyLabel setPosition:ccp(80,350)];
		
		//CCBitmapFontAtlas * musicLabel = [CCBitmapFontAtlas bitmapFontAtlasWithString:@"MUSIC" fntFile:@"hud_font.fnt"];
        CCLabelTTF *musicLabel=[CCLabelTTF labelWithString:@"MUSIC" fontName:@"Marker Felt" fontSize:30];
		[musicLabel setColor:ccRED];
		[self addChild:musicLabel];
		[musicLabel setPosition:ccp((screenSize.width)/3,(screenSize.height)*3/4)];
		
		//CCBitmapFontAtlas * soundLabel = [CCBitmapFontAtlas bitmapFontAtlasWithString:@"SOUND" fntFile:@"hud_font.fnt"];
        CCLabelTTF *soundLabel=[CCLabelTTF labelWithString:@"SOUND" fontName:@"Marker Felt" fontSize:30];
		[soundLabel setColor:ccRED];
		[self addChild:soundLabel];
		[soundLabel setPosition:ccp((screenSize.width)/3,(screenSize.height)/2)];
		
		
		
//		CCMenuItemImage * easyBtn = [CCMenuItemImage itemFromNormalImage:@"easy.png"
//														   selectedImage:@"easy_dwn.png"];
//		
//		CCMenuItemImage * normalBtn = [CCMenuItemImage itemFromNormalImage:@"normal.png"
//															 selectedImage:@"normal_dwn.png" ];
//		
//		CCMenuItemToggle * difficulty = [CCMenuItemToggle itemWithTarget:self selector:@selector(changeDifficulty:) items:easyBtn,normalBtn,nil];
		
		CCMenuItemImage * unchecked1 = [CCMenuItemImage itemFromNormalImage:@"options_check.png"
														   selectedImage:@"options_check_d.png"];
		
		CCMenuItemImage * checked1 = [CCMenuItemImage itemFromNormalImage:@"options_check_d.png"
															 selectedImage:@"options_check.png" ];
		
		CCMenuItemToggle * music = [CCMenuItemToggle itemWithTarget:self selector:@selector(changeMusic:) items:unchecked1,checked1,nil];
		
		CCMenuItemImage * unchecked2 = [CCMenuItemImage itemFromNormalImage:@"options_check.png"
															 selectedImage:@"options_check_d.png"];
		
		CCMenuItemImage * checked2 = [CCMenuItemImage itemFromNormalImage:@"options_check_d.png"
														   selectedImage:@"options_check.png" ];
		
		CCMenuItemToggle * sound = [CCMenuItemToggle itemWithTarget:self selector:@selector(changeSound:) items:unchecked2,checked2,nil];
		
		
//		CCMenuItemImage * goback = [CCMenuItemImage itemFromNormalImage:@"options_goback.png"
//														   selectedImage:@"options_goback.png" 
//														   disabledImage:@"options_goback.png"
//																  target:self
//																selector:@selector(goBack:)];
        CCLabelTTF *returnLabel=[CCLabelTTF labelWithString:@"GO Back" fontName:@"Marker Felt" fontSize:25];
        [returnLabel setColor:ccRED];
        CCMenuItemLabel * returnBtn = [CCMenuItemLabel itemWithLabel:returnLabel target:self selector:@selector(goBack:)];
        
//		[difficulty setPosition:ccp(220,350)];
		[music setPosition:ccp((screenSize.width)*2/3,(screenSize.height)*3/4+10)];
		[sound setPosition:ccp((screenSize.width)*2/3,(screenSize.height)/2+10)];
		[returnBtn setPosition:ccp((screenSize.width)/2,(screenSize.height)/4)];
		
		CCMenu * menu = [CCMenu menuWithItems:music,sound,returnBtn,nil];
		[self addChild:menu];
		[menu setPosition:ccp(0,0)];
		//[menu alignItemsHorizontallyWithPadding:23];
		NSUserDefaults *usrDef = [NSUserDefaults standardUserDefaults];
		if([usrDef boolForKey:@"sound"] == YES)
			sound.selectedIndex = 1;
		if([usrDef boolForKey:@"music"] == YES)
			music.selectedIndex = 1;
//		if([usrDef integerForKey:@"difficulty"] == 0)
//			difficulty.selectedIndex =0;
//		else if([usrDef integerForKey:@"difficulty"] == 1)
//			difficulty.selectedIndex =1;
		
    }
    return self;
}

//-(void)changeDifficulty:(CCMenuItemToggle *)sender
//{
//	NSUserDefaults *usrDef = [NSUserDefaults standardUserDefaults];
//	
//	if(sender.selectedIndex ==1)
//		[usrDef setInteger:1 forKey:@"difficulty"];
//	if(sender.selectedIndex ==0)
//		[usrDef setInteger:0 forKey:@"difficulty"];
//}

-(void)changeSound:(CCMenuItemToggle *)sender
{
	NSUserDefaults *usrDef = [NSUserDefaults standardUserDefaults];
	
	if(sender.selectedIndex ==1)
		[usrDef setBool:YES forKey:@"sound"];
	if(sender.selectedIndex ==0)
		[usrDef setBool:NO forKey:@"sound"];
}

-(void)changeMusic:(CCMenuItemToggle *)sender
{
	NSUserDefaults *usrDef = [NSUserDefaults standardUserDefaults];
	
	if(sender.selectedIndex ==1)
		[usrDef setBool:YES forKey:@"music"];
	if(sender.selectedIndex ==0)
		[usrDef setBool:NO forKey:@"music"];
}


-(void)goBack:(id)sender
{
    [[CCDirector sharedDirector] replaceScene:[NavigationScene scene]];
}


-(void)dealloc
{
	[super dealloc];
}
@end