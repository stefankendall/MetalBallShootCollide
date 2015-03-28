#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <SpriteKit/SpriteKit.h>

@interface CountdownNode : SKNode

+ (SKNode *)countdownNodeForPlayer: (enum Player) player;

- (void)countToZero:(void (^)())pFunction;
@end