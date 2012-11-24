//
//  GKMatchmakerViewController-LandscapeOnly.m
//  GreedFamily
//
//  Created by 赵 苹果 on 12-7-29.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//
#import "GKMatchmakerViewController-LandscapeOnly.h"

@implementation GKMatchmakerViewController (LandscapeOnly)

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation 
{ 
    return ( UIInterfaceOrientationIsLandscape( interfaceOrientation ) );
}

@end