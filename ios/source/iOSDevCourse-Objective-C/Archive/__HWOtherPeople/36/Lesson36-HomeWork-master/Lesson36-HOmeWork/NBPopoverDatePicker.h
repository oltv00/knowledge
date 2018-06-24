//
//  NBPopoverDatePicker.h
//  Lesson36-HOmeWork
//
//  Created by Nick Bibikov on 1/15/15.
//  Copyright (c) 2015 Nick Bibikov. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol NBPopoverDatePickerDelegate;

@interface NBPopoverDatePicker : UIViewController

@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;
- (IBAction)datePickerAction:(UIDatePicker *)sender;
@property (weak, nonatomic) id <NBPopoverDatePickerDelegate> delegate;

@end



@protocol NBPopoverDatePickerDelegate <NSObject>

- (void) NBPopoverDatePicker:(NBPopoverDatePicker*) popoverDatePicker dateBirth:(NSString*) dateBirthString howOldAreYou:(NSString*) howOldString;

@end
