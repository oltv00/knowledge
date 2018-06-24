//
//  EducationTableViewController.m
//  iOSDev3601_UIPopover
//
//  Created by Oleg Tverdokhleb on 04.05.16.
//  Copyright © 2016 Oleg Tverdokhleb. All rights reserved.
//


#import "EducationViewController.h"
#import "CheckboxTableViewCell.h"

#import "Educations.h"

@interface EducationViewController ()

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) CheckboxTableViewCell *selectedCell;
@property (strong, nonatomic) NSMutableArray *education;

@property (strong, nonatomic) UIImage *check;
@property (strong, nonatomic) UIImage *uncheck;

- (IBAction)actionDone:(UIBarButtonItem *)sender;
- (IBAction)actionCancel:(UIBarButtonItem *)sender;

@end

@implementation EducationViewController

#pragma mark - Lifecycle

- (void)viewDidLoad {
  [super viewDidLoad];
  
  self.tableView.editing = YES;
  self.tableView.allowsSelectionDuringEditing = YES;
  
  self.check = [UIImage imageNamed:@"check"];
  self.uncheck = [UIImage imageNamed:@"uncheck"];
  
  self.education = [NSMutableArray array];
  
  for (int i = 0; i < 9; i += 1) {
    [self.education addObject:educations[i]];
  }
}


- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
}

#pragma mark - IBActions

- (IBAction)actionDone:(UIBarButtonItem *)sender {
  NSString *checkBoxText = self.selectedCell.checkboxLabel.text;
  [self.delegate educationCheckBoxCell:self.selectedCell checkboxTextDidChanged:checkBoxText];
  [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)actionCancel:(UIBarButtonItem *)sender {
  self.selectedCell.checkboxImageView.image = self.uncheck;
  [self.delegate educationCheckBoxCell:nil checkboxTextDidChanged:@""];
  self.selectedCell = nil;
  [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - UITableViewDataSource


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return [self.education count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  static NSString *identifier = @"educationCell";
  
  CheckboxTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
  cell.checkboxImageView.image = self.uncheck;
  cell.checkboxLabel.text = self.education[indexPath.row];
  
  if ([cell.checkboxLabel.text isEqualToString:self.checkBoxText]) {
    self.selectedCell = cell;
    self.selectedCell.checkboxImageView.image = self.check;
  }
  
  return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  [tableView deselectRowAtIndexPath:indexPath animated:YES];
  CheckboxTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
 
  //deselect old checkbox
  if (![cell isEqual:self.selectedCell] && self.selectedCell) {
    self.selectedCell.checkboxImageView.image = self.uncheck;
  }
  
  //select new checkbox and deselect current checkbox
  if ([cell.checkboxImageView.image isEqual:self.uncheck]) {
    cell.checkboxImageView.image = self.check;
    self.selectedCell = cell;
    [self.delegate educationCheckBoxCell:cell checkboxTextDidChanged:cell.checkboxLabel.text];
  } else if ([cell.checkboxImageView.image isEqual:self.check]) {
    cell.checkboxImageView.image = self.uncheck;
    [self.delegate educationCheckBoxCell:nil checkboxTextDidChanged:@""];
    self.selectedCell = nil;
  }
  
  
  if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad && self.selectedCell) {
    [self.delegate educationCheckBoxCell:cell checkboxTextDidChanged:cell.checkboxLabel.text];
  }
}

- (BOOL)tableView:(UITableView *)tableView shouldIndentWhileEditingRowAtIndexPath:(NSIndexPath *)indexPath {
  return NO;
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
  return UITableViewCellEditingStyleNone;
}

@end
