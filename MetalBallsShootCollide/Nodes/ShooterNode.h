#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <SpriteKit/SpriteKit.h>
#import "PlayerEnum.h"

@class BallNode;
@class GameScene;

@interface ShooterNode : SKNode

@property(nonatomic) enum Player player;

- (void)shootBall:(BallNode *)node withVector:(CGVector)vector;

+ (SKNode *)shooterIn:(SKNode *)parent position:(enum Player)player;
@end