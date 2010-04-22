//
//  GameStateManager.h
//  Pontra
//
//  Created by Jarod Luebbert on 4/15/10.
//  Copyright 2010 nil. All rights reserved.
//

/*
 * Some of this code came from O'Reilly iPhone Game Development
 * from Chapter 5 game which can be downloaded here: http://bit.ly/cE3C2F
 */

#import <Foundation/Foundation.h>


@interface GameStateManager : NSObject {

}

- (void) doStateChange: (Class) state;

@end
