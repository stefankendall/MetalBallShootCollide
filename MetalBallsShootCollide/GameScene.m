#import "GameScene.h"
#import "BallNode.h"
#import "TriangleTargetNode.h"
#import "LevelBackgroundNode.h"
#import "ContactCategoryMask.h"

@implementation GameScene

- (void)didMoveToView:(SKView *)view {
    self.backgroundColor = [UIColor whiteColor];
    self.shootInterval = 0.3;
    self.physicsWorld.gravity = CGVectorMake(0, 0);
    self.physicsWorld.contactDelegate = self;

    SKNode *level = [LevelBackgroundNode levelForScene:self];
    level.name = @"level";
    [self addChild:level];

    SKNode *shooter1 = [ShooterNode shooterIn:self position:BOTTOM];
    shooter1.name = @"shooter1";
    [level addChild:shooter1];

    SKNode *shooter2 = [ShooterNode shooterIn:self position:TOP];
    shooter2.name = @"shooter2";
    [level addChild:shooter2];

    TriangleTargetNode *triangleTarget = [TriangleTargetNode node];
    triangleTarget.name = @"triangle";
    triangleTarget.position = CGPointMake(self.size.width / 2, self.size.height / 2);
    triangleTarget.physicsBody.angularVelocity = 3;
    [triangleTarget.physicsBody setVelocity:CGVectorMake(-23, 0)];
    [level addChild:triangleTarget];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self shooterFollowTouch:touches event:event];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    [self shooterFollowTouch:touches event:event];
}

- (void)shooterFollowTouch:(NSSet *)touches event:(UIEvent *)event {
    BOOL shooter1Shooting = NO;
    BOOL shooter2Shooting = NO;
    for (UITouch *touch in touches) {
        CGPoint point = [touch locationInNode:self];
        ShooterNode *shooter;

        if (point.y < self.size.height / 2) {
            self.lastTouchPointShooter1 = touch;
            shooter = (ShooterNode *) [self childNodeWithName:@"//shooter1"];
            shooter1Shooting = YES;
        }
        else {
            self.lastTouchPointShooter2 = touch;
            shooter = (ShooterNode *) [self childNodeWithName:@"//shooter2"];
            shooter2Shooting = YES;
        }

        CGVector vectorToShooter = [self vectorTo:shooter from:touch];
        shooter.zRotation = (CGFloat) (atan2(vectorToShooter.dy, vectorToShooter.dx) - M_PI_2);
    }

    if (!shooter1Shooting) {
        self.lastTouchPointShooter1 = nil;
    }
    if (!shooter2Shooting) {
        self.lastTouchPointShooter2 = nil;
    }
}

- (CGVector)vectorTo:(SKNode *)node from:(UITouch *)touch {
    CGPoint touchPoint = [touch locationInNode:self];
    CGFloat yDelta = touchPoint.y - node.position.y;
    CGFloat xDelta = touchPoint.x - node.position.x;
    return CGVectorMake(xDelta, yDelta);
}

- (void)update:(CFTimeInterval)currentTime {
    LevelBackgroundNode *level = (LevelBackgroundNode *) [self childNodeWithName:@"level"];
    ShooterNode *shooter1 = (ShooterNode *) [self childNodeWithName:@"//shooter1"];
    ShooterNode *shooter2 = (ShooterNode *) [self childNodeWithName:@"//shooter2"];

    if (self.lastTouchPointShooter1 && ([NSDate timeIntervalSinceReferenceDate] - self.lastShotTimeShooter1) > self.shootInterval) {
        self.lastShotTimeShooter1 = [NSDate timeIntervalSinceReferenceDate];
        BallNode *ball = [BallNode ballFromPosition:BOTTOM];
        [level addChild:ball];
        [shooter1 shootBall:ball withVector:[self vectorTo:shooter1 from:self.lastTouchPointShooter1]];
    }

    if (self.lastTouchPointShooter2 && ([NSDate timeIntervalSinceReferenceDate] - self.lastShotTimeShooter2) > self.shootInterval) {
        self.lastShotTimeShooter2 = [NSDate timeIntervalSinceReferenceDate];
        BallNode *ball = [BallNode ballFromPosition:TOP];
        [level addChild:ball];
        [shooter2 shootBall:ball withVector:[self vectorTo:shooter2 from:self.lastTouchPointShooter2]];
    }
}

- (void)didBeginContact:(SKPhysicsContact *)contact {
    NSLog(@"Contact");
    if (contact.bodyA.categoryBitMask == CategoryTarget) {
        NSLog(@"Category target!");
    }
}

@end
