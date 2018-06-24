//
//  OLTVStudent+CoreDataProperties.h
//  iOSDev4101_CoreDataTest
//
//  Created by Oleg Tverdokhleb on 21.05.16.
//  Copyright © 2016 oltv00. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "OLTVStudent.h"

NS_ASSUME_NONNULL_BEGIN

@interface OLTVStudent (CoreDataProperties)

@property (nullable, nonatomic, retain) NSDate *dateOfBirth;
@property (nullable, nonatomic, retain) NSString *firstName;
@property (nullable, nonatomic, retain) NSString *lastName;
@property (nullable, nonatomic, retain) NSNumber *score;
@property (nullable, nonatomic, retain) OLTVCar *car;
@property (nullable, nonatomic, retain) OLTVUniversity *university;
@property (nullable, nonatomic, retain) NSSet<OLTVCourse *> *courses;

@end

@interface OLTVStudent (CoreDataGeneratedAccessors)

- (void)addCoursesObject:(OLTVCourse *)value;
- (void)removeCoursesObject:(OLTVCourse *)value;
- (void)addCourses:(NSSet<OLTVCourse *> *)values;
- (void)removeCourses:(NSSet<OLTVCourse *> *)values;

@end

NS_ASSUME_NONNULL_END
