//
//  OLTVUniversityTableViewController.m
//  iOSDev4101_CoreDataTest
//
//  Created by Oleg Tverdokhleb on 22.05.16.
//  Copyright © 2016 oltv00. All rights reserved.
//

//model
#import "OLTVUniversity+CoreDataProperties.h"

//controller
#import "OLTVUniversityTableViewController.h"
#import "OLTVCoursesTableViewController.h"

@interface OLTVUniversityTableViewController ()

@end

@implementation OLTVUniversityTableViewController
@synthesize fetchedResultsController = _fetchedResultsController;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
  self.navigationItem.title = @"Universities";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDataSource

- (void)configureCell:(UITableViewCell *)cell withObject:(NSManagedObject *)object atIndexPath:(NSIndexPath *)indexPath {
  OLTVUniversity *university = [self.fetchedResultsController objectAtIndexPath:indexPath];
  cell.textLabel.text = university.name;
  cell.detailTextLabel.text = nil;
  cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  [tableView deselectRowAtIndexPath:indexPath animated:YES];
  
  OLTVUniversity *university = [self.fetchedResultsController objectAtIndexPath:indexPath];
  OLTVCoursesTableViewController *vc = [[OLTVCoursesTableViewController alloc] initWithStyle:UITableViewStyleGrouped];
  vc.university = university;
  [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - NSFetchedResultsController

- (NSFetchedResultsController *)fetchedResultsController
{
  if (_fetchedResultsController != nil) {
    return _fetchedResultsController;
  }
  
  NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"OLTVUniversity"];
  
  NSSortDescriptor *nameSortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES];
  [fetchRequest setSortDescriptors:@[nameSortDescriptor]];
  
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
