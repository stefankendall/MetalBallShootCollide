#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <SpriteKit/SpriteKit.h>

@interface BallNode : SKNode
- (void)shootAlongVector:(CGVector)vector;
@end