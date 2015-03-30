#import "PowerupTextNode.h"
#import "GameScene.h"
#import "PlayerEnum.h"

@implementation PowerupTextNode

+ (SKNode *)textIn:(GameScene *)scene player:(enum Player)player text:(NSString *)rulesText {
    PowerupTextNode *node = [self node];
    node.player = player;
    node.position = CGPointMake(scene.frame.size.width / 2,
            player == Player1 ? scene.frame.size.height / 4 :
                    3 * scene.frame.size.height / 4);
    node.alpha = 0.35;

    SKLabelNode *text = [SKLabelNode labelNodeWithFontNamed:@"Avenir-Next"];
    [text setText:rulesText];
    [text setFontColor:[UIColor blackColor]];
    [text setFontSize:64];
    [text runAction:[SKAction repeatActionForever:[SKAction sequence:@[
            [SKAction scaleTo:0.5 duration:0.5],
            [SKAction scaleTo:1 duration:0.5]
    ]]]];
    [node addChild:text];
    return node;
}

@end