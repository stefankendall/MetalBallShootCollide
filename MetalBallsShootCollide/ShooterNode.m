#import "ShooterNode.h"
#import "BallNode.h"

@implementation ShooterNode

+ (instancetype)shooter {
    ShooterNode *node = [self node];
    SKSpriteNode *image = [[SKSpriteNode alloc] initWithColor:[SKColor brownColor] size:CGSizeMake(30, 90)];
    image.name = @"image";
    [node addChild:image];
    return node;
}

- (void)shootBall:(BallNode *)ball withVector:(CGVector)vector {
    SKSpriteNode *image = (SKSpriteNode *) [self childNodeWithName:@"image"];
    ball.position = CGPointMake(self.position.x, self.position.y + image.size.height / 2);
    [ball shootAlongVector:vector];
}
@end