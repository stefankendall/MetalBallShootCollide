#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <SpriteKit/SpriteKit.h>

@interface TimerNode : SKNode
@property(nonatomic, strong) NSNumber *timeRemainingSeconds;

+ (TimerNode *)timerForPlayer:(enum Player)player inScene:(SKScene *)scene withTime:(NSNumber *)seconds;
@end