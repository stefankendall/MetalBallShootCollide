#import "ShooterNode.h"
#import "BallNode.h"

@implementation ShooterNode

- (void)shootBall:(BallNode *)ball withVector:(CGVector)vector {
    SKSpriteNode *image = (SKSpriteNode *) [self childNodeWithName:@"image"];

    CGFloat offsetToShootFrom = self.player == Player1 ? image.size.height / 2 : -image.size.height / 2;
    double angleOfShot = atan2(vector.dy, vector.dx);
    ball.position = CGPointMake(
            (CGFloat) (self.position.x + cos(angleOfShot) * image.size.height / 2),
            (CGFloat) (self.position.y + offsetToShootFrom * fabs(sin(angleOfShot))));
    [ball shootAlongVector:vector];
    [self runAction:[SKAction playSoundFileNamed:@"shoot.wav" waitForCompletion:NO]];
}

+ (SKNode *)shooterIn:(SKNode *)parent position:(enum Player)player {
    ShooterNode *node = [self node];
    node.player = player;
    node.position = CGPointMake(parent.frame.size.width / 2, player == Player1 ? 0 : parent.frame.size.height);
    SKSpriteNode *image = [SKSpriteNode spriteNodeWithImageNamed:@"cannon"];
    image.name = @"image";
    [node addChild:image];
    return node;
}

@end