//
//  GameOverController.h
//  Blox
//
//  Created by Admin on 17/12/16.
//  Copyright © 2016 Admin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GameOverController : GAITrackedViewController
{
    __weak IBOutlet UILabel *lblHighScore;
    __weak IBOutlet UILabel *lblScore;
}
@property(nonatomic,strong)NSString *score;
+(GameOverController *)initViewController;

-(IBAction)btnTryAgainClicked:(id)sender;
-(IBAction)navigateToMainScreen:(id)sender;
@end
