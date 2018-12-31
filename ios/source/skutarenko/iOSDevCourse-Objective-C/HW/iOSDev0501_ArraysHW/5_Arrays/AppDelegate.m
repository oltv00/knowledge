//
//  AppDelegate.m
//  5_Arrays
//
//  Created by Oleg Tverdokhleb on 29.03.16.
//  Copyright © 2016 Oleg Tverdokhleb. All rights reserved.
//

#import "AppDelegate.h"

#import "OTPerson.h"
#import "OTCyclist.h"
#import "OTRunner.h"
#import "OTSwimmer.h"
#import "OTAddition.h"

#import "OTAnimal.h"
#import "OTCat.h"
#import "OTDog.h"
#import "OTMonkey.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    //[self levelNoob];
    //[self levelStudent];
    //[self levelMaster];
    //[self levelStar];
    [self levelSuperman];
    
    return YES;
}

#pragma mark - Levels

- (void)levelSuperman {

    NSMutableArray *array = [NSMutableArray array];
    
    //Initial
    for (int i = 0; i < 10; i++) {
        OTCyclist *cyclist = [[OTCyclist alloc] initWithName:@"Cyclist" Index:i];
        OTRunner *runner = [[OTRunner alloc] initWithName:@"Runner" Index:i];
        OTSwimmer *swimmer = [[OTSwimmer alloc] initWithName:@"Swimmer" Index:i];
        OTAddition *addition = [[OTAddition alloc] initWithName:@"Addition" Index:i];
        
        OTCat *cat = [[OTCat alloc] initWithName:@"Cat" Index:i];
        OTDog *dog = [[OTDog alloc] initWithName:@"Dog" Index:i];
        OTMonkey *monkey = [[OTMonkey alloc] initWithName:@"Monkey" Index:i];
        
        [array addObject:cyclist];
        [array addObject:runner];
        [array addObject:swimmer];
        [array addObject:addition];
        [array addObject:cat];
        [array addObject:dog];
        [array addObject:monkey];
    }
    
    //Sorting
    NSArray *sortedArray = [array sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        if ([obj1 isKindOfClass:[OTPerson class]] && [obj2 isKindOfClass:[OTPerson class]]) {
            return [[(OTPerson *)obj1 name] compare:[(OTPerson *)obj2 name]];
        } else if ([obj1 isKindOfClass:[OTAnimal class]] && [obj2 isKindOfClass:[OTAnimal class]]){
            return [[(OTAnimal *)obj1 breed] compare:[(OTAnimal *)obj2 breed]];
        } else if ([obj1 isKindOfClass:[OTPerson class]]) {
            return NSOrderedAscending;
        } else {
            return NSOrderedDescending;
        }
    }];
    
    //Out
    for (id obj in sortedArray) {
        if ([obj isKindOfClass:[OTPerson class]]) {
            [self aboutHumans:obj];
        } else {
            [self aboutAnimals:obj];
        }
    }
}

- (void)levelStar {
    OTCyclist *cyclist = [[OTCyclist alloc] init];
    OTRunner *runner = [[OTRunner alloc] init];
    OTSwimmer *swimmer = [[OTSwimmer alloc] init];
    OTAddition *addition = [[OTAddition alloc] init];
    
    OTCat *cat = [[OTCat alloc] init];
    OTDog *dog = [[OTDog alloc] init];
    OTMonkey *monkey = [[OTMonkey alloc] init];
    
    NSArray *humansArray = @[cyclist, runner, swimmer, addition];
    NSArray *animalsArray = @[cat, dog, monkey];
    
    int humans = (int)humansArray.count;
    int animals = (int)animalsArray.count;
    int max = humans > animals ? humans : animals;
    
    for (int i = 0; i < max; i++) {
        NSLog(@"----CYCLE-LAP---------");
        if (i < humansArray.count) {
            OTPerson *person = [humansArray objectAtIndex:i];
            [self aboutHumans:person];
        }
        if (i < animalsArray.count) {
            OTAnimal *animal = [animalsArray objectAtIndex:i];
            [self aboutAnimals:animal];
        }
    }
}

- (void)levelMaster {
    OTCyclist *cyclist = [[OTCyclist alloc] init];
    OTRunner *runner = [[OTRunner alloc] init];
    OTSwimmer *swimmer = [[OTSwimmer alloc] init];
    OTAddition *addition = [[OTAddition alloc] init];
    
    OTCat *cat = [[OTCat alloc] init];
    OTDog *dog = [[OTDog alloc] init];
    OTMonkey *monkey = [[OTMonkey alloc] init];
    
    NSArray *array = @[cyclist, runner, swimmer, addition, cat, dog, monkey];
    
    for (id obj in array) {
        NSLog(@"--------------------------------------");
        if ([obj isKindOfClass:[OTPerson class]]) {
            //for humans
            OTPerson *person = (OTPerson *)obj;
            NSLog(@"I'am is %@", person);
            NSLog(@"Name = %@", person.name);
            NSLog(@"Height = %.2f", person.height);
            NSLog(@"Weight = %.2f", person.weight);
            [person genderCall];
            [self humanAdditionCall:person];
            [person move];
        } else {
            //for animals
            OTAnimal *animal = (OTAnimal *)obj;
            NSLog(@"I'am is %@", animal);
            NSLog(@"Breed = %@", animal.breed);
            NSLog(@"Height = %.2f", animal.height);
            NSLog(@"Weight = %.2f", animal.weight);
            [animal move];
        }
    }
}

- (void)levelStudent {
    OTCyclist *cyclist = [[OTCyclist alloc] init];
    OTRunner *runner = [[OTRunner alloc] init];
    OTSwimmer *swimmer = [[OTSwimmer alloc] init];
    OTAddition *addition = [[OTAddition alloc] init];
    
    NSArray *array = @[cyclist, runner, swimmer, addition];
    
    for (OTPerson *pers in array) {
        NSLog(@"Name = %@", pers.name);
        NSLog(@"Height = %f", pers.height);
        NSLog(@"Weight = %f", pers.weight);
        
        [pers genderCall];
        [self humanAdditionCall:pers];
        
        [pers move];
    }
}

- (void)levelNoob {
    OTCyclist *cyclist = [[OTCyclist alloc] init];
    OTRunner *runner = [[OTRunner alloc] init];
    OTSwimmer *swimmer = [[OTSwimmer alloc] init];
    
    NSArray *array = @[cyclist, runner, swimmer];
    
    for (OTPerson *pers in array) {
        NSLog(@"Name = %@", pers.name);
        NSLog(@"Height = %f", pers.height);
        NSLog(@"Weight = %f", pers.weight);
        [pers genderCall];
        [pers move];
    }
}

#pragma mark - Additional methods

- (void)humanAdditionCall:(OTPerson *) pers {
    if ([pers isKindOfClass:[OTAddition class]]) {
        OTAddition *add = (OTAddition *)pers;
        [add aboutAddition];
    }
}

- (void)aboutHumans:(OTPerson *) obj {
    NSLog(@"----------------HUMANS-LAP----------------");
    OTPerson *person = (OTPerson *)obj;
    NSLog(@"I'am is %@", person);
    NSLog(@"Name = %@", person.name);
    NSLog(@"Height = %.2f", person.height);
    NSLog(@"Weight = %.2f", person.weight);
    [person genderCall];
    [self humanAdditionCall:person];
    [person move];
}

- (void)aboutAnimals:(OTAnimal *) obj {
    NSLog(@"----------------ANIMALS-LAP----------------");
    OTAnimal *animal = (OTAnimal *)obj;
    NSLog(@"I'am is %@", animal);
    NSLog(@"Breed = %@", animal.breed);
    NSLog(@"Height = %.2f", animal.height);
    NSLog(@"Weight = %.2f", animal.weight);
    [animal move];
}

#pragma mark - ___UNUSED___

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
