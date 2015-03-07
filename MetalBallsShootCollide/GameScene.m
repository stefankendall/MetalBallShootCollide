#import "GameScene.h"
#import "BallNode.h"
#import "TriangleTargetNode.h"
#import "ShooterNode.h"

@implementation GameScene

- (void)didMoveToView:(SKView *)view {
    self.backgroundColor = [UIColor whiteColor];
    self.shootInterval = 0.3;
    self.physicsWorld.gravity = CGVectorMake(0, 0);

    SKNode *shooter1 = [ShooterNode shooterIn:self position:BOTTOM];
    shooter1.name = @"shooter1";
    [self addChild:shooter1];

    SKNode *shooter2 = [ShooterNode shooterIn:self position:TOP];
    shooter2.name = @"shooter2";
    [self addChild:shooter2];

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

    CGPoint point = [touch locationInNode:self];
    ShooterNode *shooter;

    if (point.y < self.size.height / 2) {
        self.lastTouchPointShooter1 = touch;
        shooter = (ShooterNode *) [self childNodeWithName:@"shooter1"];
    }
    else {
        self.lastTouchPointShooter2 = touch;
        shooter = (ShooterNode *) [self childNodeWithName:@"shooter2"];
    }

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
    ShooterNode *shooter1 = (ShooterNode *) [self childNodeWithName:@"shooter1"];
    ShooterNode *shooter2 = (ShooterNode *) [self childNodeWithName:@"shooter2"];

    if (self.lastTouchPointShooter1 && ([NSDate timeIntervalSinceReferenceDate] - self.lastShotTimeShooter1) > self.shootInterval) {
        self.lastShotTimeShooter1 = [NSDate timeIntervalSinceReferenceDate];
        BallNode *ball = [BallNode node];
        [self addChild:ball];
        [shooter1 shootBall:ball withVector:[self vectorTo:shooter1 from:self.lastTouchPointShooter1]];
    }

    if (self.lastTouchPointShooter2 && ([NSDate timeIntervalSinceReferenceDate] - self.lastShotTimeShooter2) > self.shootInterval) {
        self.lastShotTimeShooter2 = [NSDate timeIntervalSinceReferenceDate];
        BallNode *ball = [BallNode node];
        [self addChild:ball];
        [shooter2 shootBall:ball withVector:[self vectorTo:shooter2 from:self.lastTouchPointShooter2]];
    }
}

@end
