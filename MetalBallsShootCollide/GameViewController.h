#import <UIKit/UIKit.h>
#import <SpriteKit/SpriteKit.h>
#import "GameOverDelegate.h"
#import "GameOverViewDelegate.h"

@class GameScene;

@interface GameViewController : UIViewController <GameOverDelegate, GameOverViewDelegate>

@property(nonatomic, strong) GameScene *scene;
@property(nonatomic, strong) NSNumber *pointsToWin;
@property(nonatomic, strong) NSNumber *timeLimitMinutes;
@end
