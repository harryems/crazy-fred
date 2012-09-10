//
//  AppDelegate.h
//  crazy fred
//
//  Created by Carlos Espinosa de los Monteros on 9/4/12.
//  Copyright __MyCompanyName__ 2012. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RootViewController;

@interface AppDelegate : NSObject <UIApplicationDelegate> {
	UIWindow			*window;
	RootViewController	*viewController;

    
    
}

@property (nonatomic, retain) UIWindow *window;

@end
