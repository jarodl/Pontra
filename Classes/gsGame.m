//
//  gsGame.m
//  Pontra
//
//  Created by Jarod Luebbert on 4/15/10.
//  Copyright 2010 nil. All rights reserved.
//

#import "gsGame.h"


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
