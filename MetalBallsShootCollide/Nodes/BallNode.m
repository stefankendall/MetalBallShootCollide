#import "BallNode.h"
#import "SKEmitterNode+HelperExtensions.h"

@implementation BallNode

+ (instancetype)ballFromPosition:(Position)position {
    BallNode *node = [self node];

    node.positionInScene = position;
    int ballRadius = 8;
    SKSpriteNode *ball = [SKSpriteNode spriteNodeWithImageNamed:[self imageNameForPosition:position]];
    ball.name = @"ball";
    [node addChild:ball];
    node.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:ballRadius];
    node.physicsBody.mass = 1;
    node.physicsBody.angularDamping = 1000;

    return (BallNode *) node;
}

+ (NSString *)imageNameForPosition:(Position)position {
    return position == BOTTOM ? @"p1Ball" : @"p2ball";
}

- (void)shootAlongVector:(CGVector)vector {
    int ballSpeed = 1000;
    float angle = (float) atan2(vector.dy, vector.dx);
    self.physicsBody.velocity = CGVectorMake(
            cosf(angle) * ballSpeed,
            sinf(angle) * ballSpeed
    );

    SKAction *waitForFade = [SKAction waitForDuration:2.2];
    SKAction *doFade = [SKAction fadeAlphaTo:0 duration:0.5];

    SKSpriteNode *ball = (SKSpriteNode *) [self childNodeWithName:@"ball"];
    [ball runAction:[SKAction sequence:@[waitForFade, doFade]]];

    SKAction *wait = [SKAction waitForDuration:3];
    SKAction *remove = [SKAction removeFromParent];

    [self runAction:[SKAction sequence:@[wait, remove]]];
}

@end