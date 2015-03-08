#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <SpriteKit/SpriteKit.h>

@interface LevelBackgroundNode : SKNode
+ (SKNode *)levelForScene:(SKScene *)scene;
@end