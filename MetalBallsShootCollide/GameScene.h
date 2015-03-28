#import <SpriteKit/SpriteKit.h>

@class GameViewController;
@protocol GameOverDelegate;

@interface GameScene : SKScene <SKPhysicsContactDelegate>

@property(nonatomic) CFTimeInterval lastShotTimeShooter1;
@property(nonatomic) CFTimeInterval lastShotTimeShooter2;

@property(nonatomic) CFTimeInterval shootInterval;
@property(nonatomic) int targetExplodeHeightFromEdge;

@property(nonatomic) BOOL gameOver;


@property(nonatomic, strong) id <GameOverDelegate> gameOverDelegate;
@property(nonatomic) NSTimeInterval targetRespawnTimeInSeconds;

@property(nonatomic, strong) NSNumber *timeLimitMinutes;
@property(nonatomic, strong) NSNumber *pointsToWin;

@property(nonatomic) BOOL nextPointWins;

- (void)startGame;
@end
