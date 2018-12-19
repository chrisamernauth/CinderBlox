//
//  ShowAlertClass.h
//  SuperTeam
//
//  Created by Arpit Patel on 02/10/16.
//  Copyright © 2016 Nera. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void(^CompletionHandler)(NSInteger buttonIndex);

@interface ShowAlertClass : NSObject
{
    CompletionHandler ActionHandler;
}
+ (id) instantiateClass;

-(void)showAlertWithTitle:(NSString *)strTitle message:(NSString *)strMessage handler:(CompletionHandler)actionHandler withAlertButtons:(NSArray*)arrAlertButtons target:(UIViewController*)target;

@end
