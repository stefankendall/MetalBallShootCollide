#import "TimerNode.h"
#import "PlayerEnum.h"
#import "ScoreNode.h"

@implementation TimerNode

+ (TimerNode *)timerForPlayer:(enum Player)player inScene:(SKScene *)scene withTime:(NSNumber *)seconds {

    TimerNode *node = [self node];
    node.timeRemainingSeconds = seconds;

    SKLabelNode *remainingTime = [SKLabelNode labelNodeWithFontNamed:@"Avenir-Black"];
    [remainingTime setText:[self formatSeconds:node.timeRemainingSeconds]];
    [remainingTime setFontSize:48];
    [remainingTime setFontColor:[UIColor blackColor]];
    [node addChild:remainingTime];

    remainingTime.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeRight;
    remainingTime.verticalAlignmentMode = SKLabelVerticalAlignmentModeBottom;

    if (player == Player1) {
        node.position = CGPointMake(scene.frame.size.width - TEXT_HPAD - 10, TEXT_VPAD + 10);
    }
    else {
        node.position = CGPointMake(TEXT_HPAD, scene.frame.size.height - TEXT_VPAD - 10);
        [remainingTime setYScale:-1];
        [remainingTime setXScale:-1];
    }

    SKAction *updateLabel = [SKAction runBlock:^{
        node.timeRemainingSeconds = @([node.timeRemainingSeconds intValue] - 1);
        [remainingTime setText:[self formatSeconds:node.timeRemainingSeconds]];
    }];

    SKAction *updateTimerOnInterval = [SKAction repeatAction:
            [SKAction sequence:@[
                    [SKAction waitForDuration:1],
                    updateLabel
            ]
            ]        count:[seconds unsignedIntegerValue]];
    [node runAction:updateTimerOnInterval];
    return node;
}

+ (NSString *)formatSeconds:(NSNumber *)seconds {
    return [NSString stringWithFormat:@"%d:%02d",
                                      [seconds intValue] / 60,
                                      [seconds intValue] % 60];
}

@end