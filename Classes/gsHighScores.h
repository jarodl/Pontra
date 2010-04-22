//
//  gsHighScores.h
//  Pontra
//
//  Created by Jarod Luebbert on 4/15/10.
//  Copyright 2010 nil. All rights reserved.
//

#import <Foundation/Foundation.h>
#include "GameState.h"

// Stores the top five high scores.
@interface gsHighScores : GameState {
  IBOutlet UIView* subview;
	
	IBOutlet UILabel *name1;
	IBOutlet UILabel *name2;
	IBOutlet UILabel *name3;
	IBOutlet UILabel *name4;
	IBOutlet UILabel *name5;
	
	IBOutlet UILabel *score1;
	IBOutlet UILabel *score2;
	IBOutlet UILabel *score3;
	IBOutlet UILabel *score4;
	IBOutlet UILabel *score5;
}

- (IBAction) back;
- (NSString *) scoresFile;

@end
