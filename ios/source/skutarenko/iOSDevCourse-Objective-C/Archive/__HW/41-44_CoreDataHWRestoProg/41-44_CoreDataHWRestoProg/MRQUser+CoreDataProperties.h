//
//  MRQUser+CoreDataProperties.h
//  41-44_CoreDataHWRestoProg
//
//  Created by Oleg Tverdokhleb on 11.01.16.
//  Copyright © 2016 Oleg Tverdokhleb. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "MRQUser.h"

NS_ASSUME_NONNULL_BEGIN

@interface MRQUser (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *firstName;
@property (nullable, nonatomic, retain) NSString *lastName;
@property (nullable, nonatomic, retain) NSString *email;

@end

NS_ASSUME_NONNULL_END
