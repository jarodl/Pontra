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

@interface Paddle : GameObject {
  int side;
}

@property (nonatomic) int side;

- (void) seek:(GameObject*) object;
- (void) avoid:(GameObject*) object;
- (BOOL) didCollideWith:(GameObject*) object;

@end
