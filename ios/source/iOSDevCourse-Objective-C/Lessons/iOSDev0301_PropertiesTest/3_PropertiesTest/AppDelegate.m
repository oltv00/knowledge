//
//  AppDelegate.m
//  3_PropertiesTest
//
//  Created by Oleg Tverdokhleb on 02.03.16.
//  Copyright © 2016 Oleg Tverdokhleb. All rights reserved.
//

#import "AppDelegate.h"
#import "MRQBoxer.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    //[self firstMethod];
    //[self secondMethod];
    [self thirdMethod];
    
    return YES;
}

- (void)firstMethod {
    MRQBoxer *boxer = [[MRQBoxer alloc] init];
    
    boxer.name = @"RestoApps";
    boxer.age = 25;
    boxer.height = 1.83f;
    boxer.weight = 82.2f;
    
    NSLog(@"name = %@", boxer.name);
    NSLog(@"age = %ld", boxer.age);
    NSLog(@"height = %1.2f", boxer.height);
    NSLog(@"weight = %1.2f", boxer.weight);
}

- (void)secondMethod {
    MRQBoxer *boxer = [[MRQBoxer alloc] init];
    
    [boxer setName:@"BoxerName"];
    [boxer setAge:25];
    [boxer setHeight:1.83f];
    [boxer setWeight:82.2f];
    
    NSLog(@"name = %@", [boxer name]);
    NSLog(@"age = %ld", [boxer age]);
    NSLog(@"height = %1.2f", [boxer height]);
    NSLog(@"weight = %1.2f", [boxer weight]);
    
    NSLog(@"age = %ld", [boxer howOldAreYouWithGetter]);
    NSLog(@"age = %ld", [boxer howOldAreYouWithoutGetter]);
}

- (void)thirdMethod {
    MRQBoxer *boxer = [[MRQBoxer alloc] initWithDefaultParameters];
    boxer.name = @"myName";
    for (int i = 0; i < 10; i++) {
        [boxer name];
    }
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
