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
    walls.physicsBody = [SKPhysicsBody bodyWithEdgeChainFromPath:path.CGPath];
    walls.physicsBody.categoryBitMask = CategoryWall;
    walls.physicsBody.collisionBitMask = CategoryTarget;
    [node addChild:walls];
    return node;
}

@end