//
//  AppDelegate.m
//  TestApp
//
//  Created by Halin on 9/15/15.
//  Copyright (c) 2015 me.halin. All rights reserved.
//

#import "AppDelegate.h"
#import "SwiftDemo.h"
#import "JSPatchDemo.h"
#import "RACDemo.h"
#import "SlideMenuNavigationController.h"
#import "Mediator/Mediator.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

//    [JSPatchDemo test];
//    [SwiftDemo test];
//    [RACDemo test];
    
    //初始化加载view
    [((SlideMenuNavigationController *)self.window.rootViewController) view];
    [[Mediator shareInstance] setupWithRootViewController:((SlideMenuNavigationController *)self.window.rootViewController).childNavigationController];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {

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
