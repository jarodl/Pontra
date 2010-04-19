//
//  gsModal.m
//  Pontra
//
//  Created by Mark Sands on 4/19/10.
//  Copyright 2010 nil. All rights reserved.
//

#import "gsModal.h"

#define CENTER 480/2

#define TOP		 320/2 + 320/8
#define MIDDLE 320/2
#define BOTTOM 320/2 - 320/8

@implementation gsModal

@synthesize top_text, middle_text, bottom_text, button_pressed, default_font;

- (id) initWithText:(NSString*)top middle:(NSString*)middle andBottom:(NSString*)bottom
{
	if (self = [super init]) {
		[self setTop_text:top];
		[self setMiddle_text:middle];
		[self setBottom_text:bottom];
		button_pressed = 0;
		default_font = nil;
	}
	return self;
}

- (GLFont *) font:(UIColor*)color
{
	 if ( default_font != nil )
		[default_font release];

	default_font = [[GLFont alloc] initWithString:@"0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWYXZ,.?!@/:- "
																			 fontName:@"Marker Felt" 
																			 fontSize:24.0f
																		strokeWidth:0.0f
																			fillColor:color
																		strokeColor:[UIColor grayColor]];
	return default_font;
}

- (void) Render
{
	[[g_ResManager getTexture:@"modal.png"] drawAtPoint:CGPointMake(480/2, 320/2) withRotation: 0 withScale: 1];
	
	UIColor *color_top = [UIColor grayColor];
	UIColor *color_mid = [UIColor blackColor];
	UIColor *color_bot = [UIColor blackColor];
	
	if (button_pressed == 2) {
		color_mid = [UIColor grayColor];
	}
	else if (button_pressed == 3) {
		color_bot = [UIColor grayColor];
	}
	
	[self displayText:top_text    atPosition:TOP		withColor:color_top];
	[self displayText:middle_text atPosition:MIDDLE withColor:color_mid];
	[self displayText:bottom_text atPosition:BOTTOM withColor:color_bot];
}

/* buttonPressed
 * Last Modified: 19April2010
 * - Mark
 *
 * checks which buttons from menu are pressed.
 * each row has a Y offset of +/- 15 pixels
 * each column has an X offset of +/- 90 pixels
 *
 * NOTE: since coords are inverted with fonts (super gay)
 *  the 'BOTTOM' is actually the location's top point and
 *  the 'TOP' is actually the location's bottom point.
 */
- (int) buttonPressedFromPoint:(CGPoint) point
{
	if ( point.x >= CENTER - 90 && point.x <= CENTER + 90 &&
			 point.y >= BOTTOM - 15 && point.y <= BOTTOM + 15 ) {
		button_pressed = 1;
		return 1;
	} 
	else if ( point.x >= CENTER - 90 && point.x <= CENTER + 90 &&
					  point.y >= MIDDLE - 15 && point.y <= MIDDLE + 15 ) {		
		button_pressed = 2;
		return 2;
	} 
	else if ( point.x >= CENTER - 90 && point.x <= CENTER + 90 &&
					  point.y >= TOP	- 15 && point.y <= TOP + 15 ) {
		button_pressed = 3;
		return 3;
	} 
	button_pressed = 0;
	return 0;
}

- (void) displayText:(NSString *)str atPosition:(int)pos withColor:(UIColor *)color
{
	[[self font:color] drawString:[NSString stringWithString:str] 
												atPoint:CGPointMake(CENTER, pos)
										 withAnchor:GRAPHICS_HCENTER | GRAPHICS_TOP];
}

- (void) dealloc {
	if (default_font != nil)
		[default_font release];
	[super dealloc];
}

@end
