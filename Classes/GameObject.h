//
//  GameObject.h
//  Pontra
//
//  Created by Jarod Luebbert on 4/17/10.
//  Copyright 2010 nil. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ResourceManager.h"

// All GameObjects (paddle, ball) will inherit from this.
@interface GameObject : NSObject {
  int x;
  int y;
  int x_velocity;
  int y_velocity;
  int width;
  int height;
}

@property (nonatomic) int x;
@property (nonatomic) int y;
@property (nonatomic) int x_velocity;
@property (nonatomic) int y_velocity;
// Stores the size of the sprite.
@property (nonatomic) int width;
@property (nonatomic) int height;

- (id) initWithPosition:(CGPoint) p;
- (void) Render;
- (void) Update;
- (void) moveY:(int) dir;
- (void) moveX:(int) dir;
- (void) setPos:(CGPoint) p;
- (void) collidedRight;
- (void) collidedLeft;
- (void) collidedTop;
- (void) collidedBottom;

@end
