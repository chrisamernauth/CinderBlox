//  Blox
//
//  Created by Admin on 07/02/17.
//  Copyright © 2016 Admin. All rights reserved.
//

#import "HelperClass.h"
#import "Constants.h"
@implementation HelperClass

+ (HelperClass *)sharedInstance {
    static dispatch_once_t once;
    static HelperClass * sharedInstance;
    dispatch_once(&once, ^{
        NSSet * productIdentifiers = [NSSet setWithObjects:
                                      PURCHASE_LIVES,PURCHASE_REMOVE_ADS,nil];
        sharedInstance = [[self alloc] initWithProductIdentifiers:productIdentifiers];
    });
    return sharedInstance;
}


@end
