//
//  NBTableViewController.m
//  Lesson36-HOmeWork
//
//  Created by Nick Bibikov on 1/13/15.
//  Copyright (c) 2015 Nick Bibikov. All rights reserved.
//

#import "NBTableViewController.h"
#import "CSAnimationView.h"

@interface NBTableViewController ()

@property (strong, nonatomic) NBPopoverDatePicker* datePicker;

@end

static NSString* kSettingsFirstName              = @"firsName";
static NSString* kSettingsLastName               = @"lastName";
static NSString* kSettingsGenderSegmentedControl = @"genderSegmentedControl";
static NSString* kSettingsDateOfBirthTextField   = @"dateOfBirthTextField";
static NSString* kSettingsYearsOldTextField      = @"yearsOldTextField";
static NSString* kSettingsEducationTextField     = @"educationTextField";

@implementation NBTableViewController


- (void)viewDidLoad {
    [super viewDidLoad];

}


- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    UITapGestureRecognizer *gestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyboard)];
    [self.tableView addGestureRecognizer:gestureRecognizer];
    
    [self loadSettings];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}


#pragma mark - UITextFieldDelegate
//TODO: Date picker and education picker

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    
    if (textField.tag == 3) {
        
        NBPopoverDatePicker* vc = [self.storyboard instantiateViewControllerWithIdentifier:@"NBPopoverDatePicker"];
        
        vc.delegate = self;
        
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
            
            UIPopoverController* popover = [[UIPopoverController alloc] initWithContentViewController:vc];
            
            CGRect frame = [textField convertRect:textField.bounds toView:self.view];
            
            [popover presentPopoverFromRect:frame
                                     inView:self.view
                   permittedArrowDirections:UIPopoverArrowDirectionAny
                                   animated:YES];
            
        } else {
            
            [self presentViewController:vc animated:YES completion:nil];
        }
        
        return NO;
    
    } else if (textField.tag == 4 ) {
        return NO;
    
    } else if (textField.tag == 5) {
        return NO;
    
    }else return YES;
}



- (void)textFieldDidEndEditing:(UITextField *)textField {
    
    NSUserDefaults* userDefaults = [NSUserDefaults standardUserDefaults];
    
    if (textField.tag == 1) {
        [userDefaults setObject:textField.text forKey:kSettingsFirstName];
        
    } else if (textField.tag == 2) {
        [userDefaults setObject:textField.text forKey:kSettingsLastName];
        
    }
    
    [userDefaults synchronize];
}


#pragma mark - Help Methods

- (void) hideKeyboard {
    
    [self.firstNameTextField resignFirstResponder];
    [self.lastNameTextField resignFirstResponder];
    [self.dateOfBirthTextField resignFirstResponder];
    [self.educationTextField resignFirstResponder];
}

- (void) loadSettings {
    
    NSUserDefaults* userDefaults                     = [NSUserDefaults standardUserDefaults];

    self.firstNameTextField.text                     = [userDefaults objectForKey:kSettingsFirstName];
    self.lastNameTextField.text                      = [userDefaults objectForKey:kSettingsLastName];
    self.genderSegmentedControl.selectedSegmentIndex = [userDefaults integerForKey:kSettingsGenderSegmentedControl];
    self.dateOfBirthTextField.text                   = [userDefaults objectForKey:kSettingsDateOfBirthTextField];
    self.yearsOldTextField.text                      = [userDefaults objectForKey:kSettingsYearsOldTextField];
    self.educationTextField.text                     = [userDefaults objectForKey:kSettingsEducationTextField];
}




#pragma mark - Actions

- (IBAction)genderSegmentedControlAction:(UISegmentedControl *)sender {
    
    NSUserDefaults* userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setInteger:sender.selectedSegmentIndex forKey:kSettingsGenderSegmentedControl];
}



#pragma mark - UITableViewDelegate

- (BOOL)tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return NO;
}



#pragma mark - NBPopoverDatePickerDelegate

- (void) NBPopoverDatePicker:(NBPopoverDatePicker*) popoverDatePicker dateBirth:(NSString*) dateBirthString howOldAreYou:(NSString*) howOldString {
    
    NSUserDefaults* userDefaults = [NSUserDefaults standardUserDefaults];
    
    [userDefaults setObject:dateBirthString forKey:kSettingsDateOfBirthTextField];
    [userDefaults setObject:howOldString forKey:kSettingsYearsOldTextField];
    
    [self loadSettings];
    
}

@end
