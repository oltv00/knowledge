//
//  AppDelegate.m
//  6_TypesTestRestoProg
//
//  Created by Oleg Tverdokhleb on 01.11.15.
//  Copyright © 2015 Oleg Tverdokhleb. All rights reserved.
//

#import "AppDelegate.h"

typedef enum {
    head,
    body,
    hand,
    foot
} BodyParts;

@interface AppDelegate ()

@property (assign, nonatomic) BodyParts parts;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    //ENUM!
    int i = 0;
    while (i < 1) {
        self.parts = arc4random() % 5;
        if (self.parts == head) {
            NSLog(@"!!!!!!!!!!!!!");
            i++;
        } else {
            NSLog(@"??");
            i++;
        }
    }
    
    //CGrect!
    CGRect rect = CGRectMake(0, 0, 10, 10);
    NSInteger numberOfShots = 10;
    
    for (NSInteger i = 0; i < numberOfShots; i++){
        CGPoint point = CGPointMake(arc4random() % 11, arc4random() % 11);
        BOOL result = CGRectContainsPoint(CGRectInset(rect, +3, +3), point);
        if (result)
            NSLog(@"Died!");
        else
            NSLog(@"Miss!");
    }

    NSInteger intVar = 10;
    NSUInteger uintVar = 555;
    BOOL boolVar = YES;
    CGFloat floatVar = 5.5f;
    double doubleVar = 100;
    
    NSNumber *intObject = [NSNumber numberWithInteger:intVar];
    NSNumber *uintObject = [NSNumber numberWithUnsignedInteger:uintVar];
    NSNumber *boolObject = [NSNumber numberWithBool:boolVar];
    NSNumber *floatObject = [NSNumber numberWithFloat:floatVar];
    NSNumber *doubleObject = [NSNumber numberWithDouble:doubleVar];
    
    NSArray *numbersArray = [NSArray arrayWithObjects:intObject, uintObject, boolObject, floatObject, doubleObject, nil];
    
    NSLog(@"%ld", [[numbersArray objectAtIndex:0] integerValue]);
    NSLog(@"%ld", [[numbersArray objectAtIndex:1] unsignedIntegerValue]);
    //NSLog(@"%d", );
    
    
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
