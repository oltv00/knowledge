//
//  NBTableViewController.h
//  Lesson36-HOmeWork
//
//  Created by Nick Bibikov on 1/13/15.
//  Copyright (c) 2015 Nick Bibikov. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NBPopoverDatePicker.h"

@protocol NBPopoverDatePickerDelegate;

@interface NBTableViewController : UITableViewController <UITextFieldDelegate, NBPopoverDatePickerDelegate>

- (IBAction)genderSegmentedControlAction:(UISegmentedControl *)sender;

@property (weak, nonatomic) IBOutlet UITextField *firstNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *lastNameTextField;
@property (weak, nonatomic) IBOutlet UISegmentedControl *genderSegmentedControl;
@property (weak, nonatomic) IBOutlet UITextField *dateOfBirthTextField;
@property (weak, nonatomic) IBOutlet UITextField *educationTextField;
@property (weak, nonatomic) IBOutlet UITextField *yearsOldTextField;


@end
