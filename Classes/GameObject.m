//
//  GameObject.m
//  Pontra
//
//  Created by Jarod Luebbert on 4/17/10.
//  Copyright 2010 nil. All rights reserved.
//

#import "GameObject.h"

@implementation GameObject

@synthesize x, y, width, height, x_velocity, y_velocity;

/*
 * init
 * Last modified: 17April2010
 * - Jarod
 * 
 * initializes the object
 * 
 */
- (id) initWithPosition:(CGPoint) p
{
  if (self = [super init]) {
    [self setPos:p];
  }
  
  return self;
}

- (void) Render
{
}

- (void) Update
{
}

/*
 * moveY
 * Last modified: 17April2010
 * - Jarod
 * 
 * moves the object in the specified
 * ammount in the y direction.
 * 
 */
- (void) moveY:(int) dir
{
	y += dir;
}

/*
 * moveX
 * Last modified: 17April2010
 * - Jarod
 * 
 * Moves the object the specified
 * ammount in the x direction
 * 
 */
- (void) moveX:(int) dir
{
	x += dir;
}

/*
 * setPos
 * Last modified: 17April2010
 * - Jarod
 * 
 * sets the position of the object
 * 
 */
- (void) setPos:(CGPoint) p
{
  [self setX:p.x];
  [self setY:p.y];
}

- (void) collidedRight
{
}

- (void) collidedLeft
{
}

- (void) collidedTop
{
}

- (void) collidedBottom
{
}

@end
