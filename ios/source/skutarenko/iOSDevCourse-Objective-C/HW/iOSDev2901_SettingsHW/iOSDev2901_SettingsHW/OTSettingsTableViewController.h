//
//  OTSettingsTableViewController.h
//  iOSDev2901_SettingsHW
//
//  Created by Oleg Tverdokhleb on 24.04.16.
//  Copyright © 2016 Oleg Tverdokhleb. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OTSettingsTableViewController : UITableViewController <UITextFieldDelegate>

@property (strong, nonatomic) IBOutletCollection(UITextField) NSArray *textFields;

@property (weak, nonatomic) IBOutlet UITextField *nameField;
@property (weak, nonatomic) IBOutlet UITextField *lastnameField;
@property (weak, nonatomic) IBOutlet UITextField *loginField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;
@property (weak, nonatomic) IBOutlet UITextField *ageField;
@property (weak, nonatomic) IBOutlet UITextField *telNumberField;
@property (weak, nonatomic) IBOutlet UITextField *emailField;

- (IBAction)actionFieldsEditingChanged:(UITextField *)sender;
- (IBAction)actionEmailFieldDidEndEditing:(UITextField *)sender;

@end
