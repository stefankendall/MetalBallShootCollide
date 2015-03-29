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

    UIColor *blueColor = [UIColor colorWithRed:0.224 green:0.545 blue:1 alpha:1];
    [self.p1RematchButton setBackgroundImage:[UIImage imageWithColor:[UIColor redColor]] forState:UIControlStateSelected];
    [self.p2RematchButton setBackgroundImage:[UIImage imageWithColor:blueColor] forState:UIControlStateSelected];
    [self.p1RematchButton setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    [self.p2RematchButton setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];

    [self.p1HomeButton setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    [self.p2HomeButton setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];

    [self.p1HomeButton setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    [self.p2HomeButton setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];

    [self.p1HomeButton setBackgroundImage:[UIImage imageWithColor:[UIColor redColor]] forState:UIControlStateSelected];
    [self.p2HomeButton setBackgroundImage:[UIImage imageWithColor:blueColor] forState:UIControlStateSelected];
}

- (BOOL)prefersStatusBarHidden {
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

- (IBAction)p1HomeTapped:(id)sender {
    [self.p1HomeButton setSelected:!self.p1HomeButton.selected];
    if (self.p1HomeButton.selected) {
        [self.p1RematchButton setSelected:!self.p1HomeButton.selected];
    }
    [self checkForGoToHome];
}

- (IBAction)p2HomeTapped:(id)sender {
    [self.p2HomeButton setSelected:!self.p2HomeButton.selected];
    if (self.p2HomeButton.selected) {
        [self.p2RematchButton setSelected:!self.p2HomeButton.selected];
    }
    [self checkForGoToHome];
}

- (void)checkForGoToHome {
    if (self.p1HomeButton.selected && self.p2HomeButton.selected) {
        [self dismissViewControllerAnimated:YES completion:nil];
        [self.delegate goHome];
    }
}

- (void)checkForRematch {
    if (self.p1RematchButton.selected && self.p2RematchButton.selected) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 1), dispatch_get_main_queue(), ^{
            [self dismissViewControllerAnimated:YES completion:nil];
            [self.delegate rematch];
        });
    }
}

@end