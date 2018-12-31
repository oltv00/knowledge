//
//  MRQDataManager.h
//  41_CoreDataTest
//
//  Created by Oleg Tverdokhleb on 10.01.16.
//  Copyright © 2016 Oleg Tverdokhleb. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface MRQDataManager : NSObject

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

+ (MRQDataManager *) sharedManager;

- (void) generateAndAddUniversity;
- (void) reloadSQLBase;
- (void) printAllObjects;
- (void) countCourses;

@end
