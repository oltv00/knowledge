//
//  MainTableViewController.m
//  iOSDev4001_KVCHW
//
//  Created by Oleg Tverdokhleb on 18.05.16.
//  Copyright © 2016 oltv00. All rights reserved.
//

// Model
#import "OLTVStudent.h"

// Controllers
#import "OLTVMainTableViewController.h"
#import "OLTVDatePickerViewController.h"

@interface OLTVMainTableViewController () <OLTVDatePickerDelegate>
@property (strong, nonatomic) NSDate *pickerDate;
@property (strong, nonatomic) OLTVStudent *student;
@end

@implementation OLTVMainTableViewController

#pragma mark - Lifecycles

- (void)viewDidLoad {
  [super viewDidLoad];
  
  OLTVStudent *student = [OLTVStudent new];
  self.student = student;
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
  if ([textField isEqual:self.firstNameField]) {
    [self.lastNameField becomeFirstResponder];
  } else {
    [textField resignFirstResponder];
  }
  return YES;
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
  if ([textField isEqual:self.dateOfBirthField]) {
    NSLog(@"call date picker");
    OLTVDatePickerViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"OLTVDatePickerViewController"];
    vc.delegate = self;
    if (self.pickerDate) {
      vc.pickerDate = self.pickerDate;
    }
    [self presentViewController:vc animated:YES completion:nil];
    return NO;
  }
  return YES;
}

#pragma mark - OLTVDatePickerDelegate

- (void)datePicker:(UIDatePicker *)datePicker didChangeDate:(NSString *)stringDate {
  self.dateOfBirthField.text = stringDate;
  self.pickerDate = datePicker.date;
}

#pragma mark - Actions

- (IBAction)actionFirstNameDidEnd:(UITextField *)sender {
  self.student.firstName = sender.text;
}

- (IBAction)actionLastNameDidEnd:(UITextField *)sender {
  self.student.lastName = sender.text;
}

- (IBAction)actionGenderControl:(UISegmentedControl *)sender {
  self.student.gender = sender.selectedSegmentIndex;
}

- (IBAction)actionAverageGradeField:(UITextField *)sender {
  self.student.averageGrade = [sender.text floatValue];
}

#pragma mark - Gestures

- (IBAction)handleTapGesture:(UITapGestureRecognizer *)sender {
  [self.view endEditing:YES];
}

@end
