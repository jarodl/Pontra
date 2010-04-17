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


- (id)initWithFrame:(CGRect)frame andManager:pManager {
  if (self = [super initWithFrame:frame andManager:pManager]) {
    // Initialization code
  }
  
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
	
  // no idea why subtracting 80 is necessary
  int ycenter = self.frame.size.height/2 - 80;
	int xcenter = 40;
	
	switch (control_pressed) {
		case NO_CONTROL:
			[[g_ResManager getTexture:@"controls.png"] drawAtPoint:CGPointMake(xcenter, ycenter) withRotation: 0 withScale: 1];
			break;
		case TOP_CONTROL:
			[[g_ResManager getTexture:@"controls_top.png"] drawAtPoint:CGPointMake(xcenter, ycenter) withRotation: 0 withScale: 1];
			break;
		case BOTTOM_CONTROL:
			[[g_ResManager getTexture:@"controls_bottom.png"] drawAtPoint:CGPointMake(xcenter, ycenter) withRotation: 0 withScale: 1];
			break;
		default:
			break;
	}
  
  glRotatef(90, 0, 0, -1);
	//end drawing 2d stuff

  
	//you get a nice boring white screen if you forget to swap buffers.
	[self swapBuffers];
}

- (IBAction) pause
{
	
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
    [super dealloc];
}

@end
