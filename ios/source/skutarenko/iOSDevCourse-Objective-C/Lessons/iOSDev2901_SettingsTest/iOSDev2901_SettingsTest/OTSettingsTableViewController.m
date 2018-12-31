//
//  OTSettingsTableViewController.m
//  iOSDev2901_SettingsTest
//
//  Created by Oleg Tverdokhleb on 24.04.16.
//  Copyright © 2016 Oleg Tverdokhleb. All rights reserved.
//

#import "OTSettingsTableViewController.h"

@interface OTSettingsTableViewController ()

@end

static NSString *const kSettingsLogin = @"login";
static NSString *const kSettingsPassword = @"password";
static NSString *const kSettingsLevel = @"level";
static NSString *const kSettingsShadow = @"shadow";
static NSString *const kSettingsDetalization = @"detalization";
static NSString *const kSettingsSound = @"sound";
static NSString *const kSettingsMusic = @"music";

@implementation OTSettingsTableViewController

#pragma mark - View lifecycles
- (void)viewDidLoad {
  [super viewDidLoad];
  [self loadSettings];
  [self addNotification];
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
}

- (void)dealloc {
  [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - Save and Load
- (void)saveSettings {
  NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
  
  [userDefaults setObject:self.loginField.text forKey:kSettingsLogin];
  [userDefaults setObject:self.passwordField.text forKey:kSettingsPassword];
  [userDefaults setInteger:self.levelControl.selectedSegmentIndex forKey:kSettingsLevel];
  [userDefaults setInteger:self.detalizationControl.selectedSegmentIndex forKey:kSettingsDetalization];
  [userDefaults setBool:self.shadowsSwitch.isOn forKey:kSettingsShadow];
  [userDefaults setFloat:self.soundSlider.value forKey:kSettingsSound];
  [userDefaults setFloat:self.musicSlider.value forKey:kSettingsMusic];
  
  [userDefaults synchronize];
}

- (void)loadSettings {
  NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
  
  self.loginField.text = [userDefaults objectForKey:kSettingsLogin];
  self.passwordField.text = [userDefaults objectForKey:kSettingsPassword];
  self.levelControl.selectedSegmentIndex = [userDefaults integerForKey:kSettingsLevel];
  self.detalizationControl.selectedSegmentIndex = [userDefaults integerForKey:kSettingsDetalization];
  self.shadowsSwitch.on = [userDefaults boolForKey:kSettingsShadow];
  self.soundSlider.value = [userDefaults floatForKey:kSettingsSound];
  self.musicSlider.value = [userDefaults floatForKey:kSettingsMusic];
}

#pragma mark - Actions
- (IBAction)actionTextChanged:(id)sender {
  [self saveSettings];
}

- (IBAction)actionValueChanged:(id)sender {
  [self saveSettings];
}
#pragma mark - Notification
- (void)addNotification {
  NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
  [nc addObserver:self selector:@selector(KeyboardWillShowNotification:) name:UIKeyboardWillShowNotification object:nil];
  [nc addObserver:self selector:@selector(KeyboardWillHideNotification:) name:UIKeyboardWillHideNotification object:nil];
}

- (void)KeyboardWillShowNotification:(NSNotification *)notification {
  NSLog(@"KeyboardWillShowNotification");
  NSLog(@"%@", notification.userInfo);
  
  
//  CGFloat keyboardHight =
  UIEdgeInsets inset = UIEdgeInsetsMake(0, 0, 216, 0);
  self.tableView.contentInset = inset;
}

- (void)KeyboardWillHideNotification:(NSNotification *)notification {
  NSLog(@"KeyboardWillHideNotification");
  NSLog(@"%@", notification.userInfo);
}

#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
  if ([textField isEqual:self.loginField]) {
    [self.passwordField becomeFirstResponder];
  } else {
    [textField resignFirstResponder];
  }
  return NO;
}

@end