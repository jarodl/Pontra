//
//  GameState.h
//  Pontra
//
//  Created by Jarod Luebbert on 4/15/10.
//  Copyright 2010 nil. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "GameStateManager.h"
#import <UIKit/UIView.h>

@interface GameState : UIView {
  GameStateManager* manager;
}

- (id) initWithFrame:(CGRect)frame andManager:(GameStateManager*) pManager;
- (void) Render;
- (void) Update;

@end
