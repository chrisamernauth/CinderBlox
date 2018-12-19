//
//  GameScene.m
//  Blox
//
//  Created by Admin on 27/10/16.
//  Copyright © 2016 Admin. All rights reserved.
//

#import "GameScene.h"
#import "GameOverController.h"
#import "BlockNode.h"
#define CONSTANT_YPOS isIPhone?25.0f:50.0f
#define LIVES 5
typedef enum {
    STOPPED,
    STARTING,
    PLAYING
} GameState;
@implementation GameScene {
    SKShapeNode *_spinnyNode;
    NSUInteger _score;
    SKLabelNode *_scoreLabel;
    SKLabelNode *_highScoreLabel;
    SKLabelNode *_livesLabel;
    CGFloat dimension;
    BlockNode *currentnode;
    CGFloat OFFSET_WIDTH;
    int numberofBlocks;
    int screenLevel;
    NSInteger lives;
}


-(id)initWithSize:(CGSize)size {
    if (self = [super initWithSize:size]) {
       
        [self initWithData];
    }
    [[NSNotificationCenter defaultCenter] addObserver: self
                                             selector: @selector(handleEnteredBackground)
                                                 name: UIApplicationDidEnterBackgroundNotification
                                               object: nil];
    [[NSNotificationCenter defaultCenter] addObserver: self
                                             selector: @selector(handleEnteredForeground)
                                                 name: UIApplicationWillEnterForegroundNotification
                                               object: nil];
    return self;
}

-(void)handleEnteredBackground{
    [self removeActionForKey:CLOUD_ACTION_KEY];
}

-(void)handleEnteredForeground{
    [self initClouds];
}

-(void)initWithData{
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
         OFFSET_WIDTH = 95.0f;
    }
    else {
        if ([SDiOSVersion deviceSize] == Screen3Dot5inch){
            
        }
        else if ([SDiOSVersion deviceSize] == Screen4inch){
            OFFSET_WIDTH = 55.0f;
        }
        else if([SDiOSVersion deviceSize] == Screen4Dot7inch){
            OFFSET_WIDTH = 62.0f;
        }
        else if([SDiOSVersion deviceSize] == Screen5Dot5inch){
            OFFSET_WIDTH = 68.0f;
        }

    }
        _colors = @[[UIColor greenColor], [UIColor blueColor], [UIColor yellowColor],[UIColor redColor],[UIColor lightGrayColor],[UIColor purpleColor],[UIColor orangeColor],[UIColor whiteColor],[UIColor cyanColor]];
    dimension = [UIScreen mainScreen].bounds.size.height / 10;
    numberofBlocks = 1;
    screenLevel = 1;
    SKSpriteNode *bgImage = [SKSpriteNode spriteNodeWithImageNamed:@"bg_fond"];
    bgImage.size = self.frame.size;
    bgImage.position = CGPointMake(self.size.width/2, self.size.height/2);
    bgImage.zPosition = 1;
    [self addChild:bgImage];

    NSInteger purchasedlives = [ServicePreference getIntegerForKey:PURCHASE_LIVES];
    if (purchasedlives > 0) {
        lives = purchasedlives;
    }else{
        lives = 1;
    }
    
    [self initClouds];

    [self createBlockWithSize:CGSizeMake([UIScreen mainScreen].bounds.size.width - (OFFSET_WIDTH * numberofBlocks), dimension) andYPOS:CONSTANT_YPOS];
    
    _scoreLabel = [SKLabelNode labelNodeWithFontNamed:@"Arial"];
    _score=0;
    _scoreLabel.text = @"Score: 0";
    _scoreLabel.fontColor = [UIColor whiteColor];
    
    _scoreLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeLeft;
    _scoreLabel.position = CGPointMake(10, 10);
    _scoreLabel.zPosition = 25;
    [self.scene addChild:_scoreLabel];
    //
    _highScoreLabel = [SKLabelNode labelNodeWithFontNamed:@"Arial"];
     NSInteger highscore = [ServicePreference getIntegerForKey:HIGHSCORE];
    _highScoreLabel.text = [NSString stringWithFormat:@"Highscore: %ld",(long)highscore];
    _highScoreLabel.fontColor = [UIColor whiteColor];
   
    _highScoreLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeRight;
    _highScoreLabel.position = CGPointMake([UIScreen mainScreen].bounds.size.width - 10, 10);
    _highScoreLabel.zPosition = 26;
    [self.scene addChild:_highScoreLabel];
    
   
    _livesLabel = [SKLabelNode labelNodeWithFontNamed:@"Arial"];
    _livesLabel.text = [NSString stringWithFormat:@"Lives: %ld",(long)lives];
    _livesLabel.fontColor = [UIColor whiteColor];
    _livesLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeRight;
    
    _livesLabel.zPosition = 28;
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        _livesLabel.position = CGPointMake([UIScreen mainScreen].bounds.size.width - 10, [UIScreen mainScreen].bounds.size.height - ([CJPAdController sharedInstance].adsRemoved?50:140));
        _livesLabel.fontSize = 40.0f;
        _highScoreLabel.fontSize = 40.0f;
        _scoreLabel.fontSize = 44.0f;
    }else{
        _livesLabel.position = CGPointMake([UIScreen mainScreen].bounds.size.width - 10, [UIScreen mainScreen].bounds.size.height - ([CJPAdController sharedInstance].adsRemoved?50:70));
         _livesLabel.fontSize = 22.0f;
         _highScoreLabel.fontSize = 22.0f;
        _scoreLabel.fontSize = 24.0f;
    }
    [self.scene addChild:_livesLabel];
}

-(void)initClouds{
    SKAction *wait = [SKAction waitForDuration:0.8];
    SKAction *callEnemies = [SKAction runBlock:^{
        [self updateClouds];
    }];
    SKAction *updateClouds = [SKAction sequence:@[wait,callEnemies]];
    [self runAction:[SKAction repeatActionForever:updateClouds] withKey:CLOUD_ACTION_KEY];
    SKTextureAtlas *cloudsAtlas = [SKTextureAtlas atlasNamed:@"Clouds"];
    NSArray *textureNamesClouds = [cloudsAtlas textureNames];
    _cloudsTextures = [NSMutableArray new];
    for (NSString *name in textureNamesClouds) {
        SKTexture *texture = [cloudsAtlas textureNamed:name];
        [_cloudsTextures addObject:texture];
    }
}

-(void)updateClouds{
    int randomClouds = [self getRandomNumberBetween:0 to:1];
    if(randomClouds == 1){
        
        int whichCloud = [self getRandomNumberBetween:0 to:2];
        SKSpriteNode *cloud = [SKSpriteNode spriteNodeWithTexture:[_cloudsTextures objectAtIndex:whichCloud]];
        int randomYAxix = [self getRandomNumberBetween:0 to:[UIScreen mainScreen].bounds.size.height];
        cloud.position = CGPointMake([UIScreen mainScreen].bounds.size.width+40+cloud.size.height/2, randomYAxix);
        cloud.zPosition = 3;
        int randomTimeCloud = [self getRandomNumberBetween:9 to:11];//9to19
        
        SKAction *move =[SKAction moveTo:CGPointMake(0-cloud.size.height, randomYAxix) duration:randomTimeCloud];
        SKAction *remove = [SKAction removeFromParent];
        [cloud runAction:[SKAction sequence:@[move,remove]]];
        [self addChild:cloud];
          //NSLog(@"Child %lu",self.scene.children.count);
    }
}

-(int)getRandomNumberBetween:(int)from to:(int)to {
    
    return (int)from + arc4random() % (to-from+1);
}

-(float)getRandomFloatNumberBetween:(float)from to:(float)to {
    
    float low_bound = from;
    float high_bound = to;
    float rndValue = (((float)arc4random()/0x100000000)*(high_bound-low_bound)+low_bound);
    return rndValue;
}

-(void)createBlockWithSize:(CGSize)size andYPOS:(CGFloat)ypos{
    NSUInteger colorIndex = arc4random() % _colors.count;
    //NSLog(@"Width %f",size.width);
    //NSLog(@"Original Width %f",[UIScreen mainScreen].bounds.size.width - (OFFSET_WIDTH * numberofBlocks));
    CGSize actualsize;
    if (size.width < dimension) {
        actualsize = CGSizeMake(dimension, dimension);
    }else{
        actualsize = size;
    }
    BlockNode *node = [[BlockNode alloc] initWithRow:0 withColor:[_colors objectAtIndex:colorIndex] andSize:actualsize andYPOS:ypos andnumberofBlocks:numberofBlocks];
   // NSLog(@"Number Of Blocks %d",numberofBlocks);
    node.zPosition = 20+numberofBlocks;
    _scoreLabel.zPosition = 25 + numberofBlocks;
     _highScoreLabel.zPosition = 26 + numberofBlocks;
    if (numberofBlocks == 1) {
        [self insertChild:node atIndex:1];
    }else{
        [self addChild:node];
    }
    currentnode = node;
    float randomnumber;
    if(isIPhone){
        randomnumber = [self getRandomFloatNumberBetween:0.1 to:0.9];
    }else{
        randomnumber = [self getRandomFloatNumberBetween:0.1 to:0.9];
    }
    NSLog(@"Randon Number %f",node.size.width);
    CGFloat xmovement = [UIScreen mainScreen].bounds.size.width - node.size.width;
    //NSLog(@"X Movement %f",xmovement);
    //SKAction *moveRight = [SKAction moveByX:xmovement y:0 duration:0.2f];
    SKAction *moveRight = [SKAction moveByX:xmovement y:0 duration:randomnumber];
    SKAction *reversedMoveBottom = [moveRight reversedAction];
    SKAction *sequence = [SKAction sequence:@[moveRight,reversedMoveBottom]];
    SKAction *endlessAction = [SKAction repeatActionForever:sequence];
    [node runAction:endlessAction withKey:NODE_ACTION_KEY];
}

- (void)didMoveToView:(SKView *)view {
    // Setup your scene here
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(restartGame) name:@"RESTART_GAME" object:nil];
}

-(void)restartGame{
    [self initWithData];
}

-(void)playTouchSound{
    [SimpleAudioPlayer playFile:@"brick.wav"];
}

-(void)playGameOverSound{
    [SimpleAudioPlayer playFile:@"gameover.wav"];
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
   // UITouch *touch = [touches anyObject];
    // and the touch's location
    
    BlockNode *node = [self getBlockNodeHavingAction];
     NSLog(@"Number of Block = %d",numberofBlocks);
    NSLog(@"Node Bounds Width %f",[node calculateAccumulatedFrame].size.width);
    NSLog(@"Node Position X %f",node.position.x);
   
//    SKAction *action = [node actionForKey:NODE_ACTION_KEY];
//    action.duration = 1.0f;
//     [node removeActionForKey:NODE_ACTION_KEY];

    if (node) {
        CGFloat threshold = node.position.y + ([CJPAdController sharedInstance].adsRemoved?40.0f:50.0f) + dimension;
        
        
       
        NSArray *arr = node.physicsBody.allContactedBodies;
        
        if (arr.count > 0) {
            SKPhysicsBody *body = arr[0];
            if ([body.node isKindOfClass:[BlockNode class]]) {
                BlockNode *bnode = (BlockNode *)body.node;
                if (![node intersectsNode:bnode]) {
                    NSLog(@"Body %f",body.node.frame.size.width);
                     [self manipulateBlock:node andThreshold:threshold];
                    return;
                }
            }
            
//            if (node.position.x >= bnode.position.x && node.position.x <= (bnode.position.x+bnode.frame.size.width)) {
//                
//            }
            [self playTouchSound];

           
            if (threshold > ([UIScreen mainScreen].bounds.size.height - 5.0f)) {
                _score++;
                screenLevel++;
                _scoreLabel.text = [NSString stringWithFormat:@"Score: %lu",(unsigned long)_score];
                [ServicePreference setInteger:_score forKey:CURRENT_SCORE];
                NSInteger highscore = [ServicePreference getIntegerForKey:HIGHSCORE];
                _highScoreLabel.text = [NSString stringWithFormat:@"Highscore: %ld",(long)highscore];
                [self removeAllBlocks];
                
                numberofBlocks = screenLevel;
                
                
                [self createBlockWithSize:CGSizeMake([UIScreen mainScreen].bounds.size.width - (OFFSET_WIDTH * numberofBlocks), dimension) andYPOS:CONSTANT_YPOS];
                
                return;
            }
        }else{
            if ([self getNumberOfBlock] == 1) {
                [self playTouchSound];
            }else{
                [self manipulateBlock:node andThreshold:threshold];
                return;
            }
            NSLog(@"Game Over");
            
            
            
        }
        _score++;
        _scoreLabel.text = [NSString stringWithFormat:@"Score: %lu",(unsigned long)_score];
         _livesLabel.text = [NSString stringWithFormat:@"Lives: %ld",(long)lives];
        [ServicePreference setInteger:_score forKey:CURRENT_SCORE];
        //NSLog(@"Node Position %f",node.position.y);
        //NSLog(@"Frame Position %f",[UIScreen mainScreen].bounds.size.height);
       // [node removeAllActions];
        numberofBlocks++;
       
        NSLog(@"Contact Bodies %lu",(unsigned long)arr.count);
        [self createBlockWithSize:CGSizeMake([UIScreen mainScreen].bounds.size.width - (OFFSET_WIDTH * numberofBlocks), dimension) andYPOS:node.position.y + dimension];
    
    }
}

-(void)manipulateBlock:(BlockNode *)node andThreshold:(CGFloat)threshold{
    lives--;
    [ServicePreference setInteger:lives forKey:PURCHASE_LIVES];
    if (lives == 0) {
        [self playGameOverSound];
        [self removeAllBlocks];
        [self showGameOverAlert:@"Game Over"];
        // [self setHighScore];
        _score = 0;
        numberofBlocks = 0;
        NSInteger highscore = [ServicePreference getIntegerForKey:HIGHSCORE];
        _highScoreLabel.text = [NSString stringWithFormat:@"Highscore: %ld",(long)highscore];
        _scoreLabel.text = [NSString stringWithFormat:@"Score: %lu",(unsigned long)_score];
        _livesLabel.text = [NSString stringWithFormat:@"Lives: %ld",(long)lives];
        
    }else{
        [node removeFromParent];
        if (threshold > ([UIScreen mainScreen].bounds.size.height - 5.0f)) {
            //_score++;
            screenLevel++;
            _scoreLabel.text = [NSString stringWithFormat:@"Score: %lu",(unsigned long)_score];
            
            NSInteger highscore = [ServicePreference getIntegerForKey:HIGHSCORE];
            _highScoreLabel.text = [NSString stringWithFormat:@"Highscore: %ld",(long)highscore];
            _livesLabel.text = [NSString stringWithFormat:@"Lives: %ld",(long)lives];
            [self removeAllBlocks];
            
            numberofBlocks = screenLevel;
            
            [self createBlockWithSize:CGSizeMake([UIScreen mainScreen].bounds.size.width - (OFFSET_WIDTH * numberofBlocks), dimension) andYPOS:CONSTANT_YPOS];
            
           
        }else{
           // _score++;
            _scoreLabel.text = [NSString stringWithFormat:@"Score: %lu",(unsigned long)_score];
            _livesLabel.text = [NSString stringWithFormat:@"Lives: %ld",(long)lives];
            //NSLog(@"Node Position %f",node.position.y);
            //NSLog(@"Frame Position %f",[UIScreen mainScreen].bounds.size.height);
            
            //numberofBlocks++;
            //NSLog(@"Number of Block = %d",numberofBlocks);
            
           
            [self createBlockWithSize:CGSizeMake([UIScreen mainScreen].bounds.size.width - (OFFSET_WIDTH * numberofBlocks), dimension) andYPOS:node.position.y];
           
        }
        
    }

}

-(void)setHighScore{
    NSInteger highscore = [ServicePreference getIntegerForKey:HIGHSCORE];
    if (highscore < _score) {
        [ServicePreference setInteger:_score forKey:HIGHSCORE];
        [[GameCenterManager sharedManager] saveAndReportScore:_score leaderboard:GAME_CENTER_LEADERBOARD  sortOrder:GameCenterSortOrderHighToLow];

    }
}

-(void)removeAllBlocks{
    for(BlockNode *node in self.scene.children) {
        if ([node isKindOfClass:[BlockNode class]]) {
            [node removeFromParent];
        }
    }
   
}

-(BlockNode *)getBlockNodeHavingAction{
    NSArray *arr = self.scene.children;
    for(SKNode *node in arr) {
        if ([node isKindOfClass:[BlockNode class]]) {
            if ([node hasActions]) {
                [node removeAllActions];
                return (BlockNode *)node;
                break;
            }
        }
    }
    return nil;
}

-(NSInteger)getNumberOfBlock{
    NSMutableArray *blocks = [NSMutableArray new];
    NSArray *arr = self.scene.children;
    for(BlockNode  *node in arr) {
        if ([node isKindOfClass:[BlockNode class]]) {
            [blocks addObject:node];
        }
    }
    return blocks.count;
}

-(void)showGameOverAlert:(NSString *)mssg{
    NSString *message;
    NSInteger highscore = [ServicePreference getIntegerForKey:HIGHSCORE];
    [ServicePreference setInteger:0 forKey:PURCHASE_LIVES];
    if (highscore < _score) {
        [ServicePreference setInteger:_score forKey:HIGHSCORE];
         [[GameCenterManager sharedManager] saveAndReportScore:_score leaderboard:GAME_CENTER_LEADERBOARD  sortOrder:GameCenterSortOrderHighToLow];
        message = [NSString stringWithFormat:@"You have got new high score %ld",(unsigned long)_score];
    }else{
        message = mssg;
    }
    [self removeAllChildren];
    [self removeAllActions];
    
    GameOverController *controller = [GameOverController initViewController];
    controller.score = [NSString stringWithFormat:@"%lu",(unsigned long)_score];
    CJPAdController *cjpcontroller = [CJPAdController sharedInstance];
    UINavigationController *navigationController = (UINavigationController *)cjpcontroller.contentController;
    [navigationController pushViewController:controller animated:YES];
    NSInteger game_over_times = [ServicePreference getIntegerForKey:GAME_OVER_TIMES];
    BOOL status = [ServicePreference getBoolForKey:INTERSITIAL_REMOVE_ADS];
    if (!status) {
       
        if (!(game_over_times % 2 == 0)) {
            [self performSelector:@selector(openAds) withObject:nil afterDelay:0.3f];
            
        }
    }
     
   
}

-(void)openAds{
    CJPAdController *cjpcontroller = [CJPAdController sharedInstance];
    UINavigationController *navigationController = (UINavigationController *)cjpcontroller.contentController;
    [[AppDelegate appDelegate].interstitialAds presentFromRootViewController:navigationController];
}




-(void)update:(CFTimeInterval)currentTime {
    // Called before each frame is rendered
}

@end
