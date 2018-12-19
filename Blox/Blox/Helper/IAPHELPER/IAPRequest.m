//
//  IAPRequest.m
//  Blox
//
//  Created by Admin on 07/02/17.
//  Copyright © 2016 Admin. All rights reserved.
//


#import "IAPRequest.h"
static IAPRequest *singleton = nil;
@implementation IAPRequest

+(IAPRequest *)Instance{
    if (singleton == nil) {
        singleton = [[IAPRequest alloc]init];
        singleton.productsArray = [[NSMutableArray alloc]init];
    }
    return singleton;
}

-(void)requestProductWithProductIdentifiers:(NSSet *)productIdentifiers WithDelegate:(id<IAPRequestDelegate>)del{
    _delegate = del;
    [[HelperClass sharedInstance]requestProducts:productIdentifiers WithCompletionHandler:^(BOOL success, NSArray *products) {
        if (success) {
            _productsArray = [products mutableCopy];
            if (_delegate && [_delegate respondsToSelector:@selector(IAPRequestWithProductIdentifierdidSucceed:)]) {
                [_delegate IAPRequestWithProductIdentifierdidSucceed:[products mutableCopy]];
            }
        }else{
            if (_delegate && [_delegate respondsToSelector:@selector(IAPRequestWithProductIdentifierdidfail)]) {
                [_delegate IAPRequestWithProductIdentifierdidfail];
            }
        }
    }];
}

-(void)buyProductWithProductIdentifier:(NSString *)productidentifier WithDelegate:(id<IAPRequestDelegate>)del{
    _delegate = del;
    NSPredicate *predicate1 = [NSPredicate predicateWithFormat:@"SELF.productIdentifier contains[cd] %@",productidentifier];
    NSArray *temp1 = [_productsArray filteredArrayUsingPredicate:predicate1];
    if (temp1.count > 0) {
        SKProduct *product = (SKProduct *)[temp1 objectAtIndex:0];
        if ([product.productIdentifier isEqual:productidentifier]) {
           [[HelperClass sharedInstance]buyProduct:product WithDelegate:self];
        }
    }
}

-(NSMutableArray *)getRequestedProductsArray{
    return _productsArray;
}
-(BOOL)isRequestedProductExist:(NSString *)productIdentifier{
    NSPredicate *predicate1 = [NSPredicate predicateWithFormat:@"SELF.productIdentifier contains[cd] %@",productIdentifier];
    NSArray *temp1 = [_productsArray filteredArrayUsingPredicate:predicate1];
    if (temp1.count > 0) {
        SKProduct *product = (SKProduct *)[temp1 objectAtIndex:0];
        if ([product.productIdentifier isEqual:productIdentifier]) {
            return YES;
        }
    }
    return NO;
}

- (void)restoreCompletedTransactionsWithDelegate:(id<IAPRequestDelegate>)del{
    _delegate = del;
    [[HelperClass sharedInstance] restoreCompletedTransactionsWithDelegate:self];
}
#pragma mark -TransactionFinishedWithDelegate
-(void)transactionFinished:(SKPaymentTransaction *)transaction{
    if (_delegate && [_delegate respondsToSelector:@selector(IAPRequestDidSuceed:)]) {
        [_delegate IAPRequestDidSuceed:transaction];
    }
}

-(void)transactionFailedWithError:(NSError *)error{
    if (_delegate && [_delegate respondsToSelector:@selector(IAPRequestDidFailWithError:)]) {
        [_delegate IAPRequestDidFailWithError:error];
    }
}
@end
