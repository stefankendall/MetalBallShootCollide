#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <SpriteKit/SpriteKit.h>
#import "PowerUps.h"

@interface PowerUpNode : SKNode

@property(nonatomic) BOOL solid;

- (enum PowerUp)powerUpValue;

- (NSString *)powerUpText;

- (void)fadeIn;

@end