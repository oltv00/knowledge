//
//  OLTVTeacher+CoreDataProperties.h
//  iOSDev4401_CoreDataHW
//
//  Created by Oleg Tverdokhleb on 26/05/16.
//  Copyright © 2016 oltv00. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "OLTVTeacher.h"

NS_ASSUME_NONNULL_BEGIN

@interface OLTVTeacher (CoreDataProperties)

@property (nullable, nonatomic, retain) OLTVCourse *course;

@end

NS_ASSUME_NONNULL_END
