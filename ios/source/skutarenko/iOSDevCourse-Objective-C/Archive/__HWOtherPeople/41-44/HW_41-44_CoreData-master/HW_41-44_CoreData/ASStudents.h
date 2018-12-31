//
//  ASStudents.h
//  HW_41-44_CoreData
//
//  Created by MD on 08.08.15.
//  Copyright (c) 2015 MD. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
//#import "NSManagedObject.h"

@class NSManagedObject;

@interface ASStudents : NSManagedObject

@property (nonatomic, retain) NSString * email;
@property (nonatomic, retain) NSString * firstName;
@property (nonatomic, retain) NSString * lastName;
@property (nonatomic, retain) NSSet *courses;
@end

@interface ASStudents (CoreDataGeneratedAccessors)

- (void)addCoursesObject:(NSManagedObject *)value;
- (void)removeCoursesObject:(NSManagedObject *)value;
- (void)addCourses:(NSSet *)values;
- (void)removeCourses:(NSSet *)values;

@end
