//
//  GameViewController.h
//  MetalBallsShootCollide
//

//  Copyright (c) 2015 Usable Design LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <SpriteKit/SpriteKit.h>
#import "GameOverDelegate.h"
#import "GameOverViewDelegate.h"

@class GameScene;

@interface GameViewController : UIViewController <GameOverDelegate, GameOverViewDelegate>

@property(nonatomic, strong) GameScene *scene;
@end
