//
//  gsPauseMenu.h
//  Pontra
//
//  Created by Jarod Luebbert on 4/15/10.
//  Copyright 2010 SIUE. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "GameState.h"

@interface gsPauseMenu : GameState {
	IBOutlet UIView* subview;
}

- (IBAction) resume;

@end
