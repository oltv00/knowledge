//
//  AppDelegate.m
//  8_DictionaryTestRestoProg
//
//  Created by Oleg Tverdokhleb on 19.10.15.
//  Copyright © 2015 Oleg Tverdokhleb. All rights reserved.
//

#import "AppDelegate.h"
#import "MRQStudent.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    MRQStudent *student1 = [[MRQStudent alloc] init];
    MRQStudent *student2 = [[MRQStudent alloc] init];
    MRQStudent *student3 = [[MRQStudent alloc] init];
    MRQStudent *student4 = [[MRQStudent alloc] init];
    MRQStudent *student5 = [[MRQStudent alloc] init];
    
    student1.name = @"student1 name"; student1.lastName = @"student1 lastName"; student1.greeting = @"Hello, I am std1";
    student2.name = @"student2 name"; student2.lastName = @"student2 lastName"; student2.greeting = @"Hello, I am std2";
    student3.name = @"student3 name"; student3.lastName = @"student3 lastName"; student3.greeting = @"Hello, I am std3";
    student4.name = @"student4 name"; student4.lastName = @"student4 lastName"; student4.greeting = @"Hello, I am std4";
    student5.name = @"student5 name"; student5.lastName = @"student5 lastName"; student5.greeting = @"Hello, I am std5";
    
    NSDictionary *dictionary = [NSDictionary dictionaryWithObjectsAndKeys:
                                student1, [student1.lastName stringByAppendingString:student1.name],
                                student2, [student2.lastName stringByAppendingString:student2.name],
                                student3, [student3.lastName stringByAppendingString:student3.name],
                                student4, [student4.lastName stringByAppendingString:student4.name],
                                student5, [student5.lastName stringByAppendingString:student5.name],
                                nil];

    //NSLog(@"%@", dictionary);
    
    for (NSString *key in [dictionary allKeys]) {
        id object = [dictionary objectForKey:key];
        NSLog(@"Name: %@, Lastname: %@, %@", [object name], [object lastName], [object greeting]);
    }
    
# pragma mark - Level Master!
    
    NSArray *sortedDictionary = [dictionary keysSortedByValueUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        return [[obj1 name] compare:[obj2 name]];
    }];
    
    NSInteger sortedDictionaryIndex = 0;
    
    NSLog(@"\n");
    
    for (NSString *key in [dictionary allKeys]){
        id object = [dictionary objectForKey:[sortedDictionary objectAtIndex:sortedDictionaryIndex]];
        NSLog(@"%@", [object greeting]);
        sortedDictionaryIndex++;
    }
    
    
    
    
    
    
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
