#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <SpriteKit/SpriteKit.h>
#import "TargetNode.h"

@interface TriangleTargetNode : TargetNode
@property(nonatomic) BOOL exploding;
@property(nonatomic) int value;

+ (instancetype)target;

- (void)explode;

- (void)setCollisionsEnabled:(BOOL)b;
@end