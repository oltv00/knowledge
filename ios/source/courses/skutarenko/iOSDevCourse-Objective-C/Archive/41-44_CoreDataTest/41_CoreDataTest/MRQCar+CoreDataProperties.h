//
//  MRQCar+CoreDataProperties.h
//  41_CoreDataTest
//
//  Created by Oleg Tverdokhleb on 08.01.16.
//  Copyright © 2016 Oleg Tverdokhleb. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "MRQCar.h"

NS_ASSUME_NONNULL_BEGIN

@interface MRQCar (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *model;
@property (nullable, nonatomic, retain) MRQStudent *owner;

@end

NS_ASSUME_NONNULL_END
