#import "GameScene.h"
#import "BallNode.h"
#import "TriangleTargetNode.h"
#import "LevelBackgroundNode.h"
#import "ContactCategoryMask.h"
#import "CountdownNode.h"
#import "ScoreNode.h"
#import "GameOverDelegate.h"
#import "RulesNode.h"
#import "TimerNode.h"
#import "NextPointWins.h"

@implementation GameScene

- (void)didMoveToView:(SKView *)view {
    self.backgroundColor = [UIColor whiteColor];
    self.shootInterval = 0.15;
    self.targetRespawnTimeInSeconds = 1;

    self.physicsWorld.gravity = CGVectorMake(0, 0);
    self.physicsWorld.contactDelegate = self;

    self.targetExplodeHeightFromEdge = 60;

    [self startGame];
}

- (void)startGame {
    self.gameOver = NO;
    [self removeAllChildren];
    [self removeAllActions];

    SKNode *level = [LevelBackgroundNode levelForScene:self];
    level.name = @"level";
    [self addChild:level];

    SKNode *shooter1 = [ShooterNode shooterIn:self position:Player1];
    shooter1.name = @"shooter1";
    [level addChild:shooter1];

    SKNode *player1Score = [ScoreNode scoreIn:self player:Player1];
    player1Score.name = @"score1";
    [level addChild:player1Score];

    SKNode *player2Score = [ScoreNode scoreIn:self player:Player2];
    player2Score.name = @"score2";
    [level addChild:player2Score];

    SKNode *shooter2 = [ShooterNode shooterIn:self position:Player2];
    shooter2.name = @"shooter2";
    [level addChild:shooter2];

    CountdownNode *countdownNodePlayer1 = (CountdownNode *) [CountdownNode countdownNodeForPlayer:Player1];
    CGFloat positionX1 = self.size.width / 4;
    countdownNodePlayer1.position = CGPointMake(positionX1, self.size.height / 2);
    NSNumber *timeLimitSeconds = self.timeLimitMinutes ? @(self.timeLimitMinutes.intValue * 60) : nil;
//    NSNumber *timeLimitSeconds = @(2);
    [countdownNodePlayer1 countToZero:^{
        [self addTargetAtPosition:(int) positionX1 fadeInDelaySeconds:0];
        if (timeLimitSeconds) {
            TimerNode *timer1 = [TimerNode timerForPlayer:Player1 inScene:self withTime:timeLimitSeconds];
            timer1.name = @"timer";
            [self addChild:timer1];
            TimerNode *timer2 = [TimerNode timerForPlayer:Player2 inScene:self withTime:timeLimitSeconds];
            timer2.name = @"timer";
            [self addChild:timer2];
            [self runAction:[SKAction sequence:@[
                    [SKAction waitForDuration:[timeLimitSeconds intValue]],
                    [SKAction runBlock:^{
                        [self timeLimitReached];
                    }]
            ]]];
        }
    }];
    [level addChild:countdownNodePlayer1];

    CGFloat positionX2 = 3 * self.size.width / 4;
    CountdownNode *countdownNodePlayer2 = (CountdownNode *) [CountdownNode countdownNodeForPlayer:Player2];
    countdownNodePlayer2.position = CGPointMake(positionX2, self.size.height / 2);
    [countdownNodePlayer2 countToZero:^{
        [self addTargetAtPosition:(int) positionX2 fadeInDelaySeconds:0];
    }];
    [level addChild:countdownNodePlayer2];

    [level addChild:[RulesNode rulesIn:self player:Player1]];
    [level addChild:[RulesNode rulesIn:self player:Player2]];
}

- (void)timeLimitReached {
    ScoreNode *score1 = (ScoreNode *) [self childNodeWithName:@"//score1"];
    ScoreNode *score2 = (ScoreNode *) [self childNodeWithName:@"//score2"];
    if (!self.gameOver) {
        if (score1.score != score2.score) {
            self.gameOver = YES;
            [self.gameOverDelegate gameOverByVictory:score1.score > score2.score ? Player1 : Player2];
        }
        else {
            [self enumerateChildNodesWithName:@"//timer" usingBlock:^(SKNode *node, BOOL *stop) {
                [node removeFromParent];
            }];
            self.nextPointWins = YES;
            LevelBackgroundNode *level = (LevelBackgroundNode *) [self childNodeWithName:@"level"];
            [level addChild:[NextPointWins nextPointWinsInScene:self]];
        }
    }
}

- (void)addTargetAtPosition:(int)x fadeInDelaySeconds:(float)seconds {
    SKNode *level = [self childNodeWithName:@"level"];
    TriangleTargetNode *triangleTarget = [TriangleTargetNode target];
    triangleTarget.name = @"target";
    triangleTarget.position = CGPointMake(x, self.size.height / 2);
    triangleTarget.physicsBody.angularVelocity = 3;
    [triangleTarget.physicsBody setVelocity:CGVectorMake(-23, 0)];
    [level addChild:triangleTarget];

    if (seconds > 0) {
        triangleTarget.alpha = 0.1;
        [triangleTarget setCollisionsEnabled:NO];
        [triangleTarget runAction:
                [SKAction sequence:@[
                        [SKAction fadeAlphaTo:0.4 duration:seconds],
                        [SKAction runBlock:^{
                            [triangleTarget setCollisionsEnabled:YES];
                        }],
                        [SKAction fadeAlphaTo:1 duration:0]
                ]]
        ];
    }
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self shooterFollowTouch:touches event:event];
    if (self.gameOver) {
        return;
    }

    LevelBackgroundNode *level = (LevelBackgroundNode *) [self childNodeWithName:@"level"];
    for (UITouch *touch in touches) {
        CGPoint point = [touch locationInNode:self];
        ShooterNode *shooter;

        if (point.y < self.size.height / 2) {
            if (([NSDate timeIntervalSinceReferenceDate] - self.lastShotTimeShooter1) > self.shootInterval) {
                shooter = (ShooterNode *) [self childNodeWithName:@"//shooter1"];
                self.lastShotTimeShooter1 = [NSDate timeIntervalSinceReferenceDate];
                BallNode *ball = [BallNode ballFromPlayer:Player1];
                [level addChild:ball];
                [shooter shootBall:ball withVector:[self vectorTo:shooter from:touch]];
            }
        }
        else {
            shooter = (ShooterNode *) [self childNodeWithName:@"//shooter2"];
            if (([NSDate timeIntervalSinceReferenceDate] - self.lastShotTimeShooter2) > self.shootInterval) {
                self.lastShotTimeShooter2 = [NSDate timeIntervalSinceReferenceDate];
                BallNode *ball = [BallNode ballFromPlayer:Player2];
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
    [self enumerateChildNodesWithName:@"//target" usingBlock:^(SKNode *node, BOOL *stop) {
        TriangleTargetNode *target = (TriangleTargetNode *) node;
        if (target.position.y < self.targetExplodeHeightFromEdge ||
                target.position.y > self.size.height - self.targetExplodeHeightFromEdge
                ) {
            if (!target.exploding) {
                [target explode];

                ScoreNode *playerScore = nil;
                if (target.position.y < self.targetExplodeHeightFromEdge) {
                    playerScore = (ScoreNode *) [self childNodeWithName:@"//score2"];
                }
                else {
                    playerScore = (ScoreNode *) [self childNodeWithName:@"//score1"];
                }

                [playerScore setScore:playerScore.score + target.value];

                if ((self.pointsToWin && playerScore.score >= [self.pointsToWin intValue]) || self.nextPointWins) {
                    self.gameOver = YES;
                    [self.gameOverDelegate gameOverByVictory:playerScore.player];
                    return;
                }

                [self runAction:[SKAction sequence:@[
                        [SKAction waitForDuration:self.targetRespawnTimeInSeconds],
                        [SKAction performSelector:@selector(respawnTriangle) onTarget:self]
                ]]];
            }
        }
    }];
}

- (void)respawnTriangle {
    float positionAdjust = (float) ((1 + arc4random_uniform(3)) / 5.0);
    [self addTargetAtPosition:(int) ((int) self.size.width * positionAdjust) fadeInDelaySeconds:2];
}

- (void)didBeginContact:(SKPhysicsContact *)contact {
    if (contact.bodyA.categoryBitMask == CategoryWall && contact.bodyB.categoryBitMask == CategoryTarget) {
        SKPhysicsBody *target = contact.bodyB;
        [target applyImpulse:CGVectorMake(1500 * contact.contactNormal.dx, 0)];
    }
}

@end
