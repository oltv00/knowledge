//
//  OLTVCoursesTableViewController.m
//  iOSDev4101_CoreDataTest
//
//  Created by Oleg Tverdokhleb on 22.05.16.
//  Copyright © 2016 oltv00. All rights reserved.
//

//model
#import "OLTVCourse+CoreDataProperties.h"

//controller
#import "OLTVCoursesTableViewController.h"
#import "OLTVStudentsTableViewController.h"

@interface OLTVCoursesTableViewController ()

@end

@implementation OLTVCoursesTableViewController
@synthesize fetchedResultsController = _fetchedResultsController;

- (void)viewDidLoad {
  [super viewDidLoad];
  // Do any additional setup after loading the view.
  self.navigationItem.title = @"Courses";
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDataSource

- (void)configureCell:(UITableViewCell *)cell withObject:(NSManagedObject *)object atIndexPath:(NSIndexPath *)indexPath {
  OLTVCourse *course = [self.fetchedResultsController objectAtIndexPath:indexPath];
  cell.textLabel.text = course.name;
  cell.detailTextLabel.text = [NSString stringWithFormat:@"%ld", [[course students] count]];
  cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  [tableView deselectRowAtIndexPath:indexPath animated:YES];
  
  OLTVCourse *course = [self.fetchedResultsController objectAtIndexPath:indexPath];
  OLTVStudentsTableViewController *vc = [[OLTVStudentsTableViewController alloc] initWithStyle:UITableViewStyleGrouped];
  vc.course = course;
  [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - Fetched results controller

- (NSFetchedResultsController *)fetchedResultsController {
  if (_fetchedResultsController != nil) {
    return _fetchedResultsController;
  }
  
  NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"OLTVCourse"];
  [fetchRequest setRelationshipKeyPathsForPrefetching:@[@"students"]];
  
  NSSortDescriptor *nameSortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES];
  [fetchRequest setSortDescriptors:@[nameSortDescriptor]];
  
  NSPredicate *predicate = [NSPredicate predicateWithFormat:@"university == %@", self.university];
  [fetchRequest setPredicate:predicate];
  
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
