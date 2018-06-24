//
//  DatePickerViewController.h
//  Lesson4
//
//  Created by Oleg Tverdokhleb on 05.02.16.
//  Copyright © 2016 Oleg Tverdokhleb. All rights reserved.
//

#import "ViewController.h"

@protocol DatePickerDelegate;

@interface DatePickerViewController : ViewController
@property (weak, nonatomic) id <DatePickerDelegate> delegate;
@end

@protocol DatePickerDelegate <NSObject>

@optional
- (void) DateValueWillChanged:(UIDatePicker *) picker;

@end