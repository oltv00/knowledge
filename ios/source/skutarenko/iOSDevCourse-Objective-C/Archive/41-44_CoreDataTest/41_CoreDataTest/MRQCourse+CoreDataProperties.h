//
//  MRQCourse+CoreDataProperties.h
//  41_CoreDataTest
//
//  Created by Oleg Tverdokhleb on 08.01.16.
//  Copyright © 2016 Oleg Tverdokhleb. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "MRQCourse.h"

NS_ASSUME_NONNULL_BEGIN

@interface MRQCourse (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *name;
@property (nullable, nonatomic, retain) MRQUniversity *university;
@property (nullable, nonatomic, retain) NSSet<MRQStudent *> *students;
@property (nullable, nonatomic, retain) NSArray<MRQStudent *> *bestStudents;
@property (nullable, nonatomic, retain) NSArray<MRQStudent *> *studentsWithManyCourses;

@end

@interface MRQCourse (CoreDataGeneratedAccessors)

- (void)addStudentsObject:(MRQStudent *)value;
- (void)removeStudentsObject:(MRQStudent *)value;
- (void)addStudents:(NSSet<MRQStudent *> *)values;
- (void)removeStudents:(NSSet<MRQStudent *> *)values;

@end

NS_ASSUME_NONNULL_END
