//
//  gsMainMenu.m
//  Pontra
//
//  Created by Jarod Luebbert on 4/15/10.
//  Copyright 2010 nil. All rights reserved.
//

#import "gsMainMenu.h"
#import "gsGame.h"
#import "gsHighScores.h"
#import "gsSettings.h"


@implementation gsMainMenu

-(gsMainMenu*) initWithFrame:(CGRect)frame andManager:(GameStateManager *)pManager
{
  if (self = [super initWithFrame:frame andManager:pManager]) {
    // load the .xib file here.
    // this inits the 'subview' UIView.
    [[NSBundle mainBundle] loadNibNamed:@"gsMainMenu" owner:self options:nil];
    // add as a subview, this will let everything from the nib show up
    // on the screen.
    [self addSubview:subview];
  }

    return self;
}

- (IBAction) playGame
{
  [manager doStateChange:[gsGame class]];
}

- (IBAction) showHighScores
{
  [manager doStateChange:[gsHighScores class]];
}

- (IBAction) showSettings
{
  [manager doStateChange:[gsSettings class]];
}
  
@end
