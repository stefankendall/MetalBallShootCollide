#import "MenuViewController.h"
#import "UIImage+ColorFromImage.h"
#import "GameViewController.h"

@implementation MenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    UIFont *font = [UIFont fontWithName:@"AvenirNext-Bold" size:24];
    NSDictionary *attributes = @{NSFontAttributeName : font};
    [self.p1TimeSegment setTitleTextAttributes:attributes forState:UIControlStateNormal];
    [self.p1PointsSegment setTitleTextAttributes:attributes forState:UIControlStateNormal];

    [self.p1PointsSegment setSelectedSegmentIndex:0];
    [self.p1StartButton setBackgroundImage:[UIImage imageWithColor:[UIColor redColor]] forState:UIControlStateSelected];

    [self.p2TopLabel.layer setAffineTransform:CGAffineTransformMakeScale(-1, -1)];
}

- (IBAction)p1StartButtonSelected:(id)sender {
    [self.p1StartButton setSelected:!self.p1StartButton.selected];

    GameViewController *controller = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateInitialViewController];
    [self.navigationController pushViewController:controller animated:YES];
}

- (IBAction)p1TimeChanged:(id)sender {
    if([self.p1TimeSegment selectedSegmentIndex] == 1){
        [self.p1PointsSegment setSelectedSegmentIndex:0];
    }
}

- (IBAction)p1PointsChanged:(id)sender {
    if([self.p1PointsSegment selectedSegmentIndex] == 1){
        [self.p1TimeSegment setSelectedSegmentIndex:0];
    }
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}

@end