//
//  ResultLayer.h
//  GreedFamily
//
//  Created by MagicStudio on 12-6-20.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface ResultLayer : CCLayer {
    CCLabelTTF *basescorelabel;
    CCLabelTTF *timescorelabel;
    CCLabelTTF *totalscorelabel;
    
    int basescore;
    int timescore;
    int totalscore;
    int curbasescore;
    int curtimescore;
    int curtotalscore;
    int starNum;
    int isNewrecord;
    int gameLevel;
    bool isShow1;
    bool isShow2;
    
    CCSprite* background;
}
+(id)createResultLayer:(int)level Score:(int)score AddScore:(int)addscore StarNum:(int)starnum Newrecord:(int)isnewrecord;
@end
