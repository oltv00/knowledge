//
//  AppDelegate.m
//  7_ProtocolsTest
//
//  Created by Oleg Tverdokhleb on 11.10.15.
//  Copyright © 2015 Oleg Tverdokhleb. All rights reserved.
//

#import "AppDelegate.h"
#import "MRQPatient.h"
#import "MRQStudent.h"
#import "MRQDancer.h"
#import "MRQDeveloper.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    MRQDancer *dancer1 = [[MRQDancer alloc] init];
    MRQDancer *dancer2 = [[MRQDancer alloc] init];
    
    MRQStudent *student1 = [[MRQStudent alloc] init];
    MRQStudent *student2 = [[MRQStudent alloc] init];
    MRQStudent *student3 = [[MRQStudent alloc] init];
    
    MRQDeveloper *developer1 = [[MRQDeveloper alloc] init];
    
    dancer1.name = @"dancer 1";
    dancer2.name = @"dancer 2";
    
    student1.name = @"student 1";
    student2.name = @"student 2";
    student3.name = @"student 3";
    
    developer1.name = @"developer 1";
    
    NSObject *fake = [[NSObject alloc] init];
    
    NSArray *patients = [NSArray arrayWithObjects:dancer1, student1, developer1, fake, student2, student3, dancer2,nil];

    
    for (id <MRQPatient> patient in patients) {
        
        if ([patient conformsToProtocol:@protocol(MRQPatient)]) {
            NSLog(@"Patient name = %@", patient.name);
            
            if ([patient respondsToSelector:@selector(howIsYourFamily)]) {
                NSLog(@"How is your family %@?\n%@", patient.name, [patient howIsYourFamily]);
            }
            
            if ([patient respondsToSelector:@selector(howIsYourJob)]) {
                NSLog(@"How is your job %@?\n%@", patient.name, [patient howIsYourJob]);
            }
            
            if (![patient areYouOK]) {
                
                [patient takePill];
                
                if (![patient areYouOK]) {
                    [patient makeShot];
                }
            }
        } else
            NSLog(@"FAKE!!!");
        
    
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
