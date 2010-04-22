//
//  GameState.h
//  Pontra
//
//  Created by Jarod Luebbert on 4/15/10.
//  Copyright 2010 nil. All rights reserved.
//

/*
 * Some of this code came from O'Reilly iPhone Game Development
 * from Chapter 5 game which can be downloaded here: http://bit.ly/cE3C2F
 */

#import "GameStateManager.h"
#import <UIKit/UIView.h>

@interface GameState : UIView {
  GameStateManager* manager;
}

- (id) initWithFrame:(CGRect)frame andManager:(GameStateManager*) pManager;
- (void) Render;
- (void) Update;

@end
