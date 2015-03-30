#import <SpriteKit/SpriteKit.h>
#import "PowerUps.h"

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

@property(nonatomic) enum PowerUp player1PowerUps;

@property(nonatomic) enum PowerUp player2PowerUps;

@property(nonatomic) CGVector p1ShootVector;

@property(nonatomic) CGVector p2ShootVector;

@property(nonatomic) int powerupLengthSeconds;

@property(nonatomic) int powerupRespawnVarianceSeconds;

@property(nonatomic) int powerupRespawnMinTimeSeconds;

- (void)startGame;
@end
