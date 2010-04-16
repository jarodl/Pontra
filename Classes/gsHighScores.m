//
//  gsHighScores.m
//  Pontra
//
//  Created by Jarod Luebbert on 4/15/10.
//  Copyright 2010 nil. All rights reserved.
//

#import "gsHighScores.h"
#import "gsMainMenu.h"

@implementation gsHighScores

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame andManager:manager]) {
      [[NSBundle mainBundle] loadNibNamed:@"highscores" owner:self options:nil];
      
      [self addSubview:subview];
    }
    return self;
}

- (IBAction) back
{
}

- (void)dealloc {
    [super dealloc];
}

@end
