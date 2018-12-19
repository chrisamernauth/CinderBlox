//
//  NoAdsController.h
//  Blox
//
//  Created by Admin on 19/02/17.
//  Copyright © 2017 Admin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NoAdsController : GAITrackedViewController
{
    __weak IBOutlet UIImageView *imgView;
}

+(NoAdsController *)initViewController;
-(IBAction)btnNoAdsClicked:(id)sender;
@end
