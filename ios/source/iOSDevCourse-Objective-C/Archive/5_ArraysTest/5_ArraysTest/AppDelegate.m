//
//  AppDelegate.m
//  5_ArraysTest
//
//  Created by Oleg Tverdokhleb on 05.10.15.
//  Copyright © 2015 Oleg Tverdokhleb. All rights reserved.
//

#import "AppDelegate.h"
#import "MRQObject.h"
#import "MRQChiledOfObject.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    MRQObject* obj1 = [[MRQObject alloc] init];
    MRQObject* obj2 = [[MRQObject alloc] init];
    MRQChiledOfObject* obj3 = [[MRQChiledOfObject alloc] init];
    
    NSArray* array = [NSArray arrayWithObjects:obj1, obj2, obj3, nil];
    
    obj1.name = @"Object 1";
    obj2.name = @"Object 2";
    [obj3 setName:@"Object 3"];
    
    obj3.lastName = @"Last Name";
    
    for (MRQObject* obj in array){
        NSLog(@"name = %@", obj.name);
        [obj action];
    
        if ([obj isKindOfClass:[MRQChiledOfObject class]]){
            //NSLog(@"%@", (MRQChiledOfObject*)obj.lastName);
            MRQChiledOfObject* child = (MRQChiledOfObject*)obj;
            NSLog(@"%@", child.lastName);
        }
    }
    
    
    /*NSArray* array = [[NSArray alloc]
                      initWithObjects:
                      @"String 1",
                      @"String 2",
                      @"String 3",
                      nil];
    */
    //NSArray* array = [NSArray arrayWithObjects:@"String 1", @"String2", @"String 3", nil];
    
    //NSArray* array = @[@"String 1", @"String2", @"String 3"];
    /*
    for (NSString* string in array){
        NSLog(@"%@", string);
        NSLog(@"index = %d", [array indexOfObject:string]);
    }
    
    
    for (int i = 0; i < [array count]; i++) {
        NSLog(@"%@", [array objectAtIndex:i]);
        NSLog(@"i = %d", i);
    }
    */
    
    
    // Override point for customization after application launch.
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
