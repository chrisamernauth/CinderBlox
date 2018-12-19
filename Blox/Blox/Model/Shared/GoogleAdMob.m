//
//  GoogleAdMob.m
//  Blox
//
//  Created by Admin on 18/03/17.
//  Copyright © 2017 Admin. All rights reserved.
//

#import "GoogleAdMob.h"
#define kSCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define kSCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height
#define kHEIGHT (CGFloat)([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPad)?90:50
@interface GoogleAdMob()<GADBannerViewDelegate,GADInterstitialDelegate>

@property(nonatomic,assign)BOOL isInitializeBannerView;
@property(nonatomic,assign)BOOL isInitializeInterstitial;
@property(nonatomic,assign)BOOL isBannerViewDisplay;
@property(nonatomic,strong)GADInterstitial *interstitialAds;
@property(nonatomic,strong)GADBannerView *bannerView;
@property(nonatomic,assign)BOOL isBannerLiveID;
@property(nonatomic,assign)BOOL isInterstitialLiveID;
@end

@implementation GoogleAdMob
+ (GoogleAdMob *)sharedInstance
{
    static GoogleAdMob *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    
    return sharedInstance;
}

-(instancetype)init{
    if (self = [super init]) {
        
    }
    return self;
}

-(void)initializeBannerView:(BOOL)liveunitid{
    self.isInitializeBannerView = true;
    self.isBannerLiveID = liveunitid;
    [self createBannerView];
}

-(void)createBannerView{
    if ([UIApplication sharedApplication].keyWindow.rootViewController == nil) {
        [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(createBannerView) object:nil];
    }else{
        self.isBannerViewDisplay = true;
        self.bannerView = [[GADBannerView alloc] initWithFrame:CGRectMake(0, kSCREEN_HEIGHT-kHEIGHT, kSCREEN_WIDTH, kSCREEN_HEIGHT)];
    }
    if (self.isBannerLiveID) {
        self.bannerView.adUnitID = strBannerAdsID;
        
    }else{
        self.bannerView.adUnitID = kTEST_ID;
    }
    self.bannerView.rootViewController = [UIApplication sharedApplication].keyWindow.rootViewController;
    self.bannerView.delegate = self;
    [self.bannerView loadRequest:[GADRequest request]];
    [[UIApplication sharedApplication].keyWindow addSubview:self.bannerView];
}

-(void)showBannerView{
    self.isBannerViewDisplay = true;
    if (!_isInitializeBannerView) {
        NSLog(@"Initialize Bannerview");
    }else{
        self.bannerView.hidden = YES;
        [UIView animateWithDuration:0.3 animations:^{
            self.bannerView = [[GADBannerView alloc] initWithFrame:CGRectMake(0, kSCREEN_HEIGHT-kHEIGHT, kSCREEN_WIDTH, kSCREEN_HEIGHT)];
        } completion:^(BOOL finished) {
            
        }];
    }
}

-(void)hideBannerView{
    self.isBannerViewDisplay = false;
    if (self.bannerView != nil) {
        [UIView animateWithDuration:0.3 animations:^{
            self.bannerView = [[GADBannerView alloc] initWithFrame:CGRectMake(0, kSCREEN_HEIGHT, kSCREEN_WIDTH, kSCREEN_HEIGHT)];
        } completion:^(BOOL finished) {
            
        }];
    }
}

-(void)showBanner{
    if (self.bannerView != nil && self.isBannerViewDisplay == true) {
        self.bannerView.hidden = YES;
    }
}

-(void)hideBanner{
    if (self.bannerView != nil ) {
        self.bannerView.hidden = true;
    }
}

#pragma mark - GADBannerViewDelegate

-(void)adViewDidReceiveAd:(GADBannerView *)bannerView{
}

-(void)adViewDidDismissScreen:(GADBannerView *)bannerView{
}

-(void)adViewWillDismissScreen:(GADBannerView *)bannerView{
}

-(void)adViewWillPresentScreen:(GADBannerView *)bannerView{

}

-(void)adViewWillLeaveApplication:(GADBannerView *)bannerView{

}

-(void)adView:(GADBannerView *)bannerView didFailToReceiveAdWithError:(GADRequestError *)error{

}

-(void)initalizeIntersitial:(BOOL)liveunitid{
    self.isInitializeInterstitial = true;
    self.isInterstitialLiveID = liveunitid;
    [self createIntersitial];
}

-(void)createIntersitial{
//    if (!self.isInterstitialLiveID) {
//        self.interstitialAds = [[GADInterstitial alloc] initWithAdUnitID:strInterstitialAdsID];
//    }else{
//        self.interstitialAds = [[GADInterstitial alloc] initWithAdUnitID:strInterstitialAdsID];
//    }
    self.interstitialAds.delegate = self;
    [self.interstitialAds loadRequest:[GADRequest request]];
}

-(void)showIntersitial{
    if (!self.isInitializeInterstitial) {
        NSLog(@"First Intializer Intersitial Ads");
    }else{
        if (self.interstitialAds.isReady) {
            [self.interstitialAds presentFromRootViewController:[UIApplication sharedApplication].keyWindow.rootViewController];
        }else{
            [self createIntersitial];
        }
    }
}

#pragma mark GADInterstitialDelegate

-(void)interstitialDidReceiveAd:(GADInterstitial *)ad{

}

-(void)interstitialDidDismissScreen:(GADInterstitial *)ad{
    [self createIntersitial];
}
-(void)interstitialWillDismissScreen:(GADInterstitial *)ad{
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(showBanner) object:nil];
    [self performSelector:@selector(showBanner) withObject:nil afterDelay:0.1f];
}

-(void)interstitialWillPresentScreen:(GADInterstitial *)ad{
    [self hideBanner];
}

-(void)interstitialWillLeaveApplication:(GADInterstitial *)ad{

}



-(void)interstitial:(GADInterstitial *)ad didFailToReceiveAdWithError:(GADRequestError *)error{

}

@end
