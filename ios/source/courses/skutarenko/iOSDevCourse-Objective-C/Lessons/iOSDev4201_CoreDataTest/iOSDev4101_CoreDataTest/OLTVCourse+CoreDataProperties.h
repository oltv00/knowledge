//
//  OLTVCourse+CoreDataProperties.h
//  iOSDev4101_CoreDataTest
//
//  Created by Oleg Tverdokhleb on 21.05.16.
//  Copyright © 2016 oltv00. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "OLTVCourse.h"

NS_ASSUME_NONNULL_BEGIN

@interface OLTVCourse (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *name;
@property (nullable, nonatomic, retain) OLTVUniversity *university;
@property (nullable, nonatomic, retain) NSSet<OLTVStudent *> *students;

@end

@interface OLTVCourse (CoreDataGeneratedAccessors)

- (void)addStudentsObject:(OLTVStudent *)value;
- (void)removeStudentsObject:(OLTVStudent *)value;
- (void)addStudents:(NSSet<OLTVStudent *> *)values;
- (void)removeStudents:(NSSet<OLTVStudent *> *)values;

@end

NS_ASSUME_NONNULL_END
