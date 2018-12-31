//
//  ViewController.m
//  25_UIButtonsTestRestoProg
//
//  Created by Oleg Tverdokhleb on 15.11.15.
//  Copyright © 2015 Oleg Tverdokhleb. All rights reserved.
//

typedef enum {
    
    MRQEN_commaCalc         = 10, // ,
    MRQEN_ACCalc            = 11, // AC
    MRQEN_invertCalc        = 12, // +/-
    MRQEN_percentageCalc    = 13, // %
    MRQEN_divideCalc        = 14, // /
    MRQEN_multiplyCalc      = 15, // *
    MRQEN_minusCalc         = 16, // -
    MRQEN_plusCalc          = 17, // +
    MRQEN_equalCalc         = 18  // =
    
} MRQEN_Сalculations;

#import "ViewController.h"

@interface ViewController ()

@property (assign, nonatomic) NSInteger operation;
@property (assign, nonatomic) NSInteger firstNumber;
@property (assign, nonatomic) NSInteger secondNumber;
@property (assign, nonatomic) NSInteger resultNumber;

@property (assign, nonatomic) BOOL firstNumberWasChoicen;

@end

@implementation ViewController

#pragma mark - General methods

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setup];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Setup methods

- (void) setup {
    [self buttonSetup];
}

- (void) buttonSetup {
    
}

#pragma mark - Action methods

- (IBAction) numbersButton:(UIButton *) sender {

    if (self.firstNumberWasChoicen == NO) {
        self.firstNumber = [self shouldBeEnteredTheNumbersByTagOfSender:sender.tag];
    } else {
        self.secondNumber = [self shouldBeEnteredTheNumbersByTagOfSender:sender.tag];
    }
}

- (IBAction) actionsButton:(UIButton *) sender {
        [self calcResultWithTagOfSender:sender.tag];
}

#pragma mark - Helper methods

- (void) calcResultWithTagOfSender:(NSInteger) tagOfSender {

    switch (tagOfSender) {
        case MRQEN_commaCalc:
            self.indicatorLabel.text = @",";
            break;
        case MRQEN_ACCalc:
            self.indicatorLabel.text = @"0";
            self.firstNumberWasChoicen = NO;
            break;
        case MRQEN_invertCalc:
            self.indicatorLabel.text = @"+/-";
            break;
        case MRQEN_percentageCalc:
            self.indicatorLabel.text = @"%";
            break;
        case MRQEN_divideCalc:
            self.firstNumberWasChoicen = YES;
            self.resultNumber = self.firstNumber * self.secondNumber;
            break;
        case MRQEN_multiplyCalc:
            self.firstNumberWasChoicen = YES;
            self.resultNumber = self.firstNumber / self.secondNumber;
            break;
        case MRQEN_minusCalc:
            self.firstNumberWasChoicen = YES;
            self.resultNumber = self.firstNumber - self.secondNumber;
            break;
        case MRQEN_plusCalc:
            if (self.firstNumberWasChoicen == NO) {
                self.firstNumberWasChoicen = YES;
            } else {
                self.resultNumber = self.firstNumber + self.secondNumber;
            }
            break;
        default:
            break;
    }
    if (tagOfSender == MRQEN_equalCalc) {
        self.indicatorLabel.text = [NSString stringWithFormat:@"%ld", self.resultNumber];
        self.firstNumber = self.resultNumber;
    }
}

- (NSInteger) shouldBeEnteredTheOperationByTagOfSender:(NSInteger) senderOfTag {
    return senderOfTag;
}

- (NSInteger) shouldBeEnteredTheNumbersByTagOfSender:(NSInteger) TagOfSender  {
    if ([self.indicatorLabel.text isEqualToString:@"0"] ||
        self.firstNumberWasChoicen == YES) {
        self.indicatorLabel.text = @"";
    }
    NSString *string = [NSString stringWithFormat:@"%ld", TagOfSender];
    self.indicatorLabel.text = [self.indicatorLabel.text stringByAppendingString:string];
    return [self.indicatorLabel.text integerValue];
}

@end
