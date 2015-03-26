#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface MenuViewController : UIViewController {}

@property (weak, nonatomic) IBOutlet UISegmentedControl *p1TimeSegment;
@property (weak, nonatomic) IBOutlet UISegmentedControl *p1PointsSegment;
@property (weak, nonatomic) IBOutlet UIButton *p1StartButton;
@property (weak, nonatomic) IBOutlet UILabel *p2TopLabel;

@end