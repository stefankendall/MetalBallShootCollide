#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <SpriteKit/SpriteKit.h>

@class BallNode;

@interface ShooterNode : SKNode
+ (instancetype)shooter;

- (void)shootBall:(BallNode *)node withVector:(CGVector)vector;
@end