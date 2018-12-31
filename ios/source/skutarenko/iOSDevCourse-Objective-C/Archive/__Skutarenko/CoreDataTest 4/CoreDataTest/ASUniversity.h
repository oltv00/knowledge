//
//  ASUniversity.h
//  CoreDataTest
//
//  Created by Oleksii Skutarenko on 01.02.14.
//  Copyright (c) 2014 Alex Skutarenko. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "ASObject.h"

@class ASStudent;

@interface ASUniversity : ASObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSSet *students;
@property (nonatomic, retain) NSSet *courses;
@end

@interface ASUniversity (CoreDataGeneratedAccessors)

- (void)addStudentsObject:(ASStudent *)value;
- (void)removeStudentsObject:(ASStudent *)value;
- (void)addStudents:(NSSet *)values;
- (void)removeStudents:(NSSet *)values;

- (void)addCoursesObject:(NSManagedObject *)value;
- (void)removeCoursesObject:(NSManagedObject *)value;
- (void)addCourses:(NSSet *)values;
- (void)removeCourses:(NSSet *)values;

@end
