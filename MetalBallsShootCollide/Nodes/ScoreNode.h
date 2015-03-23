#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <SpriteKit/SpriteKit.h>

@class GameScene;

@interface ScoreNode : SKNode

@property(nonatomic) int score;

+ (SKNode *)scoreIn:(GameScene *)scene position:(enum Position)position;
@end