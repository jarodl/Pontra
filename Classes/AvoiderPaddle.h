//
//  Paddle.h
//  Pontra
//
//  Created by Jarod Luebbert on 4/15/10.
//  Copyright 2010 nil. All rights reserved.
//

#import "Paddle.h"

@interface AvoiderPaddle : Paddle {
}

- (BOOL) isInProximity:(GameObject*) object;

@end
