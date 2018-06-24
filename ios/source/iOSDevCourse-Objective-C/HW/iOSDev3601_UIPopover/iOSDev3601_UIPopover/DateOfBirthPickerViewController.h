//
//  DateOfBirthPickerViewController.h
//  iOSDev3601_UIPopover
//
//  Created by Oleg Tverdokhleb on 03.05.16.
//  Copyright © 2016 Oleg Tverdokhleb. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol DateOfBirthPickerDelegate;

@interface DateOfBirthPickerViewController : UIViewController
@property (strong, nonatomic) NSString *dateString;
@property (weak, nonatomic) id <DateOfBirthPickerDelegate> delegate;
@end

@protocol DateOfBirthPickerDelegate
@required
- (void)datePicker:(UIDatePicker *)datePicker didChangeDate:(NSDate *)date;
- (void)datePickerTapToClearButtonWasPressed:(UIDatePicker *)datePicker;
@end