#import "CountdownNode.h"

@implementation CountdownNode

+ (SKNode *)countdownNode {
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

    [node addChild:text];
    return node;
}

- (void)countToZero:(void (^)())callback {
    SKAction *shrink = [SKAction scaleTo:0.5 duration:1];
    SKAction *fade = [SKAction fadeAlphaTo:0.8 duration:1];
    SKAction *shrinkAndFade = [SKAction group:@[shrink, fade]];

    SKAction *hide = [SKAction fadeAlphaTo:0 duration:0];

    SKAction *remove = [SKAction removeFromParent];

    SKAction *resetSize = [SKAction scaleTo:1 duration:0];
    SKAction *show = [SKAction fadeAlphaTo:1 duration:0];

    [self setTextNodeText:@"3"];
    [self runAction:
            [SKAction sequence:
                    @[shrinkAndFade, hide, resetSize, [self actionSetText:@"2"], show,
                            shrinkAndFade, hide, resetSize, [self actionSetText:@"1"], show,
                            shrinkAndFade, [SKAction runBlock:callback], remove]]];
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