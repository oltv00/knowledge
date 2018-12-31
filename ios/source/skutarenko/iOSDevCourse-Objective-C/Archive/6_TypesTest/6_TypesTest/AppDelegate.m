//
//  AppDelegate.m
//  6_TypesTest
//
//  Created by Oleg Tverdokhleb on 10.10.15.
//  Copyright © 2015 Oleg Tverdokhleb. All rights reserved.
//

#import "AppDelegate.h"
#import "MRQStudent.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    BOOL boolVar = YES; // 1 бит
    
    NSInteger intVar = 10;
    
    NSUInteger uIntVar = 100;
    
    CGFloat floatVar = 1.5f;
    
    double doubleVar = 2.5f;
    
    
    NSNumber *boolObject = [NSNumber numberWithBool:boolVar];
    NSNumber *integerObject = [NSNumber numberWithInteger:intVar];
    NSNumber *nsUIntegerObject = [NSNumber numberWithUnsignedInteger:uIntVar];
    NSNumber *cgfloatObject = [NSNumber numberWithFloat:floatVar];
    NSNumber *doubleObject = [NSNumber numberWithDouble:doubleVar];
    
    NSArray *array = [NSArray arrayWithObjects:boolObject,integerObject,nsUIntegerObject,cgfloatObject,doubleObject, nil];
    
    NSLog(@"boolVar = %d, intVar = %ld, uIntVar = %lu, floatVar = %.3f, doubleVar = %.3f",
          [[array objectAtIndex:0] boolValue],
          [[array objectAtIndex:1] integerValue],
          [[array objectAtIndex:2] unsignedIntegerValue],
          [[array objectAtIndex:3] floatValue],
          [[array objectAtIndex:4] doubleValue]
          );
    
    /*
    NSLog(@"\nboolVar = %d\n"
          @"intVar = %ld\n"
          @"uIntVar = %lu\n"
          @"floatVar = %.3f\n"
          @"doubleVar = %.3f\n",
          boolVar, (long)intVar, (unsigned long)uIntVar, floatVar, doubleVar);
    
    NSLog(@"\nboolVar = %ld\n"
          @"intVar = %ld\n"
          @"uIntVar = %ld\n"
          @"floatVar = %ld\n"
          @"doubleVar = %ld\n",
          sizeof (boolVar),sizeof (intVar),sizeof (uIntVar),sizeof (floatVar),sizeof (doubleVar));
    
    NSInteger a = floatVar;
    NSLog(@"NSInteger 1.5(floatVar) = %ld", (long)a);
    */
    /*
    MRQStudent *studentA = [[MRQStudent alloc] init];
    
    studentA.name = @"Best Student!";
    NSLog(@"StudentA name = %@", studentA.name);
    
    MRQStudent *studentB = studentA;
    
    [studentB setName:@"Bad Student!"];
    NSLog(@"StudentA name = %@", [studentA name]);
    */
    /*
    NSInteger a = 10;
    NSLog(@"a = %ld", (long)a);
    
    NSInteger b = a;
    b = 5;
    
    NSLog(@"a = %ld, b = %ld", (long)a, (long)b);
    
    NSInteger *c = &a;
    
    *c = 8;
    
    NSLog(@"a = %ld, b = %ld", (long)a, (long)b);
    
    MRQStudent *student = [[MRQStudent alloc] init];
    student.gender = MRQGenderMale;
    */
    /*
    CGPoint point;
    point.x = 5.5f;
    point.y = 10;
    
    point = CGPointMake(6, 3);
    
    CGSize size;
    size.width = 10;
    size.height = 5;
    
    size = CGSizeMake(10, 5);
    
    CGRect rect;
    
    rect.origin = point;
    rect.size = size;
    
    rect = CGRectMake(0, 0, 30, 60);
    
    //--
    
    BOOL result = CGRectContainsPoint(rect, point);
    if (result) NSLog(@"Died!");
    //-----*/
    
    CGPoint point1 = CGPointMake(0, 5);
    CGPoint point2 = CGPointMake(3, 4);
    CGPoint point3 = CGPointMake(2, 8);
    CGPoint point4 = CGPointMake(7, 1);
    CGPoint point5 = CGPointMake(4, 4);
    
    NSArray *array2 = [NSArray arrayWithObjects:
                      [NSValue valueWithCGPoint:point1],
                      [NSValue valueWithCGPoint:point2],
                      [NSValue valueWithCGPoint:point3],
                      [NSValue valueWithCGPoint:point4],
                      [NSValue valueWithCGPoint:point5], nil];
    
    for (NSValue* value in array2){
        CGPoint p = [value CGPointValue];
        
        NSLog(@"point = %@", NSStringFromCGPoint(p));
    }
    
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
