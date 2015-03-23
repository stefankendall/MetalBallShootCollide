#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <SpriteKit/SpriteKit.h>
#import "ShooterNode.h"
#import "PlayerEnum.h"

@class GameScene;

@interface ScoreNode : SKNode

@property(nonatomic) int score;
@property(nonatomic) enum Player player;

+ (SKNode *)scoreIn:(GameScene *)scene player:(enum Player)player;
@end