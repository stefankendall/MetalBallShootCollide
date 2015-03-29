#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>

@interface MenuViewController : UIViewController <MFMailComposeViewControllerDelegate> {}

@property (weak, nonatomic) IBOutlet UISegmentedControl *p1TimeSegment;
@property (weak, nonatomic) IBOutlet UISegmentedControl *p2TimeSegment;

@property (weak, nonatomic) IBOutlet UISegmentedControl *p1PointsSegment;
@property (weak, nonatomic) IBOutlet UISegmentedControl *p2PointsSegment;
@property (weak, nonatomic) IBOutlet UIButton *p1StartButton;
@property (weak, nonatomic) IBOutlet UIButton *p2StartButton;
@property (weak, nonatomic) IBOutlet UILabel *p2TopLabel;

@end