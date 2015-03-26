#import "GameViewController.h"
#import "GameScene.h"
#import "ShooterNode.h"
#import "GameOverViewController.h"

@implementation SKScene (Unarchive)

+ (instancetype)unarchiveFromFile:(NSString *)file {
    NSString *nodePath = [[NSBundle mainBundle] pathForResource:file ofType:@"sks"];
    NSData *data = [NSData dataWithContentsOfFile:nodePath
                                          options:NSDataReadingMappedIfSafe
                                            error:nil];
    NSKeyedUnarchiver *arch = [[NSKeyedUnarchiver alloc] initForReadingWithData:data];
    [arch setClass:self forClassName:@"SKScene"];
    SKScene *scene = [arch decodeObjectForKey:NSKeyedArchiveRootObjectKey];
    [arch finishDecoding];

    return scene;
}

@end

@implementation GameViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    SKView *skView = (SKView *) self.view;
//    skView.showsFPS = YES;
//    skView.showsNodeCount = YES;
    skView.ignoresSiblingOrder = YES;
//    skView.showsPhysics = YES;

    self.scene = [[GameScene alloc] initWithSize:self.view.frame.size];
    self.scene.scaleMode = SKSceneScaleModeAspectFill;
    self.scene.gameOverDelegate = self;

    [skView presentScene:self.scene];
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}

- (void)gameOverByVictory:(enum Player)player {
    GameOverViewController *controller = [[UIStoryboard storyboardWithName:@"GameOverViewController" bundle:[NSBundle mainBundle]] instantiateInitialViewController];
    controller.winner = player;
    controller.delegate = self;
    [self presentViewController:controller animated:YES completion:nil];
}

- (void)rematch {
    [self.scene startGame];
}


@end
