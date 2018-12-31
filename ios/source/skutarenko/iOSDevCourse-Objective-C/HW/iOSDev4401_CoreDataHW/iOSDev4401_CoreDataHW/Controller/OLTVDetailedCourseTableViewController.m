//
//  OLTVDetailedCourseTableViewController.m
//  iOSDev4401_CoreDataHW
//
//  Created by Oleg Tverdokhleb on 22.05.16.
//  Copyright © 2016 oltv00. All rights reserved.
//

//model
#import "OLTVCoreDataManager.h"
#import "../Model/Entities/OLTVCourse+CoreDataProperties.h"
#import "../Model/Entities/OLTVTeacher+CoreDataProperties.h"
#import "../Model/Entities/OLTVStudent+CoreDataProperties.h"

//controller
#import "OLTVDetailedCourseTableViewController.h"
#import "OLTVDetailedUserTableViewController.h"
#import "OLTVAddUserToCourseTableViewController.h"

//UI
#import "../UI/Cells/OLTVDetailedCourseTableViewCell.h"

@interface OLTVDetailedCourseTableViewController ()

@property (strong, nonatomic) NSString *courseName;
@property (strong, nonatomic) NSString *courseSubject;
@property (strong, nonatomic) NSString *courseBranch;

- (void)actionOk:(UIBarButtonItem *)sender;

- (IBAction)actionCourseNameEditingChanged:(UITextField *)sender;
- (IBAction)actionCourseSubjectEditingChanged:(UITextField *)sender;
- (IBAction)actionCourseBranchEditingChanged:(UITextField *)sender;

@end

@implementation OLTVDetailedCourseTableViewController

#pragma mark - Lifecycles

- (void)viewDidLoad {
  [super viewDidLoad];
  
  self.navigationItem.title = @"Course Info";
  
  UIBarButtonItem *save = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(actionOk:)];
  self.navigationItem.rightBarButtonItem = save;
  
  if (self.course) {
    
    self.courseName = self.course.name;
    self.courseSubject = self.course.subject;
    self.courseBranch = self.course.branch;
    self.courseTeacher = self.course.teacher;
    self.students = [NSMutableArray array];
    
    //TODO:Add fetch to SQL with NSPredicate and sort by firstname and lastname
    for (OLTVStudent *student in self.course.students) {
      [self.students addObject:student];
    }
  }
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
}

#pragma mark - Additional

- (void)pushDetailedStudentControllerWithStudent:(OLTVStudent *)student course:(OLTVCourse *)course {
  OLTVDetailedUserTableViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"OLTVDetailedUserTableViewController"];
  vc.user = student;
  vc.course = course;
  vc.detailedUser = OLTVDetailedUserStudent;
  [self.navigationController pushViewController:vc animated:YES];
  
}

- (void)showAlertWithTitle:(NSString *)title message:(NSString *)message {
  UIAlertController *alert = [UIAlertController alertControllerWithTitle:title
                                                                 message:message
                                                          preferredStyle:UIAlertControllerStyleAlert];
  UIAlertAction *action = [UIAlertAction
                           actionWithTitle:@"OK"
                           style:UIAlertActionStyleDefault handler:nil];
  [alert addAction:action];
  [self presentViewController:alert animated:YES completion:nil];
}

#pragma mark - Actions

- (void)actionOk:(UIBarButtonItem *)sender {
  
  if (self.course) {
    
    self.course.name = self.courseName;
    self.course.subject = self.courseSubject;
    self.course.branch = self.courseBranch;
    self.course.teacher = self.courseTeacher;
    
  } else {
    
    [[OLTVCoreDataManager sharedManager]
     addCourseWithName:self.courseName
     subject:self.courseSubject
     branch:self.courseBranch
     teacher:self.courseTeacher];
    
  }
  
  [[OLTVCoreDataManager sharedManager] saveAllObjects];
  [[(UITableViewController *)[self.navigationController.viewControllers firstObject] tableView] reloadData];
  [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)actionCourseNameEditingChanged:(UITextField *)sender {
  self.courseName = sender.text;
}

- (IBAction)actionCourseSubjectEditingChanged:(UITextField *)sender {
  self.courseSubject = sender.text;
}

- (IBAction)actionCourseBranchEditingChanged:(UITextField *)sender {
  self.courseBranch = sender.text;
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
  return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  if (section == 2) {
    if (self.course) {
      return [[self.course students] count];
    } else return 0;
  } else {
    return 1;
  }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  
  //TODO:Add constants for identifiers
  static NSString *detailedCourseCell = @"detailedCourseCell";
  static NSString *studentIdentifier = @"studentIdentifier";
  static NSString *addNewStudentCellIdentifier = @"addNewStudentCellIdentifier";
  
  if (indexPath.section == 0) {
    
    OLTVDetailedCourseTableViewCell *courseCell = [tableView dequeueReusableCellWithIdentifier:detailedCourseCell];
    
    if (self.course) {
      courseCell.nameField.text = self.course.name;
      courseCell.subjectField.text = self.course.subject;
      courseCell.branchField.text = self.course.branch;
      if (self.course.teacher) {
        courseCell.teacherField.text = [NSString stringWithFormat:@"%@ %@", self.course.teacher.firstName, self.course.teacher.lastName];
      } else {
        courseCell.teacherField.text = [NSString stringWithFormat:@"Tap to add new teacher"];
      }
    }
    
    return courseCell;
    
  } else if (indexPath.section == 1) {
    
    UITableViewCell *addNewStudent = [tableView dequeueReusableCellWithIdentifier:addNewStudentCellIdentifier];
    
    if (!addNewStudent) {
      addNewStudent = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:addNewStudentCellIdentifier];
    }
    
    addNewStudent.textLabel.text = @"Tap to add new students to course";
    addNewStudent.textLabel.textAlignment = NSTextAlignmentCenter;
    
    if (self.course) {
      addNewStudent.textLabel.textColor = [UIColor blueColor];
    } else {
      addNewStudent.textLabel.textColor = [UIColor lightGrayColor];
    }
    return addNewStudent;
    
  } else if (indexPath.section == 2) { //&& [self.students count] > indexPath.row) {
    
    //TODO:Add fetch to load object
    OLTVStudent *student = self.students[indexPath.row];
    UITableViewCell *studentCell = [tableView dequeueReusableCellWithIdentifier:studentIdentifier];
    
    if (!studentCell) {
      studentCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:studentIdentifier];
    }
    
    studentCell.textLabel.text = [NSString stringWithFormat:@"%@ %@", student.firstName, student.lastName];

    return studentCell;
  }
  
  return nil;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
  if (indexPath.section == 2) {
    return YES;
  }
  return NO;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
  OLTVStudent *student = self.students[indexPath.row];
  
  [self.course removeStudentsObject:student];
  [self.students removeObject:student];
  
  [tableView beginUpdates];
  [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationLeft];
  [tableView endUpdates];
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  [tableView deselectRowAtIndexPath:indexPath animated:YES];
  
  UITableViewCell *tappedCell = [tableView cellForRowAtIndexPath:indexPath];
  
  if ([tappedCell.reuseIdentifier isEqualToString:@"addNewStudentCellIdentifier"]) {
    
    if (self.course) {
      
      OLTVAddUserToCourseTableViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"OLTVAddUserToCourseTableViewController"];
      vc.course = self.course;
      vc.allObjects = [[OLTVCoreDataManager sharedManager] allStudents];
      vc.inputVC = self;
      vc.inputUser = OLTVInputUserToVCStudent;
      
      [self presentViewController:vc animated:YES completion:nil];
    
    } else {
      
      [self showAlertWithTitle:@"Oops..." message:@"Course must saved first"];
    }
  
  } else if ([tappedCell.reuseIdentifier isEqualToString:@"studentIdentifier"]) {
    
    OLTVStudent *student = self.students[indexPath.row];
    [self pushDetailedStudentControllerWithStudent:student course:self.course];
  }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
  if (indexPath.section == 0) {
    return 166.f;
  } else {
    return 44.f;
  }
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
  if (textField.tag == 1) {
    
    if (self.course) {
      
      OLTVAddUserToCourseTableViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"OLTVAddUserToCourseTableViewController"];
      vc.course = self.course;
      vc.allObjects = [[OLTVCoreDataManager sharedManager] allTeachers];
      vc.inputVC = self;
      vc.inputUser = OLTVInputUserToVCTeacher;
      vc.inputField = textField;
      
      [self presentViewController:vc animated:YES completion:nil];

    } else {
      [self showAlertWithTitle:@"Oops..." message:@"Course must saved first"];
    }
    
    return NO;
  }
  return YES;
}

@end
