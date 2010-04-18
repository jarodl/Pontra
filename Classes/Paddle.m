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

@end
