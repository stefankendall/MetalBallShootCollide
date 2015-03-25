#import "BallNode.h"
#import "ContactCategoryMask.h"

@implementation BallNode

+ (instancetype)ballFromPlayer:(enum Player)player {
    BallNode *node = [self node];
    node.physicsBody.categoryBitMask = CategoryBall;

    node.player = player;
    int ballRadius = 8;
    SKSpriteNode *ball = [SKSpriteNode spriteNodeWithImageNamed:[self imageNameForPlayer:player]];
    ball.name = @"ball";
    [node addChild:ball];
    node.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:ballRadius];
    node.physicsBody.mass = 1;
    node.physicsBody.angularDamping = 1000;
    node.physicsBody.categoryBitMask = CategoryBall;
    node.physicsBody.collisionBitMask = CategoryBall | CategoryWall | CategoryTarget;
    node.physicsBody.contactTestBitMask = CategoryBall | CategoryWall | CategoryTarget;
    return node;
}

+ (NSString *)imageNameForPlayer:(enum Player)player {
    return player == Player1 ? @"p1ball" : @"p2ball";
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