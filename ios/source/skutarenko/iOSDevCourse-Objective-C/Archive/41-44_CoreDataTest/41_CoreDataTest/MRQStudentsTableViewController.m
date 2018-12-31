//
//  MRQStudentsTableViewController.m
//  41_CoreDataTest
//
//  Created by Oleg Tverdokhleb on 10.01.16.
//  Copyright © 2016 Oleg Tverdokhleb. All rights reserved.
//

#import "MRQStudentsTableViewController.h"

#import "MRQStudent.h"
#import "MRQCourse.h"

@interface MRQStudentsTableViewController ()

@end

@implementation MRQStudentsTableViewController

@synthesize fetchedResultsController = _fetchedResultsController;

#pragma mark - VC LifeCycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - FetchRequests

- (NSFetchedResultsController *)fetchedResultsController
{
    if (_fetchedResultsController != nil) {
        return _fetchedResultsController;
    }
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *description = [NSEntityDescription entityForName:@"MRQStudent"
                                                   inManagedObjectContext:self.managedObjectContext];
    [fetchRequest setEntity:description];
    
    NSSortDescriptor *firstNameDescriptor = [[NSSortDescriptor alloc] initWithKey:@"firstName" ascending:YES];
    NSSortDescriptor *lastNameDescriptor = [[NSSortDescriptor alloc] initWithKey:@"lastName" ascending:YES];
    [fetchRequest setSortDescriptors:@[firstNameDescriptor, lastNameDescriptor]];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"courses contains %@", self.course];
    [fetchRequest setPredicate:predicate];
    
    // Edit the section name key path and cache name if appropriate.
    // nil for section name key path means "no sections".
    NSFetchedResultsController *aFetchedResultsController = [[NSFetchedResultsController alloc]
                                                             initWithFetchRequest:fetchRequest
                                                             managedObjectContext:self.managedObjectContext
                                                             sectionNameKeyPath:nil
                                                             cacheName:nil];
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
    
    MRQStudent *student = [self.fetchedResultsController objectAtIndexPath:indexPath];
    
    cell.textLabel.text = [NSString stringWithFormat:@"%@ %@", [student firstName], [student lastName]];
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@", [student score]];
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//    
//    MRQCourse *course = [self.fetchedResultsController objectAtIndexPath:indexPath];
//    
//    MRQStudentsTableViewController *vc = [[MRQStudentsTableViewController alloc] init];
//    vc.course = course;
//    
//    [self.navigationController pushViewController:vc animated:YES];
}
@end
