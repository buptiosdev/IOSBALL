#import "OptionsScene.h"
#import "NavigationScene.h"
#import "SimpleAudioEngine.h"
#import "CommonLayer.h"


//BEGIN item scale  ??????X???
float logolabelscaleY=0.15;
float optionsoundscaleY=40.0/320;
//END



@implementation OptionsScene

DeveloperInfo *view;
//UIActivityIndicatorView *activityIndicatorView;
//BOOL isCreateIndicatorView;


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
        //set the background pic
		CCSprite * background = [CCSprite spriteWithFile:@"background_begin.jpg"];
        background.scaleX=(screenSize.width)/[background contentSize].width; //?????????????????
        background.scaleY=(screenSize.height)/[background contentSize].height;
        NSAssert( background != nil, @"background must be non-nil");
		[background setPosition:ccp(screenSize.width / 2, screenSize.height/2)];
		[self addChild:background];
        CCSpriteFrameCache* frameCache = [CCSpriteFrameCache sharedSpriteFrameCache];
        [frameCache addSpriteFramesWithFile:@"levlescene_default_default.plist"];
        [frameCache addSpriteFramesWithFile:@"beginscene_default.plist"];
// delete by liuyunpeng 2012-12-11        
//		//CCBitmapFontAtlas * musicLabel = [CCBitmapFontAtlas labelWithString:@"MUSIC" fntFile:@"hud_font.fnt"];
//        CCLabelTTF *musicLabel=[CCLabelTTF labelWithString:@"MUSIC" fontName:@"Marker Felt" fontSize:30];
//		[musicLabel setColor:ccYELLOW];
//		[self addChild:musicLabel];
//		[musicLabel setPosition:ccp((screenSize.width)/3,(screenSize.height)*3/4)];
//		
//		//CCBitmapFontAtlas * soundLabel = [CCBitmapFontAtlas labelWithString:@"SOUND" fntFile:@"hud_font.fnt"];
//        CCLabelTTF *soundLabel=[CCLabelTTF labelWithString:@"SOUND" fontName:@"Marker Felt" fontSize:30];
//		[soundLabel setColor:ccYELLOW];
//		[self addChild:soundLabel];
//		[soundLabel setPosition:ccp((screenSize.width)/3,(screenSize.height)/2)];
//		
//		
//		CCMenuItemImage * unchecked1 = [CCMenuItemImage itemFromNormalImage:@"options_check.png"
//														   selectedImage:@"options_check_d.png"];
//		
//		CCMenuItemImage * checked1 = [CCMenuItemImage itemFromNormalImage:@"options_check_d.png"
//															 selectedImage:@"options_check.png" ];
//		
//		CCMenuItemToggle * music = [CCMenuItemToggle itemWithTarget:self selector:@selector(changeMusic:) items:unchecked1,checked1,nil];
//		
//		CCMenuItemImage * unchecked2 = [CCMenuItemImage itemFromNormalImage:@"options_check.png"
//															 selectedImage:@"options_check_d.png"];
//		
//		CCMenuItemImage * checked2 = [CCMenuItemImage itemFromNormalImage:@"options_check_d.png"
//														   selectedImage:@"options_check.png" ];
//		
//		CCMenuItemToggle * sound = [CCMenuItemToggle itemWithTarget:self selector:@selector(changeSound:) items:unchecked2,checked2,nil];
//		
//		
//		[music setPosition:ccp((screenSize.width)*2/3,(screenSize.height)*3/4+10)];
//		[sound setPosition:ccp((screenSize.width)*2/3,(screenSize.height)/2+10)];
//		
//		CCMenu * menu = [CCMenu menuWithItems:music,sound,nil];
//		[self addChild:menu];
//		[menu setPosition:ccp(0,0)];
//		//[menu alignItemsHorizontallyWithPadding:23];
//		NSUserDefaults *usrDef = [NSUserDefaults standardUserDefaults];
//		if([usrDef boolForKey:@"sound"] == YES)
//			sound.selectedIndex = 1;
//		if([usrDef boolForKey:@"music"] == YES)
//			music.selectedIndex = 1;

        CGSize size = [[CCDirector sharedDirector] winSize];
        //sound
        CCSprite *soundoff = [CCSprite spriteWithSpriteFrameName:@"music.png"];
        CCSprite *soundon = [CCSprite spriteWithSpriteFrameName:@"music2.png"];
        CCSprite *soundoff1 = [CCSprite spriteWithSpriteFrameName:@"music.png"];
        CCSprite *soundon1 = [CCSprite spriteWithSpriteFrameName:@"music2.png"];
        
        CCMenuItemSprite *unchecked=[CCMenuItemSprite itemFromNormalSprite:soundoff selectedSprite:soundon];
        CCMenuItemSprite *checked=[CCMenuItemSprite itemFromNormalSprite:soundon1 selectedSprite:soundoff1];
        CCMenuItemToggle * sound = [CCMenuItemToggle itemWithTarget:self selector:@selector(changeSound:) items:checked,unchecked,nil];
        float soundscale=screenSize.height*optionsoundscaleY/[soundon contentSize].height;
        sound.scale=soundscale; //?????????????????
        
        CCMenu * soundMenu = [CCMenu menuWithItems:sound,nil];
        [soundMenu setPosition:ccp((screenSize.width)*0.2,(screenSize.height)* 0.6)];
        [self addChild:soundMenu];
        NSUserDefaults *usrDef = [NSUserDefaults standardUserDefaults];
		if([usrDef boolForKey:@"sound"] == YES)
			sound.selectedIndex = 1;
        
        
        //music
        CCSprite *musicoff = [CCSprite spriteWithSpriteFrameName:@"sound.png"];
        CCSprite *musicon = [CCSprite spriteWithSpriteFrameName:@"sound2.png"];
        CCSprite *musicoff1 = [CCSprite spriteWithSpriteFrameName:@"sound.png"];
        CCSprite *musicon1 = [CCSprite spriteWithSpriteFrameName:@"sound2.png"];
        
        CCMenuItemSprite *uncheckedmusic=[CCMenuItemSprite itemFromNormalSprite:musicoff selectedSprite:musicon];
        CCMenuItemSprite *checkedmusic=[CCMenuItemSprite itemFromNormalSprite:musicon1 selectedSprite:musicoff1];
		CCMenuItemToggle * music = [CCMenuItemToggle itemWithTarget:self selector:@selector(changeMusic:) items:checkedmusic,uncheckedmusic,nil];
        music.scale=soundscale; //?????????????????

        
        CCMenu * musicMenu = [CCMenu menuWithItems:music,nil];
        [musicMenu setPosition:ccp((screenSize.width)*0.4,(screenSize.height)*0.6)];
        [self addChild:musicMenu];
        //NSUserDefaults *usrDef = [NSUserDefaults standardUserDefaults];
		if([usrDef boolForKey:@"music"] == YES)
			music.selectedIndex = 1;
        

        
        //set info in the right-down corner
        CCSprite *info = [CCSprite spriteWithSpriteFrameName:@"info.png"];
        CCSprite *info1 = [CCSprite spriteWithSpriteFrameName:@"info.png"];
        info1.scaleX=1.1;
        info1.scaleY=1.1;
        CCMenuItemSprite *infoItem = [CCMenuItemSprite itemFromNormalSprite:info 
                                                             selectedSprite:info1 
                                                                     target:self 
                                                                   selector:@selector(displayInfo:)];

        infoItem.scale=soundscale;
        CCMenu * infomenu = [CCMenu menuWithItems:infoItem, nil];
//        [infomenu setPosition:ccp(screenSize.width-[info contentSize].width*optscale/2,[info contentSize].height*optscale/2)];
        [infomenu setPosition:ccp((screenSize.width)*0.6,(screenSize.height)*0.6)];
        [self addChild:infomenu z:1];
        
        
        //teach
        CCSprite *teachInfo = [CCSprite spriteWithSpriteFrameName:@"teach.png"];
        CCSprite *teachInfo2 = [CCSprite spriteWithSpriteFrameName:@"teach.png"];
        teachInfo2.scaleX = 1.1;
        teachInfo2.scaleY = 1.1;
        teachInfoMenu = [CCMenuItemSprite itemFromNormalSprite:teachInfo 
                                                selectedSprite:teachInfo2 
                                                        target:self 
                                                      selector:@selector(getTeachInfo:)];
        

        teachInfoMenu.scale=soundscale;
        CCMenu * menu = [CCMenu menuWithItems:teachInfoMenu, nil];
        [menu setPosition:ccp(size.width*0.8,(screenSize.height)*0.6)];
        //[leadermenu setPosition:ccp(size.width/2, size.height/4)];
//        //set the distance to be the 1.5times of the label
//        [menu alignItemsHorizontallyWithPadding:size.width*logoleaderdistance-[leader contentSize].width*leaderscale];
        [self addChild:menu z:1];
        
        
        CCSprite *returnBtn = [CCSprite spriteWithSpriteFrameName:@"return.png"];
        CCSprite *returnBtn1 = [CCSprite spriteWithSpriteFrameName:@"return.png"];
        returnBtn1.scale=1.1;
        CCMenuItemSprite *returnItem = [CCMenuItemSprite itemFromNormalSprite:returnBtn 
                                                               selectedSprite:returnBtn1 
                                                                       target:self 
                                                                     selector:@selector(returnMain)];
        float optscale=(screenSize.height*logolabelscaleY)/[returnBtn contentSize].height;
        returnItem.scale=optscale; //??????????
        CCMenu * returnmenu = [CCMenu menuWithItems:returnItem, nil];
        [returnmenu setPosition:ccp([returnBtn contentSize].width * returnItem.scale * 0.5,
                                    [returnBtn contentSize].height * returnItem.scale * 0.5)];
        
        [self addChild:returnmenu];
        
    }
    return self;
}

//??
-(void)viewAddPointY{
    view.scrollView.contentOffset = ccpAdd(view.scrollView.contentOffset, ccp(0,0.8));//?UIScrollView????????????0.8??
    //view.scrollView.contentSize.height :??UIScrollView???
    if (view.scrollView.contentOffset.y >= view.scrollView.contentSize.height)
    {
        view.scrollView.contentOffset = ccp(0,-view.scrollView.frame.size.height+500);
    }
}


-(void)displayInfo:(id)sender
{
    [CommonLayer playAudio:SelectOK];
    view = [[DeveloperInfo alloc] initWithNibName:@"DeveloperInfo" bundle:nil];
    [[[CCDirector sharedDirector] openGLView] addSubview:view.view];
    //[view release];
    [self schedule:@selector(viewAddPointY) interval:0.03];
}

-(void)changeSound:(CCMenuItemToggle *)sender
{
    [CommonLayer playAudio:SelectOK];
	NSUserDefaults *usrDef = [NSUserDefaults standardUserDefaults];
	
	if(sender.selectedIndex ==1)
		[usrDef setBool:YES forKey:@"sound"];
	if(sender.selectedIndex ==0)
		[usrDef setBool:NO forKey:@"sound"];
}

-(void)changeMusic:(CCMenuItemToggle *)sender
{
    [CommonLayer playAudio:SelectOK];
	NSUserDefaults *usrDef = [NSUserDefaults standardUserDefaults];
	
	if(sender.selectedIndex ==1)
    {
		[usrDef setBool:YES forKey:@"music"];
        [CommonLayer playBackMusic:UnGameMusic1];
    }
    else if(sender.selectedIndex ==0)
    {
		[usrDef setBool:NO forKey:@"music"];
        [CommonLayer playBackMusic:StopGameMusic];
    }
}




//add teach 
//  leaderboardpic optionpic
-(void)getTeachInfo:(CCMenuItemToggle *)sender
{
    //CCLayer *teachLayer = [[CCLayer node] autorelease];
    [teachInfoMenu setIsEnabled:NO];
    CGSize screenSize = [[CCDirector sharedDirector] winSize];
    
    CCSprite *nextPic = [CCSprite spriteWithSpriteFrameName:@"playgame1.png"];
    CCSprite *nextPic2 = [CCSprite spriteWithSpriteFrameName:@"playgame1.png"];
    nextPic2.scaleX = 1.1;
    nextPic2.scaleY = 1.1;
    CCSprite *lastPic = [CCSprite spriteWithSpriteFrameName:@"playgame2.png"];
    CCSprite *lastPic2 = [CCSprite spriteWithSpriteFrameName:@"playgame2.png"]; 
    lastPic2.scaleX = 1.1;
    lastPic2.scaleY = 1.1;
    
    CCSprite *returnBackPic = [CCSprite spriteWithSpriteFrameName:@"close.png"];
    CCSprite *returnBackPic2 = [CCSprite spriteWithSpriteFrameName:@"close.png"];
    returnBackPic2.scaleX = 1.1;
    returnBackPic2.scaleY = 1.1;
    
    CCMenuItemSprite *nextMenu = [CCMenuItemSprite itemFromNormalSprite:nextPic 
                                                         selectedSprite:nextPic2 
                                                                 target:self 
                                                               selector:@selector(onNextPic:)];
    CCMenuItemSprite *lastMenu = [CCMenuItemSprite itemFromNormalSprite:lastPic 
                                                         selectedSprite:lastPic2 
                                                                 target:self 
                                                               selector:@selector(onLastPic:)];
    CCMenuItemSprite *returnBackMenu = [CCMenuItemSprite itemFromNormalSprite:returnBackPic 
                                                               selectedSprite:returnBackPic2 
                                                                       target:self 
                                                                     selector:@selector(onReturnBackPic:)];
    
    nextMenu.scaleX=(40)/[nextPic contentSize].width; //??????????
    nextMenu.scaleY=(40)/[nextPic contentSize].height;
    lastMenu.scaleX=(40)/[lastPic contentSize].width; //??????????
    lastMenu.scaleY=(40)/[lastPic contentSize].height;
    returnBackMenu.scaleX=(40)/[returnBackPic contentSize].width; //??????????
    returnBackMenu.scaleY=(40)/[returnBackPic contentSize].height;
    
    
    CCMenu *controlMenu = [CCMenu menuWithItems:lastMenu, nextMenu, returnBackMenu,nil];
    
    [controlMenu alignItemsVerticallyWithPadding:20];
    //change size by diff version
    controlMenu.position = CGPointMake(screenSize.width * 0.9, screenSize.height * 0.5);
    [controlMenu alignItemsVerticallyWithPadding:50];
    [self addChild:controlMenu z:21 tag:100];
    
    teachPicCount = 0;
    NSString* teachStr = [NSString stringWithFormat:@"teachdetail"];
    NSString* teachPic = [NSString stringWithFormat:@"%@%i.jpg", teachStr, teachPicCount+1];
    
    teachSprite = [CCSprite spriteWithFile:teachPic];
    teachSprite.position = CGPointMake(screenSize.width * 0.5, screenSize.height * 0.5);
    teachSprite.scaleX=(screenSize.width)/[teachSprite contentSize].width; //??????????
    teachSprite.scaleY=(screenSize.height)/[teachSprite contentSize].height;
    [self addChild:teachSprite z:2 tag:101];
    
    //[self addChild:teachLayer z:1 tag:100];
}

-(void)onNextPic:(CCMenuItemToggle *)sender
{
    [self removeChildByTag:(NSInteger)101 cleanup:YES];
    teachPicCount++;
    teachPicCount = teachPicCount % 7;
    
    NSString* teachStr = [NSString stringWithFormat:@"teachdetail"];
    NSString* teachPic = [NSString stringWithFormat:@"%@%i.jpg", teachStr, teachPicCount+1];
    CGSize screenSize = [[CCDirector sharedDirector] winSize];
    teachSprite = [CCSprite spriteWithFile:teachPic];
    teachSprite.position = CGPointMake(screenSize.width * 0.5, screenSize.height * 0.5);
    teachSprite.scaleX=(screenSize.width)/[teachSprite contentSize].width; //??????????
    teachSprite.scaleY=(screenSize.height)/[teachSprite contentSize].height;
    
    [self addChild:teachSprite z:20 tag:101];
}

-(void)onLastPic:(CCMenuItemToggle *)sender
{
    [self removeChildByTag:(NSInteger)101 cleanup:YES];
    
    teachPicCount--;
    if (teachPicCount == -1)
    {
        teachPicCount = 6;
    }
    
    teachPicCount = teachPicCount % 7;
    
    NSString* teachStr = [NSString stringWithFormat:@"teachdetail"];
    NSString* teachPic = [NSString stringWithFormat:@"%@%i.jpg", teachStr, teachPicCount+1];
    CGSize screenSize = [[CCDirector sharedDirector] winSize];
    teachSprite = [CCSprite spriteWithFile:teachPic];
    teachSprite.position = CGPointMake(screenSize.width * 0.5, screenSize.height * 0.5);
    teachSprite.scaleX=(screenSize.width)/[teachSprite contentSize].width; //??????????
    teachSprite.scaleY=(screenSize.height)/[teachSprite contentSize].height;
    
    [self addChild:teachSprite z:20 tag:101];
    
}

-(void)onReturnBackPic:(CCMenuItemToggle *)sender
{
    [teachInfoMenu setIsEnabled:YES];
    [self removeChildByTag:(NSInteger)100 cleanup:YES];
    [self removeChildByTag:(NSInteger)101 cleanup:YES];
}

-(void)returnMain
{
    [CommonLayer playAudio:SelectOK];
    [[CCDirector sharedDirector] popScene];
}


-(void)dealloc
{
	[super dealloc];
}
@end