#import "NextPointWins.h"
#import "GameScene.h"

@implementation NextPointWins

+ (SKNode *)nextPointWinsInScene:(GameScene *)scene {
    NextPointWins *node = [self node];

    node.position = CGPointMake(scene.frame.size.width / 2, scene.frame.size.height / 2);
    SKLabelNode *label = [SKLabelNode labelNodeWithFontNamed:@"Avenir-Black"];
    [label setText:@"NEXT POINT WINS!"];
    [label setFontColor:[UIColor blackColor]];
    [label setFontSize:64];
    [node addChild:label];
    node.zPosition = 3;

    [node runAction:
            [SKAction sequence:@[
                    [SKAction rotateByAngle:(CGFloat) (4 * M_PI) duration:1],
                    [SKAction fadeAlphaTo:0 duration:1],
                    [SKAction removeFromParent]
            ]]
    ];
    return node;
}

@end