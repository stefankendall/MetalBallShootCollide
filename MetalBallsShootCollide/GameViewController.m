
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

- (void)viewDidLoad
{
    [super viewDidLoad];

    SKView * skView = (SKView *)self.view;
//    skView.showsFPS = YES;
//    skView.showsNodeCount = YES;
    skView.ignoresSiblingOrder = YES;
//    skView.showsPhysics = YES;
    
    GameScene *scene = [[GameScene alloc] initWithSize:self.view.frame.size];
    scene.scaleMode = SKSceneScaleModeAspectFill;
    scene.gameOverDelegate = self;
    
    [skView presentScene:scene];
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}

- (void)gameOverByVictory:(enum Player)player {
    GameOverViewController *controller = [[UIStoryboard storyboardWithName:@"GameOverViewController" bundle:[NSBundle mainBundle]] instantiateInitialViewController];
    [self presentViewController:controller animated:YES completion:nil];
}

@end
