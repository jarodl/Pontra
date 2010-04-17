//
//  gsGame.m
//  Pontra
//
//  Created by Jarod Luebbert on 4/15/10.
//  Copyright 2010 nil. All rights reserved.
//

#import "gsGame.h"
#import "ResourceManager.h"

#define NO_CONTROL 0
#define TOP_CONTROL 1
#define BOTTOM_CONTROL 2

@implementation gsGame

@synthesize ball, sound;


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
  }
  
	// initialize the sound
	NSString *soundFile = [[NSBundle mainBundle] pathForResource:@"teachingrobot" ofType:@"wav"];	
	NSMutableArray *sounds = [[NSMutableArray alloc] initWithCapacity:1];
	[sounds addObject:soundFile];
	
	// initialize the sound with the array of audio files
	sound = [[Balto alloc] initWithFiles:sounds];
		
	// check settings if sound is on/off
	NSString *filePath = [self settingsFile];
	BOOL soundSetting = FALSE;
	if ([[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
		NSArray *array = [[NSArray alloc]initWithContentsOfFile:filePath];
		soundSetting = [[array objectAtIndex:0] boolValue];
	} else {
		soundSetting = TRUE;
	}

	
	if (soundSetting) {
		[sound Play:0 andLooping:YES];
	}

	ball = [[Ball alloc] init];
	[ball setPos:CGPointMake(self.frame.size.width/2, self.frame.size.height/2)];
	
  return self;
}

- (void) Render
{
  //clear anything left over from the last frame, and set background color.
	glClearColor(0xff/256.0f, 0xcc/256.0f, 0x99/256.0f, 1.0f);
	glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT); //important to clear the depth buffer as well as color buffer.
	
	glLoadIdentity();
  
  //Set up OpenGL projection matrix for 2d hud rendering.
	glMatrixMode(GL_PROJECTION);
	glPushMatrix(); //pushing so we can restore the main game view after playing with the hud.
	glLoadIdentity(); //needed, glorthof doesn't clobber the matrix like joe would expect
	glOrthof(0, self.frame.size.width, 0, self.frame.size.height, -1, 1);
	
	//setup for drawing the alpha blended textures used in the hud.
	glMatrixMode(GL_MODELVIEW);
	glLoadIdentity(); //needed
	glEnableClientState(GL_TEXTURE_COORD_ARRAY); //needed, every frame, else nothing renders
	glEnable(GL_BLEND); //needed, otherwise extra chunks of the image are drawn
	glBlendFunc(GL_ONE, GL_ONE_MINUS_SRC_ALPHA); //needed
	glDisable(GL_DEPTH_TEST); //needed for overlaying images

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
  
  glRotatef(90, 0, 0, -1);
	//end drawing 2d stuff

  
	//you get a nice boring white screen if you forget to swap buffers.
	[self swapBuffers];
}

/*
 * Update
 * Last modified: 17April2010
 * - Jarod
 *
 * This is inherited from GameState and will be used to
 * update the paddles and player's position on the screen.
 *	
 */
- (void) Update
{
  switch (control_pressed) {
    case TOP_CONTROL:
      // move the ball up
      [ball moveY:5];
      break;
    case BOTTOM_CONTROL:
      // move the ball down
      [ball moveY:-5];
      break;
    default:
      break;
  }
}

- (IBAction) pause
{
	
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
	return [documentsDirectory stringByAppendingPathComponent:@"settings.plist"];
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
	[self setNeedsDisplay];
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
	[self setNeedsDisplay];
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
 * Last modified: 16April2010
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
	else {
		control_pressed = NO_CONTROL;
	}
}


- (void)dealloc {
	[ball release];
	[sound release];
	[super dealloc];
}

@end
