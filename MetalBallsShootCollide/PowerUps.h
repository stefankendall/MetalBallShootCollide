#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef NS_OPTIONS(uint32_t, PowerUp) {
    PowerUpNone = 1 << 0,
    PowerUpSpeed = 1 << 1
};