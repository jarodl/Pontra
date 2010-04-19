//
//  gsGame.m
//  Pontra
//
//  Created by Jarod Luebbert on 4/15/10.
//  Copyright 2010 nil. All rights reserved.
//

#import "gsGame.h"

#define NO_CONTROL 0
#define TOP_CONTROL 1
#define BOTTOM_CONTROL 2

#define THEME 0
#define POP 1

@implementation gsGame

@synthesize ball, sound, levels, current_level, modal;

/*
 * initWithFrame andManager
 * Last modified: 17April2010
 * - Mark
 * 
 * Initializes the playing field.
 * Loads the main sound in the audio driver, and
 * checks the sound on/off in settings to play.
 * Initializes the ball and sets the coordinates.
 * 
 */
- (id)initWithFrame:(CGRect)frame andManager:pManager {
  if (self = [super initWithFrame:frame andManager:pManager]) {
    // Initialization code
    score = 0;
  }

	// initialize the sound
	NSString *soundFile1 = [[NSBundle mainBundle] pathForResource:@"teachingrobot" ofType:@"wav"];
	NSString *soundFile2 = [[NSBundle mainBundle] pathForResource:@"pop" ofType:@"wav"];
	NSMutableArray *sounds = [[NSMutableArray alloc] initWithCapacity:2];
	[sounds addObject:soundFile1];
	[sounds addObject:soundFile2];
	
	// initialize the sound with the array of audio files
	sound = [[Balto alloc] initWithFiles:sounds];
	[sounds release];
		
	// check settings if sound is on/off
	NSString *filePath = [self settingsFile];
	soundSetting = FALSE, fxSetting = FALSE;
	if ([[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
		NSArray *array = [[NSArray alloc]initWithContentsOfFile:filePath];
		soundSetting = [[array objectAtIndex:0] boolValue];
		fxSetting = [[array objectAtIndex:1] boolValue];
	} else {
		soundSetting = TRUE;
		fxSetting = TRUE;
	}
	
	if (soundSetting) {
		[sound Play:THEME andLooping:YES];
	}

	pause = FALSE;
	
  // init game objects
	ball = [[Ball alloc] init];
	
  // flipped the height and width here, this is due to the rotation of the
  // frame again. We should fix that.
  // - Jarod
	[ball setPos:CGPointMake(self.frame.size.width/2, self.frame.size.height/2)];
	
	// first level
	current_level = 0;
	
	// pause menu
	modal = [[gsModal alloc] initWithText:@"Paused" middle:@"Resume" andBottom:@"Settings"];
	
	// init levels
	[self addLevels];
	
  return self;
}

/*
 * addLevels
 * Last modified: 18April2010
 * - Mark
 * 
 * initializes the level components with
 * a difficulty and adds them to the
 * levels array.
 * 
 */
- (void) addLevels {
	gsLevel *lvl;
	levels = [[NSMutableArray alloc] initWithCapacity:5];
	for ( int i = 100; i <= 300; i+=50 ) {
		lvl = [[[gsLevel alloc] initWithDifficulty:i] autorelease];
		[levels addObject:lvl];
	}
}

- (void) Render
{
  //clear anything left over from the last frame, and set background color.
	glClearColor(0x1b/256.0f, 0x1b/256.0f, 0x1b/256.0f, 1.0f);
	glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT); //important to clear the depth buffer as well as color buffer.

	glLoadIdentity();

  //Set up OpenGL projection matrix for 2d hud rendering.
	glMatrixMode(GL_PROJECTION);
	glPushMatrix(); //pushing so we can restore the main game view after playing with the hud.
	glLoadIdentity(); //needed, glorthof doesn't clobber the matrix like joe would expect
  
  //
  // Okay, so this is the weirdest problem ever. If you switch the height
  // and the width here then the view is stretched out and messed up.
  // This has to have something to do with the way I am rotating all of the
  // subviews. This needs fixed throughout the entire application.
  // 
  // TODO:
  // * Fix the way the entire application handles landscape mode.
  //
  // - Jarod (16April2010)
	glOrthof(0, self.frame.size.height, 0, self.frame.size.width, -1, 1);
	
	//setup for drawing the alpha blended textures used in the hud.
	glMatrixMode(GL_MODELVIEW);
	glLoadIdentity(); //needed
	glEnableClientState(GL_TEXTURE_COORD_ARRAY); //needed, every frame, else nothing renders
	glEnable(GL_BLEND); //needed, otherwise extra chunks of the image are drawn
	glBlendFunc(GL_ONE, GL_ONE_MINUS_SRC_ALPHA); //needed
	glDisable(GL_DEPTH_TEST); //needed for overlaying images
  
  // Draw level text to the screen
	[[g_ResManager defaultFont] drawString:[NSString stringWithString:@"Go Right!"] atPoint:CGPointMake(self.frame.size.height/2, 300) withAnchor:GRAPHICS_HCENTER | GRAPHICS_TOP];
	[[g_ResManager defaultFont] drawString:[NSString stringWithFormat:@"%d", score] atPoint:CGPointMake(self.frame.size.height, 300) withAnchor:GRAPHICS_RIGHT | GRAPHICS_TOP];
  
  /* This needed to be the width/2 because it happens
   * before rotation.
   * - Jarod */
  int ycenter = self.frame.size.width/2;
	int xcenter = 40;
	
	NSString *ctrl;
	switch (control_pressed) {
		case NO_CONTROL:
			ctrl = @"controls.png";
			break;
		case TOP_CONTROL:
			ctrl = @"controls_top.png";
			break;
		case BOTTOM_CONTROL:
			ctrl = @"controls_bottom.png";
			break;
		default:
			break;
	}

  // Draw the controls
	[[g_ResManager getTexture:ctrl] drawAtPoint:CGPointMake(xcenter, ycenter) withRotation: 0 withScale: 1];
	
  // Draw the player here
	[ball Render];
	
  // Draw the paddles
	[[levels objectAtIndex:current_level] Render];

	// Pause modal display
	if (pause) {
		[modal Render];
	}

	//pop the 2d hud stuff off the projection stack
	glMatrixMode(GL_PROJECTION);
	glPopMatrix();
	glMatrixMode(GL_MODELVIEW);
    
	//you get a nice boring white screen if you forget to swap buffers.
	[self swapBuffers];
}

/*
 * Update
 * Last modified: 17April2010
 * - Mark
 *
 * This is inherited from GameState and will be used to
 * update the paddles and player's position on the screen.
 *
 * The collision handler should be called before the ball updates
 * itself so the ball's coordinates stay on screen.
 */
- (void) Update
{
	if (pause)
		return;
	
  // Update the balls position based on what control the player
  // is pressing.
  switch (control_pressed) {
    case TOP_CONTROL:
      // move the ball up
			[ball increaseYVelocity];
			break;
    case BOTTOM_CONTROL:
      // move the ball down
			[ball decreaseYVelocity];
      break;
    default:
      break;
  }
  
	// Check for collisions and resolve them.
  [self handleCollision: ball];

  // Call the ball's update method to apply velocity/acceleration.
  [ball Update];
	
	// Update paddles
	[[levels objectAtIndex:current_level] Update];
  
  // Update the AI for the paddles
	[[levels objectAtIndex:current_level] Seek:ball];
	[[levels objectAtIndex:current_level] Avoid:ball];
  
  // Check for collisions and resolve them.
  [self handleCollision:ball];
}

/*
 * settingsFile
 * Last modified: 17April2010
 * - Mark
 * 
 * Returns the settings.plist file 
 * 
 */
- (NSString *)settingsFile {
	// Get the documents directory
	NSArray	*paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsDirectory = [paths objectAtIndex:0];
	return [documentsDirectory stringByAppendingPathComponent:@"pontra-settings.plist"];
}

/*
 * touchesBegan
 * Last modified: 16April2010
 * - Mark
 *
 * Method to track the coordinates when the user
 * first touches the screen
 *	
 */
- (void) touchesBegan:(NSSet*)touches withEvent:(UIEvent*)event
{
	[self touchesHandler:touches];
}

/*
 * touchesMoved
 * Last modified: 16April2010
 * - Mark
 *
 * Method to track the coordinates when the user
 * moves their finger around the screen
 *	
 */
- (void) touchesMoved:(NSSet*)touches withEvent:(UIEvent*)event
{
	[self touchesHandler:touches];
}

/*
 * touchesEnded
 * Last modified: 16April2010
 * - Mark
 *
 * Method to track the coordinates when the user
 * removes their finger from the screen
 * This method releases the control_pressed var
 * assuming the user is done 'moving' the ball
 * around
 *	
 */
- (void) touchesEnded:(NSSet*)touches withEvent:(UIEvent*)event
{
	control_pressed = NO_CONTROL;
}

/*
 * touchesHandler
 * Last modified: 17April2010
 * - Mark
 *
 * Touches Handler to avoid redudant code
 * touchesBegan, touchesMoved, touchesEnded
 * use this to handle touch events
 *	
 */
- (void) touchesHandler:(NSSet*)touches
{
	UITouch *touch = [touches anyObject];
	CGPoint location = [touch locationInView:self];
	printf("x: %g\n",location.x);
	printf("y: %g\n",location.y);
	
	if ( location.x >=0 && location.x <= 75 &&
			location.y >= 0 && location.y <= 85 )
		control_pressed = TOP_CONTROL;
	else if ( location.x >=0 && location.x <= 75 &&
					 location.y >= 235 && location.y <= 320 )
		control_pressed = BOTTOM_CONTROL;
	else if ( location.x >= 90 ) {
		pause = !pause;
	}
	else {
		control_pressed = NO_CONTROL;
	}
	
	// handle pause
	if (pause) {
		[sound Pause];
		control_pressed = NO_CONTROL;
		
		if (location.x >= 480/2 - 50 &&
				location.x <= 480/2 + 50 &&
				location.y >= 320/2 - 20 &&
				location.y <= 320/2 + 20) {
			// ??? :\
			// [manager doStateChange:[gsSettings class]];
		}
	}
	else {
		[sound Resume];
	}
}

/*
 * collisionHandler
 * Last modified: 17April2010
 * - Mark
 *
 * Collision Handler that updates a game object
 * to resolve a collision.
 *
 * Also plays sound effects on collision if
 * the settings are on.
 *	
 */
- (void) handleCollision:(GameObject*) object
{
  float height = self.frame.size.width;
  float width = self.frame.size.height;
  
  BOOL shouldpop = FALSE;
	
	if ([[levels objectAtIndex:current_level] rightPaddleDidCollideWith:object]) {
		[object collidedRight];
		shouldpop = TRUE;
	}
	
	if ([[levels objectAtIndex:current_level] leftPaddleDidCollideWith:object]) {
		[object collidedLeft];
		shouldpop = TRUE;
	}
  
  if (object.x + object.width/2 >= width) {
    // handle hit right side
    [object collidedRight];
		shouldpop = TRUE;
  }
  else if (object.x - object.width/2 <= 0) {
    // handle hit left side
    [object collidedLeft];
		shouldpop = TRUE;
  }
  
  if (object.y + object.height/2 >= height) {
    // handle hit top
    [object collidedTop];
		shouldpop = TRUE;
  }
  else if (object.y - object.height/2 <= 0) {
    // handle hit bottom
    [object collidedBottom];
		shouldpop = TRUE;
  }
	
	// level done, advance ball back to start position
	if ( [[levels objectAtIndex:current_level] shouldAdvanceToNext:object] ) {
		if (current_level < 4)
			current_level++;
		[ball setPos:CGPointMake(self.frame.size.width/2, self.frame.size.height/2)];
	}
				
	// play soundFX
	if (shouldpop && fxSetting )
		[sound Play:POP andLooping:NO];
}

- (void)dealloc {
	[ball release];
	[sound release];
	[modal release];
	[super dealloc];
}

@end
