//
//  MRQUniversityTableViewController.m
//  41_CoreDataTest
//
//  Created by Oleg Tverdokhleb on 10.01.16.
//  Copyright © 2016 Oleg Tverdokhleb. All rights reserved.
//

#import "MRQUniversityTableViewController.h"
#import "MRQCoursesTableViewController.h"

#import "MRQUniversity.h"

@interface MRQUniversityTableViewController ()

@end

@implementation MRQUniversityTableViewController
@synthesize fetchedResultsController = _fetchedResultsController;

#pragma mark - VC LifeCycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setup];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Setup

- (void) setup {
    [self setupNavigationController];
}

- (void) setupNavigationController {
    
    self.navigationItem.title = @"Universities";
    self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

#pragma mark - FetchRequests

- (NSFetchedResultsController *)fetchedResultsController
{
    if (_fetchedResultsController != nil) {
        return _fetchedResultsController;
    }
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *description = [NSEntityDescription entityForName:@"MRQUniversity"
                                                   inManagedObjectContext:self.managedObjectContext];
    [fetchRequest setEntity:description];
    
    NSSortDescriptor *nameDescriptor = [[NSSortDescriptor alloc] initWithKey:@"name"
                                                                   ascending:YES];
    [fetchRequest setSortDescriptors:@[nameDescriptor]];
    
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

#pragma mark - UITableViewDataSource

- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    
    MRQUniversity *university = [self.fetchedResultsController objectAtIndexPath:indexPath];
    
    cell.textLabel.text = university.name;
    cell.detailTextLabel.text = nil;
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
 
    MRQUniversity *university = [self.fetchedResultsController objectAtIndexPath:indexPath];
    MRQCoursesTableViewController *vc = [[MRQCoursesTableViewController alloc] init];
    
    vc.university = university;
    
    [self.navigationController pushViewController:vc animated:YES];
}

@end
