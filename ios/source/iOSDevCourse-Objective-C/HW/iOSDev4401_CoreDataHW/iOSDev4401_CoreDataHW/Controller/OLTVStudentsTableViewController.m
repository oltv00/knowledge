//
//  OLTVUsersTableViewController.m
//  iOSDev4401_CoreDataHW
//
//  Created by Oleg Tverdokhleb on 22.05.16.
//  Copyright © 2016 oltv00. All rights reserved.
//

//model
#import "../Model/Entities/OLTVStudent+CoreDataProperties.h"

//controller
#import "OLTVStudentsTableViewController.h"
#import "OLTVDetailedUserTableViewController.h"

@interface OLTVStudentsTableViewController ()

- (IBAction)actionAddStudent:(UIBarButtonItem *)sender;

@end

@implementation OLTVStudentsTableViewController

@synthesize fetchedResultsController = _fetchedResultsController;

#pragma mark - Lifecycles

- (void)viewDidLoad {
  [super viewDidLoad];
  self.navigationItem.title = @"Students";
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
}

#pragma mark - Actions

- (IBAction)actionAddStudent:(UIBarButtonItem *)sender {
  OLTVDetailedUserTableViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"OLTVDetailedUserTableViewController"];
  vc.user = nil;
  vc.detailedUser = OLTVDetailedUserStudent;
  [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - UITableViewDataSource

- (void)configureCell:(UITableViewCell *)cell withObject:(NSManagedObject *)object atIndexPath:(NSIndexPath *)indexPath {
  OLTVStudent *student = [self.fetchedResultsController objectAtIndexPath:indexPath];
  cell.textLabel.text = [NSString stringWithFormat:@"%@ %@", student.firstName, student.lastName];
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  [tableView deselectRowAtIndexPath:indexPath animated:YES];
  
  OLTVStudent *student = [self.fetchedResultsController objectAtIndexPath:indexPath];
  OLTVDetailedUserTableViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"OLTVDetailedUserTableViewController"];
  vc.user = student;
  vc.detailedUser = OLTVDetailedUserStudent;
  [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - Fetched results controller

- (NSFetchedResultsController *)fetchedResultsController {
  if (_fetchedResultsController) {
    return _fetchedResultsController;
  }
  
  NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"OLTVStudent"];
  NSSortDescriptor *firstNameDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"firstName" ascending:YES];
  NSSortDescriptor *lastNameDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"lastName" ascending:YES];
  [fetchRequest setSortDescriptors:@[firstNameDescriptor, lastNameDescriptor]];
  
  NSFetchedResultsController *aFetchedResultsController = [[NSFetchedResultsController alloc]
                                                           initWithFetchRequest:fetchRequest
                                                           managedObjectContext:self.managedObjectContext
                                                           sectionNameKeyPath:nil
                                                           cacheName:nil];
  aFetchedResultsController.delegate = self;
  self.fetchedResultsController = aFetchedResultsController;
  
  NSError *error = nil;
  if (![self.fetchedResultsController performFetch:&error]) {
    NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
    abort();
  }
  
  return _fetchedResultsController;
}


@end
