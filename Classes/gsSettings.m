//
//  gsSettings.m
//  Pontra
//
//  Created by Jarod Luebbert on 4/15/10.
//  Copyright 2010 nil. All rights reserved.
//

#import "gsSettings.h"
#import "gsMainMenu.h"

@implementation gsSettings

/*
 * initWithFrame andManager
 * Last modified: 16April2010
 * - Mark
 *
 * Initializes the frame that the settings nib
 * is loaded in.
 *
 * TODO: This is currently broken
 *	
 */
- (id)initWithFrame:(CGRect)frame andManager:(GameStateManager *)pManager {
		if (self = [super initWithFrame:frame andManager:pManager]) {
			[[NSBundle mainBundle] loadNibNamed:@"gsSettings" owner:self options:nil];
			[self addSubview:subview];
    }
  
    return self;
}

- (IBAction) back
{
  [manager doStateChange:[gsMainMenu class]];
}

- (void)dealloc {
    [super dealloc];
}

@end
