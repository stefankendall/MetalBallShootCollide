#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "PlayerEnum.h"

@protocol GameOverDelegate

- (void)gameOverByVictory:(enum Player)player;

@end