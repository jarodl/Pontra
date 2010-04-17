//
//  Ball.m
//  Pontra
//
//  Created by Mark Sands on 4/16/10.
//  Copyright 2010 nil. All rights reserved.
//

#import "Ball.h"


@implementation Ball

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

@end
