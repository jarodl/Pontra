//
//  gsLevel.m
//  Pontra
//
//  Created by Mark Sands on 4/18/10.
//  Copyright 2010 nil. All rights reserved.
//

#import "gsLevel.h"

@implementation gsLevel

/* initWithDifficulty
 * Last Modified: 18April2010
 * - Mark
 * 
 * initializes each level with
 * a certain difficulty
 * 
 */
- (id) initWithDifficulty:(int)diff {
	if(self = [super init]) {
		// .. initialize ..
	}
	
	leftPaddle = [[AvoiderPaddle alloc] initWithPosition:CGPointMake(90, 160)];
	rightPaddle =[[SeekerPaddle alloc] initWithPosition:CGPointMake(465, 160)];
	
	[leftPaddle setProximity:480];
	[leftPaddle setSide:LEFT];
	
	[rightPaddle setProximity:diff];
	[rightPaddle setSide:RIGHT];

	return self;
}

/* Render
 * Last Modified: 18April2010
 * - Mark
 * 
 * calls left/right paddle render
 * 
 */
- (void) Render {
	[leftPaddle Render];
	[rightPaddle Render];
}

/* Update
 * Last Modified: 18April2010
 * - Mark
 * 
 * Calls left/right paddle update
 * 
 */
- (void) Update {
	[leftPaddle Update];
	[rightPaddle Update];
}

/* Seek
 * Last Modified: 18April2010
 * - Mark
 * 
 * The right paddle seeks the ball
 * 
 */
- (void) Seek:(GameObject*)object {
	[rightPaddle seek:object];
}

/* Avoid
 * Last Modified: 18April2010
 * - Mark
 * 
 * The left paddle avoids the ball
 * 
 */
- (void) Avoid:(GameObject*)object {
	[leftPaddle avoid:object];
}

/* leftPaddleDidCollideWith
 * Last Modified: 18April2010
 * - Mark
 * 
 * Handles left paddle collisions
 * 
 */
- (BOOL) leftPaddleDidCollideWith:(GameObject*)object {
	return [leftPaddle didCollideWith:object];
}

/* rightPaddleDidCollideWith
 * Last Modified: 18April2010
 * - Mark
 * 
 * Handles right paddle collisions
 * 
 */
- (BOOL) rightPaddleDidCollideWith:(GameObject*)object {
	return [rightPaddle didCollideWith:object];
}

/* shouldAdvanceToNext
 * Last Modified: 18April2010
 * - Mark
 * 
 * test if ball is past the paddle, then 
 * it should advance to the next level
 * 
 */
- (BOOL) shouldAdvanceToNext:(GameObject*)object {
	return ([rightPaddle isLessThanObject:object]);
}

- (void) dealloc {
	[leftPaddle release];
	[rightPaddle release];
	[super dealloc];
}

@end
