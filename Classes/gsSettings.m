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
 * Last modified: 17April2010
 * - Mark
 *
 * Initializes the frame that the settings nib
 * is loaded in. Also loads the saved settings
 * data.
 *	
 */
- (id)initWithFrame:(CGRect)frame andManager:(GameStateManager *)pManager {
		if (self = [super initWithFrame:frame andManager:pManager]) {
			[[NSBundle mainBundle] loadNibNamed:@"gsSettings" owner:self options:nil];
			[self addSubview:subview];
    }
	
		NSString *filePath = [self settingsFile];
		if ([[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
			NSArray *array = [[NSArray alloc]initWithContentsOfFile:filePath];
			BOOL soundSetting = [[array objectAtIndex:0] boolValue];
			[soundSwitch setOn:soundSetting animated:YES];
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
	return [documentsDirectory stringByAppendingPathComponent:@"pontra-settings.plist"];
}

/*
 * back
 * Last modified: 17April2010
 * - Mark
 * 
 * When the user presses 'back' the settings
 * are saved to the settings.plist and the state
 * is changed back to the gsMainMenu
 * 
 */
- (IBAction) back
{
	BOOL soundSetting;
	if (soundSwitch.on)
		soundSetting = TRUE;
	else
		soundSetting = FALSE;
		
	// write the soundSetting to the array which is saved to the plist
	NSMutableArray *array = [[NSMutableArray alloc] init];
	[array addObject:[NSNumber numberWithBool:soundSetting]];
	[array writeToFile:[self settingsFile] atomically:YES];
	
	[manager doStateChange:[gsMainMenu class]];
}

- (void)dealloc {
    [super dealloc];
}

@end
