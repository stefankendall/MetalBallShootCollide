#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <SpriteKit/SpriteKit.h>
#import "ShooterNode.h"

@interface BallNode : SKNode
@property(nonatomic) Position positionInScene;

+ (instancetype)ballFromPosition:(Position)position;

- (void)shootAlongVector:(CGVector)vector;

@end