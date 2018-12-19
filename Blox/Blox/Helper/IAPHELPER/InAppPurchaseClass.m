//  Blox
//
//  Created by Admin on 07/02/17.
//  Copyright © 2016 Admin. All rights reserved.
//


#import "InAppPurchaseClass.h"
#import <StoreKit/StoreKit.h>
NSString *const InAppProductPurchasedNotification = @"InAppProductPurchasedNotification";
@interface InAppPurchaseClass () <SKProductsRequestDelegate>
@end
@implementation InAppPurchaseClass{
    // 3
    SKProductsRequest * _productsRequest;
    // 4
    RequestProductsCompletionHandler _completionHandler;
    NSSet * _productIdentifiers;
    NSMutableSet * _purchasedProductIdentifiers;
}
- (id)initWithProductIdentifiers:(NSSet *)productIdentifiers {
    
    if ((self = [super init])) {
        // Store product identifiers
        _productIdentifiers = productIdentifiers;
        // Check for previously purchased products
        _purchasedProductIdentifiers = [NSMutableSet set];
        for (NSString * productIdentifier in _productIdentifiers) {
            BOOL productPurchased = [[NSUserDefaults standardUserDefaults] boolForKey:productIdentifier];
            if (productPurchased) {
                [_purchasedProductIdentifiers addObject:productIdentifier];
                NSLog(@"Previously purchased: %@", productIdentifier);
            } else {
                NSLog(@"Not purchased: %@", productIdentifier);
            }
        }
   [[SKPaymentQueue defaultQueue] addTransactionObserver:self];
    }
    return self;
}
- (void)requestProductsWithCompletionHandler:(RequestProductsCompletionHandler)completionHandler {
    
    // 1
    _completionHandler = [completionHandler copy];
    
    // 2
    _productsRequest = [[SKProductsRequest alloc] initWithProductIdentifiers:_productIdentifiers];
    _productsRequest.delegate = self;
    [_productsRequest start];
    
}

-(void)requestProducts:(NSSet *)productIdentifiers WithCompletionHandler:(RequestProductsCompletionHandler)completionHandler{
    _completionHandler = [completionHandler copy];
    
    // 2
    _productsRequest = [[SKProductsRequest alloc] initWithProductIdentifiers:productIdentifiers];
    _productsRequest.delegate = self;
    [_productsRequest start];
}
- (void)productsRequest:(SKProductsRequest *)request didReceiveResponse:(SKProductsResponse *)response {
        NSLog(@"Loaded list of products...");
   // [[ActivityIndicator currentIndicator]displayCompleted];
        _productsRequest = nil;
    
        NSArray * skProducts = response.products;
        for (SKProduct * skProduct in skProducts) {
            NSLog(@"Found product: %@ %@ %0.2f",
                  skProduct.productIdentifier,
                  skProduct.localizedTitle,
                  skProduct.price.floatValue);
        }
    @try {
        if (_completionHandler) {
            _completionHandler(YES, skProducts);
            _completionHandler = nil;
        }
    }
    @catch (NSException *exception) {
        NSLog(@"some exception occured");
    }
    @finally {
        NSLog(@"some exception occured");
    }
}

- (void)request:(SKRequest *)request didFailWithError:(NSError *)error {
    // [[ActivityIndicator currentIndicator]displayCompleted];
    NSLog(@"Failed to load list of products.");
    _productsRequest = nil;
    
    _completionHandler(NO, nil);
    _completionHandler = nil;
    
}
- (BOOL)productPurchased:(NSString *)productIdentifier {
    return [_purchasedProductIdentifiers containsObject:productIdentifier];
}

- (void)buyProduct:(SKProduct *)product WithDelegate:(id<TransactionFinishedWithDelegate>)del{
    _delegate = del;
    NSLog(@"Buying %@...", product.productIdentifier);
    
    SKPayment * payment = [SKPayment paymentWithProduct:product];
    [[SKPaymentQueue defaultQueue] addPayment:payment];
    
}
- (void)paymentQueue:(SKPaymentQueue *)queue updatedTransactions:(NSArray *)transactions
{
    for (SKPaymentTransaction * transaction in transactions) {
        switch (transaction.transactionState)
        {
            case SKPaymentTransactionStatePurchased:
                [self completeTransaction:transaction];
                break;
            case SKPaymentTransactionStateFailed:
                [self failedTransaction:transaction];
                break;
            case SKPaymentTransactionStateRestored:
                [self restoreTransaction:transaction];
            default:
                break;
        }
    };
}
- (void)completeTransaction:(SKPaymentTransaction *)transaction
{
    NSLog(@"completeTransaction...");
    [self provideContentForProductIdentifier:transaction.payment.productIdentifier];
    [[SKPaymentQueue defaultQueue] finishTransaction:transaction];
    if(_delegate && [_delegate respondsToSelector:@selector(transactionFinished:)]){
        [_delegate transactionFinished:transaction];
    }
    //[[SKPaymentQueue defaultQueue]removeTransactionObserver:self];
}
- (void)restoreTransaction:(SKPaymentTransaction *)transaction {
    NSLog(@"restoreTransaction...");
    [self provideContentForProductIdentifier:transaction.originalTransaction.payment.productIdentifier];
    [[SKPaymentQueue defaultQueue] finishTransaction:transaction];
    if(_delegate && [_delegate respondsToSelector:@selector(transactionFinished:)]){
        [_delegate transactionFinished:transaction];
    }
    }

- (void)restoreCompletedTransactionsWithDelegate:(id<TransactionFinishedWithDelegate>)del {
    _delegate = del;
    [[SKPaymentQueue defaultQueue] restoreCompletedTransactions];
}
- (void)failedTransaction:(SKPaymentTransaction *)transaction {
    //[[ActivityIndicator currentIndicator]displayCompleted];
    NSLog(@"failedTransaction...");
    if (transaction.error.code != SKErrorPaymentCancelled)
    {
        NSLog(@"Transaction error: %@", transaction.error.localizedDescription);
    }
    
    [[SKPaymentQueue defaultQueue] finishTransaction: transaction];
    if (_delegate && [_delegate respondsToSelector:@selector(transactionFailedWithError:)]) {
        [_delegate transactionFailedWithError:transaction.error];
    }
}
- (void)provideContentForProductIdentifier:(NSString *)productIdentifier {
    
    [_purchasedProductIdentifiers addObject:productIdentifier];
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:productIdentifier];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [[NSNotificationCenter defaultCenter] postNotificationName:InAppProductPurchasedNotification object:productIdentifier userInfo:nil];
    
}

-(void)paymentQueueRestoreCompletedTransactionsFinished:(SKPaymentQueue *)queue{
    
}

-(void)paymentQueue:(SKPaymentQueue *)queue restoreCompletedTransactionsFailedWithError:(NSError *)error{
    if (_delegate && [_delegate respondsToSelector:@selector(transactionFailedWithError:)]) {
        [_delegate transactionFailedWithError:error];
    }
}
@end
