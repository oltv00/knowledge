//
//  AppDelegate.m
//  6_TypesTest
//
//  Created by Oleg Tverdokhleb on 30.03.16.
//  Copyright © 2016 Oleg Tverdokhleb. All rights reserved.
//

#import "AppDelegate.h"
#import "OTStudent.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
//    [self testOne];
//    [self testTwo];
//    [self testThree];
//    [self testFive];
//    [self testSix];
    [self testSeven];
    
    return YES;
}

- (void)testSeven {
    CGPoint point1 = CGPointMake(0, 5);
    CGPoint point2 = CGPointMake(3, 4);
    CGPoint point3 = CGPointMake(2, 8);
    CGPoint point4 = CGPointMake(7, 1);
    CGPoint point5 = CGPointMake(4, 4);
    
    NSArray *array = [NSArray arrayWithObjects:
                      [NSValue valueWithCGPoint:point1],
                      [NSValue valueWithCGPoint:point2],
                      [NSValue valueWithCGPoint:point3],
                      [NSValue valueWithCGPoint:point4],
                      [NSValue valueWithCGPoint:point5], nil];
    
    NSLog(@"%@", array);
    
    for (NSValue *value in array) {
        NSLog(@"point #%ld = %@",[array indexOfObject:value]+1, NSStringFromCGPoint([value CGPointValue]));
    }
}

- (void)testSix {
    BOOL boolVar = YES; //NO
    NSInteger intVar = 10;
    NSUInteger uIntVar = 100;
    CGFloat floatVar = 1.9f;
    double doubleVar = 2.5f;
    
    NSArray *array = @[@(boolVar), @(intVar), @(uIntVar), @(floatVar), @(doubleVar)];
    NSLog(@"%@", array);
    
    for (NSNumber *number in array) {
        NSLog(@"%@", number);
    }
}

- (void)testFive {
    CGPoint point;
    point.x = 5;
    point.y = 10;
    point = CGPointMake(0, 0);
    
    CGSize size;
    size.width = 20;
    size.height = 30;
    size = CGSizeMake(10, 10);
    
    CGRect rect;
    rect.origin = point;
    rect.size = size;
    rect = CGRectMake(0, 0, 10, 10);
    
    //находится ли эта point в rect
    BOOL result = CGRectContainsPoint(rect, point);
    NSLog(@"%d", result);
}

- (void)testFour {
    OTStudent *studentA = [[OTStudent alloc] init];
    studentA.gender = OTGenderMale;
}

- (void)testThree {
    NSInteger a = 10;
    NSLog(@"a = %ld", a);
    
    NSInteger b = a;
    b = 5;
    NSLog(@"a = %ld, b = %ld", a, b);
    
    NSInteger *c = &a;
    *c = 2;
    NSLog(@"a = %ld, b = %ld, c = %ld", a, b, *c);
}

- (void)testTwo {
    OTStudent *studentA = [[OTStudent alloc] init];
    studentA.name = @"Best Student";
    NSLog(@"StudentA name = %@", studentA.name);
    
    OTStudent *studentB = studentA;
    studentB.name = @"Bad Student";
    
    NSLog(@"StudentA name = %@", studentA.name);
}

- (void)testOne {
    BOOL boolVar = YES; //NO
    NSInteger intVar = 10;
    NSUInteger uIntVar = 100;
    CGFloat floatVar = 1.9f;
    double doubleVar = 2.5f;
    
    NSLog(@"boolVar = %d\tbytes = %ld", boolVar, sizeof(boolVar));
    NSLog(@"intVar = %ld\tbytes = %ld", intVar, sizeof(intVar));
    NSLog(@"uIntVar = %ld\tbytes = %ld", uIntVar, sizeof(uIntVar));
    NSLog(@"floatVar = %f\tbytes = %ld", floatVar, sizeof(floatVar));
    NSLog(@"doubleVar = %f\tbytes = %ld", doubleVar, sizeof(doubleVar));
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
