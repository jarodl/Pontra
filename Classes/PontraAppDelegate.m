//
//  PontraAppDelegate.m
//  Pontra
//
//  Created by Jarod Luebbert on 3/28/10.
//  Copyright SIUE 2010. All rights reserved.
//

#import "PontraAppDelegate.h"
#import "PontraViewController.h"
#import "gsMainMenu.h"

#define LOOP_TIMER_MINIMUM 0.033f
#define IPHONE_HEIGHT 480
#define IPHONE_WIDTH 320

@implementation PontraAppDelegate

@synthesize window;
@synthesize viewController;

- (void)applicationDidFinishLaunching:(UIApplication *)application {    
  
  [ResourceManager initialize];
  
  // Set up the main loop
  [NSTimer scheduledTimerWithTimeInterval:LOOP_TIMER_MINIMUM target:self selector:@selector(gameLoop:) userInfo:nil repeats:NO];
  
  lastUpdateTime = [[NSDate date] timeIntervalSince1970];
  
  FPS_lastSecondStart = lastUpdateTime;
  FPS_framesThisSecond = 0;
	
  // set up our first game state
  [self doStateChange:[gsMainMenu class]];
}

- (void) gameLoop: (id) sender
{
  double currTime = [[NSDate date] timeIntervalSince1970];
	
	[((GameState*)viewController.view) Update];
	[((GameState*)viewController.view) Render];
	
	FPS_framesThisSecond++;
	float timeThisSecond = currTime - FPS_lastSecondStart;
	if( timeThisSecond > 1.0f ) {
		bestFramesPerSecond = FPS_framesThisSecond;
		FPS_framesThisSecond = 0;
		FPS_lastSecondStart = currTime;
	}
	
	float sleepPeriod = LOOP_TIMER_MINIMUM;	
	[NSTimer scheduledTimerWithTimeInterval:sleepPeriod target:self selector:@selector(gameLoop:) userInfo:nil repeats:NO];
	
	lastUpdateTime = currTime;
}

- (float) getFramesPerSecond
{
  return bestFramesPerSecond;
}

// Handles the transition from the different menu items and the game.
- (void) doStateChange: (Class) state
{	
	if( viewController.view != nil ) {
		[viewController.view removeFromSuperview]; //remove view from window's subviews.
		[viewController.view release]; //release gamestate 
	}
	
  // If you can figure out why 160 is needed here, I'll buy you a beer.
  // If it's zero then the game screen is thrown off by, well, 160px or so.
	viewController.view = [[state alloc]  initWithFrame:CGRectMake(0, 160, 480.0, 320.0) andManager:self];	
  [window addSubview:viewController.view];
  [window makeKeyAndVisible];
}

- (void)dealloc {
    [viewController release];
    [window release];
    [super dealloc];
}

@end
