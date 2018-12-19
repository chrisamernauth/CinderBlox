//
//  AppDelegate.h
//  Blox
//
//  Created by Admin on 27/10/16.
//  Copyright © 2016 Admin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Reachability.h"
@import GoogleMobileAds;
@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property(nonatomic,retain) Reachability *hostReachable;
@property(nonatomic,strong)GADInterstitial *interstitialAds;
@property (strong, nonatomic) UINavigationController *navController;
+(AppDelegate *)appDelegate;
-(BOOL)isReachable;
@end

