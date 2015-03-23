#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <SpriteKit/SpriteKit.h>
#import "ShooterNode.h"
#import "PlayerEnum.h"

@interface BallNode : SKNode
@property(nonatomic) enum Player player;

+ (instancetype)ballFromPlayer:(enum Player)player;

- (void)shootAlongVector:(CGVector)vector;

@end