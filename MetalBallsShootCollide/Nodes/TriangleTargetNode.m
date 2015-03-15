#import "TriangleTargetNode.h"
#import "ContactCategoryMask.h"
#import "SKEmitterNode+HelperExtensions.h"

@implementation TriangleTargetNode

+ (instancetype)node {
    SKNode *node = [super node];
    SKSpriteNode *triangle = [SKSpriteNode spriteNodeWithImageNamed:@"triangle"];
    [node addChild:triangle];

    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, nil, -triangle.size.width / 2, -triangle.size.height / 2);
    CGPathAddLineToPoint(path, nil, triangle.size.width / 2, -triangle.size.height / 2);
    CGPathAddLineToPoint(path, nil, 0, triangle.size.height / 2);
    CGPathAddLineToPoint(path, nil, -triangle.size.width / 2, -triangle.size.height / 2);
    node.physicsBody = [SKPhysicsBody bodyWithPolygonFromPath:path];
    node.physicsBody.mass = 8;
    node.physicsBody.categoryBitMask = CategoryTarget;
    node.physicsBody.collisionBitMask = CategoryWall;
    node.physicsBody.angularDamping = 0.07;
    CGPathRelease(path);
    return (TriangleTargetNode *) node;
}

- (void)explode {
    self.physicsBody.angularVelocity = 0;
    SKEmitterNode *explosion = [SKEmitterNode rcw_nodeWithFile:@"explosion.sks"];
    explosion.position = CGPointMake(0, 0);
    explosion.zPosition = 1;
    [self addChild:explosion];

    SKAction *fade = [SKAction fadeAlphaTo:0 duration:3];
    SKAction *remove = [SKAction removeFromParent];
    SKAction *fadeAndRemove = [SKAction sequence:@[fade, remove]];
    SKAction *sound = [SKAction playSoundFileNamed:@"short_explosion.mp3" waitForCompletion:NO];

    [self runAction:[SKAction group:@[fadeAndRemove, sound]]];
}

@end