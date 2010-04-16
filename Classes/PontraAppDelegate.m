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
#define IPHONE_HEIGHT 320
#define IPHONE_WIDTH 480

@implementation PontraAppDelegate

@synthesize window;
@synthesize viewController;

- (void)applicationDidFinishLaunching:(UIApplication *)application {    
  
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
	//float dt = currTime - m_lastUpdateTime;  //can store this as double or float
	
	//	printf("main loop");
	
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
	//[self performSelector: @selector(gameLoop:) withObject:self afterDelay:  sleepPeriod];
	
	lastUpdateTime = currTime;
}

- (float) getFramesPerSecond
{
  return bestFramesPerSecond;
}

- (void) doStateChange: (Class) state
{
  BOOL animateTransition = TRUE;
  
  if (animateTransition) {
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.5];
    [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft forView:window cache:YES];
  }
  
  if (viewController.view != nil) {
    [viewController.view removeFromSuperview];
    [viewController.view release];
  }
  
  viewController.view = [[state alloc] initWithFrame:CGRectMake(0, 0, IPHONE_WIDTH, IPHONE_HEIGHT) andManager:self];
  
  // now set the view as visible
  [window addSubview:viewController.view];
  [window makeKeyAndVisible];
  
  if (animateTransition) {
    [UIView commitAnimations];
  }
}

- (void)dealloc {
    [viewController release];
    [window release];
    [super dealloc];
}

@end
