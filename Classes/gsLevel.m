//
//  gsLevel.m
//  Pontra
//
//  Created by Mark Sands on 4/18/10.
//  Copyright 2010 nil. All rights reserved.
//

#import "gsLevel.h"

@implementation gsLevel

- (id) initWithDifficulty:(int)diff {
	if(self = [super init]) {
		// .. initialize ..
	}
	
	leftPaddle = [[AvoiderPaddle alloc] initWithPosition:CGPointMake(90, 160)];
	rightPaddle =[[SeekerPaddle alloc] initWithPosition:CGPointMake(465, 160)];
	
	[leftPaddle setProximity:300];
	[leftPaddle setSide:LEFT];
	
	[rightPaddle setProximity:diff];
	[rightPaddle setSide:RIGHT];

	return self;
}

- (void) Render {
	[leftPaddle Render];
	[rightPaddle Render];
}

- (void) Update {
	[leftPaddle Update];
	[rightPaddle Update];
}

- (void) Seek:(GameObject*)object {
	[rightPaddle seek:object];
}

- (void) Avoid:(GameObject*)object {
	[leftPaddle avoid:object];
}

- (BOOL) leftPaddleDidCollideWith:(GameObject*)object {
	return [leftPaddle didCollideWith:object];
}

- (BOOL) rightPaddleDidCollideWith:(GameObject*)object {
	return [rightPaddle didCollideWith:object];
}

- (BOOL) shouldAdvanceToNext:(GameObject*)object {
	return ([rightPaddle isLessThanObject:object]);
}

- (void) dealloc {
	[super dealloc];
}

@end
