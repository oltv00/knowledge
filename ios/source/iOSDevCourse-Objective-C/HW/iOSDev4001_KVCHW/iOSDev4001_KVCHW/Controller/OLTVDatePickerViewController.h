//
//  OLTVDatePickerViewController.h
//  iOSDev4001_KVCHW
//
//  Created by Oleg Tverdokhleb on 19/05/16.
//  Copyright © 2016 oltv00. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol OLTVDatePickerDelegate;

@interface OLTVDatePickerViewController : UIViewController

@property (strong, nonatomic) NSDate *pickerDate;
@property (weak, nonatomic) id <OLTVDatePickerDelegate> delegate;

- (IBAction)actionDatePickerValueChanged:(UIDatePicker *)sender;
- (IBAction)actionOKButton:(UIButton *)sender;

@end

@protocol OLTVDatePickerDelegate

@required
- (void)datePicker:(UIDatePicker *)datePicker didChangeDate:(NSString *)stringDate;

@end