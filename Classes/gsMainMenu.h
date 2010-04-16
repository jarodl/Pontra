//
//  gsMainMenu.h
//  Pontra
//
//  Created by Jarod Luebbert on 4/15/10.
//  Copyright 2010 nil. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GameState.h"

@interface gsMainMenu : GameState {
  IBOutlet UIView* subview;
}

- (IBAction) playGame;
- (IBAction) showHighScores;
- (IBAction) showSettings;

@end
