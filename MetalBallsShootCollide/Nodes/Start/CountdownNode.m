#import "CountdownNode.h"
#import "PlayerEnum.h"

@implementation CountdownNode

+ (SKNode *)countdownNodeForPlayer:(enum Player)player {
    CountdownNode *node = [self node];
    node.zPosition = 2;

    SKShapeNode *backgroundCircle = [SKShapeNode shapeNodeWithCircleOfRadius:100];
    [backgroundCircle setName:@"circle"];
    [backgroundCircle setStrokeColor:[UIColor blackColor]];
    [backgroundCircle setFillColor:[UIColor whiteColor]];
    [backgroundCircle setLineWidth:10];
    [node addChild:backgroundCircle];

    SKLabelNode *text = [SKLabelNode labelNodeWithFontNamed:@"Avenir-Next"];
    [text setFontColor:[UIColor blackColor]];
    [text setFontSize:96];
    [text setName:@"text"];
    [text setVerticalAlignmentMode:SKLabelVerticalAlignmentModeCenter];

    if (player == Player2) {
        [text setXScale:-1];
        [text setYScale:-1];
    }

    [node addChild:text];
    return node;
}

- (void)countToZero:(void (^)())callback {
    SKAction *shrink = [SKAction scaleTo:0.5 duration:1];
    SKAction *fade = [SKAction fadeAlphaTo:0.8 duration:1];
    SKAction *shrinkAndFade = [SKAction group:@[shrink, fade]];

    SKAction *shortBeep = [SKAction playSoundFileNamed:@"short_beep.mp3" waitForCompletion:NO];
    SKAction *goSound = [SKAction playSoundFileNamed:@"go.mp3" waitForCompletion:NO];

    SKAction *hide = [SKAction fadeAlphaTo:0 duration:0];

    SKAction *remove = [SKAction removeFromParent];

    SKAction *resetSize = [SKAction scaleTo:1 duration:0];
    SKAction *show = [SKAction fadeAlphaTo:1 duration:0];

    [self setTextNodeText:@"3"];
    [self runAction:
            [SKAction sequence:
                    @[[SKAction group:@[shrinkAndFade, shortBeep]], hide, resetSize, [self actionSetText:@"2"], show,
                            [SKAction group:@[shrinkAndFade, shortBeep]], hide, resetSize, [self actionSetText:@"1"], show,
                            [SKAction group:@[shrinkAndFade, shortBeep]], [SKAction runBlock:callback], goSound, remove]]];
}

- (SKAction *)actionSetText:(NSString *)text {
    return [SKAction runBlock:^{
        [self setTextNodeText:text];
    }];
}

- (void)setTextNodeText:(NSString *)text {
    SKLabelNode *textNode = (SKLabelNode *) [self childNodeWithName:@"text"];
    [textNode setText:text];
}

@end