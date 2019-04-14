//
//  DatePickerViewController.m
//  Lesson4
//
//  Created by Oleg Tverdokhleb on 05.02.16.
//  Copyright © 2016 Oleg Tverdokhleb. All rights reserved.
//

#import "DatePickerViewController.h"

@interface DatePickerViewController ()

@property (weak, nonatomic) IBOutlet UIDatePicker *datePickerView;

- (IBAction)actionDoneButton:(id)sender;

@end

@implementation DatePickerViewController

#pragma mark - VCLifeCycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Action

- (IBAction)actionDoneButton:(id)sender {
    
    if ([self.delegate respondsToSelector:@selector(DateValueWillChanged:)]) {
        [self.delegate DateValueWillChanged:self.datePickerView];
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end