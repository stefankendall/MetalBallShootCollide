#import "GameScene.h"

@implementation GameScene

- (void)didMoveToView:(SKView *)view {
    self.backgroundColor = [UIColor whiteColor];
    SKSpriteNode *shooter = [[SKSpriteNode alloc] initWithColor:[SKColor brownColor] size:CGSizeMake(30, 90)];
    shooter.position = CGPointMake(self.size.width / 2, 0);
    shooter.name = @"shooter";
    [self addChild:shooter];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self shooterFollowTouch: touches event: event];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    [self shooterFollowTouch: touches event: event];
}

- (void)shooterFollowTouch:(NSSet *)touches event:(UIEvent *)event {
    SKSpriteNode *shooter = (SKSpriteNode *) [self childNodeWithName:@"shooter"];
    UITouch *touch = [touches anyObject];
    CGPoint touchPoint = [touch locationInNode:self];
    CGFloat yDelta = touchPoint.y - shooter.position.y;
    CGFloat xDelta = touchPoint.x - shooter.position.x;
    shooter.zRotation = (CGFloat) (atan2(yDelta, xDelta) - M_PI_2);
}

- (void)update:(CFTimeInterval)currentTime {
}

@end
