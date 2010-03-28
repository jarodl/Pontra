//
//  PontraAppDelegate.h
//  Pontra
//
//  Created by Jarod Luebbert on 3/28/10.
//  Copyright SIUE 2010. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PontraViewController;

@interface PontraAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    PontraViewController *viewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet PontraViewController *viewController;

@end

