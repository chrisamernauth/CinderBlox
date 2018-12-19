//  Blox
//
//  Created by Admin on 07/02/17.
//  Copyright © 2016 Admin. All rights reserved.
//



#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import <StoreKit/StoreKit.h>

@protocol TransactionFinishedWithDelegate<NSObject>
@optional
-(void)transactionFinished:(SKPaymentTransaction *)transaction;
-(void)transactionFailedWithError:(NSError *)error;


@end
UIKIT_EXTERN NSString *const InAppProductPurchasedNotification;
typedef void (^RequestProductsCompletionHandler)(BOOL success, NSArray * products);

@interface InAppPurchaseClass : NSObject<SKProductsRequestDelegate, SKPaymentTransactionObserver>

@property(nonatomic,strong)id<TransactionFinishedWithDelegate>delegate;
- (id)initWithProductIdentifiers:(NSSet *)productIdentifiers;
- (void)requestProductsWithCompletionHandler:(RequestProductsCompletionHandler)completionHandler;
-(void)requestProducts:(NSSet *)productIdentifiers WithCompletionHandler:(RequestProductsCompletionHandler)completionHandler;
- (void)buyProduct:(SKProduct *)product WithDelegate:(id<TransactionFinishedWithDelegate>)del;
- (BOOL)productPurchased:(NSString *)productIdentifier;
- (void)restoreCompletedTransactionsWithDelegate:(id<TransactionFinishedWithDelegate>)del;
@end
