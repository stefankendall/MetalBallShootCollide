#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <SpriteKit/SpriteKit.h>
#import "ShooterNode.h"

@interface BallNode : SKNode
@property(nonatomic) Player PlayerInScene;

+ (instancetype)ballFromPlayer:(enum Player)player;

- (void)shootAlongVector:(CGVector)vector;

@end