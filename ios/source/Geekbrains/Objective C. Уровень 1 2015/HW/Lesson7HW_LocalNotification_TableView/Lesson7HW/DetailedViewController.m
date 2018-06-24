//
//  DetailedViewController.m
//  Lesson7HW
//
//  Created by Oleg Tverdokhleb on 07.02.16.
//  Copyright © 2016 Oleg Tverdokhleb. All rights reserved.
//

#import "Constants.h"
#import "DetailedViewController.h"

@interface DetailedViewController () <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UIDatePicker *datePickerChoice;
@property (weak, nonatomic) IBOutlet UITextField *textFieldSchedule;
@property (weak, nonatomic) IBOutlet UIButton *buttonSave;

- (IBAction)actionTextField:(UITextField *)sender;

@end

@implementation DetailedViewController

#pragma mark - VCLifeCycle

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setup];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    if (!self.isNewSchedule) {
        [self.datePickerChoice setDate:self.date animated:YES];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Setup

- (void)setup {
    
    if (self.isNewSchedule) {
        [self setupButtonSave];
        [self setupDatePicker];
        [self setupTextFieldSchedule];
    } else {
        self.buttonSave.alpha = 0.f;
        self.textFieldSchedule.text = self.stringCurrentSchedule;
        self.datePickerChoice.userInteractionEnabled = NO;
        self.textFieldSchedule.userInteractionEnabled = NO;
    }
}

- (void)setupButtonSave {
    self.buttonSave.enabled = NO;
    self.buttonSave.userInteractionEnabled = NO;
    [self.buttonSave addTarget:self
                        action:@selector(setLocalNotification)
              forControlEvents:UIControlEventTouchUpInside];
}

- (void)setupDatePicker {
    self.datePickerChoice.minimumDate = [NSDate date];
    [self.datePickerChoice addTarget:self
                              action:@selector(setDate)
                    forControlEvents:UIControlEventValueChanged];
}

- (void)setupTextFieldSchedule {
    [self.textFieldSchedule becomeFirstResponder];
}

#pragma mark - Additional methods

- (void)setDate {
    self.date = self.datePickerChoice.date;
    NSLog(@"%@", self.date);
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if ([textField isEqual:self.textFieldSchedule]) {
        [textField resignFirstResponder];
    }
    return YES;
}

#pragma mark - Action

- (IBAction)actionTextField:(UITextField *)sender {
    if (sender.text.length > 0) {
        self.buttonSave.userInteractionEnabled = YES;
        self.buttonSave.enabled = YES;
    } else {
        self.buttonSave.userInteractionEnabled = NO;
        self.buttonSave.enabled = NO;
    }
}

#pragma mark - UILocalNotification

- (void)setLocalNotification {

    if (!self.date) {
        
        [self alertChoiceTheDate];
        
    } else {
        
        UILocalNotification *localNotification = [[UILocalNotification alloc] init];
        
        localNotification.fireDate = self.date;
        localNotification.timeZone = [NSTimeZone defaultTimeZone];
        localNotification.alertBody = self.textFieldSchedule.text;
        localNotification.soundName = UILocalNotificationDefaultSoundName;
        
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"HH:mm dd.MM.yyyy"];
        NSString *stringDate = [dateFormatter stringFromDate:self.date];
        
        NSDictionary *userInfo = [NSDictionary
                                  dictionaryWithObjectsAndKeys:
                                  self.textFieldSchedule.text, kScheduleText,
                                  stringDate, kScheduleDate, nil];
        
        localNotification.userInfo = userInfo;
        localNotification.applicationIconBadgeNumber = [[UIApplication sharedApplication] applicationIconBadgeNumber] + 1;
        [[UIApplication sharedApplication] scheduleLocalNotification:localNotification];
        
        [self.navigationController popViewControllerAnimated:YES];
    }
}

#pragma mark - Alerts

- (void)alertChoiceTheDate {
    
    UIAlertController *ac = [UIAlertController alertControllerWithTitle:@"Date not choice!"
                                                                message:@"Choice the date please"
                                                         preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *defaultAction = [UIAlertAction actionWithTitle:@"OK"
                                                            style:UIAlertActionStyleDefault
                                                          handler:nil];
    [ac addAction:defaultAction];
    [self presentViewController:ac animated:YES completion:nil];
}

@end
























































