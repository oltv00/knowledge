//
//  MRQMainTableViewController.m
//  36_UIPopoverControllerRestoProg
//
//  Created by Oleg Tverdokhleb on 20.12.15.
//  Copyright © 2015 Oleg Tverdokhleb. All rights reserved.
//

#import "MRQMainTableViewController.h"
#import "MRQInfoModallyViewController.h"
#import "MRQDatePickerViewController.h"
#import "MRQEducationViewController.h"

@interface MRQMainTableViewController () <MRQDatePickerDelegate, MRQEducationDelegate, UITextFieldDelegate>

@end

@implementation MRQMainTableViewController

#pragma mark - LifeCycle

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Additional


#pragma mark - Navigation

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
}

#pragma mark - Action

#pragma mark - MRQDatePickerDelegate

- (void) didFinishChoiceDate:(NSString *) date {
    
    self.dateOfBirthTextField.text = date;
}

#pragma mark - MRQEducationDelegate

- (void) didFinishEducation:(NSString *) education {
    
    self.educationTextField.text = education;
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {

    if ([textField isEqual:self.name]) {
        [self.lastName becomeFirstResponder];
    }
    if ([textField isEqual:self.lastName]) {
        [textField resignFirstResponder];
    }
    return YES;
}


- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    
    if ([textField isEqual:self.dateOfBirthTextField]) {
        MRQDatePickerViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"MRQDatePickerViewController"];
        vc.delegate = self;
        [self presentViewController:vc animated:YES completion:nil];
        return NO;
    }
    
    if ([textField isEqual:self.educationTextField]) {
        MRQEducationViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"MRQEducationViewController"];
        vc.delegate = self;
        [self presentViewController:vc animated:YES completion:nil];
        return NO;
    }
    
    return YES;
}

@end
