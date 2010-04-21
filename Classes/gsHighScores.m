//
//  gsHighScores.m
//  Pontra
//
//  Created by Jarod Luebbert on 4/15/10.
//  Copyright 2010 nil. All rights reserved.
//

#import "gsHighScores.h"
#import "gsMainMenu.h"

@implementation gsHighScores

/*
 * initWithFrame andManager
 * Last modified: 20April2010
 * - Mark
 *
 * Initializes the frame that the highscores nib
 * is loaded in. Loads highscores data.
 *
 * This is so fucking terrible, but it's due at midnight.
 *	
 */
- (id)initWithFrame:(CGRect)frame andManager:(GameStateManager *)pManager
{
	if (self = [super initWithFrame:frame andManager:pManager]) {
		[[NSBundle mainBundle] loadNibNamed:@"gsHighscores" owner:self options:nil];
		[self addSubview:subview];

		NSString *filePath = [self settingsFile];
		if ([[NSFileManager defaultManager] fileExistsAtPath:filePath])
		{
			NSArray *array = [[NSArray alloc] initWithContentsOfFile:filePath];
			
			for ( int i = 0; i < [array count]; i+=2 ) {
				NSString *name = [array objectAtIndex:i];
				NSString *score = [array objectAtIndex:(i+1)];
				switch (i) {
					case 0: [name1 setText:name];[score1 setText:score];break;
					case 2:	[name2 setText:name];[score2 setText:score];break;
					case 4:	[name3 setText:name];[score3 setText:score];break;
					case 6:	[name4 setText:name];[score4 setText:score];break;
					case 8:	[name5 setText:name];[score5 setText:score];break;					
					default: break;
				}
				[array release];
			}
		}//fi
		
	}
	return self;
}

/*
 * settingsFile
 * Last modified: 17April2010
 * - Mark
 * 
 * Returns the ponra-highscores.plist file 
 * 
 */
- (NSString *)settingsFile {
	// Get the documents directory
	NSArray	*paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsDirectory = [paths objectAtIndex:0];
	return [documentsDirectory stringByAppendingPathComponent:@"pontra-highscores.plist"];
}

/*
 * back
 * Last modified: 17April2010
 * - Mark
 * 
 * When the user presses 'back' the state
 * is changed back to the gsMainMenu
 * 
 */
- (IBAction) back
{
	[manager doStateChange:[gsMainMenu class]];
}

- (void)dealloc {
    [super dealloc];
}

@end
