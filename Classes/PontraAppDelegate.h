//
//  PontraAppDelegate.h
//  Pontra
//
//  Created by Jarod Luebbert on 3/28/10.
//  Copyright SIUE 2010. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "GameStateManager.h"

@class PontraViewController;

@interface PontraAppDelegate : GameStateManager <UIApplicationDelegate> {
  UIWindow *window;
  PontraViewController *viewController;
  
  CFTimeInterval FPS_lastSecondStart;
  int FPS_framesThisSecond;
  
  CFTimeInterval lastUpdateTime;
  float bestFramesPerSecond;
  
}

- (void) gameLoop: (id) sender;
- (float) getFramesPerSecond;

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet PontraViewController *viewController;

@end

