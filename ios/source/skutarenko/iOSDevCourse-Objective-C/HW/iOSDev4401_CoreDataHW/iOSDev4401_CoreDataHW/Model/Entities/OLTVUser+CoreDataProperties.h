//
//  OLTVUser+CoreDataProperties.h
//  iOSDev4401_CoreDataHW
//
//  Created by Oleg Tverdokhleb on 26/05/16.
//  Copyright © 2016 oltv00. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "OLTVUser.h"

NS_ASSUME_NONNULL_BEGIN

@interface OLTVUser (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *firstName;
@property (nullable, nonatomic, retain) NSString *lastName;
@property (nullable, nonatomic, retain) NSString *email;

@end

NS_ASSUME_NONNULL_END
