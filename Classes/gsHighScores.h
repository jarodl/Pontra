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
	
	IBOutlet UILabel *score1;
	IBOutlet UILabel *score2;
	IBOutlet UILabel *score3;
	IBOutlet UILabel *score4;
	IBOutlet UILabel *score5;
}

- (IBAction) back;
- (NSString *) scoresFile;

@end
