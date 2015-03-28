#import "ScoreNode.h"
#import "GameScene.h"
#import "PlayerEnum.h"

const int TEXT_VPAD = 10;
const int TEXT_HPAD = 20;

@implementation ScoreNode

- (void)setScore:(int)score {
    _score = score;

    SKLabelNode *scoreText = (SKLabelNode *) [self childNodeWithName:@"score"];
    [scoreText setText:[NSString stringWithFormat:@"%d pts", score]];
}

+ (SKNode *)scoreIn:(GameScene *)scene player:(enum Player)player {
    ScoreNode *node = [self node];
    node.player = player;

    SKLabelNode *label = [SKLabelNode labelNodeWithFontNamed:@"Avenir-Black"];
    [node addChild:label];
    label.name = @"score";
    [node setScore:0];
    [label setFontSize:96];
    [label setFontColor:[UIColor blackColor]];

    label.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeLeft;
    label.verticalAlignmentMode = SKLabelVerticalAlignmentModeBottom;

    if (player == Player1) {
        node.position = CGPointMake(TEXT_HPAD, TEXT_VPAD);
    }
    else {
        node.position = CGPointMake(scene.frame.size.width - TEXT_HPAD, scene.frame.size.height - TEXT_VPAD);
        [label setYScale:-1];
        [label setXScale:-1];
    }

    return node;
}

@end