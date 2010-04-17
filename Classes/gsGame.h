//
//  gsGame.h
//  Pontra
//
//  Created by Jarod Luebbert on 4/15/10.
//  Copyright 2010 nil. All rights reserved.
//

#import <UIKit/UIKit.h>
#include "GLESGameState.h"
#include "Ball.h"

@interface gsGame : GLESGameState {
	int control_pressed;
	Ball *ball;
}

@property (nonatomic, retain) Ball *ball;

- (void) touchesHandler:(NSSet*)touches;
- (IBAction) pause;

@end
