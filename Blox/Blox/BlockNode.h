//
//  BlockNode.h
//  Blox
//
//  Created by Admin on 29/10/16.
//  Copyright © 2016 Admin. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface BlockNode : SKSpriteNode
@property (nonatomic, assign) NSUInteger row;

-(BlockNode *)initWithRow:(NSUInteger)row withColor:(UIColor *)color andSize:(CGSize)size andYPOS:(float)ypos andnumberofBlocks:(NSInteger)numberofblocks;
@end
