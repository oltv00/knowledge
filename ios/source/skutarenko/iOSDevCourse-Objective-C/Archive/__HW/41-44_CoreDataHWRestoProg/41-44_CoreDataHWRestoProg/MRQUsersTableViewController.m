//
//  MRQUsersTableViewController.m
//  41-44_CoreDataHWRestoProg
//
//  Created by Oleg Tverdokhleb on 11.01.16.
//  Copyright © 2016 Oleg Tverdokhleb. All rights reserved.
//

#import "MRQUsersTableViewController.h"
#import "MRQAddNewUserTableViewController.h"

#import "MRQUser.h"

@interface MRQUsersTableViewController ()

@end

@implementation MRQUsersTableViewController

@synthesize fetchedResultsController = _fetchedResultsController;

#pragma mark - VCLifeCycle

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Actions

- (IBAction)actionAddNewUserBarButtonPressed:(id)sender {
    
    MRQAddNewUserTableViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"MRQAddNewUserTableViewController"];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - UITableViewDataSource

- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    
    MRQUser *user = [self.fetchedResultsController objectAtIndexPath:indexPath];
    
    cell.textLabel.text = [NSString stringWithFormat:@"%@ %@", [user firstName], [user lastName]];
}

#pragma mark - UITableViewDelegate

#pragma mark - NSFetchedResultsController

- (NSFetchedResultsController *)fetchedResultsController
{
    if (_fetchedResultsController != nil) {
        return _fetchedResultsController;
    }
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    // Edit the entity name as appropriate.
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"MRQUser"
                                              inManagedObjectContext:self.managedObjectContext];
    [fetchRequest setEntity:entity];
    
    // Set the batch size to a suitable number.
    [fetchRequest setFetchBatchSize:20];
    
    // Edit the sort key as appropriate.
    NSSortDescriptor *firstNameDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"firstName"
                                                                          ascending:YES];

    NSSortDescriptor *lastNameDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"lastName"
                                                                          ascending:YES];

    [fetchRequest setSortDescriptors:@[firstNameDescriptor, lastNameDescriptor]];
    
    // Edit the section name key path and cache name if appropriate.
    // nil for section name key path means "no sections".
    NSFetchedResultsController *aFetchedResultsController = [[NSFetchedResultsController alloc]
                                                             initWithFetchRequest:fetchRequest
                                                             managedObjectContext:self.managedObjectContext
                                                             sectionNameKeyPath:nil
                                                             cacheName:@"Master"];
    
    aFetchedResultsController.delegate = self;
    self.fetchedResultsController = aFetchedResultsController;
    
    NSError *error = nil;
    if (![self.fetchedResultsController performFetch:&error]) {
        // Replace this implementation with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    return _fetchedResultsController;
}

@end
