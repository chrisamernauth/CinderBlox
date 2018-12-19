//
//  InstructionViewController.m
//  Blox
//
//  Created by Admin on 19/02/17.
//  Copyright © 2017 Admin. All rights reserved.
//

#import "InstructionViewController.h"

@interface InstructionViewController ()

@end

@implementation InstructionViewController

+(InstructionViewController *)initViewController{
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    InstructionViewController *controller = [sb instantiateViewControllerWithIdentifier:@"InstructionViewController"];
    return controller;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.screenName = @"Game Instruction Screen";
    self.navigationController.navigationBar.hidden = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleImageTap:)];
    tap.cancelsTouchesInView = YES;
    tap.numberOfTapsRequired = 1;
    [imgView addGestureRecognizer:tap];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) handleImageTap:(UIGestureRecognizer *)gestureRecognizer {
    [self.navigationController popViewControllerAnimated:YES];
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
