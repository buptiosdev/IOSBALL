#import "OptionsScene.h"
#import "NavigationScene.h"
#import "SimpleAudioEngine.h"
#import "CommonLayer.h"


//BEGIN item scale  默认为相对于X的比例
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
        background.scaleX=(screenSize.width)/[background contentSize].width; //按照像素定制图片宽高是控制像素的。
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

        
        //sound
        CCSprite *soundoff = [CCSprite spriteWithSpriteFrameName:@"music.png"];
        CCSprite *soundon = [CCSprite spriteWithSpriteFrameName:@"music2.png"];
        CCSprite *soundoff1 = [CCSprite spriteWithSpriteFrameName:@"music.png"];
        CCSprite *soundon1 = [CCSprite spriteWithSpriteFrameName:@"music2.png"];
        
        CCMenuItemSprite *unchecked=[CCMenuItemSprite itemFromNormalSprite:soundoff selectedSprite:soundon];
        CCMenuItemSprite *checked=[CCMenuItemSprite itemFromNormalSprite:soundon1 selectedSprite:soundoff1];
        CCMenuItemToggle * sound = [CCMenuItemToggle itemWithTarget:self selector:@selector(changeSound:) items:checked,unchecked,nil];
        float soundscale=screenSize.height*optionsoundscaleY/[soundon contentSize].height;
        sound.scale=soundscale; //按照像素定制图片宽高是控制像素的。
        
        CCMenu * soundMenu = [CCMenu menuWithItems:sound,nil];
        [soundMenu setPosition:ccp((screenSize.width)*0.4,(screenSize.height)* 0.6)];
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
        music.scale=soundscale; //按照像素定制图片宽高是控制像素的。

        
        CCMenu * musicMenu = [CCMenu menuWithItems:music,nil];
        [musicMenu setPosition:ccp((screenSize.width)*0.6,(screenSize.height)*0.6)];
        [self addChild:musicMenu];
        //NSUserDefaults *usrDef = [NSUserDefaults standardUserDefaults];
		if([usrDef boolForKey:@"music"] == YES)
			music.selectedIndex = 1;
        
        CCSprite *returnBtn = [CCSprite spriteWithSpriteFrameName:@"return.png"];
        CCSprite *returnBtn1 = [CCSprite spriteWithSpriteFrameName:@"return.png"];
        returnBtn1.scale=1.1;
        CCMenuItemSprite *returnItem = [CCMenuItemSprite itemFromNormalSprite:returnBtn 
                                                               selectedSprite:returnBtn1 
                                                                       target:self 
                                                                     selector:@selector(returnMain)];
        float optscale=(screenSize.height*logolabelscaleY)/[returnBtn contentSize].height;
        returnItem.scale=optscale; //按照像素定制图片宽高
        CCMenu * returnmenu = [CCMenu menuWithItems:returnItem, nil];
        [returnmenu setPosition:ccp([returnBtn contentSize].width * returnItem.scale * 0.5,
                                    [returnBtn contentSize].height * returnItem.scale * 0.5)];
        
        [self addChild:returnmenu];
        
        //set info in the right-down corner
        CCSprite *info = [CCSprite spriteWithSpriteFrameName:@"info.png"];
        CCSprite *info1 = [CCSprite spriteWithSpriteFrameName:@"info.png"];
        info1.scaleX=1.1;
        info1.scaleY=1.1;
        CCMenuItemSprite *infoItem = [CCMenuItemSprite itemFromNormalSprite:info 
                                                             selectedSprite:info1 
                                                                     target:self 
                                                                   selector:@selector(displayInfo:)];
        infoItem.scale=optscale;
        CCMenu * infomenu = [CCMenu menuWithItems:infoItem, nil];
        [infomenu setPosition:ccp(screenSize.width-[info contentSize].width*optscale/2,[info contentSize].height*optscale/2)];
        [self addChild:infomenu z:1];
    }
    return self;
}

//滚动
-(void)viewAddPointY{
    view.scrollView.contentOffset = ccpAdd(view.scrollView.contentOffset, ccp(0,0.8));//让UIScrollView显示内容每次慢慢向上移动0.8像素
    //view.scrollView.contentSize.height :得到UIScrollView的高度
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