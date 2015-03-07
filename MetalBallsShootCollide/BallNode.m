#import "BallNode.h"

@implementation BallNode

+ (instancetype)node {
    SKNode *node = [super node];

    int ballRadius = 8;
    SKSpriteNode *ball = [[SKSpriteNode alloc] initWithColor:[SKColor blackColor] size:CGSizeMake(ballRadius, ballRadius)];
    ball.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:ballRadius];
    ball.name = @"ball";
    [node addChild:ball];

    return (BallNode *) node;
}

- (void)shootAlongVector:(CGVector)vector {
    SKNode *ball = [self childNodeWithName:@"ball"];
    int ballSpeed = 1000;
    float angle = (float) atan2(vector.dy, vector.dx);
    ball.physicsBody.velocity = CGVectorMake(
            cosf(angle) * ballSpeed,
            sinf(angle) * ballSpeed
    );
}

@end