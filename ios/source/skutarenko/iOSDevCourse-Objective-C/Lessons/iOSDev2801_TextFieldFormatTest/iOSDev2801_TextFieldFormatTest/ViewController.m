//
//  ViewController.m
//  iOSDev2801_TextFieldFormatTest
//
//  Created by Oleg Tverdokhleb on 24.04.16.
//  Copyright © 2016 Oleg Tverdokhleb. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UITextFieldDelegate>

@end

@implementation ViewController

#pragma mark - View lifecycles
- (void)viewDidLoad {
  [super viewDidLoad];
  // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

#pragma mark - UITextFieldDelegate
//- (BOOL)textFieldShouldReturn:(UITextField *)textField;

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
  //  NSLog(@"textField.text = %@", textField.text);
  //  NSLog(@"shouldChangeCharactersInRange = %@", NSStringFromRange(range));
  NSLog(@"replacementString = %@", string);
  
  NSCharacterSet *validationSet = [[NSCharacterSet decimalDigitCharacterSet] invertedSet];
  NSArray *components = [string componentsSeparatedByCharactersInSet:validationSet];
  
  if (components.count > 1) {
    return NO;
  }
  
  NSString *newString = [textField.text stringByReplacingCharactersInRange:range withString:string];
  NSLog(@"newString = %@", newString);
  
  NSArray *validComponents = [newString componentsSeparatedByCharactersInSet:validationSet];
  newString = [validComponents componentsJoinedByString:@""];

  static const int localNumberMaxLength = 7;
  static const int areaCodeMaxLength = 3;
  static const int countryCodeMaxLength = 3;
  
  if ([newString length] > localNumberMaxLength + areaCodeMaxLength + countryCodeMaxLength) {
    return NO;
  }
  
  /*
   NSCharacterSet *set = [[NSCharacterSet decimalDigitCharacterSet] invertedSet];
   NSArray *words = [resultString componentsSeparatedByCharactersInSet:set];
   NSLog(@"words = %@", words);
   return [resultString length] <= 10;
   */
  
  NSMutableString *resultString = [NSMutableString string];

  /*
   +XX (XXX) XXX-XXXX
   */
  
  NSInteger localNumberLength = MIN([newString length], localNumberMaxLength);
  
  //local number
  if (localNumberLength > 0) {
    NSString *number = [newString substringFromIndex:(int)[newString length] - localNumberLength];
    [resultString appendString:number];
    
    if ([resultString length] > 3) {
      [resultString insertString:@"-" atIndex:3];
    }
  }
  
  //area code
  if ([newString length] > localNumberMaxLength) {
    NSInteger areaCodeLength = MIN((int)[newString length] - localNumberMaxLength, areaCodeMaxLength);
    NSRange areaRange = NSMakeRange((int)[newString length] - localNumberMaxLength - areaCodeLength, areaCodeLength);
    NSString *area = [newString substringWithRange:areaRange];
    area = [NSString stringWithFormat:@"(%@) ", area];
    [resultString insertString:area atIndex:0];
  }
  
  //country code
  if ([newString length] > localNumberMaxLength + areaCodeMaxLength) {
    NSInteger countryCodeLength = MIN((int)[newString length] - localNumberMaxLength - areaCodeMaxLength, countryCodeMaxLength);
    NSRange countryCodeRange = NSMakeRange(0, countryCodeLength);
    NSString *countryCode = [newString substringWithRange:countryCodeRange];
    countryCode = [NSString stringWithFormat:@"+%@ ", countryCode];
    [resultString insertString:countryCode atIndex:0];
  }
  NSLog(@"resultString = %@", resultString);
  
  textField.text = resultString;
  
  return NO;
}

@end














