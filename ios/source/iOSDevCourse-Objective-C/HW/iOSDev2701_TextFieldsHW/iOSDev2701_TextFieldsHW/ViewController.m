//
//  ViewController.m
//  iOSDev2701_TextFieldsHW
//
//  Created by Oleg Tverdokhleb on 23.04.16.
//  Copyright © 2016 Oleg Tverdokhleb. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UITextFieldDelegate>

@property (strong, nonatomic) IBOutletCollection(UITextField) NSArray *textFields;
@property (strong, nonatomic) IBOutletCollection(UILabel) NSArray *textLabels;

@property (weak, nonatomic) IBOutlet UILabel *nameTextLabel;
@property (weak, nonatomic) IBOutlet UILabel *lastnameTextLabel;
@property (weak, nonatomic) IBOutlet UILabel *loginTextLabel;
@property (weak, nonatomic) IBOutlet UILabel *passwordTextLabel;
@property (weak, nonatomic) IBOutlet UILabel *birthDateTextLabel;
@property (weak, nonatomic) IBOutlet UILabel *telNumberTextLabel;
@property (weak, nonatomic) IBOutlet UILabel *emailTextLabel;
@property (weak, nonatomic) IBOutlet UILabel *addressTextLabel;

- (IBAction)actionNameField:(UITextField *)sender;
- (IBAction)actionLastnameField:(UITextField *)sender;
- (IBAction)actionLoginField:(UITextField *)sender;
- (IBAction)actionPasswordField:(UITextField *)sender;
- (IBAction)actionBirthDateField:(UITextField *)sender;
- (IBAction)actionTelNumberField:(UITextField *)sender;
- (IBAction)actionEmailField:(UITextField *)sender;
- (IBAction)actionAddressField:(UITextField *)sender;

//additional for validations
- (IBAction)actionEmailFieldDidEndEditing:(UITextField *)sender;
@property (weak, nonatomic) IBOutlet UITextField *telNumberField;

@end

@implementation ViewController

#pragma mark - View lifecycles
- (void)viewDidLoad {
  [super viewDidLoad];
  // Do any additional setup after loading the view, typically from a nib.
  [self setup];
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

- (void)setup {
  for (UITextField *field in self.textFields) {
    field.delegate = self;
  }
  for (UILabel *label in self.textLabels) {
    label.text = @"";
  }
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

#pragma mark - Actions
- (IBAction)actionNameField:(UITextField *)sender {
  self.nameTextLabel.text = sender.text;
}

- (IBAction)actionLastnameField:(UITextField *)sender {
  self.lastnameTextLabel.text = sender.text;
}

- (IBAction)actionLoginField:(UITextField *)sender {
  self.loginTextLabel.text = sender.text;
}

- (IBAction)actionPasswordField:(UITextField *)sender {
  self.passwordTextLabel.text = sender.text;
}

- (IBAction)actionBirthDateField:(UITextField *)sender {
  self.birthDateTextLabel.text = sender.text;
}

- (IBAction)actionTelNumberField:(UITextField *)sender {
  self.telNumberTextLabel.text = sender.text;
}

- (IBAction)actionEmailField:(UITextField *)sender {
  self.emailTextLabel.text = sender.text;
}

- (IBAction)actionEmailFieldDidEndEditing:(UITextField *)sender {
  if (![self validateEmail:sender.text]) {
    sender.text = @"";
    self.emailTextLabel.text = @"";
    
    //alert
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"E-mail" message:@"Email is not validate" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
    [alert addAction:action];
    [self presentViewController:alert animated:YES completion:nil];
  }
}

- (IBAction)actionAddressField:(UITextField *)sender {
  self.addressTextLabel.text = sender.text;
}

#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
  if ([textField isEqual:self.textFields[7]]) {
    [textField resignFirstResponder];
  } else {
    [self.textFields[[self.textFields indexOfObject:textField] + 1] becomeFirstResponder];
  }
  return YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
  if ([textField isEqual:self.telNumberField]) {
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
  return YES;
}

@end