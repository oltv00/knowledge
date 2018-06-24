//
//  ViewController.m
//  iOSDev2701_TextFieldsTest
//
//  Created by Oleg Tverdokhleb on 23.04.16.
//  Copyright © 2016 Oleg Tverdokhleb. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *firstField;
@property (weak, nonatomic) IBOutlet UITextField *secondField;

- (IBAction)actionLog:(UIButton *)sender;
- (IBAction)actionTextChanged:(UITextField *)sender;

@end

@implementation ViewController

#pragma mark - View lifecycles
- (void)viewDidLoad {
  [super viewDidLoad];
  // Do any additional setup after loading the view, typically from a nib.
  
  [self.firstField becomeFirstResponder];
  [self addNotifications];
  
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

- (IBAction)actionLog:(UIButton *)sender {
  NSLog(@"first: %@, second: %@", self.firstField.text, self.secondField.text);
  
  if ([self.firstField isFirstResponder]) {
    [self.firstField resignFirstResponder];
  } else if ([self.secondField isFirstResponder]) {
    [self.secondField resignFirstResponder];
  }
}

- (IBAction)actionTextChanged:(UITextField *)sender {
  NSLog(@"%@", sender.text);
}

- (void)dealloc {
  [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - Notifications
/*
 UIKIT_EXTERN NSString *const UITextFieldTextDidBeginEditingNotification;
 UIKIT_EXTERN NSString *const UITextFieldTextDidEndEditingNotification;
 UIKIT_EXTERN NSString *const UITextFieldTextDidChangeNotification;
 */
- (void)addNotifications {
  NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
  [nc addObserver:self selector:@selector(notificationTextDidBeginEditing:) name:UITextFieldTextDidBeginEditingNotification object:nil];
  [nc addObserver:self selector:@selector(notificationTextidEndEditing:) name:UITextFieldTextDidEndEditingNotification object:nil];
  [nc addObserver:self selector:@selector(notificationTextDidChangeEditing:) name:UITextFieldTextDidChangeNotification object:nil];
}

- (void)notificationTextDidBeginEditing:(NSNotification *)notification {
  NSLog(@"notificationTextDidBeginEditing");
}

- (void)notificationTextidEndEditing:(NSNotification *)notification {
  NSLog(@"notificationTextidEndEditing");
}

- (void)notificationTextDidChangeEditing:(NSNotification *)notification {
  NSLog(@"notificationTextDidChangeEditing");
}

#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldClear:(UITextField *)textField {
  if ([textField isEqual:self.firstField]) {
    return YES;
  } else {
    return NO;
  }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
  if ([textField isEqual:self.firstField]) {
    [self.secondField becomeFirstResponder];
  } else {
    [textField resignFirstResponder];
  }
  return YES;
}

@end
