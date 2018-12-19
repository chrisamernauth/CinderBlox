//
//  PurchaseLivesController.h
//  Blox
//
//  Created by Admin on 19/02/17.
//  Copyright © 2017 Admin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PurchaseLivesController : GAITrackedViewController
{
    __weak IBOutlet UIImageView *imgView;
}
+(PurchaseLivesController *)initViewController;
-(IBAction)btnPurchaseLivesClicked:(id)sender;
-(IBAction)btnPurchaseHundredLivesClicked:(id)sender;
-(IBAction)btnPurchaseFiftyLivesClicked:(id)sender;
-(IBAction)btnPurchaseThirtyLivesClicked:(id)sender;
-(IBAction)btnPurchaseTenLivesClicked:(id)sender;
-(IBAction)btnPurchaseFourLivesClicked:(id)sender;
-(IBAction)btnContinueClicked:(id)sender;


@end
