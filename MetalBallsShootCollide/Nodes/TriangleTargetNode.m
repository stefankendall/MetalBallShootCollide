#import "TriangleTargetNode.h"
#import "ContactCategoryMask.h"

@implementation TriangleTargetNode

+ (instancetype)node {
    SKNode *node = [super node];
    SKSpriteNode *triangle = [SKSpriteNode spriteNodeWithImageNamed:@"triangle"];
    [node addChild:triangle];

    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, nil, -triangle.size.width/2, -triangle.size.height/2);
    CGPathAddLineToPoint(path, nil, triangle.size.width/2, -triangle.size.height/2);
    CGPathAddLineToPoint(path, nil, 0, triangle.size.height/2);
    CGPathAddLineToPoint(path, nil, -triangle.size.width/2, -triangle.size.height/2);
    node.physicsBody = [SKPhysicsBody bodyWithPolygonFromPath:path];
    node.physicsBody.mass = 8;
    node.physicsBody.categoryBitMask = CategoryTarget;
    node.physicsBody.collisionBitMask = CategoryWall;
    node.physicsBody.angularDamping = 0.07;
    CGPathRelease(path);
    return (TriangleTargetNode *) node;
}

@end