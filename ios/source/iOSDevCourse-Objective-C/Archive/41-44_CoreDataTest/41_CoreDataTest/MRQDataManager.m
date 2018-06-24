//
//  MRQDataManager.m
//  41_CoreDataTest
//
//  Created by Oleg Tverdokhleb on 10.01.16.
//  Copyright © 2016 Oleg Tverdokhleb. All rights reserved.
//

#import "MRQDataManager.h"
#import "MRQStaticData.h"
#import "MRQStudent.h"
#import "MRQCar.h"
#import "MRQUniversity.h"
#import "MRQCourse.h"

@implementation MRQDataManager

@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

+ (MRQDataManager *) sharedManager {
    
    static MRQDataManager *manager = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        manager = [[MRQDataManager alloc] init];
        
    });
    
    return manager;
}

//MARK:SQLBase

- (MRQStudent *) addRandomStudent {
    
    MRQStudent *student = [NSEntityDescription insertNewObjectForEntityForName:@"MRQStudent"
                                                        inManagedObjectContext:self.managedObjectContext];
    
    student.firstName = firstNames[arc4random_uniform(50)];
    student.lastName = lastNames[arc4random_uniform(50)];
    student.dateOfBirth = [NSDate dateWithTimeIntervalSince1970:((arc4random_uniform(365)) * (60 * 60 * 24 * 365))];
    student.score = @(((double)(arc4random_uniform(301)) + 200) / 100);
    
    return student;
}

- (MRQCar *) addRandomCar {
    
    MRQCar *car = [NSEntityDescription insertNewObjectForEntityForName:@"MRQCar"
                                                inManagedObjectContext:self.managedObjectContext];
    
    car.model = carsModelNames[arc4random_uniform(7)];
    
    return car;
}

- (MRQCourse *) addCourseWithName:(NSString *) name {
    
    MRQCourse *course = [NSEntityDescription insertNewObjectForEntityForName:@"MRQCourse"
                                                      inManagedObjectContext:self.managedObjectContext];
    
    course.name = name;
    
    return course;
    
}

- (MRQUniversity *) addUniversity {
    
    MRQUniversity *university = [NSEntityDescription insertNewObjectForEntityForName:@"MRQUniversity"
                                                              inManagedObjectContext:self.managedObjectContext];
    
    university.name = @"MGTU";
    
    return university;
}

- (NSArray *) allObjects {
    
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSEntityDescription *description = [NSEntityDescription entityForName:@"MRQObject"
                                                   inManagedObjectContext:self.managedObjectContext];
    [request setEntity:description];
    
    NSError *requestError = nil;
    NSArray *resultArray = [self.managedObjectContext executeFetchRequest:request error:&requestError];
    if (requestError) {
        NSLog(@"%@", [requestError localizedDescription]);
    }
    
    return resultArray;
}

- (void) printAllObjects {
    
    NSArray *allObjects = [self allObjects];
    
    [self printArray:allObjects];
}

- (void) printArray:(NSArray *) array {
    
    for (id object in array) {
        //NSLog(@"%@", object);
        
        if ([object isKindOfClass:[MRQCar class]]) {
            
            MRQCar *car = (MRQCar *) object;
            NSLog(@"CAR: %@, OWNER: %@ %@", car.model, car.owner.firstName, car.owner.lastName);
            
        } else if ([object isKindOfClass:[MRQStudent class]]) {
            
            MRQStudent *student = (MRQStudent *) object;
            NSLog(@"STUDENT: %@ %@, CAR: %@, SCORE: %1.2f, COURSES: %ld", student.firstName, student.lastName, student.car.model,
                  [student.score doubleValue], [student.courses count]);
            
        } else if ([object isKindOfClass:[MRQUniversity class]]) {
            
            MRQUniversity *university = (MRQUniversity *) object;
            NSLog(@"UNIVERSITY: %@, COURSES: %ld, STUDENT: %ld", university.name, [university.courses count], [university.students count]);
            
        } else if ([object isKindOfClass:[MRQCourse class]]) {
            
            MRQCourse *course = (MRQCourse *) object;
            //            NSLog(@"---------------------------------------------");
            NSLog(@"COURSE %@, %ld students", course.name, [course.students count]);
            
            //            for (MRQStudent *student in course.students) {
            //
            //                NSLog(@"STUDENT %@ %@", student.firstName, student.lastName);
            //            }
            
            //            NSLog(@"---------------------------------------------");
        }
    }
    
    NSLog(@"COUNT %ld", [array count]);
}

- (void) deleteAllObjects {
    
    NSArray *allObjects = [self allObjects];
    
    for (id object in allObjects) {
        [self.managedObjectContext deleteObject:object];
    }
    [self.managedObjectContext save:nil];
}

- (void) generateAndAddUniversity {
    
    NSArray *courses = @[[self addCourseWithName:@"iOS"],
                         [self addCourseWithName:@"Androind"],
                         [self addCourseWithName:@"PHP"],
                         [self addCourseWithName:@"HTML"],
                         [self addCourseWithName:@"Management"]];
    
    MRQUniversity *university = [self addUniversity];
    [university addCourses:[NSSet setWithArray:courses]];
    
    for (int i = 0; i < 100; i++) {
        
        MRQStudent *student = [self addRandomStudent];
        
        student.university = university;
        
        if (arc4random_uniform(100000) < 60000) {
            MRQCar *car = [self addRandomCar];
            student.car = car;
        }
        
        NSInteger number = arc4random_uniform(4) + 1;
        
        while ([student.courses count] <= number) {
            
            MRQCourse *course = [courses objectAtIndex:arc4random_uniform(5)];
            
            if (![student.courses containsObject:course]) {
                [student addCoursesObject:course];
            }
        }
    }
    
    [self.managedObjectContext save:nil];
    
}

- (void) predicatesAndSortDescriptors {
    
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSEntityDescription *description = [NSEntityDescription entityForName:@"MRQStudent"
                                                   inManagedObjectContext:self.managedObjectContext];
    
    NSSortDescriptor *firstNameDescriptor = [[NSSortDescriptor alloc] initWithKey:@"firstName" ascending:YES];
    NSSortDescriptor *lastNameDescriptor = [[NSSortDescriptor alloc] initWithKey:@"lastName" ascending:YES];
    
    [request setEntity:description];
    //[request setFetchBatchSize:20];
    
    [request setRelationshipKeyPathsForPrefetching:@[@"courses", @"car", @"students"]];
    //[request setSortDescriptors:@[firstNameDescriptor, lastNameDescriptor]];
    
    NSArray *validNames = @[@"Nellie", @"Roma", @"Trang", @"Vernell"];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:
                              @"score >= 3.0 && score <= 3.5 &&"
                              "courses.@count >= 3 && firstName IN %@",
                              validNames];;
    
    //[request setPredicate:predicate];
    
    //    NSPredicate *testPredicate = [NSPredicate predicateWithFormat:@"@avg.students.score > 3.5"];
    //    [request setPredicate:testPredicate];
    
    //    NSPredicate *carPredicate = [NSPredicate predicateWithFormat:@"SUBQUERY(students, $student, $student.car.model == %@).@count >= %d", @"BMW", 5];
    //    [request setPredicate:carPredicate];
    
    
    NSError *error = nil;
    NSArray *resultRequest = [self.managedObjectContext executeFetchRequest:request error:&error];
    
    if (error) {
        NSLog(@"%@", [error localizedDescription]);
    }
    
    [self printArray:resultRequest];
    
}

- (void) modelFetchRequest {
    
    NSFetchRequest *request = [self.managedObjectModel fetchRequestTemplateForName:@"FetchRequest"];
    
    [request setRelationshipKeyPathsForPrefetching:@[@"courses", @"car", @"score"]];
    
    NSError *error = nil;
    NSArray *result = [self.managedObjectContext executeFetchRequest:request error:&error];
    
    
    if (error) NSLog(@"%@", [error localizedDescription]);
    
    [self printArray:result];
    
}

- (void) useMethodsFetchedProperties {

    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSEntityDescription *description = [NSEntityDescription entityForName:@"MRQCourse"
                                                   inManagedObjectContext:self.managedObjectContext];
    [request setEntity:description];
    
    NSArray *result = [self.managedObjectContext executeFetchRequest:request
                                                               error:nil];
    
    for (MRQCourse *course in result) {
        
        NSLog(@"------------------------------------");
        NSLog(@"COURSE NAME: %@", course.name);
        NSLog(@"------------------------------------");
        NSLog(@"BEST STUDENTS:");
        [self printArray:course.bestStudents];
        NSLog(@"------------------------------------");
        NSLog(@"BUZY STUDENTS");
        [self printArray:course.studentsWithManyCourses];
        NSLog(@"------------------------------------");
    }
}

- (void) deleteSQLBase {
    
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"_1_CoreDataTest.sqlite"];
    [[NSFileManager defaultManager] removeItemAtURL:storeURL error:nil];
}

- (void) reloadSQLBase {
    
    [self deleteAllObjects];
    [self deleteSQLBase];
    [self generateAndAddUniversity];
}

//- (void) countCourses {
//    
//    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
//    NSEntityDescription *description = [NSEntityDescription entityForName:@"MRQCourse"
//                                                   inManagedObjectContext:self.managedObjectContext];
//    [fetchRequest setEntity:description];
//    [fetchRequest setResultType:NSCountResultType];
//    
//    NSArray *resultRequest = [self.managedObjectContext executeFetchRequest:fetchRequest error:nil];
//    
//    for (id obj in resultRequest) {
//        NSLog(@"%@", obj);
//    }
//}

#pragma mark - Core Data stack

- (NSURL *)applicationDocumentsDirectory {
    // The directory the application uses to store the Core Data store file. This code uses a directory named "MRQResto._1_CoreDataTest" in the application's documents directory.
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

- (NSManagedObjectModel *)managedObjectModel {
    // The managed object model for the application. It is a fatal error for the application not to be able to find and load its model.
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"_1_CoreDataTest" withExtension:@"momd"];
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
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"_1_CoreDataTest.sqlite"];
    NSError *error = nil;
    NSString *failureReason = @"There was an error creating or loading the application's saved data.";
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        // Report any error we got.
        
        [[NSFileManager defaultManager] removeItemAtURL:storeURL error:nil];
        
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        dict[NSLocalizedDescriptionKey] = @"Failed to initialize the application's saved data";
        dict[NSLocalizedFailureReasonErrorKey] = failureReason;
        dict[NSUnderlyingErrorKey] = error;
        error = [NSError errorWithDomain:@"YOUR_ERROR_DOMAIN" code:9999 userInfo:dict];
        // Replace this with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
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