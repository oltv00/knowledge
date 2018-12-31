//
//  OLTVTeachersTableViewController.m
//  iOSDev4401_CoreDataHW
//
//  Created by Oleg Tverdokhleb on 25/05/16.
//  Copyright © 2016 oltv00. All rights reserved.
//

//model
#import "OLTVCoreDataManager.h"
#import "OLTVTeacher+CoreDataProperties.h"
#import "OLTVCourse+CoreDataProperties.h"

//controller
#import "OLTVTeachersTableViewController.h"
#import "OLTVDetailedUserTableViewController.h"

//UI

@interface OLTVSubject : NSObject
@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSMutableArray <OLTVTeacher*> *teachers;
@end

@implementation OLTVSubject
@end


@interface OLTVTeachersTableViewController ()

@property (strong, nonatomic) NSMutableArray *subjects;
- (IBAction)actionAddTeacher:(UIBarButtonItem *)sender;
- (IBAction)actionReloadTable:(UIBarButtonItem *)sender;
@end

@implementation OLTVTeachersTableViewController

#pragma mark - Lifecycles

//TODO: reload table after first load and change tab bar items
- (void)viewDidLoad {
  [super viewDidLoad];
  self.navigationItem.title = @"Teachers";
  [self reloadTable];
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
}

#pragma mark - Additional

- (void)reloadTable {
  self.subjects = [NSMutableArray array];
  
  NSArray *allCourses = [[OLTVCoreDataManager sharedManager] allCourses];
  NSArray *subjects = [allCourses valueForKeyPath:@"@distinctUnionOfObjects.subject"];
  
  NSArray *allTeachers = [[OLTVCoreDataManager sharedManager] allTeachersSortedBySubjects];
  
  for (NSString *subjectName in subjects) {
    OLTVSubject *subject = nil;
    for (OLTVTeacher *teacher in allTeachers) {
      if ([subjectName isEqualToString:teacher.course.subject]) {
        if (!subject) {
          
          subject = [OLTVSubject new];
          subject.name = subjectName;
          subject.teachers = [NSMutableArray array];
          [subject.teachers addObject:teacher];
          
        } else {
          
          [subject.teachers addObject:teacher];
          
        }
      }
    }
    
    if (subject) {
      [self.subjects addObject:subject];
    }
  }
}

#pragma mark - Actions

- (IBAction)actionAddTeacher:(UIBarButtonItem *)sender {
  OLTVDetailedUserTableViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"OLTVDetailedUserTableViewController"];
  vc.user = nil;
  vc.detailedUser = OLTVDetailedUserTeacher;
  [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)actionReloadTable:(UIBarButtonItem *)sender {
  [self reloadTable];
  [self.tableView reloadData];
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
  return [self.subjects count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  OLTVSubject *subject = self.subjects[section];
  return [subject.teachers count];
}

- (nullable NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
  OLTVSubject *subject = self.subjects[section];
  return subject.name;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
 
  static NSString *identifier = @"teachersIdentifier";
  
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
  
  if (!cell) {
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
  }
  
  OLTVSubject *subject = self.subjects[indexPath.section];
  OLTVTeacher *teacher = subject.teachers[indexPath.row];
  
  cell.textLabel.text = [NSString stringWithFormat:@"%@ %@", teacher.firstName, teacher.lastName];
  
  return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  [tableView deselectRowAtIndexPath:indexPath animated:YES];
  
  OLTVSubject *subject = self.subjects[indexPath.section];
  OLTVTeacher *teacher = subject.teachers[indexPath.row];

  OLTVDetailedUserTableViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"OLTVDetailedUserTableViewController"];
  vc.user = teacher;
  vc.detailedUser = OLTVDetailedUserTeacher;
  [self.navigationController pushViewController:vc animated:YES];
}

@end
