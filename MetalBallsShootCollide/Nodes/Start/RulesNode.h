#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <SpriteKit/SpriteKit.h>

@class GameScene;

@interface RulesNode : SKNode
+ (RulesNode *)rulesIn:(GameScene *)scene player:(enum Player)player;
@end