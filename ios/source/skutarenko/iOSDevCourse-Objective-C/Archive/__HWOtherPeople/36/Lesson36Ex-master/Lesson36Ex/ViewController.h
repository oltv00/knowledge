//
//  ViewController.h
//  Lesson36Ex
//
//  Created by Hopreeeeenjust on 01.02.15.
//  Copyright (c) 2015 Hopreeeeenjust. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UITableViewController
@property (weak, nonatomic) IBOutlet UITextField *firstNameField;
@property (weak, nonatomic) IBOutlet UITextField *lastNameField;
@property (weak, nonatomic) IBOutlet UISegmentedControl *genderControl;
@property (weak, nonatomic) IBOutlet UITextField *dateOfBirthField;
@property (weak, nonatomic) IBOutlet UITextField *educationField;
@property (weak, nonatomic) IBOutlet UIButton *infoButton;

- (IBAction)actionInfoButtonPressed:(UIButton *)infoButton;
- (IBAction)actionTextFieldTextChanged:(UITextField *)sender;
- (IBAction)actionGenderControlValueChanged:(UISegmentedControl *)sender;
@end

