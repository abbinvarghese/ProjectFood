//
//  AppDelegate.m
//  ProjectFood
//
//  Created by Abbin Varghese on 07/07/16.
//  Copyright © 2016 Abbin Varghese. All rights reserved.
//

#import "AppDelegate.h"

#import <FBSDKCoreKit/FBSDKCoreKit.h>

@import Firebase;

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [FIRApp configure];
    
    [[FBSDKApplicationDelegate sharedInstance] application:application
                             didFinishLaunchingWithOptions:launchOptions];
//    
//    NSError *error;
//    [[FIRAuth auth] signOut:&error];
//    if (!error) {
//        // Sign-out succeeded
//    }
    
    return YES;
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    [FBSDKAppEvents activateApp];
}

- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation {
    return [[FBSDKApplicationDelegate sharedInstance] application:application
                                                          openURL:url
                                                sourceApplication:sourceApplication
                                                       annotation:annotation];
}
@end
