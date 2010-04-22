//
//  PontraViewController.m
//  Pontra
//
//  Created by Jarod Luebbert on 3/28/10.
//  Copyright SIUE 2010. All rights reserved.
//

/*
 * Some of this code came from O'Reilly iPhone Game Development
 * from Chapter 5 game which can be downloaded here: http://bit.ly/cE3C2F
 */

#import "PontraViewController.h"

#define DEGREES_TO_RADIANS(__ANGLE__) ((__ANGLE__) / 180.0 * M_PI)

@implementation PontraViewController

// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
}

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
  [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}

- (void)dealloc {
    [super dealloc];
}

- (BOOL) shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation {
  return (toInterfaceOrientation == UIInterfaceOrientationLandscapeRight);
}

/*
 * viewWillAppear
 * Added by Jarod
 * 
 * This applies a rotation to the screen in order to get the app to run
 * entirely in landscape mode.
 *
 * Fixed. "Don't touch this." - M.C. Hammer
 *
 * 18April2010
 *
 */
- (void) viewWillAppear:(BOOL)animated {
  CGAffineTransform landscapeTransform = CGAffineTransformMakeRotation(DEGREES_TO_RADIANS(90));
  // Mystery numbers below are still a mystery.
  landscapeTransform = CGAffineTransformTranslate(landscapeTransform, -80.0, +80.0);
  [self.view setTransform:landscapeTransform];
}

@end
