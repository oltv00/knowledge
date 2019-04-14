//
//  OLTVCheckboxStudentsTableViewController.m
//  iOSDev4401_CoreDataHW
//
//  Created by Oleg Tverdokhleb on 24.05.16.
//  Copyright © 2016 oltv00. All rights reserved.
//

//model
#import "../Model/OLTVCoreDataManager.h"
#import "../Model/Entities/OLTVStudent+CoreDataProperties.h"
#import "../Model/Entities/OLTVCourse+CoreDataProperties.h"
#import "../Model/Entities/OLTVTeacher+CoreDataProperties.h"

//controller
#import "OLTVAddUserToCourseTableViewController.h"
#import "OLTVDetailedCourseTableViewController.h"

//UI
#import "../UI/Cells/OLTVStudentCheckboxTableViewCell.h"

@interface OLTVAddUserToCourseTableViewController ()

@property (strong, nonatomic) UIImage *checkImage;
@property (strong, nonatomic) UIImage *unCheckImage;
@property (strong, nonatomic) OLTVStudentCheckboxTableViewCell *selectedCell;

@property (weak, nonatomic) IBOutlet UINavigationItem *navigationItem;

@property (strong, nonatomic) OLTVTeacher *courseTeacher;

- (IBAction)actionDone:(UIBarButtonItem *)sender;

@end

@implementation OLTVAddUserToCourseTableViewController

#pragma mark - Lifecycles

- (void)viewDidLoad {
  [super viewDidLoad];
  
  if (self.course) {
    switch (self.inputUser) {
      case OLTVInputUserToVCStudent:
        self.navigationItem.title = [NSString stringWithFormat:@"%@ - add students", self.course.name];
        break;
      case OLTVInputUserToVCTeacher:
        self.navigationItem.title = [NSString stringWithFormat:@"%@ - add teacher", self.course.name];
        break;
    }
  }
  
  self.checkImage = [UIImage imageNamed:@"check.png"];
  self.unCheckImage = [UIImage imageNamed:@"uncheck.png"];
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
}

#pragma mark - Actions

- (IBAction)actionDone:(UIBarButtonItem *)sender {
  __weak OLTVAddUserToCourseTableViewController *weakSelf = self;
  
  if (self.inputUser == OLTVInputUserToVCStudent) {
    
    //TODO:Add animation to reload data
    [self dismissViewControllerAnimated:YES completion:^{
      [weakSelf.inputVC.tableView reloadData];
    }];
  
  } else if (self.inputUser == OLTVInputUserToVCTeacher) {
   
    NSString *dismissString = nil;
    
    if (self.courseTeacher) {
      dismissString = [NSString stringWithFormat:@"%@ %@", self.courseTeacher.firstName, self.courseTeacher.lastName];
    } else {
      dismissString = @"Tap to add new teacher";
    }
    
    [self dismissViewControllerAnimated:YES completion:^{
      weakSelf.inputField.text = dismissString;
      weakSelf.inputVC.courseTeacher = weakSelf.courseTeacher;
    }];
  }
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
  return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return [self.allObjects count];
}

//TODO:Add flags to teachers which have other course
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  
  static NSString *identifier = @"OLTVStudentCheckboxTableViewCell";
  OLTVStudentCheckboxTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
  cell.checkBoxImageView.image = self.unCheckImage;
  
  if (self.inputUser == OLTVInputUserToVCStudent) {

    OLTVStudent *student = self.allObjects[indexPath.row];
    cell.studentFullNameLabel.text = [NSString stringWithFormat:@"%@ %@", student.firstName, student.lastName];
    
    if ([self.course.students containsObject:student]) {
      cell.checkBoxImageView.image = self.checkImage;
    }
    
    return cell;
    
  } else if (self.inputUser == OLTVInputUserToVCTeacher) {
    
    OLTVTeacher *teacher = self.allObjects[indexPath.row];
    cell.studentFullNameLabel.text = [NSString stringWithFormat:@"%@ %@", teacher.firstName, teacher.lastName];
    
    if ([self.course.teacher isEqual:teacher]) {
      cell.checkBoxImageView.image = self.checkImage;
      self.courseTeacher = teacher;
      self.selectedCell = cell;
    }
    
    if (![teacher isEqual:self.courseTeacher] && teacher.course) {
      cell.checkBoxImageView.image = self.checkImage;
    }
    
    return cell;
  }
  
  return nil;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  [tableView deselectRowAtIndexPath:indexPath animated:YES];
  OLTVStudentCheckboxTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];

  if (self.inputUser == OLTVInputUserToVCStudent) {
    
    OLTVStudent *student = self.allObjects[indexPath.row];
    
    if ([cell.checkBoxImageView.image isEqual:self.checkImage]) {
      
      cell.checkBoxImageView.image = self.unCheckImage;
      [student removeCoursesObject:self.course];
      [self.inputVC.students removeObject:student];
    
    } else if ([cell.checkBoxImageView.image isEqual:self.unCheckImage]) {
      
      cell.checkBoxImageView.image = self.checkImage;
      [student addCoursesObject:self.course];
      [self.inputVC.students addObject:student];
    }
  
  } else if (self.inputUser == OLTVInputUserToVCTeacher) {
  
    //deselect old checkbox
    if (![cell isEqual:self.selectedCell] && self.selectedCell) {
      self.selectedCell.checkBoxImageView.image = self.unCheckImage;
    }
    
    OLTVTeacher *teacher = self.allObjects[indexPath.row];
    
    if ([cell.checkBoxImageView.image isEqual:self.checkImage]) {
      
      cell.checkBoxImageView.image = self.unCheckImage;
      self.course.teacher = nil;
      self.courseTeacher = nil;
      self.selectedCell = nil;
      
    } else if ([cell.checkBoxImageView.image isEqual:self.unCheckImage]) {
      
      self.selectedCell = cell;
      cell.checkBoxImageView.image = self.checkImage;
      self.course.teacher = teacher;
      self.courseTeacher = teacher;
    }
  }
  
  [[OLTVCoreDataManager sharedManager] saveAllObjects];
}

@end
