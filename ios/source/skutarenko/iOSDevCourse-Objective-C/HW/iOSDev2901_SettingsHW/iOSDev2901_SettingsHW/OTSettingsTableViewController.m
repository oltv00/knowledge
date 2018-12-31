//
//  OTSettingsTableViewController.m
//  iOSDev2901_SettingsHW
//
//  Created by Oleg Tverdokhleb on 24.04.16.
//  Copyright © 2016 Oleg Tverdokhleb. All rights reserved.
//

#import "OTSettingsTableViewController.h"

static NSString *kSettingsName = @"name";
static NSString *kSettingsLastname = @"lastname";
static NSString *kSettingsLogin = @"login";
static NSString *kSettingsPassword = @"password";
static NSString *kSettingsAge = @"age";
static NSString *kSettingsTelNumber = @"telNumber";
static NSString *kSettingsEmail = @"email";

@interface OTSettingsTableViewController ()

@end

@implementation OTSettingsTableViewController

#pragma mark - View lifecycles
- (void)viewDidLoad {
  [super viewDidLoad];
  [self insetsFix];
  [self addfieldsDelegate];
  [self loadSettings];
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
}

- (void)insetsFix {
  UIEdgeInsets inset = UIEdgeInsetsMake(20, 0, 0, 0);
  self.tableView.contentInset = inset;
  self.tableView.scrollIndicatorInsets = inset;
}

- (void)addfieldsDelegate {
  for (UITextField *field in self.textFields) {
    field.delegate = self;
  }
}

#pragma mark - Save and Load
- (void)saveSettings {
  NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
  
  [userDefaults setObject:self.nameField.text forKey:kSettingsName];
  [userDefaults setObject:self.lastnameField.text forKey:kSettingsLastname];
  [userDefaults setObject:self.loginField.text forKey:kSettingsLogin];
  [userDefaults setObject:self.passwordField.text forKey:kSettingsPassword];
  [userDefaults setObject:self.ageField.text forKey:kSettingsAge];
  [userDefaults setObject:self.telNumberField.text forKey:kSettingsTelNumber];
  [userDefaults setObject:self.emailField.text forKey:kSettingsEmail];
  
  [userDefaults synchronize];
}

- (void)loadSettings {
  NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
  
  self.nameField.text = [userDefaults objectForKey:kSettingsName];
  self.lastnameField.text = [userDefaults objectForKey:kSettingsLastname];
  self.loginField.text = [userDefaults objectForKey:kSettingsLogin];
  self.passwordField.text = [userDefaults objectForKey:kSettingsPassword];
  self.ageField.text = [userDefaults objectForKey:kSettingsAge];
  self.telNumberField.text = [userDefaults objectForKey:kSettingsTelNumber];
  self.emailField.text = [userDefaults objectForKey:kSettingsEmail];
}

#pragma mark - Additional
- (BOOL)validateEmail:(NSString *)candidate {
  NSString *emailRegex =
  @"(?:[a-z0-9!#$%\\&'*+/=?\\^_`{|}~-]+(?:\\.[a-z0-9!#$%\\&'*+/=?\\^_`{|}"
  @"~-]+)*|\"(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21\\x23-\\x5b\\x5d-\\"
  @"x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])*\")@(?:(?:[a-z0-9](?:[a-"
  @"z0-9-]*[a-z0-9])?\\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\\[(?:(?:25[0-5"
  @"]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-"
  @"9][0-9]?|[a-z0-9-]*[a-z0-9]:(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21"
  @"-\\x5a\\x53-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])+)\\])";
  NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES[c] %@", emailRegex];
  
  return [emailTest evaluateWithObject:candidate];
}

- (BOOL)telephoneNumberValidate:(NSString *)string textField:(UITextField *)textField range:(NSRange)range{
  NSCharacterSet* validationSet = [[NSCharacterSet decimalDigitCharacterSet] invertedSet];
  NSArray* components = [string componentsSeparatedByCharactersInSet:validationSet];
  
  if ([components count] > 1) {
    return NO;
  }
  
  NSString* newString = [textField.text stringByReplacingCharactersInRange:range withString:string];
  NSArray* validComponents = [newString componentsSeparatedByCharactersInSet:validationSet];
  newString = [validComponents componentsJoinedByString:@""];
  
  static const int localNumberMaxLength = 7;
  static const int areaCodeMaxLength = 3;
  static const int countryCodeMaxLength = 3;
  
  if ([newString length] > localNumberMaxLength + areaCodeMaxLength + countryCodeMaxLength) {
    return NO;
  }
  
  NSMutableString* resultString = [NSMutableString string];
  NSInteger localNumberLength = MIN([newString length], localNumberMaxLength);
  
  if (localNumberLength > 0) {
    NSString* number = [newString substringFromIndex:(int)[newString length] - localNumberLength];
    [resultString appendString:number];
    
    if ([resultString length] > 3) {
      [resultString insertString:@"-" atIndex:3];
    }
  }
  
  if ([newString length] > localNumberMaxLength) {
    NSInteger areaCodeLength = MIN((int)[newString length] - localNumberMaxLength, areaCodeMaxLength);
    NSRange areaRange = NSMakeRange((int)[newString length] - localNumberMaxLength - areaCodeLength, areaCodeLength);
    NSString* area = [newString substringWithRange:areaRange];
    area = [NSString stringWithFormat:@"(%@) ", area];
    [resultString insertString:area atIndex:0];
  }
  
  if ([newString length] > localNumberMaxLength + areaCodeMaxLength) {
    NSInteger countryCodeLength = MIN((int)[newString length] - localNumberMaxLength - areaCodeMaxLength, countryCodeMaxLength);
    NSRange countryCodeRange = NSMakeRange(0, countryCodeLength);
    NSString* countryCode = [newString substringWithRange:countryCodeRange];
    countryCode = [NSString stringWithFormat:@"+%@ ", countryCode];
    [resultString insertString:countryCode atIndex:0];
  }
  textField.text = resultString;
  return NO;
}

#pragma mark - Actions
- (IBAction)actionFieldsEditingChanged:(id)sender {
  [self saveSettings];
}

- (IBAction)actionEmailFieldDidEndEditing:(UITextField *)sender {
  if (![self validateEmail:sender.text] && ![sender.text isEqualToString:@""]) {
    sender.text = @"";
    
    //alert
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"E-mail" message:@"Email is not validate, please try again" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
    [alert addAction:action];
    [self presentViewController:alert animated:YES completion:nil];
  }
}

#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
  if ([textField isEqual:self.textFields[6]]) {
    [textField resignFirstResponder];
  } else {
    [self.textFields[[self.textFields indexOfObject:textField] + 1] becomeFirstResponder];
  }
  return YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
  if ([textField isEqual:self.telNumberField]) {
    return [self telephoneNumberValidate:string textField:textField range:range];
  }
  return YES;
}

@end
