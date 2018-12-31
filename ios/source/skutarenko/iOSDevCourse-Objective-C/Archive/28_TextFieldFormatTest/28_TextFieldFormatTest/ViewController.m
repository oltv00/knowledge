//
//  ViewController.m
//  28_TextFieldFormatTest
//
//  Created by Oleg Tverdokhleb on 21.11.15.
//  Copyright © 2015 Oleg Tverdokhleb. All rights reserved.
//

#import "ViewController.h"

typedef enum {
    phoneFieldType = 1
} TextFieldsType;

@interface ViewController ()

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

#pragma mark - UITextFieldDelegate

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    if (textField.tag == phoneFieldType) {
//        NSLog(@"Text Field text: %@", textField.text);
//        NSLog(@"shouldChangeCharactersInRange: %@", NSStringFromRange(range));
//        NSLog(@"replacementString: %@", string);

        NSCharacterSet *validationSet = [[NSCharacterSet decimalDigitCharacterSet] invertedSet];
        NSArray *components = [string componentsSeparatedByCharactersInSet:validationSet];
        
        if ([components count] > 1) {
            return NO;
        }
        
        NSString *needFormatString = [textField.text stringByReplacingCharactersInRange:range withString:string];
        
        
        
        
        
        /* Берем все числа (0-9) в decimalDigitCharacterSet, и делаем invertedSet
         * т.к. числа не должны быть разделителями
        NSCharacterSet *allNumbersSet = [[NSCharacterSet decimalDigitCharacterSet] invertedSet];
        NSArray *words = [resultString componentsSeparatedByCharactersInSet:testSet];
        NSLog(@"words: %@", words);
        */
        
        return [needFormatString length] <= 10;
    }
    
    return YES;
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    for (UITextField *checkTestField in self.textFields) {
        if ([checkTestField isEqual:textField]) {
            if ([textField isEqual:[self.textFields lastObject]]) {
                [textField resignFirstResponder];
            } else {
                [[self.textFields objectAtIndex:[self.textFields indexOfObject:textField] + 1] becomeFirstResponder];
            }
        }
    }
    
    return YES;
}


@end
