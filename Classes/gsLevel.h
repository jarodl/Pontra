//
//  gsLevel.h
//  Pontra
//
//  Created by Mark Sands on 4/18/10.
//  Copyright 2010 nil. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ResourceManager.h"
#import "AvoiderPaddle.h"
#import "SeekerPaddle.h"
#import "GameObject.h"

/* gsLevel
 * Last Modified: 18April2010
 * - Mark
 * 
 * Provides and abstract interface
 * to the Pontra levels.
 * 
 */
@interface gsLevel : NSObject {
	AvoiderPaddle *leftPaddle;
  SeekerPaddle *rightPaddle;
}

- (id) initWithDifficulty:(int)diff;

- (void) Render;
- (void) Update;

- (void) Seek:(GameObject*)object;
- (void) Avoid:(GameObject*)object;

- (BOOL) leftPaddleDidCollideWith:(GameObject*)object;
- (BOOL) rightPaddleDidCollideWith:(GameObject*)object;

- (BOOL) shouldAdvanceToNext:(GameObject*)object;

@end