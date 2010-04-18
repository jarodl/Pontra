//
//  gsGame.h
//  Pontra
//
//  Created by Jarod Luebbert on 4/15/10.
//  Copyright 2010 nil. All rights reserved.
//

#import <UIKit/UIKit.h>
#include "GLESGameState.h"
#import "Ball.h"
#import "Paddle.h"
#import "Balto.h"
#import "GameObject.h"
#import "ResourceManager.h"

@interface gsGame : GLESGameState {
	int control_pressed;
	Ball *ball;
  Paddle *leftPaddle;
  Paddle *rightPaddle;
	Balto *sound;
	
	BOOL soundSetting;
	BOOL fxSetting;
}

@property (nonatomic, retain) Ball *ball;
@property (nonatomic, retain) Balto *sound;

- (void) touchesHandler:(NSSet*)touches;
- (IBAction) pause;
- (NSString *) settingsFile;
- (void) handleCollision:(GameObject*) object;

@end
