//
//  Ball.m
//  Pontra
//
//  Created by Mark Sands on 4/16/10.
//  Copyright 2010 nil. All rights reserved.
//

#import "Ball.h"

#define WIDTH 8
#define HEIGHT 8

@implementation Ball

- (id) init
{
  if (self = [super init]) {
    x_velocity = 5;
    y_velocity = 0;
    width = WIDTH;
    height = HEIGHT;
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
 * decreaseYVelocity
 * Last modified: 17April2010
 * - Mark
 *
 * called by the user controls
 * in order to give the ball's
 * angle an effected response.
 * The y_velocity is halted at
 * 5 for obvious reasons. This
 * number is safe to alter.
 *	
 */
- (void) decreaseYVelocity {
	if ( y_velocity >= -5 )
		y_velocity--;
}

/*
 * increaseYVelocity
 * Last modified: 17April2010
 * - Mark
 *
 * called by the user controls
 * in order to give the ball's
 * angle an effected response
 * The y_velocity is halted at
 * 5 for obvious reasons. This
 * number is safe to alter.
 *	
 */
- (void) increaseYVelocity {
	if ( y_velocity <= 5 )
		y_velocity++;
}

- (void) collidedRight
{
  x -= width/2;
  x_velocity *= -1;
}

- (void) collidedLeft
{
  x += width/2;
  x_velocity *= -1;
}

- (void) collidedTop
{
  y -= height/2;
  y_velocity *= -1;
}

- (void) collidedBottom
{
  y += height/2;
  y_velocity *= -1;
}


@end
