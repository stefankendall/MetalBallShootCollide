#import "TriangleTargetNode.h"
#import "ContactCategoryMask.h"
#import "SKEmitterNode+HelperExtensions.h"

@implementation TriangleTargetNode

+ (instancetype)target {
    TriangleTargetNode *node = [self node];
    node.value = 1;

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
    node.physicsBody.collisionBitMask = CategoryWall | CategoryBall;
    node.physicsBody.contactTestBitMask = CategoryWall | CategoryBall;
    node.physicsBody.angularDamping = 0.07;
    CGPathRelease(path);

    SKLabelNode *pointLabel = [SKLabelNode labelNodeWithFontNamed:@"Avenir-Black"];
    [pointLabel setVerticalAlignmentMode:SKLabelVerticalAlignmentModeTop];
    [pointLabel setFontColor:[UIColor blackColor]];
    [pointLabel setFontSize:20];
    [pointLabel setPosition:CGPointMake(-2, 0)];
    [pointLabel setText:[NSString stringWithFormat:@"%d", node.value]];
    [node addChild:pointLabel];

    return node;
}

- (void)explode {
    self.exploding = YES;
    self.physicsBody.angularVelocity = 0;
    self.physicsBody.velocity = CGVectorMake(
            (CGFloat) (self.physicsBody.velocity.dx * 0.05),
            (CGFloat) (self.physicsBody.velocity.dy * 0.05)
    );
    SKEmitterNode *explosion = [SKEmitterNode rcw_nodeWithFile:@"explosion.sks"];
    explosion.position = CGPointMake(0, 0);
    explosion.zPosition = 1;
    [self addChild:explosion];

    SKAction *fade = [SKAction fadeAlphaTo:0 duration:1];
    SKAction *remove = [SKAction removeFromParent];
    SKAction *fadeAndRemove = [SKAction sequence:@[fade, remove]];
    SKAction *sound = [SKAction playSoundFileNamed:@"short_explosion.mp3" waitForCompletion:NO];

    [self runAction:[SKAction group:@[fadeAndRemove, sound]]];
}

- (void)setCollisionsEnabled:(BOOL)enabled {
    if (enabled) {
        self.physicsBody.categoryBitMask = CategoryTarget;
        self.physicsBody.collisionBitMask = CategoryWall | CategoryBall;
    }
    else {
        self.physicsBody.categoryBitMask = CategoryInvisibleTarget;
        self.physicsBody.collisionBitMask = 0;
    }
}
@end