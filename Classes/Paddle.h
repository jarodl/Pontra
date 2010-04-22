//
//  Paddle.h
//  Pontra
//
//  Created by Jarod Luebbert on 4/15/10.
//  Copyright 2010 nil. All rights reserved.
//

#import "GameObject.h"

#define LEFT 0
#define RIGHT 1
#define WIDTH 7
#define HEIGHT 150
#define IPHONE_HEIGHT 320

// The different types of paddles will inherit from this object.
@interface Paddle : GameObject {
  int side;
  int proximity;
}

@property (nonatomic) int proximity;
@property (nonatomic) int side;

// The two AI methods for the different types of paddles.
- (void) avoid:(GameObject*) object;
- (void) seek:(GameObject*) object;
- (BOOL) didCollideWith:(GameObject*) object;
- (BOOL) isLessThanObject:(GameObject*) object;

@end
