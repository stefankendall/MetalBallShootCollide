#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <SpriteKit/SpriteKit.h>
#import "PlayerEnum.h"

@class GameScene;

@interface PowerupTextNode : SKNode
@property(nonatomic) enum Player player;

+ (SKNode *)textIn:(GameScene *)scene player:(enum Player)player text:(NSString *)text;
@end