//
//  GameViewController.m
//  Blox
//
//  Created by Admin on 27/10/16.
//  Copyright © 2016 Admin. All rights reserved.
//

#import "GameViewController.h"
#import "GameScene.h"

@implementation GameViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.screenName = @"Game Play Screen";
     self.navigationController.navigationBarHidden = YES;
}


-(void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];

   
    SKView * skView = (SKView *)self.view;
    // Load the SKScene from 'GameScene.sks'
    
    if (skView.scene == nil) {
        SKScene * scene = [GameScene sceneWithSize:skView.bounds.size];
        scene.scaleMode = SKSceneScaleModeAspectFill;
         [skView presentScene:scene];
    }else{
        GameScene *scene = (GameScene *)skView.scene;
        scene.size = skView.bounds.size;
    }
    // Present the scene.
   
    
    // Present the scene
    // [skView presentScene:scene];
    
    skView.showsFPS = NO;
    skView.showsNodeCount = NO;
}

- (BOOL)shouldAutorotate {
    return YES;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return UIInterfaceOrientationMaskAllButUpsideDown;
    } else {
        return UIInterfaceOrientationMaskAll;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}

@end
