//
//  ViewController.m
//  27_TextFieldsTest
//
//  Created by Oleg Tverdokhleb on 20.11.15.
//  Copyright © 2015 Oleg Tverdokhleb. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

#pragma mark - VC methods

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setup];
    
    // При запуске фокус встает на loginTextField, и появляется клавиатура
    [self.loginTextField becomeFirstResponder];
    
    //Нотификации
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    [nc addObserver:self selector:@selector(notificationTextDidBeginEditing:) name:UITextFieldTextDidBeginEditingNotification object:nil];
    [nc addObserver:self selector:@selector(notificationTextDidEndEditing:) name:UITextFieldTextDidEndEditingNotification object:nil];
    [nc addObserver:self selector:@selector(notificationTextDidChangeEditing:) name:UITextFieldTextDidChangeNotification object:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void) dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - Setup methods

- (void) setup {
    [self codeTextFieldSetup];
}

- (void) codeTextFieldSetup {
    self.codeTextField.placeholder = @"placeholder";
    self.codeTextField.clearsOnBeginEditing = YES;
}

#pragma mark - Action methods

- (IBAction) actionLoginPressButton:(UIButton *)sender {
    
    NSLog(@"\nLogin: %@ \nPassword: %@", self.loginTextField.text, self.passwordTextField.text);
    
    if ([self.loginTextField isFirstResponder] || [self.passwordTextField isFirstResponder]) {
        for (UITextField *textField in self.view.subviews) {
            [textField resignFirstResponder];
        }
    }
}

- (IBAction)actionTextChanged:(UITextField *)sender {
    
    NSLog(@"%@", sender.text);
}

#pragma mark UITextFieldDelegate

//Добавление property delegate на View Controller сделано в storyboard

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    
    //return [textField isEqual:self.passwordTextField];
    return YES;
}

- (BOOL)textFieldShouldClear:(UITextField *)textField {
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    //FirstResoponder - объект на котором есть фокус, на который мы нажали
    //become - сделать активным
    //resign - убрать выделение
    
    if ([textField isEqual:self.loginTextField]) {
        [self.passwordTextField becomeFirstResponder];
    } else {
        [textField resignFirstResponder];
    }
    return YES;
}

#pragma mark - Notifications

- (void) notificationTextDidBeginEditing:(NSNotification *) notification {
    NSLog(@"notificationTextDidBeginEditing");
}

- (void) notificationTextDidEndEditing:(NSNotification *) notification {
    NSLog(@"notificationTextDidEndEditing");
}

- (void) notificationTextDidChangeEditing:(NSNotification *) notification {
    NSLog(@"notificationTextDidChangeEditing");
}

@end
