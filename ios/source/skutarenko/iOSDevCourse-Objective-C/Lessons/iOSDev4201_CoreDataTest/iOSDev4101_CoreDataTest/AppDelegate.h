//
//  AppDelegate.h
//  iOSDev4101_CoreDataTest
//
//  Created by Oleg Tverdokhleb on 20.05.16.
//  Copyright © 2016 oltv00. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@class OLTVStudent;
@class OLTVCar;

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;


- (OLTVStudent *)addRandomStudent;
- (OLTVCar *)addRandomCar;
- (void)addStudentsInAmount:(NSInteger)amount;
- (void)addRandomStudentWithRandomCar;

- (void)databaseRemove;
- (void)databaseSave;

- (void)printAllObjects;

- (void)deleteAllObjects;
- (void)deleteRandomStudent;
- (void)deleteRandomCar;

@end

