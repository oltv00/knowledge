//
//  AppDelegate.m
//  11_SelectorsTest
//
//  Created by Oleg Tverdokhleb on 22.10.15.
//  Copyright © 2015 Oleg Tverdokhleb. All rights reserved.
//

#import "AppDelegate.h"
#import "MRQObject.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    
    
    
//    [[NSNotificationCenter defaultCenter] addObserver:<#(nonnull id)#> selector:<#(nonnull SEL)#> name:<#(nullable NSString *)#> object:<#(nullable id)#>];
    
//    [self testMethod];
    
//    SEL selector1 = @selector(testMethod);
    
//    [self performSelector:selector1];
    
//    [self performSelector:@selector(testMethod)];
    
//    SEL selector2 = @selector(testMethodAndParameter:);
    
//    [self performSelector:@selector(testMethodWithParameter:)];
    
//    [self performSelector:selector2 withObject:@"I'am object in selector!"];
    
//    [self performSelector:@selector(testMethodWithTwoParameter:secondString:) withObject:@"I am first string" withObject:@"I am second string"];
    
//    [self performSelector:@selector(testMethodWithParameter:) withObject:@"I am object with delay" afterDelay:5.f];
    
    [self performSelector:@selector(testMethod)];

    MRQObject* object = [[MRQObject alloc] init];
    
    [object performSelector:@selector(testMethod)];
    
    //-------------------
    
    //Вызов метода, который скрыт под инкапсуляцией.
    
    NSString* secret = [object performSelector:@selector(superSecretText)];
    
    NSLog(@"secret = %@", secret);
    
    
    [self performSelector:@selector(testMethodParameter1:) withObject:[NSNumber numberWithInt:11]];

//    SEL selector1 = @selector(testMethod);

//    NSString* a = NSStringFromSelector(selector1);
//    SEL sel = NSSelectorFromString(a);
    
    // Override point for customization after application launch.
    return YES;
}

- (void) testMethodWithTwoParameter:(NSString*) firstString secondString:(NSString*) secondString {
    NSLog(@"Test method with two parameters: %@, %@", firstString, secondString);
}

- (void) testMethodWithParameter:(NSString*) string {
    NSLog(@"Test method with Parameter: %@",string);
}

- (void) testMethod {
    NSLog(@"Test Method");
}

- (void) testMethodParameter1:(NSInteger) intValue {
    NSLog(@"testMethodParameter1 = %d", intValue);
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
