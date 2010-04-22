//
//  Paddle.m
//  Pontra
//
//  Created by Jarod Luebbert on 4/15/10.
//  Copyright 2010 nil. All rights reserved.
//

#import "AvoiderPaddle.h"

@implementation AvoiderPaddle

/*
 * avoid
 * Last modified: 17April2010
 * - Jarod
 * 
 * if the ball is within the paddles
 * view, it moves slowly away the
 * ball to avoid it.
 * 
 */
- (void) avoid:(GameObject*) object
{
	if ([self isInProximity:object]) {
    // within proxmity, so react
    [self setY_velocity:[object y_velocity]];
  }
  // start moving the paddle back to the middle
  else if ([self y] > IPHONE_HEIGHT/2 + 10) {
    [self setY_velocity:-1];
  }
  else if ([self y] < IPHONE_HEIGHT/2 - 10) {
    [self setY_velocity:1];
  }
  else {
    [self setY_velocity:0];
  }
}

/*
 * isInProximity
 * Last modified: 17April2010
 * - Jarod
 * 
 * checks to see if the ball is within the
 * paddles' view.
 * 
 */
- (BOOL) isInProximity:(GameObject*) object
{
  if ([self side] == LEFT) {
    return ([self x] + proximity >= [object x]);
  }
  else {
    return ([self x] - proximity <= [object x]);
  }
}

@end
