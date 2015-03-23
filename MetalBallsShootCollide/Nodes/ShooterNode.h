#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <SpriteKit/SpriteKit.h>

@class BallNode;
@class GameScene;

typedef NS_ENUM(NSUInteger, Player) {
    Player2,
    Player1
};

@interface ShooterNode : SKNode

@property(nonatomic) enum Player player;

- (void)shootBall:(BallNode *)node withVector:(CGVector)vector;

+ (SKNode *)shooterIn:(SKNode *)parent position:(enum Player)player;
@end