//
//  Paddle.m
//  Pontra
//
//  Created by Jarod Luebbert on 4/15/10.
//  Copyright 2010 nil. All rights reserved.
//

#import "SeekerPaddle.h"

#define WIDTH 7
#define HEIGHT 150

@implementation SeekerPaddle

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

@end
