//
//  GCHelper.h
//  CatRace
//
//  Created by 赵 苹果 on 12-7-6.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <GameKit/GameKit.h>

@protocol GCHelperDelegate 
-(void)matchStarted;
-(void)matchEnded;
-(void)match:(GKMatch *)match didReceiveData:(NSData *)data 
  fromPlayer:(NSString *)playerID;

@end


@interface GCHelper : NSObject <GKMatchmakerViewControllerDelegate, GKMatchDelegate>
{
    BOOL gameCenterAvailable;
    BOOL userAuthenticated;
    UIViewController *presentingViewController;
    GKMatch *match;
    BOOL matchStarted;
    id <GCHelperDelegate> delegate;
    NSMutableDictionary *playersDict;
    GKInvite *pendingInvite;
    NSArray *pendingPlayersToInvite;

}

@property (assign, readonly) BOOL gameCenterAvailable;
@property (retain) UIViewController *presentingViewController;
@property (retain) GKMatch *match;
@property (assign) id <GCHelperDelegate> delegate;
@property (retain)NSMutableDictionary *playersDict;
@property (retain) GKInvite *pendingInvite;
@property(retain)NSArray *pendingPlayersToInvite;

+(GCHelper *)sharedInstance;
-(void)inviteReceived;
-(void)authenticateLocalUser;
-(void)findMatchWithMinPlayers:(int)minPlayers maxPlayers:(int)maxPlayers
                viewController:(UIViewController *)viewController
                      delegate:(id<GCHelperDelegate>)theDelegate;
@end
