#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <SpriteKit/SpriteKit.h>

@interface CountdownNode : SKNode

+ (SKNode *) countdownNode;

- (void)countToZero:(void (^)())pFunction;
@end