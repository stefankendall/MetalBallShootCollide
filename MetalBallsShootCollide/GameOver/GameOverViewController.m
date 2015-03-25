#import "GameOverViewController.h"

@implementation GameOverViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.p2Label.layer setAffineTransform:CGAffineTransformMakeScale(-1, -1)];

    [self.p1Label setText:[self messageForVictory:self.winner == Player1]];
    [self.p2Label setText:[self messageForVictory:self.winner == Player2]];
}

- (NSString *)messageForVictory:(BOOL)winner {
    return winner ? @"You Win! :)" : @"You Lose :(";
}

@end