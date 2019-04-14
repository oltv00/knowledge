//
//  OLTVCourse+CoreDataProperties.h
//  iOSDev4401_CoreDataHW
//
//  Created by Oleg Tverdokhleb on 26/05/16.
//  Copyright © 2016 oltv00. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "OLTVCourse.h"

NS_ASSUME_NONNULL_BEGIN

@interface OLTVCourse (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *branch;
@property (nullable, nonatomic, retain) NSString *name;
@property (nullable, nonatomic, retain) NSString *subject;
@property (nullable, nonatomic, retain) NSSet<OLTVStudent *> *students;
@property (nullable, nonatomic, retain) OLTVTeacher *teacher;

@end

@interface OLTVCourse (CoreDataGeneratedAccessors)

- (void)addStudentsObject:(OLTVStudent *)value;
- (void)removeStudentsObject:(OLTVStudent *)value;
- (void)addStudents:(NSSet<OLTVStudent *> *)values;
- (void)removeStudents:(NSSet<OLTVStudent *> *)values;

@end

NS_ASSUME_NONNULL_END
