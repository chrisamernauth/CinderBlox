//
//  NoAdsController.m
//  Blox
//
//  Created by Admin on 19/02/17.
//  Copyright © 2017 Admin. All rights reserved.
//

#import "NoAdsController.h"

@interface NoAdsController ()<IAPRequestDelegate>

@end

@implementation NoAdsController

+(NoAdsController *)initViewController{
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    NoAdsController *controller = [sb instantiateViewControllerWithIdentifier:@"NoAdsController"];
    return controller;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.screenName = @"No Ads Screen";
     self.navigationController.navigationBar.hidden = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleImageTap:)];
    tap.cancelsTouchesInView = YES;
    tap.numberOfTapsRequired = 1;
    [imgView addGestureRecognizer:tap];
    // Do any additional setup after loading the view.
}

- (void) handleImageTap:(UIGestureRecognizer *)gestureRecognizer {
     [self.navigationController popViewControllerAnimated:YES];
}

-(void)btnNoAdsClicked:(id)sender{
    if ([[AppDelegate appDelegate] isReachable]) {
        [SVProgressHUD show];
        [[IAPRequest Instance] buyProductWithProductIdentifier:PURCHASE_REMOVE_ADS WithDelegate:self];
    }else{
        [[ShowAlertClass instantiateClass] showAlertWithTitle:ALERT_TITLE message:kNO_CONNECTION_MESSAGE handler:nil withAlertButtons:@[@"Ok"] target:self];
    }
   
}

-(void)btnContinueClicked:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];
}



-(void)IAPRequestDidSuceed:(SKPaymentTransaction *)transaction{
    [SVProgressHUD dismiss];
    [[CJPAdController sharedInstance] removeAdsAndMakePermanent:YES andRemember:YES];
    [ServicePreference setBool:true forKey:INTERSITIAL_REMOVE_ADS];
    id<GAITracker> tracker = [[GAI sharedInstance] defaultTracker];
    GAIDictionaryBuilder *builder = [GAIDictionaryBuilder createScreenView];
    GAIEcommerceProductAction *action = [[GAIEcommerceProductAction alloc] init];
    [action setAction:kGAIPAPurchase];
    [action setTransactionId:transaction.transactionIdentifier];
    [action setRevenue:@0.99];
    [builder setProductAction:action];
    GAIEcommerceProduct *product = [[GAIEcommerceProduct alloc] init];
    [product setId:@"PID-4321"];
    [product setName:@"Purchase No Ads"];
    [product setPrice:@0.99];
    [product setQuantity:@1];
    [builder addProduct:product];
    [tracker send:[builder build]];

}

-(void)IAPRequestDidFailWithError:(NSError *)error{
    [SVProgressHUD dismiss];
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
