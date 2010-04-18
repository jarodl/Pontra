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

- (id) initWithPosition:(CGPoint) p
{
  if (self = [super initWithPosition:p]) {
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

- (BOOL) didCollideWith:(GameObject *)object
{
  if ([self side] == LEFT) {
		if (object.x - object.width/2 <= self.x + self.width/2 &&
				object.y >= self.y - self.height/2 &&
				object.y <= self.y + self.height/2 ) {
			return TRUE;
    }
  }
  if ([self side] == RIGHT) {	
		if (object.x + object.width/2 >= self.x - self.width/2 &&
				object.y >= self.y - self.height/2 &&
				object.y <= self.y + self.height/2 ) {
			return TRUE;
    }
  }
  
  return FALSE;
}

@end
