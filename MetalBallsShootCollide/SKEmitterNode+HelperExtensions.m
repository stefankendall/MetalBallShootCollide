#import "SKEmitterNode+HelperExtensions.h"

@implementation SKEmitterNode (HelperExtensions)

+ (SKEmitterNode *)rcw_nodeWithFile:(NSString *)filename {
    NSString *basename = [filename stringByDeletingPathExtension];
    NSString *path = [[NSBundle mainBundle] pathForResource:basename ofType:@"sks"];
    SKEmitterNode *node = (id) [NSKeyedUnarchiver unarchiveObjectWithFile:path];
    return node;
}

- (void)rcw_dieOutInDuration:(NSTimeInterval)duration {
    SKAction *firstWait = [SKAction waitForDuration:duration];
    __weak SKEmitterNode *weakSelf = self;
    SKAction *stop = [SKAction runBlock:^{
        weakSelf.particleBirthRate = 0;
    }];
    SKAction *secondWait = [SKAction waitForDuration:self.particleLifetime];
    SKAction *remove = [SKAction removeFromParent];
    SKAction *dieOut = [SKAction sequence:@[firstWait, stop, secondWait, remove]];
    [self runAction:dieOut];
}

@end