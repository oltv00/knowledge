//
//  OLTVCoreDataManager.m
//  iOSDev4401_CoreDataHW
//
//  Created by Oleg Tverdokhleb on 22.05.16.
//  Copyright © 2016 oltv00. All rights reserved.
//

//model
#import "Entities/OLTVStudent+CoreDataProperties.h"
#import "Entities/OLTVCourse+CoreDataProperties.h"
#import "Entities/OLTVTeacher+CoreDataProperties.h"
#import "Data.h"

#import "OLTVCoreDataManager.h"

@implementation OLTVCoreDataManager

+ (OLTVCoreDataManager *)sharedManager {
  static OLTVCoreDataManager *manager = nil;
  static dispatch_once_t token;
  dispatch_once(&token, ^{
    manager = [[OLTVCoreDataManager alloc] init];
  });
  return manager;
}

#pragma mark - Core Data

- (NSArray *)allStudents {
  return [self fetchRequestWithEntityName:@"OLTVStudent"];
}

- (NSArray *)allTeachers {
  return [self fetchRequestWithEntityName:@"OLTVTeacher"];
}

- (NSArray *)allCourses {
  return [self fetchRequestWithEntityName:@"OLTVCourse"];
}

- (NSArray *)allObjects {
  return [self fetchRequestWithEntityName:@"OLTVObject"];
}

- (NSArray *)fetchRequestWithEntityName:(NSString *)entityName {
  NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:entityName];
  
  NSError *fetchError = nil;
  NSArray *objects = [self.managedObjectContext executeFetchRequest:fetchRequest error:&fetchError];
  if (fetchError) {
    NSLog(@"fetchRequestWithEntityName fetchError = %@ %@", [fetchError localizedDescription], [fetchError userInfo]);
    abort();
  }
  return objects;
}

- (NSArray *)allTeachersSortedBySubjects {
  NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"OLTVTeacher"];
  
  NSError *fetchError = nil;
  NSArray *teachers = [self.managedObjectContext executeFetchRequest:fetchRequest error:&fetchError];
  if (fetchError) {
    NSLog(@"fetchRequestWithEntityName fetchError = %@ %@", [fetchError localizedDescription], [fetchError userInfo]);
    abort();
  }
  return teachers;
}

- (void)saveAllObjects {
  NSError *error = nil;
  [self.managedObjectContext save:&error];
  if (error) {
    NSLog(@"CoreData save error = %@ %@", [error localizedDescription], [error userInfo]);
    abort();
  }
}

- (void)deleteAllObjects {
  NSArray *allObjects = [self allObjects];
  for (id object in allObjects) {
    [self.managedObjectContext deleteObject:object];
  }
}

- (OLTVStudent *)addStudentWithFirstName:(NSString *)firstName
                                lastName:(NSString *)lastName
                                   email:(NSString *)email
{
  OLTVStudent *student = [NSEntityDescription insertNewObjectForEntityForName:@"OLTVStudent" inManagedObjectContext:self.managedObjectContext];
  student.firstName = firstName;
  student.lastName = lastName;
  student.email = email;
  return student;
}

- (OLTVTeacher *)addTeacherWithFirstName:(NSString *)firstName
                                lastName:(NSString *)lastName
                                   email:(NSString *)email
{
  OLTVTeacher *teacher = [NSEntityDescription insertNewObjectForEntityForName:@"OLTVTeacher" inManagedObjectContext:self.managedObjectContext];
  teacher.firstName = firstName;
  teacher.lastName = lastName;
  teacher.email = email;
  return teacher;
}

- (OLTVCourse *)addCourseWithName:(NSString *)name
                          subject:(NSString *)subject
                           branch:(NSString *)branch
                          teacher:(OLTVTeacher *)teacher
{
  OLTVCourse *course = [NSEntityDescription insertNewObjectForEntityForName:@"OLTVCourse" inManagedObjectContext:self.managedObjectContext];
  course.name = name;
  course.subject = subject;
  course.branch = branch;
  //TODO:Add teacher to course
  course.teacher = nil;
  return course;
}

- (void)addDefaultStudents:(NSInteger)students teachers:(NSInteger)teachers {
  for (int i = 0; i < students; i += 1) {
    
    NSString *firstName = firstNames[arc4random_uniform(50)];
    NSString *lastName = lastNames[arc4random_uniform(50)];
    NSString *email = [NSString stringWithFormat:@"%@%@@students-gmail.com", firstName, lastName];
    
    [self addStudentWithFirstName:firstName lastName:lastName email:email];
  }
  
  for (int i = 0; i < teachers; i += 1) {
    
    NSString *firstName = firstNames[arc4random_uniform(50)];
    NSString *lastName = lastNames[arc4random_uniform(50)];
    NSString *email = [NSString stringWithFormat:@"%@%@@teachers-gmail.com", firstName, lastName];
    
    [self addTeacherWithFirstName:firstName lastName:lastName email:email];
  }
  
  [self addCourseWithName:@"iOS" subject:@"Programming" branch:@"Development" teacher:nil];
  [self addCourseWithName:@"Android" subject:@"Programming" branch:@"Development" teacher:nil];
  [self addCourseWithName:@"PHP" subject:@"Programming" branch:@"Development" teacher:nil];
  [self addCourseWithName:@"Javascript" subject:@"Programming" branch:@"Development" teacher:nil];
  [self addCourseWithName:@"Python" subject:@"Programming" branch:@"Development" teacher:nil];
  
  [self addCourseWithName:@"Running" subject:@"Sport" branch:@"Health" teacher:nil];
  [self addCourseWithName:@"Workout" subject:@"Sport" branch:@"Health" teacher:nil];
  
  [self addCourseWithName:@"English" subject:@"Languange" branch:@"Communication" teacher:nil];
  [self addCourseWithName:@"Russian" subject:@"Languange" branch:@"Communication" teacher:nil];
  [self addCourseWithName:@"German" subject:@"Languange" branch:@"Communication" teacher:nil];
}

#pragma mark - Core Data stack

@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

- (NSURL *)applicationDocumentsDirectory {
  // The directory the application uses to store the Core Data store file. This code uses a directory named "com.oltv00.iOSDev4401_CoreDataHW" in the application's documents directory.
  return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

- (NSManagedObjectModel *)managedObjectModel {
  // The managed object model for the application. It is a fatal error for the application not to be able to find and load its model.
  if (_managedObjectModel != nil) {
    return _managedObjectModel;
  }
  NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"iOSDev4401_CoreDataHW" withExtension:@"momd"];
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
  NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"iOSDev4401_CoreDataHW.sqlite"];
  NSError *error = nil;
  NSString *failureReason = @"There was an error creating or loading the application's saved data.";
  if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
    // Report any error we got.
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    dict[NSLocalizedDescriptionKey] = @"Failed to initialize the application's saved data";
    dict[NSLocalizedFailureReasonErrorKey] = failureReason;
    dict[NSUnderlyingErrorKey] = error;
    error = [NSError errorWithDomain:@"YOUR_ERROR_DOMAIN" code:9999 userInfo:dict];
    // Replace this with code to handle the error appropriately.
    // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
    NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
    
    [[NSFileManager defaultManager] removeItemAtURL:storeURL error:nil];
    [_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error];
    
    abort();
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
