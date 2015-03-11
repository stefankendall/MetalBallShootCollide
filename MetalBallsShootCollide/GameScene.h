#import <SpriteKit/SpriteKit.h>

@interface GameScene : SKScene <SKPhysicsContactDelegate>

@property(nonatomic) CFTimeInterval lastShotTimeShooter1;
@property(nonatomic) CFTimeInterval lastShotTimeShooter2;

@property(nonatomic, weak) UITouch *lastTouchPointShooter2;
@property(nonatomic, weak) UITouch *lastTouchPointShooter1;

@property(nonatomic) CFTimeInterval shootInterval;
@end
