//
//  ASEducationPopover.m
//  HW_36_UIPopoverController
//
//  Created by MD on 04.07.15.
//  Copyright (c) 2015 hh. All rights reserved.
//

#import "ASEducationPopover.h"
#import "MainViewController.h"



@implementation ASEducationPopover


- (void)viewDidLoad {
    [super viewDidLoad];
   
}

- (void)idReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - UIPickerViewDataSource

- (int)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

- (int)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if (self.dataForArray) {
        return [self.dataForArray count];
    }
    
    return 0;
}

- (NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    
    if (self.dataForArray) {
        return [self.dataForArray objectAtIndex:row];
    }
    
    return @"Default";
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    
    [self passDataBack:[self.dataForArray objectAtIndex:row]];
}


- (void)passDataBack:(NSString*) backString
{
    if ([_delegate respondsToSelector:@selector(dataFromEducationController:)])
    {
        [_delegate dataFromEducationController:backString];
    }
}

@end
