#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <SpriteKit/SpriteKit.h>
#import "PowerUpNode.h"

@class GameScene;

@interface SpeedPowerUpNode : PowerUpNode
+ (SKNode *)powerUpInScene:(GameScene *)scene;

@end