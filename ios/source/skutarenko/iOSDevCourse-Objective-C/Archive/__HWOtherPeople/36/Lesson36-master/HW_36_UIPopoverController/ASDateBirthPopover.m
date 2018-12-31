//
//  ASDateBirthPopover.m
//  HW_36_UIPopoverController
//
//  Created by MD on 04.07.15.
//  Copyright (c) 2015 hh. All rights reserved.
//

#import "ASDateBirthPopover.h"
#import "MainViewController.h"


@implementation ASDateBirthPopover

- (IBAction)pickerAction:(UIDatePicker *)sender {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    [dateFormatter setDateFormat:@"dd-MM-yyyy"];
    
    NSString *formatedDate = [dateFormatter stringFromDate:self.datePicker.date];
    
    [self passDataBack:formatedDate];
}


- (void)passDataBack:(NSString*) backString
{
    if ([_delegate respondsToSelector:@selector(dataFromDateBirthController:)])
    {
        [_delegate dataFromDateBirthController:backString];
    }
}


@end
