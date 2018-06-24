//
//  OLTVDatePickerViewController.m
//  iOSDev4001_KVCHW
//
//  Created by Oleg Tverdokhleb on 19/05/16.
//  Copyright © 2016 oltv00. All rights reserved.
//

#import "OLTVDatePickerViewController.h"

@interface OLTVDatePickerViewController ()
@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;
@end

#pragma mark - Lifecycles

@implementation OLTVDatePickerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewDidAppear:(BOOL)animated {
  [super viewDidAppear:animated];
  
  if (self.pickerDate) {
    [self.datePicker setDate:self.pickerDate animated:YES];
  }
}

#pragma mark - Actions

- (IBAction)actionDatePickerValueChanged:(UIDatePicker *)sender {
  NSDateFormatter *df = [NSDateFormatter new];
  [df setDateFormat:@"dd.MM.yyyy"];
  [self.delegate datePicker:sender didChangeDate:[df stringFromDate:sender.date]];
}

- (IBAction)actionOKButton:(UIButton *)sender {
  [self dismissViewControllerAnimated:YES completion:nil];
}

@end
