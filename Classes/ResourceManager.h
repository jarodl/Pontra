//
//  ResourceManager.h
//  Test_Framework
//
//  Created by Joe Hogue on 4/4/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

/*
 * Some of this code came from O'Reilly iPhone Game Development
 * from Chapter 5 game which can be downloaded here: http://bit.ly/cE3C2F
 */


#import <OpenGLES/EAGL.h>
#import <OpenGLES/EAGLDrawable.h>
#import <OpenGLES/ES1/gl.h>
#import <OpenGLES/ES1/glext.h>
#import <Foundation/Foundation.h>
#import "GLTexture.h"
#import "GLFont.h"
#import "Balto.h"

@class GLESGameState;
@class ResourceManager;

#define STORAGE_FILENAME @"appstorage"

//some helper methods.  These don't really belong in this class.
//returns the distance between two points.
CGFloat distsquared(CGPoint a, CGPoint b);
//returns a unit vector pointing from a to b.
CGPoint toward(CGPoint a, CGPoint b);

extern ResourceManager *g_ResManager; //paul <3's camel caps, hungarian notation, and underscores.

@interface ResourceManager : NSObject {
	//used to allocate and manage GLTexture instances.  Needs to be cleared in dealloc.
	NSMutableDictionary*	textures;
	
	Balto *sound;
  
	NSMutableDictionary*	storage;
	BOOL storage_dirty;
	NSString* storage_path;
	
	GLFont* default_font;
}

+ (ResourceManager *)instance;

- (void) shutdown;

//loads and buffers images as 2d opengles textures.
- (GLTexture*) getTexture: (NSString*) filename;
- (void) purgeTextures;

//useful for loading binary files that you include in the program bundle, such as game level data
- (NSData*) getBundleData:(NSString*) filename;

//for saving preferences or other game data.  This is stored in the documents directory, and may persist between app version updates.
- (BOOL) storeUserData:(id) data toFile:(NSString*) filename;
//for loading prefs or other data saved with storeData.  Returns nil if the file does not exist.
- (id) getUserData:(NSString*) filename;
- (BOOL) userDataExists:(NSString*) filename;
+ (NSString*) appendStorePath:(NSString*) filename;

// sounds
- (Balto *) sound;

- (GLFont *) defaultFont;
- (void) setDefaultFont: (GLFont *) newValue;
@end
