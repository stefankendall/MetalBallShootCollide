
#import <SpriteKit/SpriteKit.h>

@interface GameScene : SKScene

@property(nonatomic, weak) UITouch *lastTouchPoint;
@property(nonatomic) CFTimeInterval lastShotTime;
@property(nonatomic) CFTimeInterval shootInterval;
@end
