#import <Foundation/Foundation.h>

@protocol GameOverViewDelegate <NSObject>

- (void) rematch;

- (void)goHome;
@end