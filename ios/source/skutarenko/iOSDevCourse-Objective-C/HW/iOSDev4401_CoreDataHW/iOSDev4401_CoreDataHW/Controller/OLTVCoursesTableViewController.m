//
//  OLTVCoursesTableViewController.m
//  iOSDev4401_CoreDataHW
//
//  Created by Oleg Tverdokhleb on 22.05.16.
//  Copyright © 2016 oltv00. All rights reserved.
//

//model
#import "../Model/Entities/OLTVCourse+CoreDataProperties.h"
#import "../Model/Entities/OLTVTeacher+CoreDataProperties.h"

//controller
#import "OLTVCoursesTableViewController.h"
#import "OLTVDetailedCourseTableViewController.h"

//UI
#import "../UI/Cells/OLTVCourseTableViewCell.h"

@interface OLTVCoursesTableViewController ()

- (IBAction)actionAddCourse:(UIBarButtonItem *)sender;

@end

@implementation OLTVCoursesTableViewController

@synthesize fetchedResultsController = _fetchedResultsController;

- (void)viewDidLoad {
  [super viewDidLoad];
  
  self.navigationItem.title = @"Courses";
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
}

#pragma mark - Actions

- (IBAction)actionAddCourse:(UIBarButtonItem *)sender {
  OLTVDetailedCourseTableViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"OLTVDetailedCourseTableViewController"];
  vc.course = nil;
  [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - UITableViewDataSource

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  
  static NSString *identifier = @"OLTVCourseTableViewCell";
  
  OLTVCourseTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
  
  OLTVCourse *course = [[self fetchedResultsController] objectAtIndexPath:indexPath];
  NSString *fullName = [NSString stringWithFormat:@"%@ %@", course.teacher.firstName, course.teacher.lastName];
  cell.nameLabel.text = course.name;
  cell.subjectLabel.text = course.subject;
  cell.branchLabel.text = course.branch;
  cell.teacherLabel.text = course.teacher ? fullName : @"No teacher";
  
  return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  [tableView deselectRowAtIndexPath:indexPath animated:YES];
  
  OLTVCourse *course = [[self fetchedResultsController] objectAtIndexPath:indexPath];
  OLTVDetailedCourseTableViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"OLTVDetailedCourseTableViewController"];
  vc.course = course;
  [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - Fetched results controller

- (NSFetchedResultsController *)fetchedResultsController {
  if (_fetchedResultsController) {
    return _fetchedResultsController;
  }
  
  NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"OLTVCourse"];
  NSSortDescriptor *nameDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES];
  [fetchRequest setSortDescriptors:@[nameDescriptor]];
  
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
