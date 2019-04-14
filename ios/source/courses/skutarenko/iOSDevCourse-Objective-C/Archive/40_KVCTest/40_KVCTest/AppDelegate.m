//
//  AppDelegate.m
//  40_KVCTest
//
//  Created by Oleg Tverdokhleb on 26.12.15.
//  Copyright © 2015 Oleg Tverdokhleb. All rights reserved.
//

#import "AppDelegate.h"
#import "Student.h"
#import "Group.h"

@interface AppDelegate ()

@property (strong, nonatomic) Student *student;
@property (strong, nonatomic) NSArray *groups;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    /*
    Student *student = [[Student alloc] init];
    self.student = student;
    
    [student addObserver:self
              forKeyPath:@"name"
                 options: NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld
                 context:nil];

    [student addObserver:self
              forKeyPath:@"age"
                 options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld
                 context:nil];
    
    student.name = @"StdName";
    student.age = 20;
    
    NSLog(@"%@", student);
    
    [student setValue:@"ValueStdName" forKey:@"name"];
    [student setValue:@25 forKey:@"age"];
    
    NSLog(@"%@", student);
    
    //UNDEFINED
    [student setValue:@"value" forKey:@"key"];
    NSLog(@"%@", [student valueForKey:@"key"]);
    
    [student changeNameProperty];
    NSLog(@"%@", student);
    
    [student changeNameWithIvar];
    NSLog(@"%@", student);
     */
    
    /*
    Student *student1 = [[Student alloc] init];
    student1.name = @"Alex";
    student1.age = 20;
    
    Student *student2 = [[Student alloc] init];
    student2.name = @"Roger";
    student2.age = 25;
    
    Student *student3 = [[Student alloc] init];
    student3.name = @"John";
    student3.age = 27;

    Student *student4 = [[Student alloc] init];
    student4.name = @"Jack";
    student4.age = 30;

    Group *group1 = [[Group alloc] init];
    group1.students = @[student1, student2, student3, student4];
    NSLog(@"%@", group1.students);
    
    NSMutableArray *tempArray = [group1 mutableArrayValueForKey:@"students"];
    [tempArray removeLastObject];
    NSLog(@"%@", group1.students);
    
    [[group1 mutableArrayValueForKey:@"students"] removeLastObject];
    NSLog(@"%@", group1.students);
    */
    
    /*
    Student *student1 = [[Student alloc] init];
    student1.name = @"Alex";
    student1.age = 20;
    
    Student *student2 = [[Student alloc] init];
    student2.name = @"Roger";
    student2.age = 25;
    
    Student *student3 = [[Student alloc] init];
    student3.name = @"John";
    student3.age = 27;
    
    Student *student4 = [[Student alloc] init];
    student4.name = @"Jack";
    student4.age = 30;
    
    Group *group1 = [[Group alloc] init];
    group1.students = @[student1, student2, student3, student4];
    
    self.student = student1;
    NSLog(@"%@", [self valueForKeyPath:@"student.name"]);
    
    NSString *name = @"Alex1";
    NSError *error = nil;
    if (![self.student validateValue:&name forKey:@"name" error:&error]) {
        NSLog(@"%@", error);
    }
    */
    
    Student *student1 = [[Student alloc] init];
    student1.name = @"Alex";
    student1.age = 20;
    
    Student *student2 = [[Student alloc] init];
    student2.name = @"Roger";
    student2.age = 25;
    
    Student *student3 = [[Student alloc] init];
    student3.name = @"John";
    student3.age = 27;
    
    Student *student4 = [[Student alloc] init];
    student4.name = @"Jack";
    student4.age = 30;
    
    Student *student5 = [[Student alloc] init];
    student5.name = @"Sasha";
    student5.age = 21;
    
    Student *student6 = [[Student alloc] init];
    student6.name = @"Mike";
    student6.age = 18;
    
    Student *student7 = [[Student alloc] init];
    student7.name = @"Oleg";
    student7.age = 24;
    
    Student *student8 = [[Student alloc] init];
    student8.name = @"Michel";
    student8.age = 26;
    
    Group *group1 = [[Group alloc] init];
    group1.students = @[student1, student2, student3, student4];
    
    Group *group2 = [[Group alloc] init];
    group2.students = @[student5, student6, student7, student8];
    
    self.groups = @[group1, group2];
    
    NSArray *allStudents = [self.groups valueForKeyPath:@"@distinctUnionOfArrays.students"];
    NSLog(@"allStudents: %@", allStudents);
    
    NSArray *allNames = [allStudents valueForKeyPath:@"@distinctUnionOfObjects.name"];
    NSLog(@"allNames: %@", allNames);

    NSNumber* minAge = [allStudents valueForKeyPath:@"@min.age"];
    NSNumber* maxAge = [allStudents valueForKeyPath:@"@max.age"];
    NSNumber* sumAge = [allStudents valueForKeyPath:@"@sum.age"];
    NSNumber* avgAge = [allStudents valueForKeyPath:@"@avg.age"];
    
    NSLog(@"minAge = %@", minAge);
    NSLog(@"maxAge = %@", maxAge);
    NSLog(@"sumAge = %@", sumAge);
    NSLog(@"avgAge = %@", avgAge);
    
    return YES;
}

- (void) dealloc {
    
    [self.student removeObserver:self forKeyPath:@"name"];
    [self.student removeObserver:self forKeyPath:@"age"];
}

#pragma mark - Observing

- (void)observeValueForKeyPath:(nullable NSString *)keyPath
                      ofObject:(nullable id)object
                        change:(nullable NSDictionary<NSString*, id> *)change
                       context:(nullable void *)context {
    
    NSLog(@"\nobserveValueForKeyPath: %@\nofObject: %@\nchange: %@", keyPath, object, change);
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
