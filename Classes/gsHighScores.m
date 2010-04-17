//
//  gsHighScores.m
//  Pontra
//
//  Created by Jarod Luebbert on 4/15/10.
//  Copyright 2010 nil. All rights reserved.
//

#import "gsHighScores.h"

@implementation gsHighScores

/*
 * initWithFrame andManager
 * Last modified: 16April2010
 * - Mark
 *
 * Initializes the frame that the highscores nib
 * is loaded in.
 *
 * TODO: This is currently broken
 *	
 */
- (id)initWithFrame:(CGRect)frame andManager:(GameStateManager *)pManager {
    if (self = [super initWithFrame:frame andManager:pManager]) {
      [[NSBundle mainBundle] loadNibNamed:@"gsHighscores" owner:self options:nil];
      
      [self addSubview:subview];
    }
    return self;
}

- (IBAction) back
{
}

- (void)dealloc {
    [super dealloc];
}

@end
