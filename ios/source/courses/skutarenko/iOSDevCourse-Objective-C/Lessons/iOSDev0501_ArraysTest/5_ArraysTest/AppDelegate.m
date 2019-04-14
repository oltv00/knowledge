//
//  AppDelegate.m
//  5_ArraysTest
//
//  Created by Oleg Tverdokhleb on 29.03.16.
//  Copyright © 2016 Oleg Tverdokhleb. All rights reserved.
//

#import "AppDelegate.h"

#import "OTObject.h"
#import "OTChild.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    //[self firstMethod];
    //[self secondMethod];
    [self thirdTest];
    
    return YES;
}

- (void)thirdTest {
    OTObject *obj1 = [[OTObject alloc] initWithName:@"obj1"];
    OTObject *obj2 = [[OTObject alloc] initWithName:@"obj2"];
    OTChild *obj3 = [[OTChild alloc] initWithName:@"obj3"];

    obj3.lastName = @"CHILD_LAST_NAME";
    
    NSArray *array = @[obj1, obj2, obj3];
    for (OTObject *obj in array) {
        NSLog(@"name = %@", obj.name);
        [obj action];
        
        if ([obj isKindOfClass:[OTChild class]]) {
            NSLog(@"isKindOfClass accept");
            OTChild *child = (OTChild *)obj;
            NSLog(@"Last Name = %@", child.lastName);
        }
    }
}

- (void)secondTest {
    NSArray *array = @[@"first", @"second", @"third"];
    NSLog(@"%@", array);
    for (NSString *str in array) {
        NSLog(@"%@", str);
    }
}

- (void)firstTest {
    NSArray *array = [[NSArray alloc] initWithObjects:@"first", @"second", @"third", nil];
    NSLog(@"%@", array);
    for (int i = 0; i < [array count]; i++) {
        NSLog(@"%@", [array objectAtIndex:i]);
        NSLog(@"i = %d", i);
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
