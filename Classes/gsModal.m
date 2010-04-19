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

@synthesize top_text, middle_text, bottom_text;

- (id) initWithText:(NSString*)top middle:(NSString*)middle andBottom:(NSString*)bottom
{
	if (self = [super init]) {
		[self setTop_text:top];
		[self setMiddle_text:middle];
		[self setBottom_text:bottom];
	}
	return self;
}

- (GLFont *) font:(UIColor*)color
{
	return [[GLFont alloc] initWithString:@"0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWYXZ,.?!@/:- "
																			 fontName:@"Marker Felt" 
																			 fontSize:24.0f
																		strokeWidth:0.0f
																			fillColor:color
																		strokeColor:[UIColor grayColor]];
}

- (void) Render
{
	[[g_ResManager getTexture:@"modal.png"] drawAtPoint:CGPointMake(480/2, 320/2) withRotation: 0 withScale: 1];

	[self displayText:top_text    atPosition:TOP		withColor:[UIColor grayColor]];
	[self displayText:middle_text atPosition:MIDDLE withColor:[UIColor blackColor]];
	[self displayText:bottom_text atPosition:BOTTOM withColor:[UIColor blackColor]];
}

- (void) displayText:(NSString *)str atPosition:(int)pos withColor:(UIColor *)color
{
	[[self font:color] drawString:[NSString stringWithString:str] 
									atPoint:CGPointMake(CENTER, pos)
							 withAnchor:GRAPHICS_HCENTER | GRAPHICS_TOP];
}

@end
