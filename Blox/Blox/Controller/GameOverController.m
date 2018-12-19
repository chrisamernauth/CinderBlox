//
//  GameOverController.m
//  Blox
//
//  Created by Admin on 17/12/16.
//  Copyright © 2016 Admin. All rights reserved.
//

#import "GameOverController.h"
#import "ServicePreference.h"
#import "PurchaseLivesController.h"
@interface GameOverController ()

@end

@implementation GameOverController

+(GameOverController *)initViewController{
    UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    GameOverController *controller = [storyboard instantiateViewControllerWithIdentifier:@"gameoveridentifier"];
    
    return controller;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.screenName = @"Game Over Screen";
    lblHighScore.text = [NSString stringWithFormat:@"%ld",(long)[ServicePreference getIntegerForKey:HIGHSCORE]];
    lblScore.text = self.score;

    [self performSelector:@selector(showAlert) withObject:nil afterDelay:0.3f];
   
    // Do any additional setup after loading the view from its nib.
}

-(void)showAlert{
    NSInteger game_over_times = [ServicePreference getIntegerForKey:GAME_OVER_TIMES];
    BOOL status = [ServicePreference getBoolForKey:INTERSITIAL_REMOVE_ADS];
    if (!status) {
        
        if ((game_over_times % 2 == 0)) {
//            __block CJPAdController *cjpcontroller = [CJPAdController sharedInstance];
//            UINavigationController *navigationController = (UINavigationController *)cjpcontroller.contentController;
//            [[ShowAlertClass instantiateClass] showAlertWithTitle:ALERT_TITLE message:@"Do you want buy more lives?" handler:^(NSInteger buttonIndex) {
//                if (buttonIndex == 0) {
//                    PurchaseLivesController *controller = [PurchaseLivesController initViewController];
//                    [navigationController pushViewController:controller animated:YES];
//                }
//            } withAlertButtons:@[@"Buy More Lives",@"Cancel"] target:navigationController];
        }
    }else{
        __block CJPAdController *cjpcontroller = [CJPAdController sharedInstance];
        UINavigationController *navigationController = (UINavigationController *)cjpcontroller.contentController;
        [[ShowAlertClass instantiateClass] showAlertWithTitle:ALERT_TITLE message:@"Do you want buy more lives?" handler:^(NSInteger buttonIndex) {
            if (buttonIndex == 0) {
                PurchaseLivesController *controller = [PurchaseLivesController initViewController];
                [navigationController pushViewController:controller animated:YES];
            }
        } withAlertButtons:@[@"Buy More Lives",@"Cancel"] target:navigationController];
    }
    [ServicePreference setInteger:game_over_times+1 forKey:GAME_OVER_TIMES];
}

-(void)btnTryAgainClicked:(id)sender{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"RESTART_GAME" object:nil];
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)navigateToMainScreen:(id)sender{
    //[[NSNotificationCenter defaultCenter] postNotificationName:@"RESTART_GAME" object:nil];
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
