//
//  GameStartController.m
//  Blox
//
//  Created by Admin on 19/01/17.
//  Copyright © 2017 Admin. All rights reserved.
//

#import "GameStartController.h"
#import "InstructionViewController.h"
#import "NoAdsController.h"
#import "GoogleAdMob.h"
#import "PurchaseLivesController.h"
#import "StartScene.h"
@interface GameStartController ()<IAPRequestDelegate>

@end

@implementation GameStartController

+(GameStartController *)initViewController{
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    GameStartController *controller = [sb instantiateViewControllerWithIdentifier:@"GameStartController"];
    return controller;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.screenName = @"Game Start Screen";
    // Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;

}

-(void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    SKView * skView = (SKView *)self.view;
    // Load the SKScene from 'GameScene.sks'
    SKScene * scene = [StartScene sceneWithSize:skView.bounds.size];
    scene.scaleMode = SKSceneScaleModeAspectFill;
    
    // Present the scene.
    [skView presentScene:scene];
    
    // Present the scene
    // [skView presentScene:scene];
    
    skView.showsFPS = NO;
    skView.showsNodeCount = NO;
    
}

- (BOOL)shouldAutorotate {
    return YES;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return UIInterfaceOrientationMaskAllButUpsideDown;
    } else {
        return UIInterfaceOrientationMaskAll;
    }
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBarHidden = NO;
   }

-(void)btnGameInfoClicked:(id)sender{
    InstructionViewController *controller = [InstructionViewController initViewController];
    CJPAdController *cjpcontroller = [CJPAdController sharedInstance];
    UINavigationController *navigationController = (UINavigationController *)cjpcontroller.contentController;
     [navigationController pushViewController:controller animated:YES];

}

-(void)btnGameLivesClicked:(id)sender{
    PurchaseLivesController *controller = [PurchaseLivesController initViewController];
    CJPAdController *cjpcontroller = [CJPAdController sharedInstance];
    UINavigationController *navigationController = (UINavigationController *)cjpcontroller.contentController;
    [navigationController pushViewController:controller animated:YES];
}

-(void)btnGameAdsClicked:(id)sender{
    NoAdsController *controller = [NoAdsController initViewController];
    CJPAdController *cjpcontroller = [CJPAdController sharedInstance];
    UINavigationController *navigationController = (UINavigationController *)cjpcontroller.contentController;
    [navigationController pushViewController:controller animated:YES];
    
}

-(void)btnGameScoreClicked:(id)sender{
    [[GameCenterManager sharedManager] presentLeaderboardsOnViewController:self withLeaderboard:GAME_CENTER_LEADERBOARD];
}

-(void)btnGameStartClicked:(id)sender{
    [self performSegueWithIdentifier:@"gamestartidentifier" sender:sender];
}

-(void)btnRestorePurchaseCicked:(id)sender{
    if ([[AppDelegate appDelegate] isReachable]) {
        [SVProgressHUD show];
        [[IAPRequest Instance] restoreCompletedTransactionsWithDelegate:self];
    }else{
        [[ShowAlertClass instantiateClass] showAlertWithTitle:ALERT_TITLE message:kNO_CONNECTION_MESSAGE handler:nil withAlertButtons:@[@"Ok"] target:self];
    }
    
}

-(void)IAPRequestDidSuceed:(SKPaymentTransaction *)transaction{
    [SVProgressHUD dismiss];
    NSInteger purchasedlives = [ServicePreference getIntegerForKey:PURCHASE_LIVES];
    if ([transaction.payment.productIdentifier isEqualToString:PURCHASE_LIVES]) {
        [ServicePreference setInteger:purchasedlives+1 forKey:PURCHASE_LIVES];
    }else if ([transaction.payment.productIdentifier isEqualToString:PURCHASE_HUNDRED_LIVES]){
        [ServicePreference setInteger:purchasedlives+100 forKey:PURCHASE_LIVES];
    }else if ([transaction.payment.productIdentifier isEqualToString:PURCHASE_FIFTY_LIVES]){
        [ServicePreference setInteger:purchasedlives+50 forKey:PURCHASE_LIVES];
    }else if ([transaction.payment.productIdentifier isEqualToString:PURCHASE_THIRTY_LIVES]){
        [ServicePreference setInteger:purchasedlives+30 forKey:PURCHASE_LIVES];
    }else if ([transaction.payment.productIdentifier isEqualToString:PURCHASE_TEN_LIVES]){
        [ServicePreference setInteger:purchasedlives+10 forKey:PURCHASE_LIVES];
    }else if ([transaction.payment.productIdentifier isEqualToString:PURCHASE_FOUR_LIVES]){
        [ServicePreference setInteger:purchasedlives+4 forKey:PURCHASE_LIVES];
    }
    else if ([transaction.payment.productIdentifier isEqualToString:PURCHASE_REMOVE_ADS]){
        [[CJPAdController sharedInstance] removeAdsAndMakePermanent:YES andRemember:YES];
        [ServicePreference setBool:true forKey:INTERSITIAL_REMOVE_ADS];
    }
   
    
}

-(void)IAPRequestDidFailWithError:(NSError *)error{
    [SVProgressHUD dismiss];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)prefersStatusBarHidden {
    return YES;
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
