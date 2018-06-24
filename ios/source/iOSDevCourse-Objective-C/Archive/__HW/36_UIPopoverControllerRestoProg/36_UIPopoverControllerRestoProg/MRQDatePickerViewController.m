//
//  MRQDatePickerViewController.m
//  36_UIPopoverControllerRestoProg
//
//  Created by Oleg Tverdokhleb on 20.12.15.
//  Copyright © 2015 Oleg Tverdokhleb. All rights reserved.
//

#import "MRQDatePickerViewController.h"
#import "MRQMainTableViewController.h"

@interface MRQDatePickerViewController ()

@end

@implementation MRQDatePickerViewController

#pragma mark - LifeCycle

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void) dealloc {
    
    NSLog(@"MRQDatePickerViewController deallocated");
}

#pragma mark - Action

- (IBAction)doneButtonPressed:(UIButton *)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)actionDatePickerValueChanged:(UIDatePicker *)sender {

    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dd.MM.yy"];
    [self.delegate didFinishChoiceDate:[dateFormatter stringFromDate:sender.date]];
}
@end
