//
//  GameObject.h
//  Pontra
//
//  Created by Jarod Luebbert on 4/17/10.
//  Copyright 2010 nil. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface GameObject : NSObject {
  int x;
  int y;
  int x_velocity;
  int y_velocity;
}

@property (nonatomic) int x;
@property (nonatomic) int y;

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
