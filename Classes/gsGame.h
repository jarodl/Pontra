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
#import "SeekerPaddle.h"
#import "AvoiderPaddle.h"
#import "Balto.h"
#import "GameObject.h"
#import "ResourceManager.h"

@interface gsGame : GLESGameState {
	int control_pressed;
  int score;
	Ball *ball;
  Paddle *leftPaddle;
  Paddle *rightPaddle;
	Balto *sound;
	
	BOOL soundSetting;
	BOOL fxSetting;
	
	BOOL pause;
}

@property (nonatomic, retain) Ball *ball;
@property (nonatomic, retain) Balto *sound;

- (void) touchesHandler:(NSSet*)touches;
- (NSString *) settingsFile;
- (void) handleCollision:(GameObject*) object;

@end
