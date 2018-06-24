//
//  MRQEducationViewController.m
//  36_UIPopoverControllerRestoProg
//
//  Created by Oleg Tverdokhleb on 21.12.15.
//  Copyright © 2015 Oleg Tverdokhleb. All rights reserved.
//

#import "MRQEducationViewController.h"

@interface MRQEducationViewController ()

@end

@implementation MRQEducationViewController

#pragma mark - LifeCycle

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setup];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void) dealloc {
    
    NSLog(@"MRQEducationViewController deallocated");
}

#pragma mark - Setup

- (void) setup {
    
}

#pragma mark - Action

- (IBAction)doneButtonPressed:(UIButton *)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - UIPickerViewDataSource

// returns the number of 'columns' to display.
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

// returns the # of rows in each component..
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return 4;
}

#pragma mark - UIPickerViewDelegate

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    
    NSString *pickerString = [self pickerView:pickerView titleForRow:row forComponent:component];
    [self.delegate didFinishEducation:pickerString];
}

- (nullable NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    
    switch (row) {
        case 0:
            return @"Incomplete secondary";
            break;
        case 1:
            return @"Secondary";
            break;
        case 2:
            return @"Incomplete higher";
            break;
        case 3:
            return @"Higher";
            break;
        default:
            break;
    }
    
    return nil;
}

@end
