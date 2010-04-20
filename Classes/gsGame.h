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
#import "GameObject.h"
#import "ResourceManager.h"
#import "gsLevel.h"
#import "gsModal.h"

#import "GameState.h"
#import "gsMainMenu.h"

@interface gsGame : GLESGameState {
	int control_pressed;
  int score;
	int current_level;
	
	Ball *ball;
	gsModal *modal;
	
	NSMutableArray *levels;
	
	BOOL soundSetting;
	BOOL fxSetting;
	
	BOOL pause;
}

@property (nonatomic) int current_level;

@property (nonatomic, retain) Ball *ball;
@property (nonatomic,	retain) gsModal *modal;

@property (nonatomic, retain) NSMutableArray *levels;

- (void) addLevels;
- (void) touchesHandler:(NSSet*)touches;
- (NSString *) settingsFile;
- (void) handleCollision:(GameObject*) object;

@end
