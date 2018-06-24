//
//  AppDelegate.m
//  iOSDev4101_CoreDataTest
//
//  Created by Oleg Tverdokhleb on 20.05.16.
//  Copyright © 2016 oltv00. All rights reserved.
//

#import "AppDelegate.h"

//model
#import "Data.h"
#import "OLTVStudent+CoreDataProperties.h"
#import "OLTVCar+CoreDataProperties.h"
#import "OLTVUniversity+CoreDataProperties.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

#pragma mark - Additional Core Data

- (void)addManagedObject {
  //object create
  NSManagedObject *student = [NSEntityDescription insertNewObjectForEntityForName:@"OLTVStudent" inManagedObjectContext:self.managedObjectContext];
  
  //object settings
  [student setValue:@"DEFAULT" forKey:@"firstName"];
  [student setValue:@"DEFAULT" forKey:@"lastName"];
  [student setValue:[NSDate dateWithTimeIntervalSince1970:0] forKey:@"dateOfBirth"];
  [student setValue:@0.f forKey:@"score"];
}

- (OLTVStudent *)addRandomStudent {
  OLTVStudent *student = [NSEntityDescription insertNewObjectForEntityForName:@"OLTVStudent" inManagedObjectContext:self.managedObjectContext];
  student.firstName = firstNames[arc4random_uniform(50)];
  student.lastName = lastNames[arc4random_uniform(50)];
  student.dateOfBirth = [NSDate dateWithTimeIntervalSince1970:arc4random_uniform(1577880000)];
  student.score = @(2 + ((double)arc4random_uniform(200000)) / 100000);
  return student;
}

- (OLTVCar *)addRandomCar {
  OLTVCar *car = [NSEntityDescription insertNewObjectForEntityForName:@"OLTVCar" inManagedObjectContext:self.managedObjectContext];
  car.model = carsModelNames[arc4random_uniform(7)];
  return car;
}

- (void)addStudentsInAmount:(NSInteger)amount {
  for (int i = 0; i < amount; i += 1) {
    [self addRandomStudent];
  }
}

- (void)addRandomStudentWithRandomCar {
  OLTVStudent *student = [self addRandomStudent];
  OLTVCar *car = [self addRandomCar];
  student.car = car;
}

- (OLTVUniversity *)addUniversity {
  OLTVUniversity *university = [NSEntityDescription insertNewObjectForEntityForName:@"OLTVUniversity" inManagedObjectContext:self.managedObjectContext];
  
  university.name = @"MGU";
  
  return university;
}

- (void)addStudentsWithUniversity:(OLTVUniversity *)university inAmout:(NSInteger)amout {
  for (int i = 0; i < amout; i += 1) {
    OLTVStudent *student = [self addRandomStudent];
    
    if (arc4random_uniform(1000) < 300) {
      student.car = [self addRandomCar];
    }
    
    //[university addStudentsObject:student];
    student.university = university;
  }
}

- (void)databaseRemove {
  NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"iOSDev4101_CoreDataTest.sqlite"];
  [[NSFileManager defaultManager] removeItemAtURL:storeURL error:nil];
}

- (void)databaseSave {
  NSError *error = nil;
  if (![self.managedObjectContext save:&error]) {
    NSLog(@"%@", [error localizedDescription]);
  }
}

- (NSArray *)allObjects {
  //fetch create
  NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"OLTVObject"];
  
  //fetch execute
  NSError *fetchError = nil;
  NSArray *allObjects = [self.managedObjectContext executeFetchRequest:fetchRequest error:&fetchError];
  if (fetchError) {
    NSLog(@"%@", [fetchError localizedDescription]);
  }
  return allObjects;
}

- (void)printAllObjects {
  NSArray *allObjects = [self allObjects];
  
  for (id object in allObjects) {
    
    if ([object isKindOfClass:[OLTVCar class]]) {
      OLTVCar *car = object;
      OLTVStudent *owner = car.owner;
      NSLog(@"CAR: %@, OWNER: %@ %@", car.model, owner.firstName, owner.lastName);
      
    } else if ([object isKindOfClass:[OLTVStudent class]]) {
      OLTVStudent *student = object;
      OLTVCar *car = student.car;
      NSLog(@"STUDENT: %@ %@, CAR: %@, UNIVERSITY: %@", student.firstName, student.lastName, car.model, student.university.name);
    
    } else if ([object isKindOfClass:[OLTVUniversity class]]) {
      OLTVUniversity *university = object;
      NSLog(@"UNIVERSITY: %@ Students: %ld", university.name, [university.students count]);
    }
  }
}

- (void)deleteAllObjects {
  NSArray *allObjects = [self allObjects];
  for (id object in allObjects) {
    [self.managedObjectContext deleteObject:object];
  }
}

- (void)deleteRandomStudent {
  NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"OLTVStudent"];
  NSError *error = nil;
  NSArray *students = [self.managedObjectContext executeFetchRequest:request error:&error];
  if (error) {
    NSLog(@"%@", [error localizedDescription]);
  }
  if ([students count] > 0) {
    OLTVStudent *student = [students firstObject];
    [self.managedObjectContext deleteObject:student];
  }
}

- (void)deleteRandomCar {
  NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"OLTVCar"];
  NSError *error = nil;
  NSArray *cars = [self.managedObjectContext executeFetchRequest:request error:&error];
  if (error) {
    NSLog(@"%@", [error localizedDescription]);
  }
  if ([cars count] > 0) {
    OLTVCar *car = [cars firstObject];
    [self.managedObjectContext deleteObject:car];
  }
}

- (void)deleteUniversity {
  NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"OLTVUniversity"];
  NSError *error = nil;
  NSArray *objects = [self.managedObjectContext executeFetchRequest:request error:&error];
  if (error) {
    NSLog(@"%@", [error localizedDescription]);
  }
  OLTVUniversity *university = [objects firstObject];
  [self.managedObjectContext deleteObject:university];
}

#pragma mark - AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
  // Override point for customization after application launch.
  [self deleteAllObjects];
  
  OLTVUniversity *university = [self addUniversity];
  [self addStudentsWithUniversity:university inAmout:50];
  [self databaseSave];
  [self printAllObjects];
  
  
  
  [self deleteUniversity];
  [self databaseSave];
  [self printAllObjects];
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
  // Saves changes in the application's managed object context before the application terminates.
  [self saveContext];
}

#pragma mark - Core Data stack

@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

- (NSURL *)applicationDocumentsDirectory {
    // The directory the application uses to store the Core Data store file. This code uses a directory named "com.oltv00.iOSDev4101_CoreDataTest" in the application's documents directory.
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

- (NSManagedObjectModel *)managedObjectModel {
    // The managed object model for the application. It is a fatal error for the application not to be able to find and load its model.
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"iOSDev4101_CoreDataTest" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
    // The persistent store coordinator for the application. This implementation creates and returns a coordinator, having added the store for the application to it.
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    // Create the coordinator and store
    
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"iOSDev4101_CoreDataTest.sqlite"];
    NSError *error = nil;
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
      [[NSFileManager defaultManager] removeItemAtURL:storeURL error:nil];
      [_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error];
    }
    
    return _persistentStoreCoordinator;
}


- (NSManagedObjectContext *)managedObjectContext {
    // Returns the managed object context for the application (which is already bound to the persistent store coordinator for the application.)
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (!coordinator) {
        return nil;
    }
    _managedObjectContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
    [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    return _managedObjectContext;
}

#pragma mark - Core Data Saving support

- (void)saveContext {
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        NSError *error = nil;
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
}

@end
