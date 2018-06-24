//
//  ViewController.m
//  27_TextFieldsTestRestoProg
//
//  Created by Oleg Tverdokhleb on 20.11.15.
//  Copyright © 2015 Oleg Tverdokhleb. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UITextFieldDelegate>

@end

@implementation ViewController

#pragma mark VC methods

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Action methods

- (IBAction)actionTextFieldToLabel:(UITextField *)sender {
    
    for (UITextField *textField in self.textFields) {
        if ([textField isEqual:sender]) {
            UILabel *label;
            label = [self.textLabels objectAtIndex:[self.textFields indexOfObject:textField]];
            label.text = textField.text;
        }
    }
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    for (UITextField *checkingTestField in self.textFields) {
        if ([textField isEqual:checkingTestField]) {
            if ([textField isEqual:[self.textFields lastObject]]) {
                [textField resignFirstResponder];
            } else {
                [[self.textFields objectAtIndex:[self.textFields indexOfObject:textField] + 1] becomeFirstResponder];
                break;
            }
        }
    }
    
    return YES;
}
@end
