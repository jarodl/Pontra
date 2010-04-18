//
//  Paddle.m
//  Pontra
//
//  Created by Jarod Luebbert on 4/15/10.
//  Copyright 2010 nil. All rights reserved.
//

#import "Paddle.h"

#define WIDTH 7
#define HEIGHT 150

@implementation Paddle

@synthesize side;

- (id) init
{
  if (self = [super init]) {
    width = WIDTH;
    height = HEIGHT;
    y_velocity = 0;
  }
  
  return self;
}

- (void) Render
{
  [[g_ResManager getTexture:@"paddle.png"] drawAtPoint:CGPointMake(self.x, self.y)];
}

- (void) Update
{
  [self moveY:y_velocity];
}

- (void) seek:(GameObject*) object
{
}

- (void) avoid:(GameObject*) object
{
}


// This sucks and it doesn't work.
// I'm so freaking tired.
- (BOOL) didCollideWith:(GameObject *)object
{
  if ([self side] == LEFT) {
    if (object.x <= self.x &&
        object.y <= self.y + self.height &&
        object.y >= self.y - self.height) {
      return TRUE;
    }
  }
  else if ([self side] == RIGHT) {
    if (object.x >= self.x &&
        object.y <= self.y + self.height &&
        object.y >= self.y - self.height) {
      return TRUE;
    }
  }
  
  return FALSE;
}

@end
