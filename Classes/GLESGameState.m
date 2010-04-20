//
//  GLESGameState.m
//  Pontra
//
//  Created by Jarod Luebbert on 4/15/10.
//  Copyright 2010 nil. All rights reserved.
//

#import "GLESGameState.h"
#import <OpenGLES/EAGLDrawable.h>
#import <QuartzCore/QuartzCore.h>
#import "ResourceManager.h"

#define IPHONE_WIDTH 320.0
#define IPHONE_HEIGHT 480.0

// Primary context for all OpenGL calls. Set this up in setup2D.
// This should be cleared on teardown.
EAGLContext* gles_context;

// These next 3 variables should really be tied whatever state we get bound to.
// This is why there is a white flash when a state changes.
GLuint gles_framebuffer;
GLuint gles_renderbuffer;
GLuint gles_depthRenderbuffer;
CGSize _size;

#define DEGREES_TO_RADIANS(__ANGLE__) ((__ANGLE__) / 180.0 * M_PI)
#define PI (3.1415926535f)*(65536)

@implementation GLESGameState

+ (Class) layerClass
{
  return [CAEAGLLayer class];
}

-(id) initWithFrame:(CGRect)frame andManager:(GameStateManager*)pManager;
{
  if (self = [super initWithFrame:frame andManager:pManager]) {
    // Initialization code
		[self bindLayer];
  }
  return self;
}

+ (void) initialize
{
  static BOOL initialized = NO;
  
  if (!initialized) {
    initialized = YES;
    [GLESGameState setup2D];
  }
}

+ (void) setup2D
{	
	gles_context = [[EAGLContext alloc] initWithAPI:kEAGLRenderingAPIOpenGLES1];
	[EAGLContext setCurrentContext:gles_context];
	glGenRenderbuffersOES(1, &gles_renderbuffer);
	glBindRenderbufferOES(GL_RENDERBUFFER_OES, gles_renderbuffer);	
	glGenFramebuffersOES(1, &gles_framebuffer);
	glBindFramebufferOES(GL_FRAMEBUFFER_OES, gles_framebuffer);
	glFramebufferRenderbufferOES(GL_FRAMEBUFFER_OES, GL_COLOR_ATTACHMENT0_OES, GL_RENDERBUFFER_OES, gles_renderbuffer);
	glEnable(GL_DEPTH_TEST);
	glEnable(GL_CULL_FACE); //todo: benchmark this.
	glMatrixMode(GL_PROJECTION);
	glLoadIdentity();
	CGRect rect = CGRectMake(0, 0, IPHONE_HEIGHT, IPHONE_WIDTH);
  glFrustumf(0, IPHONE_HEIGHT, 0, IPHONE_WIDTH, 1.0, -1.0);
	glViewport(0, 0, rect.size.width, rect.size.height);
	glMatrixMode(GL_MODELVIEW);
	glEnable(GL_TEXTURE_2D);
	glEnableClientState(GL_VERTEX_ARRAY);
}

- (BOOL) bindLayer
{
	CAEAGLLayer* eaglLayer = (CAEAGLLayer*)[self layer];
	
	// NSLog(@"layer %@", eaglLayer);
	
	//set up a few drawing properties.  App will run and display without this line, but the properties
	//here should make it go faster.  todo: benchmark this.
	[eaglLayer setDrawableProperties:[NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithBool:NO], kEAGLDrawablePropertyRetainedBacking, kEAGLColorFormatRGB565, kEAGLDrawablePropertyColorFormat, nil]];
	
	if(![EAGLContext setCurrentContext:gles_context]) {
		return NO;
	}
	
	//disconnect any existing render storage.  Has no effect if there is no existing storage.
	//I have no idea if this leaks.  I'm pretty sure that this class shouldn't be responsible for
	//freeing the previous eaglLayer, as that should be handled by the view which contains that layer.
	[gles_context renderbufferStorage:GL_RENDERBUFFER_OES fromDrawable:nil];
	
	//connect our renderbuffer to the eaglLayer's storage.  This allows our opengl stuff to be drawn to
	//the presented layer (and thus, the screen) when presentRenderbuffer is called.
	if(![gles_context renderbufferStorage:GL_RENDERBUFFER_OES fromDrawable:eaglLayer]) {
		glDeleteRenderbuffersOES(1, &gles_renderbuffer); //probably should exit the app here.
		return NO;
	}
	
	// For this sample, we also need a depth buffer, so we'll create and attach one via another renderbuffer.
	//this must be done after context renderbufferStorage:fromDrawable: call above.  otherwise everything is crush.
	//todo: release. -joe
	GLint backingWidth, backingHeight;
	glGetRenderbufferParameterivOES(GL_RENDERBUFFER_OES, GL_RENDERBUFFER_WIDTH_OES, &backingWidth);
	glGetRenderbufferParameterivOES(GL_RENDERBUFFER_OES, GL_RENDERBUFFER_HEIGHT_OES, &backingHeight);
	glGenRenderbuffersOES(1, &gles_depthRenderbuffer);
	glBindRenderbufferOES(GL_RENDERBUFFER_OES, gles_depthRenderbuffer);
	glRenderbufferStorageOES(GL_RENDERBUFFER_OES, GL_DEPTH_COMPONENT16_OES, backingWidth, backingHeight);
	glFramebufferRenderbufferOES(GL_FRAMEBUFFER_OES, GL_DEPTH_ATTACHMENT_OES, GL_RENDERBUFFER_OES, gles_depthRenderbuffer);
	
	if(glCheckFramebufferStatusOES(GL_FRAMEBUFFER_OES) != GL_FRAMEBUFFER_COMPLETE_OES)
	{
		NSLog(@"failed to make complete framebuffer object %x", glCheckFramebufferStatusOES(GL_FRAMEBUFFER_OES));
		return NO;
	}
  
	return YES;
}

- (void) startDraw
{
	glBindRenderbufferOES(GL_RENDERBUFFER_OES, gles_renderbuffer);
	glBindFramebufferOES(GL_FRAMEBUFFER_OES, gles_framebuffer);
}

- (void) swapBuffers
{
  EAGLContext *oldContext = [EAGLContext currentContext];
	GLuint oldRenderbuffer;
	
	if(oldContext != gles_context)
		[EAGLContext setCurrentContext:gles_context];
	
	glGetIntegerv(GL_RENDERBUFFER_BINDING_OES, (GLint *) &oldRenderbuffer);
	glBindRenderbufferOES(GL_RENDERBUFFER_OES, gles_renderbuffer);
	
	//NSLog(@"oldrenderbuffer %d, renderbuffer %d", oldRenderbuffer, _renderbuffer);
	
	glFinish();
	
	if(![gles_context presentRenderbuffer:GL_RENDERBUFFER_OES])
		printf("Failed to swap renderbuffer in %s\n", __FUNCTION__);
}

- (void) tearDown
{
  [gles_context release];
}

@end
