//
//  gsHighScores.h
//  Pontra
//
//  Created by Jarod Luebbert on 4/15/10.
//  Copyright 2010 nil. All rights reserved.
//

#import <Foundation/Foundation.h>
#include "GameState.h"

@interface gsHighScores : GameState {
  IBOutlet UIView* subview;
}

- (IBAction) back;
- (NSString *) settingsFile;

@end
