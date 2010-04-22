//
//  Paddle.m
//  Pontra
//
//  Created by Jarod Luebbert on 4/15/10.
//  Copyright 2010 nil. All rights reserved.
//

#import "Paddle.h"

@implementation Paddle

@synthesize side, proximity;

/*
 * initWithPosition
 * Last modified: 17April2010
 * - Jarod
 * 
 * initializes a paddle with a given
 * position.
 * 
 */
- (id) initWithPosition:(CGPoint) p
{
  if (self = [super initWithPosition:p]) {
    width = WIDTH;
    height = HEIGHT;
    y_velocity = 0;
  }
  
  return self;
}

/*
 * Render
 * Last modified: 17April2010
 * - Jarod
 * 
 * Draws the paddle image
 * 
 */
- (void) Render
{
  [[g_ResManager getTexture:@"paddle.png"] drawAtPoint:CGPointMake(self.x, self.y)];
}

/*
 * Update
 * Last modified: 17April2010
 * - Jarod
 * 
 * Updates the paddle's X/Y values
 * 
 */
- (void) Update
{
  int upper_bound = self.y + self.height/2 + y_velocity;
  int lower_bound = self.y - self.height/2 + y_velocity;
  if (upper_bound <= IPHONE_HEIGHT && lower_bound >= 0) {
    [self moveY:y_velocity];
  }
}

- (void) seek:(GameObject*) object
{
}

- (void) avoid:(GameObject*) object
{
}

/*
 * didCollideWith
 * Last modified: 17April2010
 * - Jarod
 * 
 * Handles collision with the ball
 * 
 */
- (BOOL) didCollideWith:(GameObject *)object
{
  if ([self side] == LEFT) {
		if (object.x <= self.x + self.width/2 &&
				object.y >= self.y - self.height/2 &&
				object.y <= self.y + self.height/2 ) {
			return TRUE;
    }
  }
  if ([self side] == RIGHT) {	
		if (object.x >= self.x - self.width/2 &&
				object.y >= self.y - self.height/2 &&
				object.y <= self.y + self.height/2 ) {
			return TRUE;
    }
  }
  
  return FALSE;
}

/*
 * isLessThanObject
 * Last modified: 17April2010
 * - Mark
 * 
 * Returns true if the ball is not passed the
 * right paddle. Used to check if
 * the level should advance
 * 
 */
- (BOOL) isLessThanObject:(GameObject*) object {
	if ([self side] == RIGHT) {	
		if (object.x >= self.x + self.width/2)
			return TRUE;
  }
  return FALSE;
}

@end
