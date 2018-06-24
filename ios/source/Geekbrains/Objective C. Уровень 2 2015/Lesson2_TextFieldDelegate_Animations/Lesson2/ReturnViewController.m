//
//  ReturnViewController.m
//  Lesson2
//
//  Created by Oleg Tverdokhleb on 13.02.16.
//  Copyright © 2016 Oleg Tverdokhleb. All rights reserved.
//

#import "ReturnViewController.h"

@interface ReturnViewController ()
@property (weak, nonatomic) IBOutlet UITextField *textFieldLogin;
@property (weak, nonatomic) IBOutlet UITextField *textFieldPassword;

@property (weak, nonatomic) IBOutlet UITextField *textFieldMail;

@end

@implementation ReturnViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    if ([textField isEqual:self.textFieldLogin]) {
        [self.textFieldPassword becomeFirstResponder];
    } else
        if ([textField isEqual:self.textFieldPassword]) {
            [self.textFieldMail becomeFirstResponder];
        } else
            if ([textField isEqual:self.textFieldMail]) {
                [textField resignFirstResponder];
            }
    
    return YES;
}

@end
