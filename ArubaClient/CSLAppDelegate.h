//
//  CSLAppDelegate.h
//  ArubaClient
//
//  Created by Ludovic Chenneberg on 4/7/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//
#import <RestKit/RestKit.h>
#import <RestKit/CoreData.h>
#import <UIKit/UIKit.h>

@interface CSLAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

+(UIColor*) getMainBackground;

@end
