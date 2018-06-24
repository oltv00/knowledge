//
//  ASCourse.h
//  CoreDataTest
//
//  Created by Oleksii Skutarenko on 01.02.14.
//  Copyright (c) 2014 Alex Skutarenko. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "ASObject.h"

@class ASStudent, ASUniversity;

@interface ASCourse : ASObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) ASUniversity *university;
@property (nonatomic, retain) NSSet *students;
@property (nonatomic, retain) NSArray *bestStudents;
@property (nonatomic, retain) NSArray *studentsWithManyCourses;
@end

@interface ASCourse (CoreDataGeneratedAccessors)

- (void)addStudentsObject:(ASStudent *)value;
- (void)removeStudentsObject:(ASStudent *)value;
- (void)addStudents:(NSSet *)values;
- (void)removeStudents:(NSSet *)values;

@end
