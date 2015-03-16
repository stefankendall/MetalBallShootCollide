#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <SpriteKit/SpriteKit.h>

@interface TriangleTargetNode : SKNode
@property(nonatomic) BOOL exploding;

- (void)explode;
@end