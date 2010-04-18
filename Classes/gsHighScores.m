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
 * Last modified: 17April2010
 * - Mark
 *
 * Initializes the frame that the highscores nib
 * is loaded in. Loads highscores data.
 *	
 */
- (id)initWithFrame:(CGRect)frame andManager:(GameStateManager *)pManager {
    if (self = [super initWithFrame:frame andManager:pManager]) {
      [[NSBundle mainBundle] loadNibNamed:@"gsHighscores" owner:self options:nil];
      [self addSubview:subview];
    }
	
	NSString *filePath = [self settingsFile];
	if ([[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
		//NSArray *array = [[NSArray alloc]initWithContentsOfFile:filePath];
		//BOOL soundSetting = [[array objectAtIndex:0] boolValue];
	}
	
	return self;
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
