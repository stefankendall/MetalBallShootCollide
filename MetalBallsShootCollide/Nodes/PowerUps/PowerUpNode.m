#import "PowerUpNode.h"
#import "PowerUps.h"

@implementation PowerUpNode

- (PowerUp)powerUpValue {
    return PowerUpNone;
}

- (NSString *)powerUpText {
    return @"";
}

- (void) fadeIn {
    self.alpha = 0.1;
    [self runAction:[SKAction sequence:@[
            [SKAction fadeAlphaTo:0.4 duration:1],
            [SKAction fadeAlphaTo:0.1 duration:1],
            [SKAction fadeAlphaTo:0.4 duration:1],
            [SKAction fadeAlphaTo:0.1 duration:1],
            [SKAction fadeAlphaTo:1 duration:0.2],
            [SKAction runBlock:^{
                self.solid = YES;
            }]
    ]]];
}

@end