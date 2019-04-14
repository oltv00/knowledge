//
//  OLTVDetailedUserTableViewController.m
//  iOSDev4401_CoreDataHW
//
//  Created by Oleg Tverdokhleb on 22.05.16.
//  Copyright © 2016 oltv00. All rights reserved.
//

//model
#import "OLTVCoreDataManager.h"
#import "OLTVUser+CoreDataProperties.h"
#import "OLTVStudent+CoreDataProperties.h"
#import "OLTVTeacher+CoreDataProperties.h"
#import "OLTVCourse+CoreDataProperties.h"

//controller
#import "OLTVDetailedUserTableViewController.h"

//UI
#import "../UI/Cells/OLTVDetailedUserTableViewCell.h"

@interface OLTVDetailedUserTableViewController ()

@property (strong, nonatomic) NSString *firstName;
@property (strong, nonatomic) NSString *lastName;
@property (strong, nonatomic) NSString *email;

@property (strong, nonatomic) NSMutableArray *studentCourses;

- (void)actionSave:(UIBarButtonItem *)sender;

- (IBAction)actionFirstNameFieldEditingChanged:(UITextField *)sender;
- (IBAction)actionLastNameFieldEditingChanged:(UITextField *)sender;
- (IBAction)actionEmailFieldEditingChanged:(UITextField *)sender;

@end

@implementation OLTVDetailedUserTableViewController

#pragma mark - Lifecycles

- (void)viewDidLoad {
  [super viewDidLoad];
  
  if (self.user) {
    
    self.firstName = self.user.firstName;
    self.lastName = self.user.lastName;
    self.email = self.user.email;
    
    if (self.detailedUser == OLTVDetailedUserStudent) {
      OLTVStudent *student = (OLTVStudent *)self.user;
      self.studentCourses = [NSMutableArray array];
      for (OLTVCourse *course in student.courses) {
        [self.studentCourses addObject:course];
      }
    }
    
    switch (self.detailedUser) {
      case OLTVDetailedUserStudent:
        self.navigationItem.title = @"Student";
        break;
      case OLTVDetailedUserTeacher:
        self.navigationItem.title = @"Teacher";
        break;
    }
  
  } else {
    
    switch (self.detailedUser) {
      case OLTVDetailedUserStudent:
        self.navigationItem.title = @"Add new student";
        break;
      case OLTVDetailedUserTeacher:
        self.navigationItem.title = @"Add new teacher";
        break;
    }
  }
  
  UIBarButtonItem *save = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(actionSave:)];
  self.navigationItem.rightBarButtonItem = save;
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
}

#pragma mark - Actions

- (void)actionSave:(UIBarButtonItem *)sender {
  
  if (self.user) {
    
    self.user.firstName = self.firstName;
    self.user.lastName = self.lastName;
    self.user.email = self.email;
    
  } else {
    
    switch (self.detailedUser) {
      case OLTVDetailedUserStudent: {
        self.user = (OLTVUser *)[[OLTVCoreDataManager sharedManager]
                                 addStudentWithFirstName:self.firstName
                                 lastName:self.lastName
                                 email:self.email];
        if (self.course) {
          OLTVStudent *student = (OLTVStudent *)self.user;
          [self.course addStudentsObject:student];
        }
        
        break;
      }
      case OLTVDetailedUserTeacher: {
        self.user = (OLTVUser *)[[OLTVCoreDataManager sharedManager]
                                 addTeacherWithFirstName:self.firstName
                                 lastName:self.lastName
                                 email:self.email];
        break;
      }
    }
  }
  
  [[OLTVCoreDataManager sharedManager] saveAllObjects];
  [[(UITableViewController *)[self.navigationController.viewControllers firstObject] tableView] reloadData];
  [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)actionFirstNameFieldEditingChanged:(UITextField *)sender {
  self.firstName = sender.text;
}

- (IBAction)actionLastNameFieldEditingChanged:(UITextField *)sender {
  self.lastName = sender.text;
}

- (IBAction)actionEmailFieldEditingChanged:(UITextField *)sender {
  self.email = sender.text;
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
  return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

  if (section == 0) {
    return 1;
  } else if (section == 1) {
    if (!self.user) {
      return 0;
    } else {
      
      if (self.detailedUser == OLTVDetailedUserStudent) {
        return [self.studentCourses count];
      } else if (self.detailedUser == OLTVDetailedUserTeacher) {
        return 1;
      }
    }
  }
  
  abort();
  return 0;
  
}

- (nullable NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
  if (section == 1) {
    if (self.user) {
      switch (self.detailedUser) {
        case OLTVDetailedUserStudent:
          return @"Courses which teaches";
        case OLTVDetailedUserTeacher:
          return @"Сourses that he teaches";
      }
    }
  }
  return nil;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  static NSString *userCellIdentifier = @"OLTVDetailedUserTableViewCell";
  static NSString *courseCellIdentifier = @"courseCellIdentifier";
  
  if (indexPath.section == 0) {
    
    OLTVDetailedUserTableViewCell *userCell = [tableView dequeueReusableCellWithIdentifier:userCellIdentifier];
    
    if (self.user) {
      userCell.firstNameField.text = self.user.firstName;
      userCell.lastNameField.text = self.user.lastName;
      userCell.emailField.text = self.user.email;
    }
    
    return userCell;
  
  } else if (indexPath.section == 1) {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:courseCellIdentifier];
    if (!cell) {
      cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:courseCellIdentifier];
    }
    
    if (self.user) {
      
      if (self.detailedUser == OLTVDetailedUserStudent) {
        
        OLTVCourse *course = self.studentCourses[indexPath.row];
        cell.textLabel.text = course.name;
        
      } else if (self.detailedUser == OLTVDetailedUserTeacher) {
        
        OLTVTeacher *teacher = (OLTVTeacher *)self.user;
        cell.textLabel.text = teacher.course.name;
        
      }
    }
    
    return cell;
  }
  
  abort();
  return nil;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
  if (indexPath.section == 0) {
    return 101.f;
  }
  
  return 44.f;
}

@end
