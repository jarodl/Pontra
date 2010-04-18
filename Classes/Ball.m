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

@synthesize x, y;

- (id) init
{
  if (self = [super init]) {
    x_velocity = 1;
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

- (void) moveY:(int) dir
{
	y += dir;
}

- (void) moveX:(int) dir
{
	x += dir;
}

- (void) setPos:(CGPoint) p
{
	x = p.x;
	y = p.y;
}

@end
