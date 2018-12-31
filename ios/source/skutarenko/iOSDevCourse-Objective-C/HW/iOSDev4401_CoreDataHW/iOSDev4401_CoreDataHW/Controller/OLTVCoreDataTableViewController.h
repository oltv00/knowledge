//
//  OLTVCoreDataTableViewController.h
//  iOSDev4401_CoreDataHW
//
//  Created by Oleg Tverdokhleb on 22.05.16.
//  Copyright © 2016 oltv00. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OLTVCoreDataManager.h"

@interface OLTVCoreDataTableViewController : UITableViewController <NSFetchedResultsControllerDelegate>

@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;

- (void)configureCell:(UITableViewCell *)cell withObject:(NSManagedObject *)object atIndexPath:(NSIndexPath *)indexPath;

@end
