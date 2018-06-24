//
//  MainViewController.m
//  iOSDev3601_UIPopover
//
//  Created by Oleg Tverdokhleb on 03.05.16.
//  Copyright © 2016 Oleg Tverdokhleb. All rights reserved.
//

#import "MainTableViewController.h"
#import "InfoViewController.h"
#import "DateOfBirthPickerViewController.h"
#import "EducationViewController.h"

typedef NS_ENUM(NSUInteger, GenderImageControl) {
  GenderImageControlMale,
  GenderImageControlWoman
};

@interface MainTableViewController () <DateOfBirthPickerDelegate, EducationCheckBoxDelegate>

@property (weak, nonatomic) IBOutlet UITextField *nameField;
@property (weak, nonatomic) IBOutlet UITextField *lastnameField;
@property (weak, nonatomic) IBOutlet UITextField *dateOfBirthField;
@property (weak, nonatomic) IBOutlet UITextField *educationField;

- (IBAction)actionGenderControl:(UISegmentedControl *)sender;
- (IBAction)actionShowInfo:(UIButton *)sender;

@end

@implementation MainTableViewController

#pragma mark - Lifecycle

- (void)viewDidLoad {
  [super viewDidLoad];
  [self initSetup];
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  NSLog(@"%@ didReceiveMemoryWarning", self);
}
#pragma mark - Setups

- (void)initSetup {
  [self setImageToBackgroundTableView:GenderImageControlMale];
}

#pragma mark - Additional

- (void)showInfoController:(UIViewController *)vc {
  
  if ([vc isKindOfClass:[InfoViewController class]]) {
    InfoViewController *infoVC = (InfoViewController *)vc;
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
      
      infoVC.topDescriptionLabel = @"iOSDev3601_UIPopover iPhone";
      infoVC.centerDescriptionLabel = @"Test application for iPhone";
      infoVC.showOkButton = YES;
      infoVC.showNavigationBar = YES;
      infoVC.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
      
    } else if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
      
      infoVC.topDescriptionLabel = @"iOSDev3601_UIPopover iPad";
      infoVC.centerDescriptionLabel = @"Test application for iPad";
      infoVC.showOkButton = NO;
      infoVC.showNavigationBar = NO;
    }
  }
}

- (void)showDatePickerController {
  DateOfBirthPickerViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"DateOfBirthPickerViewController"];
  vc.delegate = self;
  vc.dateString = self.dateOfBirthField.text;
  
  if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
    
    [self presentViewController:vc animated:YES completion:nil];
    
  } else if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
    
    vc.modalPresentationStyle = UIModalPresentationPopover;
    
    UIPopoverPresentationController *pc = [vc popoverPresentationController];
    pc.permittedArrowDirections = UIPopoverArrowDirectionUp | UIPopoverArrowDirectionDown;
    pc.sourceView = self.dateOfBirthField;
    pc.sourceRect = self.dateOfBirthField.frame;
    [self presentViewController:vc animated:YES completion:nil];
  }
}

- (void)showEducationController {
  UINavigationController *nc = [self.storyboard instantiateViewControllerWithIdentifier:@"EducationViewController"];
  EducationViewController *vc = [nc.viewControllers firstObject];
  vc.delegate = self;
  vc.checkBoxText = self.educationField.text;
  
  if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
    
    [self presentViewController:nc animated:YES completion:nil];
  
  } else if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
    
    nc.modalPresentationStyle = UIModalPresentationPopover;
    nc.preferredContentSize = CGSizeMake(300, 300);
    
    UIPopoverPresentationController *pc = [nc popoverPresentationController];
    pc.permittedArrowDirections = UIPopoverArrowDirectionUp | UIPopoverArrowDirectionDown;
    pc.sourceView = self.educationField;
    pc.sourceRect = self.educationField.frame;
    [self presentViewController:nc animated:YES completion:nil];
  }
}

- (void)setImageToBackgroundTableView:(GenderImageControl)gender {
  if (gender == GenderImageControlMale) {
    UIImageView *image = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"male"]];
    image.contentMode = UIViewContentModeScaleAspectFit;
    self.tableView.backgroundView = image;
    self.tableView.backgroundView.alpha = 0.0f;
    [UIView animateWithDuration:0.3f animations:^{
      self.tableView.backgroundView.alpha = 1.0f;
    }];
  } else if (gender == GenderImageControlWoman) {
    UIImageView *image = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"woman"]];
    image.contentMode = UIViewContentModeScaleAspectFit;
    self.tableView.backgroundView = image;
    self.tableView.backgroundView.alpha = 0.0f;
    [UIView animateWithDuration:0.3f animations:^{
      self.tableView.backgroundView.alpha = 1.0f;
    }];
  }
}

#pragma mark - IBActions

- (IBAction)actionGenderControl:(UISegmentedControl *)sender {
  switch (sender.selectedSegmentIndex) {
    case GenderImageControlMale: {
      [self setImageToBackgroundTableView:GenderImageControlMale];
      break;
    }
    case GenderImageControlWoman: {
      [self setImageToBackgroundTableView:GenderImageControlWoman];
      break;
    }
    default: {
      NSLog(@"actionGenderControl switch default");
      break;
    }
  }
}

- (IBAction)actionShowInfo:(UIButton *)sender {
  [self performSegueWithIdentifier:@"showInfo" sender:sender];
}

#pragma mark - Segues

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
  if ([segue.destinationViewController isKindOfClass:[InfoViewController class]]) {
    [self showInfoController:segue.destinationViewController];
  }
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
  if ([textField isEqual:self.dateOfBirthField]) {
    [self showDatePickerController];
    NSLog(@"call date picker");
    return NO;
  } if ([textField isEqual:self.educationField]) {
    [self showEducationController];
    NSLog(@"call education table");
    return NO;
  } else {
    return YES;
  }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
  if ([textField isEqual:self.nameField]) {
    [self.lastnameField becomeFirstResponder];
  } else {
    [textField resignFirstResponder];
  }
  return YES;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
  cell.alpha = 0.8f;
}

#pragma mark - DateOfBirthPickerDelegate

- (void)datePicker:(UIDatePicker *)datePicker didChangeDate:(NSDate *)date {
  NSLog(@"%@", date);
  if (date) {
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    [df setDateFormat:@"dd.MM.yyyy"];
    self.dateOfBirthField.text = [df stringFromDate:date];
  }
}

- (void)datePickerTapToClearButtonWasPressed:(UIDatePicker *)datePicker {
  self.dateOfBirthField.text = @"";
}

#pragma mark - EducationCheckBoxDelegate

- (void)educationCheckBoxCell:(CheckboxTableViewCell *)checkBoxCell checkboxTextDidChanged:(NSString *)checkBoxText {
  NSLog(@"checkBoxText = %@", checkBoxText);
  self.educationField.text = checkBoxText;
}

@end
