  //
//  ViewController.m
//  Lesson4
//
//  Created by Oleg Tverdokhleb on 04.02.16.
//  Copyright © 2016 Oleg Tverdokhleb. All rights reserved.
//

#import "ViewController.h"
#import "DatePickerViewController.h"

@interface ViewController () <UITextFieldDelegate, DatePickerDelegate>

@property (weak, nonatomic) IBOutlet UITextField *textField;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    
    DatePickerViewController *DatePicker = [self.storyboard instantiateViewControllerWithIdentifier:@"DatePickerViewController"];
    DatePicker.delegate = self;
    
    [self presentViewController:DatePicker animated:YES completion:nil];
    
    return NO;
}

#pragma mark - DatePickerDelegate

- (void) DateValueWillChanged:(UIDatePicker *) picker {
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"dd.MMM.yyyy";
    
    self.textField.text = [dateFormatter stringFromDate:picker.date];
}

@end
