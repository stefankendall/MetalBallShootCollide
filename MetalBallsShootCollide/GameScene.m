#import "GameScene.h"
#import "BallNode.h"
#import "TriangleTargetNode.h"
#import "ShooterNode.h"

@implementation GameScene

- (void)didMoveToView:(SKView *)view {
    self.backgroundColor = [UIColor whiteColor];
    self.shootInterval = 0.3;
    self.physicsWorld.gravity = CGVectorMake(0, 0);

    SKNode *shooter1 = [ShooterNode shooter];
    shooter1.position = CGPointMake(self.size.width / 2, 0);
    shooter1.name = @"shooter1";
    [self addChild:shooter1];

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
    ShooterNode *shooter = (ShooterNode *) [self childNodeWithName:@"shooter1"];
    CGVector vectorToShooter = [self vectorTo:shooter from:touch];
    shooter.zRotation = (CGFloat) (atan2(vectorToShooter.dy, vectorToShooter.dx) - M_PI_2);
}

- (CGVector)vectorTo:(SKNode *)node from:(UITouch *)touch {
    CGPoint touchPoint = [touch locationInNode:self];
    CGFloat yDelta = touchPoint.y - node.position.y;
    CGFloat xDelta = touchPoint.x - node.position.x;
    return CGVectorMake(xDelta, yDelta);
}

- (void)update:(CFTimeInterval)currentTime {
    ShooterNode *shooter = (ShooterNode *) [self childNodeWithName:@"shooter1"];
    if (self.lastTouchPoint && ([NSDate timeIntervalSinceReferenceDate] - self.lastShotTime) > self.shootInterval) {
        self.lastShotTime = [NSDate timeIntervalSinceReferenceDate];
        BallNode *ball = [BallNode node];
        [self addChild:ball];
        [shooter shootBall: ball withVector: [self vectorTo:shooter from:self.lastTouchPoint]];
    }

}

@end
