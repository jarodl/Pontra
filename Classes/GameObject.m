//
//  GameObject.m
//  Pontra
//
//  Created by Jarod Luebbert on 4/17/10.
//  Copyright 2010 nil. All rights reserved.
//

#import "GameObject.h"


@implementation GameObject

@synthesize x, y;

- (void) Render
{
}

- (void) Update
{
}

- (void) moveY:(int) dir
{
	y += dir;
}

- (void) moveX:(int) dir
{
	x += dir;
}

- (void) setPos:(CGPoint) p
{
	x = p.x;
	y = p.y;
}

- (void) collidedRight
{
}

- (void) collidedLeft
{
}

- (void) collidedTop
{
}

- (void) collidedBottom
{
}

@end
