//
//  Constants.h
//  Blox
//
//  Created by Admin on 12/11/16.
//  Copyright © 2016 Admin. All rights reserved.
//

#ifndef Constants_h
#define Constants_h

#define ALERT_TITLE @"Cinder Blox"
#define NODE_ACTION_KEY @"EndlessAction"
#define CLOUD_ACTION_KEY @"CloudEndlessAction"
#define CLOUD_ACTION_REMOVE_KEY @"CloudEndlessActionRemove"
#define GOOGLE_ADMOBS_API_KEY @"ca-app-pub-6179892472556727/6458613299"
#define HIGHSCORE @"HighScore"
#define CURRENT_SCORE @"CurrentScore"
#define IAP_REMOVE_ADS @"RemoveAds"
#define HAS_LAUNCHED_ONCE @"HasLaunchedOnce"
#define GAME_OVER_TIMES @"GAME_OVER_TIMES"
////////////////////////////////InAppPurchase////////////////////////////////////
#define PURCHASE_LIVES @"com.blox.lives"
#define PURCHASE_HUNDRED_LIVES @"com.blox.hundredlives"
#define PURCHASE_FIFTY_LIVES @"com.blox.fiftylives"
#define PURCHASE_THIRTY_LIVES @"com.blox.thirtylives"
#define PURCHASE_TEN_LIVES @"com.blox.tenlives"
#define PURCHASE_FOUR_LIVES @"com.blox.fourlives"
#define PURCHASE_REMOVE_ADS @"com.blox.ads"
/////////////////////////////////////////////////////////////////////////////////


#define GAME_CENTER_LEADERBOARD @"com.cfbrands.blox.HighScores"
#define INTERSITIAL_REMOVE_ADS @"removeAdsPurchased"
#define kNO_CONNECTION_MESSAGE @"Please check your internet connection"
#define isIPhone (![[UIDevice currentDevice] respondsToSelector:@selector(userInterfaceIdiom)] || [[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)

#endif /* Constants_h */
