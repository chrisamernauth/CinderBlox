//
//  GoogleAdMob.h
//  Blox
//
//  Created by Admin on 18/03/17.
//  Copyright © 2017 Admin. All rights reserved.
//

#import <Foundation/Foundation.h>


#define strBannerAdsID  @"ca-app-pub-7969708800175875/6567466149"
#define kTEST_ID @"ca-app-pub-7969708800175875/6567466149"
@interface GoogleAdMob : NSObject

+(GoogleAdMob *)sharedInstance;
-(void)initializeBannerView:(BOOL)liveunitid;
-(void)initalizeIntersitial:(BOOL)liveunitid;
-(void)showBannerView;
-(void)showIntersitial;
-(void)hideBannerView;
@end
