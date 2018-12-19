//
//  InstructionViewController.h
//  Blox
//
//  Created by Admin on 19/02/17.
//  Copyright © 2017 Admin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface InstructionViewController : GAITrackedViewController
{
    __weak IBOutlet UIImageView *imgView;
}
+(InstructionViewController *)initViewController;
@end
