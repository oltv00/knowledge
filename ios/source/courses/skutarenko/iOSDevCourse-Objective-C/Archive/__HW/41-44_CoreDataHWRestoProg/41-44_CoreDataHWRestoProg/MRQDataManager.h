//
//  MRQDataManager.h
//  41-44_CoreDataHWRestoProg
//
//  Created by Oleg Tverdokhleb on 10.01.16.
//  Copyright © 2016 Oleg Tverdokhleb. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class MRQUser;

@interface MRQDataManager : NSObject

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

+ (MRQDataManager *) sharedManager;

- (MRQUser *) addNewUserWithFirstName:(NSString *) firstName
                             lastName:(NSString *) lastName
                                email:(NSString *) email;

@end
