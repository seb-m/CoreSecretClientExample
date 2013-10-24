//
//  AppDelegate.m
//  CSClient
//
//  Created by Sébastien Martini on 21/08/13.
//  Copyright (c) 2013 Dbzteam.org. All rights reserved.
//

#import "AppDelegate.h"

#import "IACManager.h"


@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
  [IACManager sharedManager].callbackURLScheme = @"csclient";
  return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {

}

- (void)applicationDidEnterBackground:(UIApplication *)application {

}

- (void)applicationWillEnterForeground:(UIApplication *)application {

}

- (void)applicationDidBecomeActive:(UIApplication *)application {

}

- (void)applicationWillTerminate:(UIApplication *)application {

}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
  NSLog(@"Received request: %@", url);
  return [[IACManager sharedManager] handleOpenURL:url];
}

@end
