#import "GameOverViewController.h"

@implementation GameOverViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.p2Label.layer setAffineTransform:CGAffineTransformMakeScale(-1, -1)];
}

@end