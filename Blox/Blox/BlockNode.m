//
//  BlockNode.m
//  Blox
//
//  Created by Admin on 29/10/16.
//  Copyright © 2016 Admin. All rights reserved.
//

#import "BlockNode.h"

@implementation BlockNode

-(BlockNode *)initWithRow:(NSUInteger)row withColor:(UIColor *)color andSize:(CGSize)size andYPOS:(float)ypos andnumberofBlocks:(NSInteger)numberofblocks{
    self = [super initWithColor:color size:size];
    
    if(self) {
        _row = row;
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
            if (numberofblocks >=0  &&  numberofblocks <=2) {
                self.texture = [SKTexture textureWithImage:[UIImage imageNamed:@"block5"]];
                
            }else if (numberofblocks > 2 && numberofblocks <= 4){
                self.texture = [SKTexture textureWithImage:[UIImage imageNamed:@"block4"]];
            }
            else if (numberofblocks > 4 && numberofblocks <= 5){
                self.texture = [SKTexture textureWithImage:[UIImage imageNamed:@"block3"]];
            }else if(numberofblocks > 5 && numberofblocks <= 6){
                self.texture = [SKTexture textureWithImage:[UIImage imageNamed:@"block2"]];
            }else{
                self.texture = [SKTexture textureWithImage:[UIImage imageNamed:@"block"]];
            }
        }else{
            if (numberofblocks >=0  &&  numberofblocks <=1) {
                self.texture = [SKTexture textureWithImage:[UIImage imageNamed:@"block5"]];
                
            }else if (numberofblocks > 1 && numberofblocks <= 2){
                self.texture = [SKTexture textureWithImage:[UIImage imageNamed:@"block4"]];
            }
            else if (numberofblocks > 2 && numberofblocks <= 3){
                self.texture = [SKTexture textureWithImage:[UIImage imageNamed:@"block3"]];
            }else if(numberofblocks > 3 && numberofblocks <= 4){
                self.texture = [SKTexture textureWithImage:[UIImage imageNamed:@"block2"]];
            }else{
                self.texture = [SKTexture textureWithImage:[UIImage imageNamed:@"block"]];
            }
        }

        
        self.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:CGSizeMake(size.width, size.height)];
        self.physicsBody.affectedByGravity = NO;
        UIGraphicsBeginImageContext(size);
        [color setFill];
        CGRect rect = CGRectMake(0, 0, size.width, size.height);
        UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:7.0f];
        [path fill];
        self.anchorPoint = CGPointMake(0, 0.5); // same as CGPointMake(0, 0)
        //ground.position = CGPointZero
        CGFloat xPosition = 0;
        CGFloat yPosition =  ypos;//( (size.height / 2) - _row * size.height );
        self.position = CGPointMake(xPosition, yPosition);
        
    }
    
    return self;
}



@end
