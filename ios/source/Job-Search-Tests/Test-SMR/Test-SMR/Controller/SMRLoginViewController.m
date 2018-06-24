//
//  SMRLoginViewController.m
//  Test-centr-delovih-innovacii
//
//  Created by Oleg Tverdokhleb on 11/12/2016.
//  Copyright © 2016 oltv00. All rights reserved.
//

#import "SMRLoginViewController.h"
#import "APIManager.h"
#import "Utils.h"



@interface SMRLoginViewController ()

@property (weak, nonatomic) IBOutlet UITextField *loginTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (assign, nonatomic) APIManagerServerResponse status;

@end

@implementation SMRLoginViewController

- (void)viewDidLoad {
  [super viewDidLoad];
}

#pragma mark - API

- (void)auth {
  NSString *login = self.loginTextField.text;
  NSString *password = self.passwordTextField.text;
  
  [[APIManager shared] authUserWithLogin:login password:password completion:^(APIManagerServerResponse status) {
    switch (status) {
      case APIManagerServerResponseSuccess: {
        [self.delegate SMRLoginDidFinishLogin];
        [self dismissViewControllerAnimated:YES completion:nil];
        break;
      }
        
      case APIManagerServerResponseWrongPassword: {
        dispatch_async(dispatch_get_main_queue(), ^{
          [UIAlertController showAlert:@"Ошибка" message:@"Неверный логин или пароль" inVC:self];
        });
        break;
      }
        
      default:
        dispatch_async(dispatch_get_main_queue(), ^{
          [UIAlertController showAlert:@"Ошибка сервера" message:@"" inVC:self];
        });
        break;
        
    }
  }];
}

#pragma mark - Action

- (IBAction)actionLogin:(UIButton *)sender {
  if ([self.loginTextField.text  isEqual: @""] || [self.passwordTextField.text  isEqual: @""]) {
    dispatch_async(dispatch_get_main_queue(), ^{
      [UIAlertController showAlert:@"Ошибка" message:@"Введите логин и пароль" inVC:self];
    });
  } else {
    [self auth];
  }
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
  if ([textField isEqual:self.loginTextField]) {
    [self.passwordTextField becomeFirstResponder];
  } else if ([textField isEqual:self.passwordTextField]) {
    [self.passwordTextField resignFirstResponder];
  }
  
  return YES;
}

@end
