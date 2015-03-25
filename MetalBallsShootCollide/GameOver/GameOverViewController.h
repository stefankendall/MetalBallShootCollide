#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "PlayerEnum.h"

@interface GameOverViewController : UIViewController {}
@property (weak, nonatomic) IBOutlet UILabel *p2Label;
@property (weak, nonatomic) IBOutlet UILabel *p1Label;

@property(nonatomic) enum Player winner;
@end