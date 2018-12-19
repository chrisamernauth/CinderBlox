//
//  GameStartController.h
//  Blox
//
//  Created by Admin on 19/01/17.
//  Copyright © 2017 Admin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GameStartController : GAITrackedViewController


+(GameStartController *)initViewController;

-(IBAction)btnGameScoreClicked:(id)sender;
-(IBAction)btnGameStartClicked:(id)sender;
-(IBAction)btnGameInfoClicked:(id)sender;
-(IBAction)btnGameLivesClicked:(id)sender;
-(IBAction)btnGameAdsClicked:(id)sender;
-(IBAction)btnRestorePurchaseCicked:(id)sender;
@end
