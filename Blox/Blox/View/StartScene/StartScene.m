//
//  StartScene.m
//  Blox
//
//  Created by Admin on 28/01/17.
//  Copyright © 2017 Admin. All rights reserved.
//

#import "StartScene.h"

@implementation StartScene

-(id)initWithSize:(CGSize)size {
    if (self = [super initWithSize:size]) {
        [[NSNotificationCenter defaultCenter] addObserver: self
                                                 selector: @selector(handleEnteredBackground)
                                                     name: UIApplicationDidEnterBackgroundNotification
                                                   object: nil];
        [[NSNotificationCenter defaultCenter] addObserver: self
                                                 selector: @selector(handleEnteredForeground)
                                                     name: UIApplicationWillEnterForegroundNotification
                                                   object: nil];
        [self initWithData];
    }
    return self;
}

-(void)handleEnteredBackground{
    [self removeActionForKey:CLOUD_ACTION_REMOVE_KEY];
}

-(void)handleEnteredForeground{
    [self initClouds];
}

-(void)initClouds{
    SKAction *wait = [SKAction waitForDuration:1];
    SKAction *callEnemies = [SKAction runBlock:^{
        [self updateClouds];
    }];
    
    SKAction *updateClouds = [SKAction sequence:@[wait,callEnemies]];
    [self runAction:[SKAction repeatActionForever:updateClouds] withKey:CLOUD_ACTION_REMOVE_KEY];
    SKTextureAtlas *cloudsAtlas = [SKTextureAtlas atlasNamed:@"Clouds"];
    NSArray *textureNamesClouds = [cloudsAtlas textureNames];
    _cloudsTextures = [NSMutableArray new];
    for (NSString *name in textureNamesClouds) {
        SKTexture *texture = [cloudsAtlas textureNamed:name];
        [_cloudsTextures addObject:texture];
    }
}

-(void)initWithData{
    SKSpriteNode *bgImage = [SKSpriteNode spriteNodeWithImageNamed:@"bg_fond"];
    bgImage.size = self.frame.size;
    bgImage.position = CGPointMake(self.size.width/2, self.size.height/2);
    [self addChild:bgImage];
    [self initClouds];
}

-(void)updateClouds{
    int randomClouds = [self getRandomNumberBetween:0 to:1];
    if(randomClouds == 1){
        
        int whichCloud = [self getRandomNumberBetween:0 to:3];
        SKSpriteNode *cloud = [SKSpriteNode spriteNodeWithTexture:[_cloudsTextures objectAtIndex:whichCloud]];
        int randomYAxix = [self getRandomNumberBetween:0 to:[UIScreen mainScreen].bounds.size.height];
        cloud.position = CGPointMake([UIScreen mainScreen].bounds.size.width+30+cloud.size.height/2, randomYAxix);
        cloud.zPosition = 1;
        int randomTimeCloud = [self getRandomNumberBetween:9 to:19];
        
        SKAction *move =[SKAction moveTo:CGPointMake(0-cloud.size.height, randomYAxix) duration:randomTimeCloud];
        SKAction *remove = [SKAction removeFromParent];
        [cloud runAction:[SKAction sequence:@[move,remove]]];
        [self addChild:cloud];
        //NSLog(@"Child %lu",self.scene.children.count);
    }
}

- (void)didMoveToView:(SKView *)view {
    // Setup your scene here

}

-(int)getRandomNumberBetween:(int)from to:(int)to {
    
    return (int)from + arc4random() % (to-from+1);
}
@end
