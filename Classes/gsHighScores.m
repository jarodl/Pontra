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
 * - Travis
 *
 * Initializes the frame that the highscores nib
 * is loaded in. Loads highscores data.
 *	
 */
- (id)initWithFrame:(CGRect)frame andManager:(GameStateManager *)pManager
{
	if (self = [super initWithFrame:frame andManager:pManager]) {
		[[NSBundle mainBundle] loadNibNamed:@"gsHighscores" owner:self options:nil];
		[self addSubview:subview];

		NSString *filePath = [self scoresFile];
		if ([[NSFileManager defaultManager] fileExistsAtPath:filePath])
		{
			NSArray *array = [[NSArray alloc] initWithContentsOfFile:filePath];
			NSNumber *score;
			
			NSArray *sort = [array sortedArrayUsingSelector:@selector(compare:)];
			
			int one   = [sort count]-1;
			int two   = [sort count]-2;
			int three = [sort count]-3;
			int four  = [sort count]-4;
			int five  = [sort count]-5;
			
			score = [sort objectAtIndex:one];  [score1 setText:[NSString stringWithFormat:@"%@",score]];
			score = [sort objectAtIndex:two];  [score2 setText:[NSString stringWithFormat:@"%@",score]];
			score = [sort objectAtIndex:three];[score3 setText:[NSString stringWithFormat:@"%@",score]];
			score = [sort objectAtIndex:four]; [score4 setText:[NSString stringWithFormat:@"%@",score]];
			score = [sort objectAtIndex:five]; [score5 setText:[NSString stringWithFormat:@"%@",score]];

			[array release];
		}//fi
		
	}
	return self;
}

/*
 * settingsFile
 * Last modified: 17April2010
 * - Travis
 * 
 * Returns the ponra-highscores.plist file 
 * 
 */
- (NSString *)scoresFile {
	// Get the documents directory
	NSArray	*paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsDirectory = [paths objectAtIndex:0];
	return [documentsDirectory stringByAppendingPathComponent:@"pontra-highscores.plist"];
}

/*
 * back
 * Last modified: 17April2010
 * - Travis
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
