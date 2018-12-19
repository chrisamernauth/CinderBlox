//
//  IAPRequest.h
//  Blox
//
//  Created by Admin on 07/02/17.
//  Copyright © 2016 Admin. All rights reserved.
//


#import <Foundation/Foundation.h>
#import "HelperClass.h"
@protocol IAPRequestDelegate<NSObject>
@optional
-(void)IAPRequestWithProductIdentifierdidSucceed:(NSMutableArray *)arr;
-(void)IAPRequestWithProductIdentifierdidfail;
-(void)IAPRequestDidSuceed:(SKPaymentTransaction *)transaction;
-(void)IAPRequestDidFailWithError:(NSError *)error;

@end

@interface IAPRequest : NSObject<TransactionFinishedWithDelegate>
@property(nonatomic,strong)id<IAPRequestDelegate>delegate;
@property(nonatomic,strong)NSMutableArray *productsArray;
+(IAPRequest *)Instance;
-(void)requestProductWithProductIdentifiers:(NSSet *)productIdentifiers WithDelegate:(id<IAPRequestDelegate>)del;
-(void)buyProductWithProductIdentifier:(NSString *)productidentifier WithDelegate:(id<IAPRequestDelegate>)del;
- (void)restoreCompletedTransactionsWithDelegate:(id<IAPRequestDelegate>)del;
-(NSMutableArray *)getRequestedProductsArray;
-(BOOL)isRequestedProductExist:(NSString *)productIdentifier;
@end
