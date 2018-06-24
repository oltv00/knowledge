//
//  MRQStudent+CoreDataProperties.h
//  41_CoreDataTest
//
//  Created by Oleg Tverdokhleb on 08.01.16.
//  Copyright © 2016 Oleg Tverdokhleb. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "MRQStudent.h"

NS_ASSUME_NONNULL_BEGIN

@interface MRQStudent (CoreDataProperties)

@property (nullable, nonatomic, retain) NSDate *dateOfBirth;
@property (nullable, nonatomic, retain) NSString *firstName;
@property (nullable, nonatomic, retain) NSString *lastName;
@property (nullable, nonatomic, retain) NSNumber *score;
@property (nullable, nonatomic, retain) MRQCar *car;
@property (nullable, nonatomic, retain) MRQUniversity *university;
@property (nullable, nonatomic, retain) NSSet<MRQCourse *> *courses;

@end

@interface MRQStudent (CoreDataGeneratedAccessors)

- (void)addCoursesObject:(MRQCourse *)value;
- (void)removeCoursesObject:(MRQCourse *)value;
- (void)addCourses:(NSSet<MRQCourse *> *)values;
- (void)removeCourses:(NSSet<MRQCourse *> *)values;

@end

NS_ASSUME_NONNULL_END
