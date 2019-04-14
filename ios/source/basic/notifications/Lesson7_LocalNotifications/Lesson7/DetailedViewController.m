//
//  DetailedViewController.m
//  Lesson7
//
//  Created by Oleg Tverdokhleb on 07.02.16.
//  Copyright © 2016 Oleg Tverdokhleb. All rights reserved.
//

#import "DetailedViewController.h"

@interface DetailedViewController () <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *textFieldSchedule;
@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;
@property (weak, nonatomic) IBOutlet UIButton *buttonSave;

- (IBAction)actionTextFieldEditingChanged:(UITextField *)sender;

@end

@implementation DetailedViewController

#pragma mark - VCLifeCycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setup];
}

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    if (!self.isNewEvent) {
        [self setEventDate];
    }
}

- (void) setup {

    
    if (self.isNewEvent) {
        
        [self.textFieldSchedule becomeFirstResponder];
        
        self.buttonSave.enabled = NO;
        self.buttonSave.alpha = 1.f;
        [self.buttonSave addTarget:self
                            action:@selector(setLocalNotification)
                  forControlEvents:UIControlEventTouchUpInside];
        
        self.datePicker.minimumDate = [NSDate date];
        [self.datePicker addTarget:self
                            action:@selector(setDate)
                  forControlEvents:UIControlEventValueChanged];
        
    } else {
        
        self.buttonSave.alpha = 0.f;
        self.datePicker.userInteractionEnabled = NO;
        self.textFieldSchedule.userInteractionEnabled = NO;
        self.textFieldSchedule.text = self.currentEvent;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Additional methods

- (void)setDate {
    self.date = self.datePicker.date;
    NSLog(@"date: %@", self.date);
}

- (void)setEventDate {
    if (self.date) {
        [self.datePicker setDate:self.date animated:YES];
    }
}

#pragma mark - Action

- (IBAction)actionTextFieldEditingChanged:(UITextField *)sender {
    
    if (sender.text.length == 0) {
        self.buttonSave.enabled = NO;
    } else {
        self.buttonSave.enabled = YES;
    }
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    if ([textField isEqual:self.textFieldSchedule] && textField.text.length > 0) {
        [textField resignFirstResponder];
        return YES;
    }
    return NO;
}

#pragma mark - UILocalNotification

- (void)setLocalNotification {
    
    if (!self.date) {
        
        UIAlertController *AC = [UIAlertController
                                 alertControllerWithTitle:@"ВНИМАНИЕ!"
                                 message:@"Крути барабан"
                                 preferredStyle:UIAlertControllerStyleAlert];

        UIAlertAction *defaultAction = [UIAlertAction
                                        actionWithTitle:@"OK"
                                        style:UIAlertActionStyleDefault
                                        handler:nil];
        
        [AC addAction:defaultAction];
        [self presentViewController:AC
                           animated:YES
                         completion:nil];
    } else {
        
        UILocalNotification *localNotification = [[UILocalNotification alloc] init];
        localNotification.fireDate = self.date;
        localNotification.timeZone = [NSTimeZone defaultTimeZone];
        localNotification.alertBody = self.textFieldSchedule.text;
        
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"dd.MMMM.yyyy HH:mm"];
        
        NSString *stringDate = [dateFormatter stringFromDate:self.date];
        
        NSDictionary *userInfo = [NSDictionary
                                  dictionaryWithObjectsAndKeys:
                                  self.textFieldSchedule.text, @"event",
                                  stringDate, @"eventDate", nil];
        NSLog(@"%@", userInfo);
        localNotification.userInfo = userInfo;
        localNotification.soundName = UILocalNotificationDefaultSoundName;
        
        localNotification.applicationIconBadgeNumber = [[UIApplication sharedApplication] applicationIconBadgeNumber] + 1;
        [[UIApplication sharedApplication] scheduleLocalNotification:localNotification];
        
        [self.navigationController popViewControllerAnimated:YES];
    }
}

@end
