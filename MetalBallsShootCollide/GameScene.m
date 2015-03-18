#import "GameScene.h"
#import "BallNode.h"
#import "TriangleTargetNode.h"
#import "LevelBackgroundNode.h"
#import "ContactCategoryMask.h"
#import "CountdownNode.h"

@implementation GameScene

- (void)didMoveToView:(SKView *)view {
    self.backgroundColor = [UIColor whiteColor];
    self.shootInterval = 0.15;
    self.physicsWorld.gravity = CGVectorMake(0, 0);
    self.physicsWorld.contactDelegate = self;

    self.targetExplodeHeightFromEdge = 60;

    SKNode *level = [LevelBackgroundNode levelForScene:self];
    level.name = @"level";
    [self addChild:level];

    SKNode *shooter1 = [ShooterNode shooterIn:self position:BOTTOM];
    shooter1.name = @"shooter1";
    [level addChild:shooter1];

    SKNode *shooter2 = [ShooterNode shooterIn:self position:TOP];
    shooter2.name = @"shooter2";
    [level addChild:shooter2];

    CountdownNode *countdownNode = (CountdownNode *) [CountdownNode countdownNode];
    countdownNode.position = CGPointMake(self.size.width / 2, self.size.height / 2);
    [countdownNode countToZero:^{
        [self addTarget];
    }];
    [level addChild:countdownNode];
}

- (void)addTarget {
    SKNode *level = [self childNodeWithName:@"level"];
    TriangleTargetNode *triangleTarget = [TriangleTargetNode node];
    triangleTarget.name = @"target";
    triangleTarget.position = CGPointMake(self.size.width / 2, self.size.height / 2);
    triangleTarget.physicsBody.angularVelocity = 3;
    [triangleTarget.physicsBody setVelocity:CGVectorMake(-23, 0)];
    [level addChild:triangleTarget];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self shooterFollowTouch:touches event:event];
    LevelBackgroundNode *level = (LevelBackgroundNode *) [self childNodeWithName:@"level"];
    for (UITouch *touch in touches) {
        CGPoint point = [touch locationInNode:self];
        ShooterNode *shooter;

        if (point.y < self.size.height / 2) {
            if (([NSDate timeIntervalSinceReferenceDate] - self.lastShotTimeShooter1) > self.shootInterval) {
                shooter = (ShooterNode *) [self childNodeWithName:@"//shooter1"];
                self.lastShotTimeShooter1 = [NSDate timeIntervalSinceReferenceDate];
                BallNode *ball = [BallNode ballFromPosition:BOTTOM];
                [level addChild:ball];
                [shooter shootBall:ball withVector:[self vectorTo:shooter from:touch]];
            }
        }
        else {
            shooter = (ShooterNode *) [self childNodeWithName:@"//shooter2"];
            if (([NSDate timeIntervalSinceReferenceDate] - self.lastShotTimeShooter2) > self.shootInterval) {
                self.lastShotTimeShooter2 = [NSDate timeIntervalSinceReferenceDate];
                BallNode *ball = [BallNode ballFromPosition:TOP];
                [level addChild:ball];
                [shooter shootBall:ball withVector:[self vectorTo:shooter from:touch]];
            }
        }

        CGVector vectorToShooter = [self vectorTo:shooter from:touch];
        shooter.zRotation = (CGFloat) (atan2(vectorToShooter.dy, vectorToShooter.dx) - M_PI_2);
    }
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    [self shooterFollowTouch:touches event:event];
}

- (void)shooterFollowTouch:(NSSet *)touches event:(UIEvent *)event {
    for (UITouch *touch in touches) {
        CGPoint point = [touch locationInNode:self];
        ShooterNode *shooter;

        if (point.y < self.size.height / 2) {
            shooter = (ShooterNode *) [self childNodeWithName:@"//shooter1"];
        }
        else {
            shooter = (ShooterNode *) [self childNodeWithName:@"//shooter2"];
        }

        CGVector vectorToShooter = [self vectorTo:shooter from:touch];
        shooter.zRotation = (CGFloat) (atan2(vectorToShooter.dy, vectorToShooter.dx) - M_PI_2);
    }
}

- (CGVector)vectorTo:(SKNode *)node from:(UITouch *)touch {
    CGPoint touchPoint = [touch locationInNode:self];
    CGFloat yDelta = touchPoint.y - node.position.y;
    CGFloat xDelta = touchPoint.x - node.position.x;
    return CGVectorMake(xDelta, yDelta);
}

- (void)update:(CFTimeInterval)currentTime {
    TriangleTargetNode *triangle = (TriangleTargetNode *) [self childNodeWithName:@"//target"];
    if (triangle != nil) {
        if (triangle.position.y < self.targetExplodeHeightFromEdge ||
                triangle.position.y > self.size.height - self.targetExplodeHeightFromEdge
                ) {
            if (!triangle.exploding) {
                [triangle explode];
            }
        }
    }
}

- (void)didBeginContact:(SKPhysicsContact *)contact {
    if (contact.bodyA.categoryBitMask == CategoryWall && contact.bodyB.categoryBitMask == CategoryTarget) {
        SKPhysicsBody *target = contact.bodyB;
        [target applyImpulse:CGVectorMake(1500 * contact.contactNormal.dx, 0)];
    }
}

@end
