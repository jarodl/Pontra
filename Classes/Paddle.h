//
//  Paddle.h
//  Pontra
//
//  Created by Jarod Luebbert on 4/15/10.
//  Copyright 2010 nil. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <CoreGraphics/CoreGraphics.h>

@interface Paddle : NSObject {
  int x_pos;
  int y_pos;
}

- (void) moveY:(int) dir;
- (void) moveX:(int) dir;
- (void) setPos:(CGPoint) p;



@end
