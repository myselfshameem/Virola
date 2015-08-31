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

    Account *account = [[AppDataManager sharedAppDatamanager] lastLoggedInUser];
    [[AppDataManager sharedAppDatamanager] setAccount:account];
    if (!account) {
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

    
    //
    [self checkImageUpload];
    
    
    return YES;
}

//- (void)checkImageUpload{
//    
//    
//    
//    NSData *imageData = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"back_btn" ofType:@"png"]];
//    NSString *boundary = @"---------------------------14737809831466499882746641449";
//    
//    
//    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
//    [request setURL:[NSURL URLWithString:@"http://localhost/xampp/Messages.php"]];
//    [request setHTTPMethod:@"POST"];
//
//    NSMutableData *body = [NSMutableData data];
//    [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
//    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"fileToUpload\"; filename=\"test.png\"\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
//    [body appendData:[[NSString stringWithFormat:@"Content-Type: image/jpeg\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
//    [body appendData:imageData];
//    [body appendData:[[NSString stringWithFormat:@"\r\n--%@--\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
//    [request setHTTPBody:body];
//    
//        NSURLResponse *response ;
//        NSError *error;
//        NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
//        NSString * responseString = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
//        NSLog(@"\n☀☀☀☀<response>: %@\n☀☀☀☀\n",responseString);
//
//    
//    
//}

- (void)checkImageUpload{
    
    // @"http://demo.dselva.info/virolainternational/api/mobile/v2/uploadPhoto.php"
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:@"http://localhost/xampp/Messages.php"]];
    
    UIImage *image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"NewDevelopment_Camera_Icon" ofType:@"png"]];
    NSData *imageData = UIImageJPEGRepresentation(image, 1.0);
    
    //[request setCachePolicy:NSURLRequestReloadIgnoringCacheData];
    [request setHTTPShouldHandleCookies:NO];
    [request setTimeoutInterval:60];
    [request setHTTPMethod:@"POST"];
    
    NSString *boundary = @"unique-consistent-string";
    
    // set Content-Type in HTTP header
    NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@", boundary];
    [request setValue:contentType forHTTPHeaderField: @"Content-Type"];
    
    // post body
    NSMutableData *body = [NSMutableData data];
    
    // add params (all params are strings)
//    [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
//    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=%@\r\n\r\n", @"imageCaption"] dataUsingEncoding:NSUTF8StringEncoding]];
//    [body appendData:[[NSString stringWithFormat:@"%@\r\n", @"Some Caption"] dataUsingEncoding:NSUTF8StringEncoding]];
    
    // add image data
    if (imageData) {
        [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=%@; filename=imageName.jpg\r\n", @"product_photo"] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[@"Content-Type: image/jpeg\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:imageData];
        [body appendData:[[NSString stringWithFormat:@"\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    }
    
    [body appendData:[[NSString stringWithFormat:@"--%@--\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    
    // setting the body of the post to the reqeust
    [request setHTTPBody:body];
    
    // set the content-length
    NSString *postLength = [NSString stringWithFormat:@"%d", [body length]];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    
    
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue currentQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
        if(data.length > 0)
        {
            //success
            NSString * responseString = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
            NSLog(@"\n☀☀☀☀<response>: %@\n☀☀☀☀\n",responseString);

        }
    }];
    
    
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
