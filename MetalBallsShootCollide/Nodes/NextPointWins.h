#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <SpriteKit/SpriteKit.h>

@class GameScene;

@interface NextPointWins : SKNode
+ (SKNode *)nextPointWinsInScene:(GameScene *)scene;
@end