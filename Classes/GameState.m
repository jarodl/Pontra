//
//  GameState.m
//  Pontra
//
//  Created by Jarod Luebbert on 4/15/10.
//  Copyright 2010 nil. All rights reserved.
//

#import "GameState.h"

#define DEGREES_TO_RADIANS(__ANGLE__) ((__ANGLE__) / 180.0 * M_PI)

@implementation GameState

- (id) initWithFrame:(CGRect)frame andManager:(GameStateManager *)pManager
{
  if (self = [super initWithFrame:frame]) {
    // init code
    manager = pManager;
    self.userInteractionEnabled = true;
    [self setViewToLandscape:self];
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

-(void)setViewToLandscape:(UIView*)viewObject {
  [viewObject setCenter:CGPointMake(160, 240)];
  CGAffineTransform cgCTM = CGAffineTransformMakeRotation(DEGREES_TO_RADIANS(90));
  viewObject.transform = cgCTM;
}

@end
