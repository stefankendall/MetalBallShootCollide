#import <SpriteKit/SpriteKit.h>

@class GameViewController;
@protocol GameOverDelegate;

@interface GameScene : SKScene <SKPhysicsContactDelegate>

@property(nonatomic) CFTimeInterval lastShotTimeShooter1;
@property(nonatomic) CFTimeInterval lastShotTimeShooter2;

@property(nonatomic) CFTimeInterval shootInterval;
@property(nonatomic) int targetExplodeHeightFromEdge;

@property(nonatomic) BOOL gameOver;

@property(nonatomic) int scoreToWin;
@property(nonatomic, strong) id <GameOverDelegate> gameOverDelegate;
@end
