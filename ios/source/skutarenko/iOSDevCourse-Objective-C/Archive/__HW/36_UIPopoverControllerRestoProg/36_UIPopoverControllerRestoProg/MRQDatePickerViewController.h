//
//  MRQDatePickerViewController.h
//  36_UIPopoverControllerRestoProg
//
//  Created by Oleg Tverdokhleb on 20.12.15.
//  Copyright © 2015 Oleg Tverdokhleb. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MRQDatePickerDelegate;

@interface MRQDatePickerViewController : UIViewController

@property (weak, nonatomic) id <MRQDatePickerDelegate> delegate;

- (IBAction)doneButtonPressed:(UIButton *)sender;
- (IBAction)actionDatePickerValueChanged:(UIDatePicker *)sender;

@end

@protocol MRQDatePickerDelegate <NSObject>

- (void) didFinishChoiceDate:(NSString *) date;

@end