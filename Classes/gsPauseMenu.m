//
//  gsPauseMenu.m
//  Pontra
//
//  Created by Jarod Luebbert on 4/15/10.
//  Copyright 2010 SIUE. All rights reserved.
//

#import "gsPauseMenu.h"

@implementation gsPauseMenu

- (id)initWithFrame:(CGRect)frame andManager: pManager {
  if (self = [super initWithFrame:frame andManager:pManager]) {
    //load the gsPauseMenu.xib file here.
    //this will instantiate the 'subview' uiview.
    [[NSBundle mainBundle] loadNibNamed:@"gsPauseMenu" owner:self options:nil];
    //add subview as... a subview.
    //this will let everything from the nib file show up on screen.
    [self addSubview:subview];
  }
  
  return self;
}

- (IBAction) resume
{
}

- (void)dealloc {
  [super dealloc];
}

@end
