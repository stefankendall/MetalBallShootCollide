#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <SpriteKit/SpriteKit.h>

@class BallNode;
@class GameScene;

typedef NS_ENUM(NSUInteger, Position) {
    TOP,
    BOTTOM
};

@interface ShooterNode : SKNode

@property(nonatomic) enum Position positionInScene;

- (void)shootBall:(BallNode *)node withVector:(CGVector)vector;

+ (SKNode *)shooterIn:(GameScene *)scene position:(enum Position)position;
@end