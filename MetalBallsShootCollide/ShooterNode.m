#import "ShooterNode.h"
#import "BallNode.h"
#import "GameScene.h"

@implementation ShooterNode

- (void)shootBall:(BallNode *)ball withVector:(CGVector)vector {
    SKSpriteNode *image = (SKSpriteNode *) [self childNodeWithName:@"image"];

    CGFloat offsetToShootFrom = self.positionInScene == BOTTOM ? image.size.height / 2 : -image.size.height / 2;
    ball.position = CGPointMake(self.position.x, self.position.y + offsetToShootFrom);
    [ball shootAlongVector:vector];
}

+ (SKNode *)shooterIn:(GameScene *)scene position:(enum Position)position {
    ShooterNode *node = [self node];
    node.positionInScene = position;
    node.position = CGPointMake(scene.size.width / 2, position == BOTTOM ? 0 : scene.size.height);
    SKSpriteNode *image = [[SKSpriteNode alloc] initWithColor:[SKColor brownColor] size:CGSizeMake(30, 90)];
    image.name = @"image";
    [node addChild:image];
    return node;
}

@end