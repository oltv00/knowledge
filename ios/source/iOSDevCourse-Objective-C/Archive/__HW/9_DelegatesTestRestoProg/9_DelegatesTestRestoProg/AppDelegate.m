//
//  AppDelegate.m
//  9_DelegatesTestRestoProg
//
//  Created by Oleg Tverdokhleb on 20.10.15.
//  Copyright © 2015 Oleg Tverdokhleb. All rights reserved.
//

#import "AppDelegate.h"
#import "MRQPatient.h"
#import "MRQDoctor.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    MRQPatient *patient1 = [[MRQPatient alloc] init];
    MRQPatient *patient2 = [[MRQPatient alloc] init];
    MRQPatient *patient3 = [[MRQPatient alloc] init];
    MRQPatient *patient4 = [[MRQPatient alloc] init];
    MRQPatient *patient5 = [[MRQPatient alloc] init];
    
    patient1.name = @"John";
    patient1.temperature = 36.6f;
    patient1.headache = arc4random() % 2;
    patient1.chestPain = arc4random() % 2;
    
    patient2.name = @"Marry";
    patient2.temperature = 38.1f;
    patient2.headache = arc4random() % 2;
    patient2.chestPain = arc4random() % 2;

    patient3.name = @"Jessy";
    patient3.temperature = 41.2f;
    patient3.headache = arc4random() % 2;
    patient3.chestPain = arc4random() % 2;
    
    patient4.name = @"Sandra";
    patient4.temperature = 39.2f;
    patient4.headache = arc4random() % 2;
    patient4.chestPain = arc4random() % 2;
    
    patient5.name = @"Jared";
    patient5.temperature = 37.f;
    patient5.headache = arc4random() % 2;
    patient5.chestPain = arc4random() % 2;
    
    MRQDoctor *doctor = [[MRQDoctor alloc] init];
    
    patient1.delegate = doctor;
    patient2.delegate = doctor;
    patient3.delegate = doctor;
    patient4.delegate = doctor;
    patient5.delegate = doctor;

    NSArray* patientsArray = [NSArray arrayWithObjects:patient1, patient2, patient3, patient4, patient5, nil];
    
    for (MRQPatient* patients in patientsArray){
        [patients conditionWorsened];
    }
    
//    [patient1 howAreYou];
//    [patient2 howAreYou];
//    [patient3 howAreYou];
//    [patient4 howAreYou];
//    [patient5 howAreYou];
    
    
    
    
    
    
    
    
    
    
    
    
    
    
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
