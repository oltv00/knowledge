//
//  OLTVStudent+CoreDataProperties.h
//  iOSDev4101_CoreDataTest
//
//  Created by Oleg Tverdokhleb on 20.05.16.
//  Copyright © 2016 oltv00. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "OLTVStudent.h"

NS_ASSUME_NONNULL_BEGIN

@interface OLTVStudent (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *firstName;
@property (nullable, nonatomic, retain) NSString *lastName;
@property (nullable, nonatomic, retain) NSDate *dateOfBirth;
@property (nullable, nonatomic, retain) NSNumber *score;

@end

NS_ASSUME_NONNULL_END
