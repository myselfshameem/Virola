//
//  AppDelegate.m
//  Catalouge
//
//  Created by Shameem Ahamad on 4/13/15.
//  Copyright (c) 2015 Shameem Ahamad. All rights reserved.
//

#import "AppDelegate.h"
#import "LoginViewController.h"
#import "NSUserDefaults+UserDetail.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    NSLog(@"HomeDirectory : %@",[NSHomeDirectory() stringByAppendingPathComponent:@"Documents/"]);

    BOOL isUserLogedIn = [NSUserDefaults isUserLoggedIn];
    if (isUserLogedIn) {
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        LoginViewController *loginViewController = [storyboard instantiateViewControllerWithIdentifier:(isIPad() ? @"LoginViewController_iPad" : @"LoginViewController")];
        [self.window setRootViewController:loginViewController];
    }

    UINavigationBar *nav = [UINavigationBar appearance];
    UIImage *navBarImg = [UIImage imageNamed:@"navBariOS7"];
    [nav setBackgroundImage:navBarImg forBarMetrics:UIBarMetricsDefault];
    
    [[UINavigationBar appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont fontWithName:@"MyriadPro-Bold" size:18],NSFontAttributeName,[UIColor whiteColor],NSForegroundColorAttributeName, nil]];
    
    
    
    
    UIBarButtonItem *bar = [UIBarButtonItem appearanceWhenContainedIn:[UINavigationBar class], nil];
    [bar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],NSForegroundColorAttributeName, nil] forState:UIControlStateNormal];
    [bar setBackButtonBackgroundImage:[UIImage imageNamed:@"back_btn"] forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    
    UITabBarItem *tabBarItem = [UITabBarItem appearance];
    [tabBarItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont fontWithName:@"MyriadPro-Regular" size:10],NSFontAttributeName,[UIColor colorWithRed:60/255 green:60/255 blue:60/255 alpha:1],NSForegroundColorAttributeName, nil] forState:UIControlStateNormal];

    [tabBarItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor colorWithRed:59/255 green:89/255 blue:152/255 alpha:1],NSForegroundColorAttributeName, nil] forState:UIControlStateSelected];

    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
