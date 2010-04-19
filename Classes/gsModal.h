//
//  gsModal.h
//  Pontra
//
//  Created by Mark Sands on 4/19/10.
//  Copyright 2010 nil. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ResourceManager.h"

@interface gsModal : NSObject {
	NSString *top_text;
	NSString *middle_text;
	NSString *bottom_text;
	
	GLFont *default_font;
	
	int button_pressed;
}

@property (nonatomic,retain) NSString *top_text;
@property (nonatomic,retain) NSString *middle_text;
@property (nonatomic,retain) NSString *bottom_text;

@property (nonatomic) int button_pressed;
@property (retain) GLFont *default_font;

- (id) initWithText:(NSString*)top middle:(NSString*)md andBottom:(NSString*)btm;
- (GLFont *) font:(UIColor*)color;
- (void) displayText:(NSString *)str atPosition:(int)pos withColor:(UIColor *)color;
- (void) Render;
- (int) buttonPressedFromPoint:(CGPoint)point;
	
@end
