//
//  AppDelegate.m
//  Blox
//
//  Created by Admin on 27/10/16.
//  Copyright © 2016 Admin. All rights reserved.
//

#import "AppDelegate.h"
#import "GoogleAdMob.h"
#import "GameStartController.h"
#define strInterstitialAdsID  @"ca-app-pub-7969708800175875/5090732945"
#define LIVE_INTERSITIAL_ADS @"ca-app-pub-6179892472556727/4177310093"
#define GOGLE_ANALYTICS_TRACKING_ID @"UA-97014601-1"
@interface AppDelegate ()<IAPRequestDelegate,GADInterstitialDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    id<GAITracker> tracker = [[GAI sharedInstance] trackerWithTrackingId:GOGLE_ANALYTICS_TRACKING_ID];
    
    // Provide unhandled exceptions reports.
    [GAI sharedInstance].trackUncaughtExceptions = YES;
    self.hostReachable = [Reachability reachabilityWithHostName:@"www.google.com"] ;
    [self.hostReachable startNotifier];
    // Enable Remarketing, Demographics & Interests reports. Requires the libAdIdAccess library
    // and the AdSupport framework.
    // https://developers.google.com/analytics/devguides/collection/ios/display-features
    tracker.allowIDFACollection = YES;
    self.interstitialAds = [[GADInterstitial alloc] initWithAdUnitID:strInterstitialAdsID];
    self.interstitialAds.delegate = self;
    [self.interstitialAds loadRequest:[GADRequest request]];
    [[GameCenterManager sharedManager] setupManager];
    [[IAPRequest Instance] requestProductWithProductIdentifiers:[[NSSet alloc] initWithObjects:PURCHASE_HUNDRED_LIVES,PURCHASE_FIFTY_LIVES,PURCHASE_THIRTY_LIVES,PURCHASE_TEN_LIVES,PURCHASE_FOUR_LIVES,PURCHASE_LIVES,PURCHASE_REMOVE_ADS, nil] WithDelegate:self];
    [CJPAdController sharedInstance].adNetworks = @[@(CJPAdNetworkAdMob)];
    [CJPAdController sharedInstance].adPosition = CJPAdPositionTop;
    [CJPAdController sharedInstance].initialDelay = 0.2;
    [CJPAdController sharedInstance].overrideIsNavController = NO;
    // AdMob specific
    [CJPAdController sharedInstance].adMobUnitID = GOOGLE_ADMOBS_API_KEY;
    [CJPAdController sharedInstance].useAdMobSmartSize = YES;
    [CJPAdController sharedInstance].testDeviceIDs = @[@"this0is3a2fake8UUID",@"and501sth1s0ne"];
    self.navController = [[UINavigationController alloc] initWithRootViewController:[GameStartController initViewController]];
    self.navController.navigationBar.translucent = NO;
    self.navController.navigationBarHidden = YES;
    [[CJPAdController sharedInstance] startWithViewController:self.navController];
    self.window.rootViewController = [CJPAdController sharedInstance];
    [self.window makeKeyAndVisible];
    if (![ServicePreference getBoolForKey:HAS_LAUNCHED_ONCE]) {
        [ServicePreference setBool:true forKey:HAS_LAUNCHED_ONCE];
    }
    return YES;
}
+(AppDelegate *)appDelegate{
    return (AppDelegate *)[[UIApplication sharedApplication] delegate];
}

-(BOOL)isReachable{
    NetworkStatus networkStatus = [self.hostReachable currentReachabilityStatus];
    return networkStatus != NotReachable;
    
}

#pragma mark GADInterstitialDelegate

-(void)interstitialDidReceiveAd:(GADInterstitial *)ad{
    
}

-(void)interstitialDidDismissScreen:(GADInterstitial *)ad{
    self.interstitialAds = [[GADInterstitial alloc] initWithAdUnitID:strInterstitialAdsID];
    self.interstitialAds.delegate = self;
    [self.interstitialAds loadRequest:[GADRequest request]];
}
-(void)interstitialWillDismissScreen:(GADInterstitial *)ad{
    
}

-(void)interstitialWillPresentScreen:(GADInterstitial *)ad{
   
}

-(void)interstitialWillLeaveApplication:(GADInterstitial *)ad{
    
}



-(void)interstitial:(GADInterstitial *)ad didFailToReceiveAdWithError:(GADRequestError *)error{
    NSLog(@"Error %@",error.description);
    self.interstitialAds = [[GADInterstitial alloc] initWithAdUnitID:LIVE_INTERSITIAL_ADS];
    self.interstitialAds.delegate = self;
    [self.interstitialAds loadRequest:[GADRequest request]];
}

-(void)IAPRequestWithProductIdentifierdidSucceed:(NSMutableArray *)arr{
    NSLog(@"IAP Request Did Succeed");
}

-(void)IAPRequestWithProductIdentifierdidfail{
    NSLog(@"IAP Request Did Fail");
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
