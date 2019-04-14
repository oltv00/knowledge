//
//  ViewController.m
//  Lesson3
//
//  Created by Oleg Tverdokhleb on 30.01.16.
//  Copyright © 2016 Oleg Tverdokhleb. All rights reserved.
//

#import "ViewController.h"
#import "LogViewController.h"

@interface ViewController () <UITextFieldDelegate, LogViewDelegate>

@property (weak, nonatomic) IBOutlet UIView *colorView;
@property (weak, nonatomic) IBOutlet UITextField *numbersTextField;

- (IBAction)actionNumbersTextFieldValueChanged:(id)sender;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Action

- (IBAction)actionNumbersTextFieldValueChanged:(id)sender {
        
    NSInteger number = [self.numbersTextField.text integerValue];
    
    switch (number) {
        case 1: {
            [self.colorView setBackgroundColor:[UIColor redColor]];
            
            break;
        }
        case 2: {
            [self.colorView setBackgroundColor:[UIColor greenColor]];
            break;
        }
        case 3: {
            [self.colorView setBackgroundColor:[UIColor blueColor]];
        }
    }
}
@end
