//
//  OLTVCar+CoreDataProperties.h
//  iOSDev4101_CoreDataTest
//
//  Created by Oleg Tverdokhleb on 21.05.16.
//  Copyright © 2016 oltv00. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "OLTVCar.h"

NS_ASSUME_NONNULL_BEGIN

@interface OLTVCar (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *model;
@property (nullable, nonatomic, retain) OLTVStudent *owner;

@end

NS_ASSUME_NONNULL_END
