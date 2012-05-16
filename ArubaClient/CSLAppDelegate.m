//
//  CSLAppDelegate.m
//  ArubaClient
//
//  Created by Ludovic Chenneberg on 4/7/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CSLAppDelegate.h"
#import <RestKit/RestKit.h>
#import "CSLEvent.h"
#import <QuartzCore/QuartzCore.h>

@implementation CSLAppDelegate

@synthesize window = _window;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    
    // Override point for customization after application launch.
    return YES;
}

+(UIColor *)getMainBackground{
    UIColor *col;
    if ([[UIScreen mainScreen] scale] == 2.0f) {
        col = [UIColor colorWithPatternImage:[UIImage imageNamed:@"gWallpaper@2x.jpg"]];
    } else {
        col = [UIColor colorWithPatternImage:[UIImage imageNamed:@"gWallpaper.jpg"]];
    }
    return col;
    
    // Initialise
    
//    // Create an image context (think of this as a canvas for our masterpiece) the same size as the view
//    UIGraphicsBeginImageContextWithOptions([UIScreen mainScreen].bounds.size, YES, 1);
//    // Our gradient only has two locations - start and finish. More complex gradients might have more colours
//    size_t num_locations = 2;
//    // The location of the colors is at the start and end
//    CGFloat locations[2] = { 0.0, 1.0 };
//    // These are the colors! That's two RBGA values
//    CGFloat components[8] = {
//        0.9,0.9,0.9, 1,
//        1.,1.,1., 1 };
//    // Create a color space
//    CGColorSpaceRef myColorspace = CGColorSpaceCreateDeviceRGB();
//    // Create a gradient with the values we've set up
//    CGGradientRef myGradient = CGGradientCreateWithColorComponents (myColorspace, components, locations, num_locations);
//    // Set the radius to a nice size, 80% of the width. You can adjust this
//    float myRadius = ([UIScreen mainScreen].bounds.size.width*.8);
//    // Now we draw the gradient into the context. Think painting onto the canvas
//    CGPoint center = CGPointMake([UIScreen mainScreen].bounds.size.width/2, [UIScreen mainScreen].bounds.size.height/2);
//    CGContextDrawRadialGradient (UIGraphicsGetCurrentContext(), myGradient, center, 0, center, myRadius, kCGGradientDrawsAfterEndLocation);
//    // Rip the 'canvas' into a UIImage object
//    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
//    // And release memory
//    CGColorSpaceRelease(myColorspace);
//    CGGradientRelease(myGradient);
//    UIGraphicsEndImageContext();
//    // … obvious.
//    return [UIColor colorWithPatternImage:image];

}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

-(void)applicationDidFinishLaunching:(UIApplication *)application withOptions: (NSDictionary*)options{
//    RKObjectManager* objectManager = [RKObjectManager managerWithBaseURLString:@"https://localhost:3000/api/v1/account"];
//    RKManagedObjectStore *objectStore = [RKManagedObjectStore objectStoreWithStoreFilename:@"ArubaClientDB.sqlite"];
//    objectManager.objectStore = objectStore;
//    
//    RKManagedObjectMapping *eventMapping = [RKManagedObjectMapping mappingForClass:[CSLEvent class] inManagedObjectStore:[[RKObjectManager sharedManager] objectStore]];
//    [eventMapping mapKeyPath:@"id" toAttribute:@"eventID"];
//    [eventMapping mapKeyPath:@"name" toAttribute:@"name"];
//    [eventMapping mapKeyPath:@"description" toAttribute:@"description"];
//    [eventMapping mapKeyPath:@"from" toAttribute:@"from"];
//    [eventMapping mapKeyPath:@"to" toAttribute:@"to"];
//    [eventMapping mapKeyPath:@"url" toAttribute:@"url"];
//    [eventMapping mapKeyPath:@"price" toAttribute:@"price"];
//    [eventMapping mapKeyPath:@"location" toAttribute:@"location"];
//    [eventMapping mapKeyPath:@"coordinates" toAttribute:@"coordinates"];
//    [eventMapping mapKeyPath:@"user_id" toAttribute:@"userID"];
//    [eventMapping mapKeyPath:@"created_at" toAttribute:@"createdAt"];
//    [eventMapping mapKeyPath:@"updated_at" toAttribute:@"updatedAt"];
//    eventMapping.primaryKeyAttribute = @"eventID";
//    
    
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
