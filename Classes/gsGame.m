//
//  gsGame.m
//  Pontra
//
//  Created by Jarod Luebbert on 4/15/10.
//  Copyright 2010 nil. All rights reserved.
//

#import "gsGame.h"
#import "ResourceManager.h"

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
  [[g_ResManager getTexture:@"controls.png"] drawAtPoint:CGPointMake(xcenter, ycenter) withRotation: 0 withScale: 1];
  
  glRotatef(90, 0, 0, -1);
	//end drawing 2d stuff

  
	//you get a nice boring white screen if you forget to swap buffers.
	[self swapBuffers];
}

- (IBAction) pause
{
}

- (void)dealloc {
    [super dealloc];
}

@end
