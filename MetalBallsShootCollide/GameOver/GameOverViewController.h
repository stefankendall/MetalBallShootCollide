#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "PlayerEnum.h"

@protocol GameOverViewDelegate;

@interface GameOverViewController : UIViewController {}
@property (weak, nonatomic) IBOutlet UILabel *p2Label;
@property (weak, nonatomic) IBOutlet UILabel *p1Label;
@property (weak, nonatomic) IBOutlet UIButton *p1RematchButton;
@property (weak, nonatomic) IBOutlet UIButton *p2RematchButton;
@property (weak, nonatomic) NSObject<GameOverViewDelegate> *delegate;

@property(nonatomic) enum Player winner;
@end