#import "MenuViewController.h"
#import "UIImage+ColorFromImage.h"
#import "GameViewController.h"
#import "Mailer.h"

@implementation MenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    UIFont *font = [UIFont fontWithName:@"AvenirNext-Bold" size:24];
    NSDictionary *attributes = @{NSFontAttributeName : font};
    [self.p1TimeSegment setTitleTextAttributes:attributes forState:UIControlStateNormal];
    [self.p1PointsSegment setTitleTextAttributes:attributes forState:UIControlStateNormal];

    [self.p2TimeSegment setTitleTextAttributes:attributes forState:UIControlStateNormal];
    [self.p2PointsSegment setTitleTextAttributes:attributes forState:UIControlStateNormal];

    [self.p1StartButton setBackgroundImage:[UIImage imageWithColor:[UIColor redColor]] forState:UIControlStateSelected];
    [self.p2StartButton setBackgroundImage:[UIImage imageWithColor:[UIColor colorWithRed:0.224 green:0.545 blue:1 alpha:1]] forState:UIControlStateSelected];

    [self.p2TopLabel.layer setAffineTransform:CGAffineTransformMakeScale(-1, -1)];
    [self.p2TimeSegment.layer setAffineTransform:CGAffineTransformMakeScale(-1, -1)];
    [self.p2PointsSegment.layer setAffineTransform:CGAffineTransformMakeScale(-1, -1)];
    [self.p2StartButton.layer setAffineTransform:CGAffineTransformMakeScale(-1, -1)];
}

- (IBAction)p1StartButtonSelected:(id)sender {
    [self.p1StartButton setSelected:!self.p1StartButton.selected];
    [self checkForStart];
}

- (IBAction)p2StartButtonSelected:(id)sender {
    [self.p2StartButton setSelected:!self.p2StartButton.selected];
    [self checkForStart];
}

- (void)checkForStart {
    if ([self.p1StartButton isSelected] && [self.p2StartButton isSelected]) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 1), dispatch_get_main_queue(), ^{
            GameViewController *controller = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateInitialViewController];
            controller.pointsToWin = [self.p1PointsSegment selectedSegmentIndex] == 0 ? @5 : nil;
            controller.timeLimitMinutes = [self.p1PointsSegment selectedSegmentIndex] == 0 ? @2 : nil;
            [self.navigationController pushViewController:controller animated:YES];
        });
    }
}

- (IBAction)p1TimeChanged:(id)sender {
    [self checkInfinity:self.p1TimeSegment with:self.p1PointsSegment];
    [self useSegmentValueFrom:self.p1TimeSegment forSegment:self.p2TimeSegment];
    [self useSegmentValueFrom:self.p1PointsSegment forSegment:self.p2PointsSegment];
}

- (IBAction)p2TimeChanged:(id)sender {
    [self checkInfinity:self.p2TimeSegment with:self.p2PointsSegment];
    [self useSegmentValueFrom:self.p2TimeSegment forSegment:self.p1TimeSegment];
    [self useSegmentValueFrom:self.p2PointsSegment forSegment:self.p1PointsSegment];
}

- (IBAction)p1PointsChanged:(id)sender {
    [self checkInfinity:self.p1PointsSegment with:self.p1TimeSegment];
    [self useSegmentValueFrom:self.p1TimeSegment forSegment:self.p2TimeSegment];
    [self useSegmentValueFrom:self.p1PointsSegment forSegment:self.p2PointsSegment];
}

- (IBAction)p2PointsChanged:(id)sender {
    [self checkInfinity:self.p2PointsSegment with:self.p2TimeSegment];
    [self useSegmentValueFrom:self.p2TimeSegment forSegment:self.p1TimeSegment];
    [self useSegmentValueFrom:self.p2PointsSegment forSegment:self.p1PointsSegment];
}

- (void)checkInfinity:(UISegmentedControl *)control1 with:(UISegmentedControl *)control2 {
    if ([control1 selectedSegmentIndex] == 1) {
        [control2 setSelectedSegmentIndex:0];
    }
}

- (void)useSegmentValueFrom:(UISegmentedControl *)control1 forSegment:(UISegmentedControl *)control2 {
    [control2 setSelectedSegmentIndex:[control1 selectedSegmentIndex]];
}

- (IBAction)contactButtonTapped:(id)sender {
    [self presentFeedbackEmail];
}

- (void)presentFeedbackEmail {
    [[[Mailer alloc] initWithSender:self] presentFeedback];
}

- (void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}

@end