//
//  AppDelegate.m
//  5_ArraysTestRestoProg
//
//  Created by Oleg Tverdokhleb on 01.11.15.
//  Copyright © 2015 Oleg Tverdokhleb. All rights reserved.
//

#import "AppDelegate.h"

#import "MRQHuman.h"
#import "MRQCyclist.h"
#import "MRQRunner.h"
#import "MRQSwimmer.h"
#import "MRQJumper.h"

#import "MRQAnimal.h"
#import "MRQDogs.h"
#import "MRQCats.h"
#import "MRQParrots.h"

@interface AppDelegate ()

@end

@class MRQHuman;

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    
    MRQCyclist *cyclist = [[MRQCyclist alloc] init];
    MRQRunner *runner = [[MRQRunner alloc] init];
    MRQSwimmer *swimmer = [[MRQSwimmer alloc] init];
    MRQJumper *jumper = [[MRQJumper alloc] init];
    
    MRQDogs *dog = [[MRQDogs alloc] init];
    MRQCats *cat = [[MRQCats alloc] init];
    MRQParrots *parrot = [[MRQParrots alloc] init];
    
    NSArray *humansArray = [NSArray arrayWithObjects:jumper, cyclist, runner, swimmer,  nil];
    NSArray *animalsArray = [NSArray arrayWithObjects:dog, parrot, cat, nil];
    
    NSMutableArray *animalsAndHumansArray = [NSMutableArray arrayWithObjects:cyclist, dog, runner, cat, swimmer, parrot, jumper, nil];
    
    //SUPERMAN
    NSArray *sortedArray = [animalsAndHumansArray sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        
        if ([obj1 isKindOfClass:[MRQHuman class]] && [obj2 isKindOfClass:[MRQHuman class]]) {
            return [[(MRQHuman*)obj1 name] compare:[(MRQHuman*)obj2 name]];
            
        } else if ([obj1 isKindOfClass:[MRQAnimal class]] && [obj2 isKindOfClass:[MRQAnimal class]]) {
            return [[(MRQAnimal*)obj1 name] compare:[(MRQAnimal*)obj2 name]];
            
        } else if ([obj1 isKindOfClass:[MRQHuman class]]) {
            return NSOrderedAscending;
            
        } else {
            return NSOrderedDescending;
        }
    }];
    
    for (id object in sortedArray) {
        if ([object isKindOfClass:[MRQHuman class]]) {
            [object conclusion];
        } else if ([object isKindOfClass:[MRQAnimal class]]){
            [object conclusion];
        }
    }
    
    //STAR
    for (NSInteger i = 0; i < [humansArray count] || i < [animalsArray count]; i++) {
        if (i < [humansArray count]) {
            [self isKindOfClass:[humansArray objectAtIndex:i] inClass:[MRQHuman class]];
        }
        if (i < [animalsArray count]) {
            [self isKindOfClass:[animalsArray objectAtIndex:i] inClass:[MRQAnimal class]];
        }
    }
    return YES;
}

- (void) isKindOfClass:(id) object inClass:(Class) classObject {
    
    if ([object isKindOfClass:[classObject class]]) {
        //[object conclusion];
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
