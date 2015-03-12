#import "LevelBackgroundNode.h"
#import "ContactCategoryMask.h"

@implementation LevelBackgroundNode

+ (SKNode *)levelForScene:(SKScene *)scene {
    SKNode *node = [self node];

    SKSpriteNode *background = [SKSpriteNode spriteNodeWithImageNamed:@"level1"];
    background.zPosition = -1;
    background.position = CGPointMake(CGRectGetMidX(scene.frame), CGRectGetMidY(scene.frame));
    [node addChild:background];

    SKShapeNode *walls = [SKShapeNode node];
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:CGRectInset(scene.frame, 8, 8) cornerRadius:8];
    walls.path = path.CGPath;
    node.physicsBody = [SKPhysicsBody bodyWithEdgeChainFromPath:path.CGPath];
    node.physicsBody.categoryBitMask = CategoryWall;
    node.physicsBody.contactTestBitMask = CategoryTarget;
    [node addChild:walls];
    return node;
}

@end