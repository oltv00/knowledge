//
//  DateOfBirthPickerViewController.m
//  iOSDev3601_UIPopover
//
//  Created by Oleg Tverdokhleb on 03.05.16.
//  Copyright © 2016 Oleg Tverdokhleb. All rights reserved.
//

#import "DateOfBirthPickerViewController.h"

@interface DateOfBirthPickerViewController ()

@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;
@property (weak, nonatomic) IBOutlet UILabel *datePreviewLabel;

- (IBAction)actionDatePicker:(UIDatePicker *)sender;
- (IBAction)actionDone:(UIBarButtonItem *)sender;
- (IBAction)actionCancel:(UIBarButtonItem *)sender;
- (IBAction)actionTapToClear:(UIButton *)sender;

@end

@implementation DateOfBirthPickerViewController

#pragma mark - Lifecycle

- (void)viewDidLoad {
  [super viewDidLoad];
  self.datePreviewLabel.text = @"";
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  NSLog(@"%@ didReceiveMemoryWarning", self);
}

- (void)dealloc {
  NSLog(@"dealloc %@", self);
}

- (void)viewDidAppear:(BOOL)animated {
  [super viewDidAppear:animated];
  
  [self datePickerSetup];
  [self previewLabelSetup];
}

#pragma mark - Setups

- (void)previewLabelSetup {
  self.datePreviewLabel.text = self.dateString;
  [self addTransitionToLabel:self.datePreviewLabel];
  
  if (!self.datePreviewLabel.text || [self.datePreviewLabel.text isEqualToString:@""]) {
    self.datePreviewLabel.text = @"Select a date";
  } else {
    self.datePreviewLabel.text = self.dateString;
  }
}

- (void)datePickerSetup {
  NSDateFormatter *df = [[NSDateFormatter alloc] init];
  [df setDateFormat:@"dd.MM.yyyy"];
  NSDate *date = [df dateFromString:self.dateString];
  
  if (date) {
    [self.datePicker setDate:date animated:YES];
  }
}

#pragma mark - Additional

- (void)addTransitionToLabel:(UILabel *)label {
  CATransition *transition = [CATransition animation];
  transition.type = kCATransitionPush;
  transition.subtype = kCATransitionFromLeft;
  transition.duration = 0.3f;
  [label.layer addAnimation:transition forKey:nil];
}

#pragma mark - IBActions

- (IBAction)actionDatePicker:(UIDatePicker *)sender {
  NSDateFormatter *df = [[NSDateFormatter alloc] init];
  [df setDateFormat:@"dd.MM.yyyy"];
  [self addTransitionToLabel:self.datePreviewLabel];
  self.datePreviewLabel.text = [df stringFromDate:sender.date];
  
  if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
    [self.delegate datePicker:sender didChangeDate:sender.date];
  }
}

- (IBAction)actionDone:(UIButton *)sender {
  [self.delegate datePicker:self.datePicker didChangeDate:self.datePicker.date];
  [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)actionCancel:(UIButton *)sender {
  [self.delegate datePicker:nil didChangeDate:nil];
  [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)actionTapToClear:(UIButton *)sender {
  [self.delegate datePickerTapToClearButtonWasPressed:self.datePicker];
  [self dismissViewControllerAnimated:YES completion:nil];
}

@end
