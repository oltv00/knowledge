//
//  OLTVStudent+CoreDataProperties.h
//  iOSDev4401_CoreDataHW
//
//  Created by Oleg Tverdokhleb on 26/05/16.
//  Copyright © 2016 oltv00. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "OLTVStudent.h"

NS_ASSUME_NONNULL_BEGIN

@interface OLTVStudent (CoreDataProperties)

@property (nullable, nonatomic, retain) NSSet<OLTVCourse *> *courses;

@end

@interface OLTVStudent (CoreDataGeneratedAccessors)

- (void)addCoursesObject:(OLTVCourse *)value;
- (void)removeCoursesObject:(OLTVCourse *)value;
- (void)addCourses:(NSSet<OLTVCourse *> *)values;
- (void)removeCourses:(NSSet<OLTVCourse *> *)values;

@end

NS_ASSUME_NONNULL_END
