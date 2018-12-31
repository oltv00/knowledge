//
//  ViewController.m
//  Lesson36Ex
//
//  Created by Hopreeeeenjust on 01.02.15.
//  Copyright (c) 2015 Hopreeeeenjust. All rights reserved.
//

#import "ViewController.h"
#import "RJInfoViewController.h"
#import "RJDatePickerViewController.h"
#import "RJEducationViewController.h"

@interface ViewController () <UITextFieldDelegate, RJDatePickerViewDelegate, RJEducationViewDelegate>
@property (strong, nonatomic) UIPopoverController* popover;
@property (strong, nonatomic) NSIndexPath *indexPath;
@property (strong, nonatomic) NSDate *date;
@end

static NSString *kNameFieldSetting = @"nameFieldSettings";
static NSString *kSurnameFieldSetting = @"surnameFieldSettings";
static NSString *kGenderControlSetting = @"genderControlSettings";
static NSString *kBirthDateFieldSetting = @"birthDateFieldSetting";
static NSString *kEducationFieldSetting = @"educationFieldSetting";
static NSString *kDateValueSetting = @"dateValueSetting";
static NSString *kIndexPathSectionValueSetting = @"indexPathSectionValueSetting";
static NSString *kIndexPathRowValueSetting = @"indexPathRowValueSetting";

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadSettings];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Actions 

- (IBAction)actionInfoButtonPressed:(UIButton *)infoButton {
    RJInfoViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"InfoController"];
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        UIPopoverController *popover = [[UIPopoverController alloc] initWithContentViewController:vc];
        popover.popoverContentSize = CGSizeMake(400, 400);
        CGRect infoButtonRect = [self.tableView convertRect:self.infoButton.frame fromView:vc.navigationController.view];
        infoButtonRect.origin.y = -32;
        [popover presentPopoverFromRect:infoButtonRect
                                 inView:self.tableView
               permittedArrowDirections:UIPopoverArrowDirectionUp
                               animated:YES];
    } else {
        [self presentViewController:vc animated:YES completion:nil];
    }
}

- (IBAction)actionTextFieldTextChanged:(UITextField *)sender {
    [self saveSettings];
}

- (IBAction)actionGenderControlValueChanged:(UISegmentedControl *)sender {
    [self saveSettings];
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    if (textField == self.dateOfBirthField) {                      //setting dateOfBirth
        RJDatePickerViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"RJDatePickerViewController"];
        vc.delegate = self;
        if (self.date) {
            vc.dateOfBirth = self.date;
        }
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
            UIPopoverController *popover = [[UIPopoverController alloc] initWithContentViewController:nav];
            popover.popoverContentSize = CGSizeMake(300, 250);
            CGRect dateOfBirthRect = [self.tableView convertRect:textField.frame fromView:textField.superview];
            [popover presentPopoverFromRect:dateOfBirthRect
                                     inView:self.tableView
                   permittedArrowDirections:UIPopoverArrowDirectionUp
                                   animated:YES];
        } else {
            [self presentViewController:nav animated:YES completion:nil];
        }
        return NO;
    } else if (textField == self.educationField) {                  //setting education
        RJEducationViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"RJEducationViewController"];
        vc.delegate = self;
        if (self.educationField.text) {
            vc.lastIndexPath = self.indexPath;
            vc.education = self.educationField.text;
        }
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
            UIPopoverController *popover = [[UIPopoverController alloc] initWithContentViewController:nav];
            popover.popoverContentSize = CGSizeMake(400, 320);
            CGRect educationRect = [self.tableView convertRect:textField.frame fromView:textField.superview];
            [popover presentPopoverFromRect:educationRect
                                     inView:self.tableView
                   permittedArrowDirections:UIPopoverArrowDirectionUp
                                   animated:YES];
        } else {
            [self presentViewController:nav animated:YES completion:nil];
        }
        return NO;
    } else {
        return YES;
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    return [textField resignFirstResponder];
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - RJDatePickerViewDelegate

- (void)didFinishEditingDate:(NSDate *)date {
        self.date = date;
        [self saveSettings];
        NSDateFormatter *formatter = [NSDateFormatter new];
        [formatter setDateFormat:@"dd/MMM/yyyy"];
        self.dateOfBirthField.text = [formatter stringFromDate:date];
        [self.tableView reloadData];
}

#pragma mark - RJEducationViewDelegate

- (void)didChoseEducation:(NSString *)education atIndexPath:(NSIndexPath *)indexPath {
    self.educationField.text = education;
    self.indexPath = indexPath;
    [self saveSettings];
    [self.tableView reloadData];
}

#pragma mark - Methods

- (void)saveSettings {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:self.firstNameField.text forKey:kNameFieldSetting];
    [defaults setObject:self.lastNameField.text forKey:kSurnameFieldSetting];
    [defaults setInteger:self.genderControl.selectedSegmentIndex forKey:kGenderControlSetting];
    [defaults setObject:self.dateOfBirthField.text forKey:kBirthDateFieldSetting];
    [defaults setObject:self.educationField.text forKey:kEducationFieldSetting];
    [defaults setValue:self.date forKey:kDateValueSetting];
    [defaults setInteger:self.indexPath.section forKey:kIndexPathSectionValueSetting];
    [defaults setInteger:self.indexPath.row forKey:kIndexPathRowValueSetting];
    [defaults synchronize];
}

- (void)loadSettings {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    self.firstNameField.text = [defaults objectForKey:kNameFieldSetting];
    self.lastNameField.text = [defaults objectForKey:kSurnameFieldSetting];
    self.genderControl.selectedSegmentIndex = [defaults integerForKey:kGenderControlSetting];
    self.dateOfBirthField.text = [defaults objectForKey:kBirthDateFieldSetting];
    self.educationField.text = [defaults objectForKey:kEducationFieldSetting];
    self.date = [defaults valueForKey:kDateValueSetting];
    NSInteger section = [defaults integerForKey:kIndexPathSectionValueSetting];
    NSInteger row = [defaults integerForKey:kIndexPathRowValueSetting];
    self.indexPath = [NSIndexPath indexPathForRow:row inSection:section];
}


@end
