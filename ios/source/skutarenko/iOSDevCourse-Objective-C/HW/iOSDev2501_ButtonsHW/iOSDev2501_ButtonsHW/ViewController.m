//
//  ViewController.m
//  iOSDev2501_ButtonsHW
//
//  Created by Oleg Tverdokhleb on 22.04.16.
//  Copyright © 2016 Oleg Tverdokhleb. All rights reserved.
//

#import "ViewController.h"

typedef NS_ENUM(NSInteger, OperationSignType) {
    OperationSignTypePlus,
    OperationSignTypeMinus,
    OperationSignTypeMultiply,
    OperationSignTypeDivide,
};

@interface ViewController ()

@property (assign, nonatomic) BOOL stillTyping;
@property (assign, nonatomic) BOOL dotIsPlaced;
@property (assign, nonatomic) double firstOperand;
@property (assign, nonatomic) double secondOperand;
@property (assign, nonatomic) double currentInput;
@property (assign, nonatomic) OperationSignType operationSign;

@end

@implementation ViewController

#pragma mark - View lifecycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.stillTyping = NO;
    self.dotIsPlaced = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Private

- (double)currentInput {
    return [self.displayResultLabel.text doubleValue];
}

- (void)setCurrentInput:(double)currentInput {
    NSString *value = [NSString stringWithFormat:@"%f", currentInput];
    NSArray *valueArray = [value componentsSeparatedByString:@"."];
    
    NSString *left = valueArray[0];
    NSString *right = valueArray[1];
    
    if ([right intValue] == 0) {
        self.displayResultLabel.text = valueArray[0];
    } else {
        //magic...
        for (int i = (int)right.length-1; i >= 0; i -= 1) {
            if ([right characterAtIndex:i] != '0') {
                right = [right substringToIndex:i+1];
                break;
            }
        }
        self.displayResultLabel.text = [NSString stringWithFormat:@"%@.%@", left, right];
    }
    self.stillTyping = NO;
}

#pragma mark - Action
- (IBAction)actionNumberPressed:(UIButton *)sender {
    double number = [sender.currentTitle doubleValue];
    
    if (self.stillTyping) {
        if (self.displayResultLabel.text.length < 15) {
            self.displayResultLabel.text = [NSString stringWithFormat:@"%@%1.0f", self.displayResultLabel.text, number];
        }
    } else {
        self.displayResultLabel.text = [NSString stringWithFormat:@"%1.0f", number];
        self.stillTyping = YES;
    }
}

- (IBAction)actionClearButtonPressed:(UIButton *)sender {
    self.firstOperand = 0;
    self.secondOperand = 0;
    self.currentInput = 0;
    self.displayResultLabel.text = @"0";
    self.stillTyping = NO;
    self.dotIsPlaced = NO;
    self.operationSign = 0;
}

- (IBAction)actionTwoOperandsSignPressed:(UIButton *)sender {
    self.operationSign = [self conversionStringToOperationSignType:sender.currentTitle];
    self.firstOperand = self.currentInput;
    self.stillTyping = NO;
    self.dotIsPlaced = NO;
}

- (IBAction)actionEqalitySignPressed:(UIButton *)sender {
    if (self.stillTyping) {
        self.secondOperand = self.currentInput;
    }
    self.dotIsPlaced = NO;
    
    if (self.firstOperand != 0 && self.secondOperand != 0) {
        [self operateWithTwoOperands];
    }
}

- (IBAction)actionPlusMinusButtonPressed:(UIButton *)sender {
    self.currentInput = -self.currentInput;
}

- (IBAction)actionPercentageButtonPressed:(UIButton *)sender {
    if (self.firstOperand == 0) {
        self.currentInput = self.currentInput / 100;
    } else {
        self.secondOperand = self.firstOperand * self.currentInput / 100;
    }
}

- (IBAction)actionSquareButtonPressed:(UIButton *)sender {
    self.currentInput = sqrt(self.currentInput);
}

- (IBAction)actionDotButtonPressed:(UIButton *)sender {
    if (self.stillTyping && !self.dotIsPlaced) {
        self.displayResultLabel.text = [NSString stringWithFormat:@"%@.", self.displayResultLabel.text];
        self.dotIsPlaced = YES;
    } else if (!self.stillTyping && !self.dotIsPlaced) {
        self.displayResultLabel.text = @"0.";
    }
}

#pragma mark - Additional

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

- (void)operateWithTwoOperands {
    switch (self.operationSign) {
        case OperationSignTypePlus:
            self.currentInput = self.firstOperand + self.secondOperand;
            break;
        case OperationSignTypeMinus:
            self.currentInput = self.firstOperand - self.secondOperand;
            break;
        case OperationSignTypeMultiply:
            self.currentInput = self.firstOperand * self.secondOperand;
            break;
        case OperationSignTypeDivide:
            self.currentInput = self.firstOperand / self.secondOperand;
            break;
        default:
            break;
    }
    self.stillTyping = NO;
}

- (OperationSignType)conversionStringToOperationSignType:(NSString *)string {
    if ([string isEqualToString:@"+"]) {
        return OperationSignTypePlus;
    } else if ([string isEqualToString:@"-"]) {
        return OperationSignTypeMinus;
    } else if ([string isEqualToString:@"×"]) {
        return OperationSignTypeMultiply;
    } else if ([string isEqualToString:@"÷"]) {
        return OperationSignTypeDivide;
    }
    
    //null check
    NSLog(@"%@", [NSException exceptionWithName:@"conversionStringToOperationSignType NULL" reason:nil userInfo:nil]);
    abort();
}

@end
