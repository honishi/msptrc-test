//
//  AppDelegate.m
//  PTRC
//
//  Created by Hiroyuki Onishi on 8/28/13.
//  Copyright (c) 2013 Hiroyuki Onishi. All rights reserved.
//

#import "AppDelegate.h"
#import "SomeViewController.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    SomeViewController* vc = [[SomeViewController alloc] init];
    
    UINavigationController* nc = [[UINavigationController alloc] initWithRootViewController:vc];
    
    [self.window setRootViewController:nc];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    return YES;
}

@end
