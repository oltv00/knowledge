//
//  AppDelegate.m
//  4_ParametersTest
//
//  Created by Oleg Tverdokhleb on 28.03.16.
//  Copyright © 2016 Oleg Tverdokhleb. All rights reserved.
//

#import "AppDelegate.h"
#import "OTObject.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    self.objectID = 0;
    
    [self firstTest];
    [self secondTest];
    [self thirdTest];
    NSLog(@"TEST IS OVER");
    
    return YES;
}

- (void)thirdTest {
    OTObject *object = [[OTObject alloc] initWithObjectID:self.objectID];
    
    self.copyyy = object;
}

- (void)secondTest {
    OTObject *object = [[OTObject alloc] initWithObjectID:self.objectID];
    
    self.strong = object;
    [self objectDescription:object];
    
    self.strong = [[OTObject alloc] initWithObjectID:self.objectID];
    [self objectDescription:object];
}

- (void)firstTest {
    OTObject *object = [[OTObject alloc] initWithObjectID:self.objectID];
    
    self.strong = object;
    self.weak = object;
    [self objectDescription:object];
    
    self.strong = nil;
    [self objectDescription:object];
}

- (void)objectDescription:(OTObject *)object {
    NSLog(@"My address in heap: %@", object);
    NSLog(@"strong = %@", self.strong);
    NSLog(@"weak = %@", self.weak);
}

- (NSInteger)objectID {
    _objectID += 1;
    return _objectID;
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