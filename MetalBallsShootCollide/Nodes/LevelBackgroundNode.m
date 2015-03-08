#import "LevelBackgroundNode.h"

@implementation LevelBackgroundNode

+ (SKNode *)levelForScene:(SKScene *)scene {
    SKNode *node = [self node];

    SKSpriteNode *background = [SKSpriteNode spriteNodeWithImageNamed:@"level1"];
    background.zPosition = -1;
    background.position = CGPointMake(CGRectGetMidX(scene.frame), CGRectGetMidY(scene.frame));
    [node addChild:background];
    return node;
}

@end