//
//  Ball.m
//  Pontra
//
//  Created by Mark Sands on 4/16/10.
//  Copyright 2010 nil. All rights reserved.
//

#import "Ball.h"
#import "ResourceManager.h"


@implementation Ball

- (id) init
{
  if (self = [super init]) {
    x_velocity = 5;
    y_velocity = 0;
  }
  
  return self;
}

/*
 * Render
 * Last modified: 17April2010
 * - Jarod
 *
 * Draws the ball image to the screen.
 *	
 */
- (void) Render
{
  [[g_ResManager getTexture:@"player.png"] drawAtPoint:CGPointMake(self.x, self.y)];
}

- (void) Update
{
  [self moveX:x_velocity];
  [self moveY:y_velocity];
}

/*
 * setYVelocity
 * Last modified: 17April2010
 * - Mark
 *
 * called by the user controls
 * to set the balls y_velocity
 * so it moves diagonally as well
 *	
 */
- (void) setYVelocity:(int) val
{
	y_velocity = val;
}

- (void) collidedRight
{
  x_velocity *= -1;
}

- (void) collidedLeft
{
  x_velocity *= -1;
}

- (void) collidedTop
{
  y_velocity *= -1;
}

- (void) collidedBottom
{
  y_velocity *= -1;
}


@end
