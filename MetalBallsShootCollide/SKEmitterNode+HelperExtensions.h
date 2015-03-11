#import <Foundation/Foundation.h>
#import <SpriteKit/SpriteKit.h>

@interface SKEmitterNode (HelperExtensions)

+ (SKEmitterNode *)rcw_nodeWithFile:(NSString *)filename;

- (void)rcw_dieOutInDuration:(NSTimeInterval)duration;

@end