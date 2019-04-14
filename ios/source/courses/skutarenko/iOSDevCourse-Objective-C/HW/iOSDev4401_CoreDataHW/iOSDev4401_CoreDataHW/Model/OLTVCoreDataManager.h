//
//  OLTVCoreDataManager.h
//  iOSDev4401_CoreDataHW
//
//  Created by Oleg Tverdokhleb on 22.05.16.
//  Copyright © 2016 oltv00. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class OLTVStudent;
@class OLTVCourse;
@class OLTVTeacher;

@interface OLTVCoreDataManager : NSObject

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

+ (OLTVCoreDataManager *)sharedManager;

- (void)saveAllObjects;
- (void)deleteAllObjects;

- (NSArray *)allStudents;
- (NSArray *)allTeachers;
- (NSArray *)allCourses;

- (NSArray *)allTeachersSortedBySubjects;
- (void)addDefaultStudents:(NSInteger)students teachers:(NSInteger)teachers;

- (OLTVStudent *)addStudentWithFirstName:(NSString *)firstName
                                lastName:(NSString *)lastName
                                   email:(NSString *)email;

- (OLTVTeacher *)addTeacherWithFirstName:(NSString *)firstName
                                lastName:(NSString *)lastName
                                   email:(NSString *)email;


- (OLTVCourse *)addCourseWithName:(NSString *)name
                          subject:(NSString *)subject
                           branch:(NSString *)branch
                          teacher:(OLTVTeacher *)teacher;
@end
