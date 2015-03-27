#import "RulesNode.h"
#import "GameScene.h"
#import "PlayerEnum.h"

@implementation RulesNode

+ (RulesNode *)rulesIn:(GameScene *)scene player:(enum Player)player {
    RulesNode *node = [self node];
    CGFloat sceneHeight = scene.frame.size.height;
    [node setPosition:CGPointMake(scene.frame.size.width / 2,
            player == Player1 ? sceneHeight / 4 : 3 * sceneHeight / 4)];

    SKLabelNode *text = [SKLabelNode labelNodeWithFontNamed:@"Avenir-Next"];
    [text setText:@"Tap to Shoot!"];
    text.name = @"text";

    if (player == Player2) {
        [node setXScale:-1];
        [node setYScale:-1];
    }

    CGFloat initialAlpha = 0.3;
    [text setAlpha:initialAlpha];
    [text setFontSize:72];
    [text setFontColor:[UIColor blackColor]];
    [node addChild:text];

    [text runAction:
            [SKAction sequence:@[
                    [SKAction waitForDuration:0.5],
                    [SKAction group:@[
                            [SKAction fadeAlphaTo:0.1 duration:1],
                            [SKAction scaleTo:0.8 duration:1]
                    ]],
                    [SKAction fadeAlphaTo:0 duration:0],
                    [SKAction scaleTo:1 duration:0],
                    [SKAction runBlock:^{
                        [text setText:@"HIT"];
                    }],
                    [SKAction fadeAlphaTo:initialAlpha duration:0],
                    [SKAction waitForDuration:0.3],
                    [SKAction runBlock:^{
                        [text setText:@"THE"];
                    }],
                    [SKAction waitForDuration:0.3],
                    [SKAction runBlock:^{
                        [text setText:@"TARGETS!"];
                    }],
            ]]
    ];

    [node runAction:[SKAction sequence:@[
            [SKAction waitForDuration:3],
            [SKAction removeFromParent]
    ]]];

    return node;
}

@end