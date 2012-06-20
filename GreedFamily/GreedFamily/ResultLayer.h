//
//  ResultLayer.h
//  GreedFamily
//
//  Created by MagicStudio on 12-6-20.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface ResultLayer : CCLayerColor {
    
}
+(id)createResultLayer:(ccColor4B)color Level:(int)level Score:(int)score AddScore:(int)addscore;
@end
