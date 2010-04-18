//
//  Ball.h
//  Pontra
//
//  Created by Mark Sands on 4/16/10.
//  Copyright 2010 nil. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <CoreGraphics/CoreGraphics.h>

@interface Ball : NSObject {
  int x;
  int y;
  int x_velocity;
  int y_velocity;
}

// Not sure if the 'nonatomic' keyword is the one to use, but it works.
// If this is a problem, please fix. ;)
// - Jarod
@property (nonatomic) int x;
@property (nonatomic) int y;

- (void) Render;
- (void) Update;
- (void) moveY:(int) dir;
- (void) moveX:(int) dir;
- (void) setPos:(CGPoint) p;

@end
