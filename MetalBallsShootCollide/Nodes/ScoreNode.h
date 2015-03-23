#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <SpriteKit/SpriteKit.h>
#import "ShooterNode.h"

@class GameScene;

@interface ScoreNode : SKNode

@property(nonatomic) int score;

+ (SKNode *)scoreIn:(GameScene *)scene player:(enum Player)player;
@end