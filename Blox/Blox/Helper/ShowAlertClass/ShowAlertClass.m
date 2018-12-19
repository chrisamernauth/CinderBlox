//
//  ShowAlertClass.m
//  SuperTeam
//
//  Created by Arpit Patel on 02/10/16.
//  Copyright © 2016 Nera. All rights reserved.
//

#import "ShowAlertClass.h"

@implementation ShowAlertClass
+ (id) instantiateClass
{
    static ShowAlertClass *singletonInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if(!singletonInstance) {
            singletonInstance = [[ShowAlertClass alloc] init];
        }
    });
    return singletonInstance;
}


-(void)showAlertWithTitle:(NSString *)strTitle message:(NSString *)strMessage handler:(CompletionHandler)actionHandler withAlertButtons:(NSArray*)arrAlertButtons target:(UIViewController*)target{
    ActionHandler = actionHandler;
    
    if([UIAlertController class]){
        //iOS 8+
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:strTitle message:strMessage preferredStyle:UIAlertControllerStyleAlert];
        
        for (int i = 0; i< arrAlertButtons.count; i++) {
            UIAlertAction *aDoneAction = [UIAlertAction actionWithTitle:arrAlertButtons[i] style:UIAlertActionStyleDefault handler:^(UIAlertAction *action)
            {
                if(ActionHandler)
                    ActionHandler(i);
            }];
            [alertController addAction:aDoneAction];

        }
        [target presentViewController:alertController animated:YES completion:nil];
        
    }
}
@end
