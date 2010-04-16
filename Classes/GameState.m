//
//  GameState.m
//  Pontra
//
//  Created by Jarod Luebbert on 4/15/10.
//  Copyright 2010 nil. All rights reserved.
//

#import "GameState.h"


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
