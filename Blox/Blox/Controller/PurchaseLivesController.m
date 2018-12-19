//
//  PurchaseLivesController.m
//  Blox
//
//  Created by Admin on 19/02/17.
//  Copyright © 2017 Admin. All rights reserved.
//

#import "PurchaseLivesController.h"

@interface PurchaseLivesController ()<IAPRequestDelegate>

@end

@implementation PurchaseLivesController

+(PurchaseLivesController *)initViewController{
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    PurchaseLivesController *controller = [sb instantiateViewControllerWithIdentifier:@"PurchaseLivesController"];
    return controller;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.screenName = @"Purchase Lives Screen";
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

-(void)btnPurchaseLivesClicked:(id)sender{
    if ([[AppDelegate appDelegate] isReachable]) {
        [SVProgressHUD show];
        [[IAPRequest Instance] buyProductWithProductIdentifier:PURCHASE_LIVES WithDelegate:self];
    }else{
         [[ShowAlertClass instantiateClass] showAlertWithTitle:ALERT_TITLE message:kNO_CONNECTION_MESSAGE handler:nil withAlertButtons:@[@"Ok"] target:self];
    }
    
}

-(void)btnPurchaseHundredLivesClicked:(id)sender{
    if ([[AppDelegate appDelegate] isReachable]) {
        [SVProgressHUD show];
        [[IAPRequest Instance] buyProductWithProductIdentifier:PURCHASE_HUNDRED_LIVES WithDelegate:self];
    }else{
        [[ShowAlertClass instantiateClass] showAlertWithTitle:ALERT_TITLE message:kNO_CONNECTION_MESSAGE handler:nil withAlertButtons:@[@"Ok"] target:self];
    }
   
}

-(void)btnPurchaseFiftyLivesClicked:(id)sender{
    if ([[AppDelegate appDelegate] isReachable]) {
        [SVProgressHUD show];
        [[IAPRequest Instance] buyProductWithProductIdentifier:PURCHASE_FIFTY_LIVES WithDelegate:self];
    }else{
         [[ShowAlertClass instantiateClass] showAlertWithTitle:ALERT_TITLE message:kNO_CONNECTION_MESSAGE handler:nil withAlertButtons:@[@"Ok"] target:self];
    }
}

-(void)btnPurchaseThirtyLivesClicked:(id)sender{
    if ([[AppDelegate appDelegate] isReachable]) {
        [SVProgressHUD show];
        [[IAPRequest Instance] buyProductWithProductIdentifier:PURCHASE_THIRTY_LIVES WithDelegate:self];
    }else{
        [[ShowAlertClass instantiateClass] showAlertWithTitle:ALERT_TITLE message:kNO_CONNECTION_MESSAGE handler:nil withAlertButtons:@[@"Ok"] target:self];
    }
    
}

-(void)btnPurchaseTenLivesClicked:(id)sender{
    if ([[AppDelegate appDelegate] isReachable]) {
        [SVProgressHUD show];
        [[IAPRequest Instance] buyProductWithProductIdentifier:PURCHASE_TEN_LIVES WithDelegate:self];
    }else{
        [[ShowAlertClass instantiateClass] showAlertWithTitle:ALERT_TITLE message:kNO_CONNECTION_MESSAGE handler:nil withAlertButtons:@[@"Ok"] target:self];
    }
   
}

-(void)btnPurchaseFourLivesClicked:(id)sender{
    if ([[AppDelegate appDelegate] isReachable]) {
        [SVProgressHUD show];
        [[IAPRequest Instance] buyProductWithProductIdentifier:PURCHASE_FOUR_LIVES WithDelegate:self];
    }else{
        [[ShowAlertClass instantiateClass] showAlertWithTitle:ALERT_TITLE message:kNO_CONNECTION_MESSAGE handler:nil withAlertButtons:@[@"Ok"] target:self];
    }
  
}

-(void)btnContinueClicked:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];
}



-(void)IAPRequestDidSuceed:(SKPaymentTransaction *)transaction{
    [SVProgressHUD dismiss];
    NSInteger purchasedlives = [ServicePreference getIntegerForKey:PURCHASE_LIVES];
    if ([transaction.payment.productIdentifier isEqualToString:PURCHASE_LIVES]) {
        [ServicePreference setInteger:purchasedlives+1 forKey:PURCHASE_LIVES];
        id<GAITracker> tracker = [[GAI sharedInstance] defaultTracker];
        GAIDictionaryBuilder *builder = [GAIDictionaryBuilder createScreenView];
        GAIEcommerceProductAction *action = [[GAIEcommerceProductAction alloc] init];
        [action setAction:kGAIPAPurchase];
        [action setTransactionId:transaction.transactionIdentifier];
        [action setRevenue:@0.99];
        [builder setProductAction:action];
        GAIEcommerceProduct *product = [[GAIEcommerceProduct alloc] init];
        [product setId:@"PID-1234"];
        [product setName:@"Purchase Lives"];
        [product setPrice:@0.99];
        [product setQuantity:@1];
        [builder addProduct:product];
        [tracker send:[builder build]];
    }else if ([transaction.payment.productIdentifier isEqualToString:PURCHASE_HUNDRED_LIVES]){
        [ServicePreference setInteger:purchasedlives+100 forKey:PURCHASE_LIVES];
        id<GAITracker> tracker = [[GAI sharedInstance] defaultTracker];
        GAIDictionaryBuilder *builder = [GAIDictionaryBuilder createScreenView];
        GAIEcommerceProductAction *action = [[GAIEcommerceProductAction alloc] init];
        [action setAction:kGAIPAPurchase];
        [action setTransactionId:transaction.transactionIdentifier];
        [action setRevenue:@49.99];
        [builder setProductAction:action];
        GAIEcommerceProduct *product = [[GAIEcommerceProduct alloc] init];
        [product setId:@"PID-1235"];
        [product setName:@"Purchase Hundred Lives"];
        [product setPrice:@49.99];
        [product setQuantity:@1];
        [builder addProduct:product];
        [tracker send:[builder build]];
    
    }else if ([transaction.payment.productIdentifier isEqualToString:PURCHASE_FIFTY_LIVES]){
        [ServicePreference setInteger:purchasedlives+50 forKey:PURCHASE_LIVES];
        id<GAITracker> tracker = [[GAI sharedInstance] defaultTracker];
        GAIDictionaryBuilder *builder = [GAIDictionaryBuilder createScreenView];
        GAIEcommerceProductAction *action = [[GAIEcommerceProductAction alloc] init];
        [action setAction:kGAIPAPurchase];
        [action setTransactionId:transaction.transactionIdentifier];
        [action setRevenue:@19.99];
        [builder setProductAction:action];
        GAIEcommerceProduct *product = [[GAIEcommerceProduct alloc] init];
        [product setId:@"PID-1236"];
        [product setName:@"Purchase Fifty Lives"];
        [product setPrice:@19.99];
        [product setQuantity:@1];
        [builder addProduct:product];
        [tracker send:[builder build]];
    
    }else if ([transaction.payment.productIdentifier isEqualToString:PURCHASE_THIRTY_LIVES]){
        [ServicePreference setInteger:purchasedlives+30 forKey:PURCHASE_LIVES];
        id<GAITracker> tracker = [[GAI sharedInstance] defaultTracker];
        GAIDictionaryBuilder *builder = [GAIDictionaryBuilder createScreenView];
        GAIEcommerceProductAction *action = [[GAIEcommerceProductAction alloc] init];
        [action setAction:kGAIPAPurchase];
        [action setTransactionId:transaction.transactionIdentifier];
        [action setRevenue:@9.99];
        [builder setProductAction:action];
        GAIEcommerceProduct *product = [[GAIEcommerceProduct alloc] init];
        [product setId:@"PID-1237"];
        [product setName:@"Purchase Thirty Lives"];
        [product setPrice:@9.99];
        [product setQuantity:@1];
        [builder addProduct:product];
        [tracker send:[builder build]];
    }else if ([transaction.payment.productIdentifier isEqualToString:PURCHASE_TEN_LIVES]){
        [ServicePreference setInteger:purchasedlives+10 forKey:PURCHASE_LIVES];
        id<GAITracker> tracker = [[GAI sharedInstance] defaultTracker];
        GAIDictionaryBuilder *builder = [GAIDictionaryBuilder createScreenView];
        GAIEcommerceProductAction *action = [[GAIEcommerceProductAction alloc] init];
        [action setAction:kGAIPAPurchase];
        [action setTransactionId:transaction.transactionIdentifier];
        [action setRevenue:@4.99];
        [builder setProductAction:action];
        GAIEcommerceProduct *product = [[GAIEcommerceProduct alloc] init];
        [product setId:@"PID-1238"];
        [product setName:@"Purchase Ten Lives"];
        [product setPrice:@4.99];
        [product setQuantity:@1];
        [builder addProduct:product];
        [tracker send:[builder build]];
        
    }else if ([transaction.payment.productIdentifier isEqualToString:PURCHASE_FOUR_LIVES]){
        [ServicePreference setInteger:purchasedlives+4 forKey:PURCHASE_LIVES];
        id<GAITracker> tracker = [[GAI sharedInstance] defaultTracker];
        GAIDictionaryBuilder *builder = [GAIDictionaryBuilder createScreenView];
        GAIEcommerceProductAction *action = [[GAIEcommerceProductAction alloc] init];
        [action setAction:kGAIPAPurchase];
        [action setTransactionId:transaction.transactionIdentifier];
        [action setRevenue:@2.99];
        [builder setProductAction:action];
        GAIEcommerceProduct *product = [[GAIEcommerceProduct alloc] init];
        [product setId:@"PID-1239"];
        [product setName:@"Purchase Four Lives"];
        [product setPrice:@2.99];
        [product setQuantity:@1];
        [builder addProduct:product];
        [tracker send:[builder build]];
        
    }
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
