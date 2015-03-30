#import "SpeedPowerUpNode.h"
#import "GameScene.h"
#import "ContactCategoryMask.h"

@implementation SpeedPowerUpNode

+ (SKNode *)powerUpInScene:(GameScene *)scene {
    SpeedPowerUpNode *node = [self node];
    node.position = CGPointMake(scene.frame.size.width / 5 * (1 + arc4random_uniform(4)), scene.frame.size.height / 2);

    int circleRadius = 28;
    SKShapeNode *circle = [SKShapeNode shapeNodeWithCircleOfRadius:circleRadius];
    [circle setStrokeColor:[UIColor blackColor]];
    [circle setFillColor:[UIColor yellowColor]];
    [node addChild:circle];

    SKLabelNode *text = [SKLabelNode labelNodeWithFontNamed:@"Avenir-Next"];
    [text setFontSize:36];
    [text setFontColor:[UIColor blackColor]];
    [text setText:@"S"];
    [text setVerticalAlignmentMode:SKLabelVerticalAlignmentModeCenter];
    [text setHorizontalAlignmentMode:SKLabelHorizontalAlignmentModeCenter];
    [circle addChild:text];

    node.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:circleRadius];
    node.physicsBody.angularDamping = 0;
    node.physicsBody.angularVelocity = -4;
    node.physicsBody.collisionBitMask = 0;
    node.physicsBody.categoryBitMask = CategoryPowerUp;
    node.physicsBody.contactTestBitMask = CategoryBall;

    node.zPosition = 4;
    [node fadeIn];

    return node;
}

- (NSString *)powerUpText {
    return @"HOLD TO SHOOT!";
}

- (PowerUp)powerUpValue {
    return PowerUpSpeed;
}

@end