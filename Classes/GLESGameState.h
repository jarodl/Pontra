//
//  GLESGameState.h
//  Pontra
//
//  Created by Jarod Luebbert on 4/15/10.
//  Copyright 2010 nil. All rights reserved.
//

/*
 * Some of this code came from O'Reilly iPhone Game Development
 * from Chapter 5 game which can be downloaded here: http://bit.ly/cE3C2F
 */


#import "GameState.h"
#import <Foundation/Foundation.h>

@interface GLESGameState : GameState {

}

- (void) startDraw;
- (void) swapBuffers;
- (BOOL) bindLayer;
+ (void) setup2D;

- (id) initWithFrame:(CGRect)frame andManager:(GameStateManager*) pManager;

@end
