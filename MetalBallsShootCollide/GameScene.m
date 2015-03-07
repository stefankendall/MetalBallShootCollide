#import "GameScene.h"
#import "BallNode.h"
#import "TriangleTargetNode.h"

@implementation GameScene

- (void)didMoveToView:(SKView *)view {
    self.backgroundColor = [UIColor whiteColor];
    self.shootInterval = 0.2;
    self.physicsWorld.gravity = CGVectorMake(0, 0);

    SKSpriteNode *shooter = [[SKSpriteNode alloc] initWithColor:[SKColor brownColor] size:CGSizeMake(30, 90)];
    shooter.position = CGPointMake(self.size.width / 2, 0);
    shooter.name = @"shooter";
    [self addChild:shooter];

    TriangleTargetNode *triangleTarget = [TriangleTargetNode node];
    triangleTarget.name = @"triangle";
    triangleTarget.position = CGPointMake(self.size.width / 2, self.size.height / 2);
    [self addChild:triangleTarget];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self shooterFollowTouch:touches event:event];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    [self shooterFollowTouch:touches event:event];
}

- (void)shooterFollowTouch:(NSSet *)touches event:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    self.lastTouchPoint = touch;
    CGVector vectorToShooter = [self vectorToShooter:touch];
    SKSpriteNode *shooter = (SKSpriteNode *) [self childNodeWithName:@"shooter"];
    shooter.zRotation = (CGFloat) (atan2(vectorToShooter.dy, vectorToShooter.dx) - M_PI_2);
}

- (CGVector)vectorToShooter:(UITouch *)touch {
    SKSpriteNode *shooter = (SKSpriteNode *) [self childNodeWithName:@"shooter"];
    CGPoint touchPoint = [touch locationInNode:self];
    CGFloat yDelta = touchPoint.y - shooter.position.y;
    CGFloat xDelta = touchPoint.x - shooter.position.x;
    return CGVectorMake(xDelta, yDelta);
}

- (void)update:(CFTimeInterval)currentTime {
    SKSpriteNode *shooter = (SKSpriteNode *) [self childNodeWithName:@"shooter"];
    if (self.lastTouchPoint && ([NSDate timeIntervalSinceReferenceDate] - self.lastShotTime) > self.shootInterval) {
        self.lastShotTime = [NSDate timeIntervalSinceReferenceDate];
        BallNode *ball = [BallNode node];
        ball.position = CGPointMake(shooter.position.x, shooter.position.y + shooter.size.height / 2);
        [self addChild:ball];
        [ball shootAlongVector:[self vectorToShooter:self.lastTouchPoint]];
    }

}

@end
