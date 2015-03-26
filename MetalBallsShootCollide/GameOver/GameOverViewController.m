#import "GameOverViewController.h"
#import "UIImage+ColorFromImage.h"
#import "GameOverDelegate.h"
#import "GameOverViewDelegate.h"

@implementation GameOverViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.p2Label.layer setAffineTransform:CGAffineTransformMakeScale(-1, -1)];
    [self.p2RematchButton.layer setAffineTransform:CGAffineTransformMakeScale(-1, -1)];

    [self.p1Label setText:[self messageForVictory:self.winner == Player1]];
    [self.p2Label setText:[self messageForVictory:self.winner == Player2]];

    [self.p1RematchButton setBackgroundImage:[UIImage imageWithColor:[UIColor redColor]] forState:UIControlStateSelected];
    [self.p2RematchButton setBackgroundImage:[UIImage imageWithColor:[UIColor colorWithRed:0.224 green:0.545 blue:1 alpha:1]] forState:UIControlStateSelected];
    [self.p1RematchButton setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    [self.p2RematchButton setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];

    [self.p1RematchButton setTitle:@"READY!" forState:UIControlStateSelected];
    [self.p2RematchButton setTitle:@"READY!" forState:UIControlStateSelected];
}

-(BOOL)prefersStatusBarHidden{
    return YES;
}

- (NSString *)messageForVictory:(BOOL)winner {
    return winner ? @"You Win! :)" : @"You Lose :(";
}

- (IBAction)p1RematchTapped:(id)sender {
    [self.p1RematchButton setSelected:!self.p1RematchButton.selected];
    [self checkForRematch];
}

- (IBAction)p2RematchTapped:(id)sender {
    [self.p2RematchButton setSelected:!self.p2RematchButton.selected];
    [self checkForRematch];
}

- (void)checkForRematch {
    if (self.p1RematchButton.selected && self.p2RematchButton.selected) {
        [self.delegate rematch];
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

@end