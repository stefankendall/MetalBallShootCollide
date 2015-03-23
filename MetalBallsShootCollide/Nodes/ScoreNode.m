#import "ScoreNode.h"
#import "GameScene.h"
#import "ShooterNode.h"

@implementation ScoreNode

- (void)setScore:(int)score {
    _score = score;

    SKLabelNode *scoreText = (SKLabelNode *) [self childNodeWithName:@"score"];
    [scoreText setText:[NSString stringWithFormat:@"%d pts", score]];
}

+ (SKNode *)scoreIn:(GameScene *)scene player:(enum Player)player {
    ScoreNode *node = [self node];

    int vPad = 10;
    int hPad = 20;

    SKLabelNode *label = [SKLabelNode labelNodeWithFontNamed:@"Avenir-Black"];
    [node addChild:label];
    label.name = @"score";
    [node setScore:0];
    [label setFontSize:96];
    [label setFontColor:[UIColor blackColor]];

    label.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeLeft;
    label.verticalAlignmentMode = SKLabelVerticalAlignmentModeBottom;

    if (player == Player1) {
        node.position = CGPointMake(hPad, vPad);
    }
    else {
        node.position = CGPointMake(scene.frame.size.width - hPad, scene.frame.size.height - vPad);
        [label setYScale:-1];
        [label setXScale:-1];
    }

    return node;
}

@end