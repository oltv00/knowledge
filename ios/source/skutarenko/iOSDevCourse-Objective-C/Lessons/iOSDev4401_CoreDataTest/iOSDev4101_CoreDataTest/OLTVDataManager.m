//
//  OLTVDataManager.m
//  iOSDev4101_CoreDataTest
//
//  Created by Oleg Tverdokhleb on 22.05.16.
//  Copyright © 2016 oltv00. All rights reserved.
//

#import "OLTVDataManager.h"

//model
#import "Data.h"
#import "OLTVStudent+CoreDataProperties.h"
#import "OLTVCar+CoreDataProperties.h"
#import "OLTVUniversity+CoreDataProperties.h"
#import "OLTVCourse+CoreDataProperties.h"

@implementation OLTVDataManager

+ (OLTVDataManager *)sharedManager {
  static OLTVDataManager *manager = nil;
  static dispatch_once_t token;
  dispatch_once(&token, ^{
    manager = [OLTVDataManager new];
  });
  return manager;
}

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

- (void)addStudentsWithUniversity:(OLTVUniversity *)university courses:(NSArray *)courses inAmout:(NSInteger)amout {
  for (int i = 0; i < amout; i += 1) {
    OLTVStudent *student = [self addRandomStudent];
    
    if (arc4random_uniform(1000) < 300) {
      student.car = [self addRandomCar];
    }
    student.university = university;
    
    NSInteger maxStudentCourses = 1 + arc4random_uniform((u_int32_t)[courses count]);
    if (maxStudentCourses == 5) {
      
    }
    while ([student.courses count] < maxStudentCourses) {
      OLTVCourse *course = courses[arc4random_uniform((u_int32_t)[courses count])];
      if (![student.courses containsObject:course]) {
        [student addCoursesObject:course];
      }
    }
  }
}

- (OLTVCourse *)addCourseWithName:(NSString *)name {
  OLTVCourse *course = [NSEntityDescription insertNewObjectForEntityForName:@"OLTVCourse" inManagedObjectContext:self.managedObjectContext];
  
  course.name = name;
  
  return course;
}

- (void)addUniversityWithDefaultCoursesInAmount:(NSInteger)amount {
  NSArray *courses = @[[self addCourseWithName:@"iOS"],
                       [self addCourseWithName:@"Android"],
                       [self addCourseWithName:@"PHP"],
                       [self addCourseWithName:@"Javascript"],
                       [self addCourseWithName:@"HTML+CSS"]];
  
  OLTVUniversity *university = [self addUniversity];
  [university addCourses:[NSSet setWithArray:courses]];
  
  [self addStudentsWithUniversity:university courses:courses inAmout:amount];
  [self databaseSave];
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

- (void)printArray:(NSArray *)array {
  
  for (id object in array) {
    
    if ([object isKindOfClass:[OLTVCar class]]) {
      OLTVCar *car = object;
      OLTVStudent *owner = car.owner;
      NSLog(@"CAR: %@, OWNER: %@ %@", car.model, owner.firstName, owner.lastName);
      
    } else if ([object isKindOfClass:[OLTVStudent class]]) {
      OLTVStudent *student = object;
      NSLog(@"STUDENT: %@ %@, SCORE: %1.2f, COURSES: %ld", student.firstName, student.lastName, [student.score doubleValue], [student.courses count]);
      
    } else if ([object isKindOfClass:[OLTVUniversity class]]) {
      OLTVUniversity *university = object;
      NSLog(@"UNIVERSITY: %@ Students: %ld", university.name, [university.students count]);
      
    } else if ([object isKindOfClass:[OLTVCourse class]]) {
      OLTVCourse *course = object;
      NSNumber *averageScore = [course.students valueForKeyPath:@"@avg.score"];
      NSNumber *sumScore = [course.students valueForKeyPath:@"@sum.score"];
      NSLog(@"COURSE: %@, STUDENTS: %ld, AVERAGE SCORE: %f, SUM SCORE: %f", course.name, [course.students count], [averageScore doubleValue], [sumScore doubleValue]);
    }
  }
  
  NSLog(@"COUNT: %ld", [array count]);
}

- (void)printAllObjects {
  NSArray *allObjects = [self allObjects];
  [self printArray:allObjects];
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

#pragma mark - TESTS
- (void)test7FetchProperty {
  NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"OLTVCourse"];
  
  NSError *fetchError = nil;
  NSArray *fetchResult = [self.managedObjectContext executeFetchRequest:fetchRequest error:&fetchError];
  if (fetchResult == nil) {
    NSLog(@"%@", [fetchError localizedDescription]);
    abort();
  }
  
  for (OLTVCourse *course in fetchResult) {
    NSLog(@"COU RSE NAME: %@", course.name);
    NSLog(@"BEST STUDENTS:");
    [self printArray:course.bestStudents];
    NSLog(@"BUZY STUDENTS:");
    [self printArray:course.studentsWithManyCourses];
    
    /*
     PREDICATE: score > $FETCHED_SOURCE.<attribute name>
     */
    
    /*
     *
     перегрузить fetched property на 1:11:33
     [[self managedObjectContext] refreshObject:self mergeChanges:YES];﻿
     *
     */
  }
}

- (void)test6RequestFromModel {
  //NSLog(@"%@", [self.managedObjectModel fetchRequestTemplatesByName]);
  NSFetchRequest *fetchRequest = [self.managedObjectModel fetchRequestTemplateForName:@"FetchStudents"];
  [fetchRequest setRelationshipKeyPathsForPrefetching:@[@"courses"]];
  
  NSSortDescriptor *firstNameDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"firstName" ascending:YES];
  NSSortDescriptor *lastNameDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"lastName" ascending:YES];
  [fetchRequest setSortDescriptors:@[firstNameDescriptor, lastNameDescriptor]];
  
  NSError *fetchError = nil;
  NSArray *fetchResult = [self.managedObjectContext executeFetchRequest:fetchRequest error:&fetchError];
  if (fetchResult == nil) {
    NSLog(@"%@", [fetchError localizedDescription]);
    abort();
  }
  
  [self printArray:fetchResult];
}

- (void)test5SubQuery {
  NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"OLTVCourse"];
  [fetchRequest setRelationshipKeyPathsForPrefetching:@[@"students.car"]];
  
  //for student in students -> if student.car.name == BMW
  //SUBQUERY return the array, get count >= 25
  NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SUBQUERY(students, $student, $student.car.model == %@).@count >= 25", @"BMW"];
  [fetchRequest setPredicate:predicate];
  
  NSError *fetchError = nil;
  NSArray *array = [self.managedObjectContext executeFetchRequest:fetchRequest error:&fetchError];
  if (fetchError) {
    NSLog(@"%@", [fetchError localizedDescription]);
    abort();
  }
  
  [self printArray:array];
}

- (void)test4Predicate {
  NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"OLTVCourse"];
  [request setRelationshipKeyPathsForPrefetching:@[@"students"]];
  
  NSPredicate *predicate = [NSPredicate predicateWithFormat:@"students.@avg.score > 3.01"];
  [request setPredicate:predicate];
  
  NSError *fetchError = nil;
  NSArray *array = [self.managedObjectContext executeFetchRequest:request error:&fetchError];
  if (fetchError) {
    NSLog(@"%@", [fetchError localizedDescription]);
    abort();
  }
  
  [self printArray:array];
}

- (void)test3 {
  NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"OLTVStudent"];
  
  //дополнительно считывает в общей таблице БД entity courses в OLTVStudent
  [request setRelationshipKeyPathsForPrefetching:@[@"courses"]];
  
  //Sort descriptors
  NSSortDescriptor *firstNameDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"firstName" ascending:YES];
  NSSortDescriptor *lastNameDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"lastName" ascending:YES];
  [request setSortDescriptors:@[firstNameDescriptor, lastNameDescriptor]];
  
  NSArray *validNames = @[@"Floyd", @"Monte", @"Tran"];
  
  //Predicate, разные способы записи
  //NSPredicate *predicate = [NSPredicate predicateWithFormat:@"score > 3.0"];
  //NSPredicate *predicate = [NSPredicate predicateWithFormat:@"score > %f", 3.0];
  //NSPredicate *predicate = [NSPredicate predicateWithFormat:@"score > %f AND score <= 3.2", 3.0];
  NSPredicate *predicate = [NSPredicate predicateWithFormat:
                            @"score > 3.0 AND score <= 3.2"
                            "AND courses.@count == 5"
                            "AND firstName IN %@", validNames];
  
  [request setPredicate:predicate];
  
  NSError *fetchError = nil;
  NSArray *students = [self.managedObjectContext executeFetchRequest:request error:&fetchError];
  if (fetchError) {
    NSLog(@"%@", [fetchError localizedDescription]);
    abort();
  }
  
  [self printArray:students];
}

- (void)test2 {
  NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"OLTVStudent"];
  
  //лимит одной загрузки
  [request setFetchBatchSize:20];
  
  //лимит загрузки всего запроса
  [request setFetchLimit:30];
  
  //с какого элемента таблицы делать запрос
  [request setFetchOffset:45];
  
  NSArray *students = [self.managedObjectContext executeFetchRequest:request error:nil];
  [self printArray:students];
}

- (void)test1DeleteAndCreate {
  [self deleteAllObjects];
  
  [self printAllObjects];
}

@end
