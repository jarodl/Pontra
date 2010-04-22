//
//  GameState.m
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

#define DEGREES_TO_RADIANS(__ANGLE__) ((__ANGLE__) / 180.0 * M_PI)

@implementation GameState

- (id) initWithFrame:(CGRect)frame andManager:(GameStateManager *)pManager
{
  if (self = [super initWithFrame:frame]) {
    // init code
    manager = pManager;
    self.userInteractionEnabled = true;
  }  
  return self;
}

- (void) Update
{
}

- (void) Render
{
}

- (void) drawRect:(CGRect) rect
{
}

- (void) dealloc
{
  [super dealloc];
}

@end
